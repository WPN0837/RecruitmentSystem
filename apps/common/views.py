from django.shortcuts import HttpResponse, render, redirect
from hashlib import md5
from io import BytesIO
from django.views import View
from .models import User
import re
import json
from utils.check_code import create_validate_code
from .tasks import send_register_email, send_reset_email
import time
import base64
from Recruitment.models import Position
from utils.common import code


# Create your views here.

class IndexView(View):
    '''
    首页
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        p = Position.objects.filter(level=1).all()
        return render(request, 'index.html', {
            'user': u,
            'p': p,
        })


class CheckCodeView(View):
    '''
    获取验证码
    '''

    def get(self, request):
        img_png = BytesIO()
        img, code = create_validate_code()
        img.save(img_png, 'PNG')
        request.session['check_code'] = code
        return HttpResponse(img_png.getvalue())


class RegisterView(View):
    '''
    注册用户
    '''

    def get(self, request):
        '''
        返回注册用户界面
        :param request:
        :return:
        '''
        if request.session.get('email'):
            return redirect('/')
        return render(request, 'register.html')

    def post(self, request):
        '''
        注册
        :param request:
        :return:
        '''
        email = request.POST.get('email', None)
        pwd = request.POST.get('pwd', None)
        Type = request.POST.get('type', None)
        code = request.POST.get('code', None)
        if User.objects.filter(email=email):
            res = {'success': 0, 'msg': '邮箱已存在'}
        elif not re.fullmatch(request.session.get('check_code'), code, flags=re.IGNORECASE):
            res = {'success': 2, 'msg': '验证码错误'}
        else:
            m = md5()
            m.update('zhaopin'.encode('utf8'))
            m.update(pwd.encode('utf8'))
            pwd = m.hexdigest()
            User(email=email, pwd=pwd, type=int(Type)).save()
            token = base64.b64encode(json.dumps({'email': email, 'time': time.time()}).encode('utf-8')).decode('utf-8')
            data = {'email': email, 'token': token}
            send_register_email.delay(data)
            res = {'success': 1, 'content': "/login.html"}
        return HttpResponse(json.dumps(res))


class LoginView(View):
    '''
    登录
    '''

    def get(self, request):
        '''
        返回登录页面
        :param request:
        :return:
        '''
        if request.session.get('email'):
            return redirect('index')
        loginToUrl = request.META.get('HTTP_REFERER', '')
        return render(request, 'login.html', {'loginToUrl': loginToUrl})

    def post(self, request):
        '''
        登录
        :param request:
        :return:
        '''
        email = request.POST.get('email', None)
        pwd = request.POST.get('pwd', None)
        autoLogin = request.POST.get('autoLogin', None)
        loginToUrl = request.POST.get('loginToUrl', None)
        code = request.POST.get('code', None)
        m = md5()
        m.update('zhaopin'.encode('utf8'))
        m.update(pwd.encode('utf8'))
        pwd = m.hexdigest()
        u = User.objects.filter(email=email, pwd=pwd).first()
        if not u:
            res = {'success': 0, 'msg': '用户名或密码错误'}
        elif not re.fullmatch(request.session.get('check_code'), code, flags=re.IGNORECASE):
            res = {'success': 2, 'msg': '验证码错误'}
        elif not u.activation:
            res = {'success': 3, 'msg': '该账户未激活，先激活'}
        else:
            try:
                autoLogin = int(autoLogin)
            except ValueError:
                autoLogin = 0
            if autoLogin:
                request.session.set_expiry(30 * 24 * 60 * 60)
            else:
                request.session.set_expiry(0)
            request.session['email'] = email
            if re.search('/login\.html|/register\.html|/update-password\.html', loginToUrl):
                loginToUrl = ''
            res = {'success': 1, 'content': {'loginToUrl': loginToUrl}}
        return HttpResponse(json.dumps(res))


class LogoutView(View):
    '''
    注销用户
    '''

    def get(self, request):
        request.session.flush()
        request.session.set_expiry(0)
        return redirect('/')


class ActivationView(View):
    '''
    激活用户
    '''

    def get(self, request):
        token = request.GET.get('token', None)
        if token:
            token = base64.b64decode(token.encode('utf-8')).decode('utf-8')
            dic = json.loads(token)
            t = dic.get('time', 0)
            if t:
                now = time.time()
                if t > now or now - t > 24 * 60 * 60:
                    return HttpResponse('激活过期')
                u = User.objects.get(email=dic.get('email', None))
                if u:
                    if u.activation == 1:
                        return HttpResponse('已激活')
                    u.activation = 1
                    u.save()
                    request.session.set_expiry(0)
                    request.session['email'] = dic['email']
                    return redirect('/')
        return redirect('/')


class Reset01View(View):
    '''
    邮件重置密码
    第一步
    '''

    def get(self, request):
        return render(request, 'reset.html')

    def post(self, request):
        email = request.POST.get('email', None)
        if User.objects.filter(email=email).exists():
            reset_code = code()
            request.session['reset_code'] = reset_code
            request.session['reset_email'] = email
            request.session.set_expiry(120)
            data = {'email': email, 'code': reset_code}
            send_reset_email.delay(data)
            return redirect('verification')
        return render(request, 'reset.html', {'email': email, 'msg': '邮箱不存在！'})


class Reset02View(View):
    '''
    验证重置密码验证码
    第二步
    '''

    def get(self, request):
        if request.session.get('reset_code', '') and request.session.get('reset_email', ''):
            return render(request, 'reset_code.html')
        return redirect('login')

    def post(self, request):
        reset_code = request.POST.get('reset_code', None)
        s = request.session.get('reset_code', '')
        if reset_code and reset_code == s:
            del request.session['reset_code']
            request.session['update_pwd'] = True
            return redirect('reset_update')
        return render(request, 'reset_code.html', {'msg': '验证码错误！'})


class Reset03View(View):
    '''
    重置密码
    第三步
    '''

    def get(self, request):
        if not request.session.get('update_pwd', None):
            return redirect('login')
        return render(request, 'reset_update.html')

    def post(self, request):
        pwd = request.POST.get('pwd', '')
        pwd1 = request.POST.get('pwd1', '')
        email = request.session.get('reset_email', None)
        if not email:
            return HttpResponse('error')
        if pwd == pwd1:
            m = md5()
            m.update('zhaopin'.encode('utf8'))
            m.update(pwd.encode('utf8'))
            pwd = m.hexdigest()
            User.objects.filter(email=email).update(pwd=pwd)
            return redirect('login')
        return render(request, 'reset_update.html', {'msg': '两次密码不一致'})
