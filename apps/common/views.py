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
from common.models import HotCity
from Recruitment.models import Position, PositionInfo, CompanyTag, IndustrySector, Company
from utils.common import code
from datetime import datetime, timedelta


# Create your views here.

class IndexView(View):
    '''
    首页
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        p = Position.objects.filter(level=1).all()
        for i in p:
            hot_p = []
            for j in i.son.all():
                hot_p.extend(list(j.son.all()))
            setattr(i, 'hot_p', sorted(hot_p, key=lambda x: x.hot, reverse=True)[:5])
        hot_search = Position.objects.filter(level=3).order_by('-hot')[:10]
        hot_company = Company.objects.order_by('-level')[:6]
        last_company = hot_company[5]
        hot_company = hot_company[:5]
        hot_positions = PositionInfo.objects.raw(
            'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`status`=0 ORDER BY r.views_count desc LIMIT 0,15) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.founder_id = rcf.id) on rp.company_id = rc.id;')
        for i in hot_positions:
            i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
            i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        new_positions = PositionInfo.objects.raw(
            'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`status`=0 ORDER BY r.id desc LIMIT 0,15) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.founder_id = rcf.id) on rp.company_id = rc.id;')
        for i in hot_positions:
            i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
            i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        return render(request, 'index.html', {
            'user': u,
            'p': p,
            'hot_positions': hot_positions,
            'new_positions': new_positions,
            'hot_search': hot_search,
            'hot_company': hot_company,
            'last_company': last_company
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


class AboutView(View):
    '''
    关于
    '''
    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        return render(request, 'about.html', {
            'user': u,
        })


class ListView(View):
    '''
    职位信息列表
    '''
    def get(self, request):
        salary = ['2k以下', '2k-5k', '5k-10k', '10k-15k', '15k-25k', '25k-50k', '50k以上']
        workYear = ['不限', '应届毕业生', '1年以下', '1-3年', '3-5年', '5-10年', '10年以上']
        education = ['不限', '大专', '本科', '硕士', '博士']
        jobNature = ['全职', '兼职', '实习']
        addTime = ['今天', '3天内', '一周内', '一月内']
        workAddress = [
            ['ABCDEF', HotCity.objects.filter(first__in=[i for i in 'ABCDEF']).values_list('name')],
            ['GHIJ', HotCity.objects.filter(first__in=[i for i in 'GHIJ']).values_list('name')],
            ['KLMN', HotCity.objects.filter(first__in=[i for i in 'KLMN']).values_list('name')],
            ['OPQR', HotCity.objects.filter(first__in=[i for i in 'OPQR']).values_list('name')],
            ['STUV', HotCity.objects.filter(first__in=[i for i in 'STUV']).values_list('name')],
            ['WXYZ', HotCity.objects.filter(first__in=[i for i in 'WXYZ']).values_list('name')],
        ]
        hotCity = ['全国', '北京', '上海', '广州', '深圳', '成都', '杭州', '武汉', '南京']
        hot_search = Position.objects.filter(level=3).order_by('-hot')[:10]
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        cte = request.GET.get('te', '')  # 类型
        csy = request.GET.get('sy', '')  # 月薪
        cwr = request.GET.get('wr', '')  # 工作经验
        cen = request.GET.get('en', '')  # 学历
        cje = request.GET.get('je', '')  # 工作类型
        cae = request.GET.get('ae', '')  # 发布时间
        cws = request.GET.get('ws', '')  # 工作城市
        cpn = request.GET.get('pn', '')  # 职位
        ccy = request.GET.get('cy', '')  # 公司
        if cte == 'hot':
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`status`=0 ORDER BY r.views_count desc) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.founder_id = rcf.id) on rp.company_id = rc.id;')
            for i in positions:
                i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
                i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        elif cte == 'new':
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`status`=0 ORDER BY r.id desc) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.founder_id = rcf.id) on rp.company_id = rc.id;')
            for i in positions:
                i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
                i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        else:
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`status`=0) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.founder_id = rcf.id) on rp.company_id = rc.id;')
            for i in positions:
                i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
                i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        positions = filter(positions, csy, cwr, cen, cje, cae, cws, cpn, ccy)
        return render(request, 'list.html', {
            'user': u,
            'hot_positions': positions,
            'salary': salary,
            'workYear': workYear,
            'education': education,
            'jobNature': jobNature,
            'addTime': addTime,
            'workAddress': workAddress,
            'hotCity': hotCity,
            'hot_search': hot_search,
            'cte': cte,
            'csy': csy,
            'cwr': cwr,
            'cen': cen,
            'cje': cje,
            'cae': cae,
            'cws': cws,
            'cpn': cpn,
            'ccy': ccy,
        })


class SearchView(View):
    '''
    搜索
    '''
    def get(self, request):
        salary = ['2k以下', '2k-5k', '5k-10k', '10k-15k', '15k-25k', '25k-50k', '50k以上']
        workYear = ['不限', '应届毕业生', '1年以下', '1-3年', '3-5年', '5-10年', '10年以上']
        education = ['不限', '大专', '本科', '硕士', '博士']
        jobNature = ['全职', '兼职', '实习']
        addTime = ['今天', '3天内', '一周内', '一月内']
        workAddress = [
            ['ABCDEF', HotCity.objects.filter(first__in=[i for i in 'ABCDEF']).values_list('name')],
            ['GHIJ', HotCity.objects.filter(first__in=[i for i in 'GHIJ']).values_list('name')],
            ['KLMN', HotCity.objects.filter(first__in=[i for i in 'KLMN']).values_list('name')],
            ['OPQR', HotCity.objects.filter(first__in=[i for i in 'OPQR']).values_list('name')],
            ['STUV', HotCity.objects.filter(first__in=[i for i in 'STUV']).values_list('name')],
            ['WXYZ', HotCity.objects.filter(first__in=[i for i in 'WXYZ']).values_list('name')],
        ]
        hotCity = ['全国', '北京', '上海', '广州', '深圳', '成都', '杭州', '武汉', '南京']
        hot_search = Position.objects.filter(level=3).order_by('-hot')[:10]
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        kd = request.GET.get('kd', '')  # 搜索关键词
        spc = request.GET.get('spc', '')  # 搜索类型
        csy = request.GET.get('sy', '')  # 月薪
        cwr = request.GET.get('wr', '')  # 工作经验
        cen = request.GET.get('en', '')  # 学历
        cje = request.GET.get('je', '')  # 工作类型
        cae = request.GET.get('ae', '')  # 发布时间
        cws = request.GET.get('ws', '')  # 工作城市
        cpn = request.GET.get('pn', '')  # 职位
        ccy = request.GET.get('cy', '')  # 公司
        if spc == '1':
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`position` LIKE %s or r.positionType LIKE %s ) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.founder_id = rcf.id) on rp.company_id = rc.id;',
                params=['%{}%'.format(kd), '%{}%'.format(kd)])
        elif spc == '2':
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (SELECT full_name,abbreviation_name,scope,development_stage,id,founder_id from recruitment_company WHERE full_name LIKE %s or abbreviation_name LIKE %s ) as rc LEFT join recruitment_companyfoundingteam as rcf on rc.founder_id = rcf.id LEFT join recruitment_positioninfo as rp on rp.company_id = rc.id;',
                params=['%{}%'.format(kd), '%{}%'.format(kd)])
        else:
            positions = []
        positions = filter(positions, csy, cwr, cen, cje, cae, cws, cpn, ccy)
        return render(request, 'search.html', {
            'user': u,
            'hot_positions': positions,
            'salary': salary,
            'workYear': workYear,
            'education': education,
            'jobNature': jobNature,
            'addTime': addTime,
            'workAddress': workAddress,
            'hotCity': hotCity,
            'hot_search': hot_search,
            'kd': kd,
            'spc': spc,
            'csy': csy,
            'cwr': cwr,
            'cen': cen,
            'cje': cje,
            'cae': cae,
            'cws': cws,
            'cpn': cpn,
            'ccy': ccy,
        })


def filter(positions, csy, cwr, cen, cje, cae, cws, cpn, ccy):
    '''
    过滤
    :param positions:
    :param csy:
    :param cwr:
    :param cen:
    :param cje:
    :param cae:
    :param cws:
    :param cpn:
    :param ccy:
    :return:
    '''
    salary = ['2k以下', '2k-5k', '5k-10k', '10k-15k', '15k-25k', '25k-50k', '50k以上']
    workYear = ['不限', '应届毕业生', '1年以下', '1-3年', '3-5年', '5-10年', '10年以上']
    education = ['不限', '大专', '本科', '硕士', '博士']
    jobNature = ['全职', '兼职', '实习']
    addTime = ['今天', '3天内', '一周内', '一月内']
    if csy in salary:
        csy_positions = []
        if salary.index(csy) == 0:
            for i in positions:
                if i.salaryMin <= 2:
                    csy_positions.append(i)
        elif salary.index(csy) == 6:
            for i in positions:
                if i.salaryMax >= 50:
                    csy_positions.append(i)
        else:
            mi, ma = [i.strip('k') for i in csy.split('-')]
            for i in positions:
                if i.salaryMin <= int(mi) <= i.salaryMax and i.salaryMin <= int(ma) <= i.salaryMax:
                    csy_positions.append(i)
        positions = csy_positions
    if cwr in workYear:
        cwr_positions = []
        if workYear.index(cwr):
            for i in positions:
                if i.workYear == cwr:
                    cwr_positions.append(i)
        positions = cwr_positions
    if cen in education:
        cen_positions = []
        if education.index(cen):
            for i in positions:
                if i.education == cen:
                    cen_positions.append(i)
        positions = cen_positions
    if cje in jobNature:
        cje_positions = []
        for i in positions:
            if i.education == cje:
                cje_positions.append(i)
        positions = cje_positions
    if cae in addTime:
        cae_positions = []
        now = datetime.now()
        if addTime.index(cae) == 0:
            for i in positions:
                if i.addTime.date() == now.date():
                    cae_positions.append(i)
        elif addTime.index(cae) == 1:
            for i in positions:
                if now - timedelta(days=3) <= i.addTime:
                    cae_positions.append(i)
        elif addTime.index(cae) == 2:
            for i in positions:
                if now - timedelta(weeks=1) <= i.addTime:
                    cae_positions.append(i)
        elif addTime.index(cae) == 3:
            for i in positions:
                if now - timedelta(days=30) <= i.addTime:
                    cae_positions.append(i)
        positions = cae_positions
    if cws and cws != '全国':
        cws_positions = []
        for i in positions:
            if i.workAddress == cws:
                cws_positions.append(i)
        positions = cws_positions
    if cpn:
        cpn_positions = []
        for i in positions:
            if cpn in i.position:
                cpn_positions.append(i)
        positions = cpn_positions
    if ccy:
        ccy_positions = []
        for i in positions:
            if ccy in i.full_name or ccy in i.abbreviation_name:
                ccy_positions.append(i)
        positions = ccy_positions
    return positions
