from django.shortcuts import HttpResponse, render, redirect
from django.views.decorators.csrf import csrf_exempt
from hashlib import md5
from io import BytesIO
from django.views import View
from .models import User
import re
import json
from utils.check_code import create_validate_code


# Create your views here.

class IndexView(View):
    def get(self, request):
        email = request.session.get('email', '')
        return render(request, 'index.html', {'email': email})


class CheckCodeView(View):
    def get(self, request):
        img_png = BytesIO()
        img, code = create_validate_code()
        img.save(img_png, 'PNG')
        request.session['check_code'] = code
        return HttpResponse(img_png.getvalue())


class RegisterView(View):
    def get(self, request):
        if request.session.get('email'):
            return redirect('/')
        return render(request, 'register.html')

    def post(self, request):
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
            res = {'success': 1, 'content': "/login.html"}
        return HttpResponse(json.dumps(res))


class LoginView(View):
    def get(self, request):
        if request.session.get('email'):
            return redirect('/')
        loginToUrl = request.META.get('HTTP_REFERER', '')
        return render(request, 'login.html', {'loginToUrl': loginToUrl})

    def post(self, request):
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
            if re.search('/login\.html|/register\.html', loginToUrl):
                loginToUrl = ''
            res = {'success': 1, 'content': {'loginToUrl': loginToUrl}}
        return HttpResponse(json.dumps(res))


class LogoutView(View):
    def get(self, request):
        request.session.flush()
        request.session.set_expiry(0)
        return redirect('/')
