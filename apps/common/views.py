from django.shortcuts import HttpResponse, render, redirect
from hashlib import md5
from io import BytesIO
from django.views import View
from django.db.models import F
from .models import User
import re
import json
from utils.check_code import create_validate_code
from .tasks import send_register_email, send_reset_email, send_submit_resume_email
import time
import base64
from common.models import HotCity, SubmitResume, Banner
from Recruitment.models import Position, PositionInfo, CompanyTag, IndustrySector, Company, CompanyAuthFile
from JobHunting.models import PositionCollection
from utils.common import code
from datetime import datetime, timedelta
from django.conf import settings
from utils.Paginator import my_Paginator


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
        if len(hot_company) < 6:
            last_company = None
        else:
            last_company = hot_company[5]
        hot_company = hot_company[:5]
        hot_positions = PositionInfo.objects.raw(
            'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id,r.views_count from recruitment_positioninfo as r where r.`status`=0 LIMIT 0,15) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.id = rcf.company_id) on rp.company_id = rc.id ORDER BY rp.views_count desc ;')
        for i in hot_positions:
            i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
            i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        new_positions = PositionInfo.objects.raw(
            'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`status`=0 ORDER BY r.id desc LIMIT 0,15) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.id = rcf.company_id) on rp.company_id = rc.id;')
        for i in hot_positions:
            i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
            i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        bs = Banner.objects.order_by('-level')[:3]
        for i in range(len(bs)):
            setattr(bs[i], 'tag', i + 1)
        return render(request, 'index.html', {
            'user': u,
            'p': p,
            'hot_positions': hot_positions,
            'new_positions': new_positions,
            'hot_search': hot_search,
            'hot_company': hot_company,
            'last_company': last_company,
            'bs': bs,
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
            if re.search('(\/login\.html|\/register\.html|\/update-password\.html)', loginToUrl):
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
            return render(request, 'reset_update.html', {'msg': '操作失败'})
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
        page = request.GET.get('page', 1)  # 页码
        try:
            if not page:
                page = 1
            page = int(page)
        except Exception as e:
            return redirect('/error.html?msg=没有找到该页面')
        if cte == 'hot':
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id,r.views_count from recruitment_positioninfo as r where r.`status`=0) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.id = rcf.company_id) on rp.company_id = rc.id ORDER BY rp.views_count desc;')
            for i in positions:
                i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
                i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        elif cte == 'new':
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`status`=0) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.id = rcf.company_id) on rp.company_id = rc.id ORDER BY rp.id DESC;')
            for i in positions:
                i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
                i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        else:
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`status`=0) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.id = rcf.company_id) on rp.company_id = rc.id;')
            for i in positions:
                i.sector = ','.join([i[0] for i in IndustrySector.objects.filter(company=i.cid).values_list('sector')])
                i.tag = CompanyTag.objects.filter(company=i.cid).values_list('name')
        positions = filter(positions, csy, cwr, cen, cje, cae, cws, cpn, ccy)
        positions = my_Paginator(positions, 10, 6, page)
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
            'page': page,
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
        page = request.GET.get('page', 1)  # 页码
        try:
            page = int(page)
        except Exception as e:
            return redirect('/error.html?msg=没有找到该页面')
        if spc == '1':
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (select r.id,r.workAddress,r.position,r.salaryMin,r.salaryMax,r.workYear,r.education,r.positionAdvantage,r.addTime,r.company_id from recruitment_positioninfo as r where r.`position` LIKE %s or r.positionType LIKE %s ) as rp LEFT join (recruitment_company as rc LEFT join recruitment_companyfoundingteam as rcf on rc.id = rcf.company_id) on rp.company_id = rc.id;',
                params=['%{}%'.format(kd), '%{}%'.format(kd)])
        elif spc == '2':
            positions = PositionInfo.objects.raw(
                'SELECT rp.id,rp.position,rp.salaryMin,rp.salaryMax,rp.workAddress,rp.workYear,rp.education,rp.positionAdvantage,rp.addTime,rc.full_name,rc.abbreviation_name,rc.scope,rc.development_stage,rcf.founder_name,rc.id as cid from (SELECT full_name,abbreviation_name,scope,development_stage,id from recruitment_company WHERE full_name LIKE %s or abbreviation_name LIKE %s ) as rc LEFT join recruitment_companyfoundingteam as rcf on rc.id = rcf.company_id LEFT join recruitment_positioninfo as rp on rp.company_id = rc.id;',
                params=['%{}%'.format(kd), '%{}%'.format(kd)])
        else:
            positions = []
        positions = filter(positions, csy, cwr, cen, cje, cae, cws, cpn, ccy)
        positions = my_Paginator(positions, 10, 6, page)
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
            'page': page,
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


class CompanyDetailView(View):
    '''
    公司详细信息
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        cid = request.GET.get('id', 0)
        try:
            c = Company.objects.filter(id=int(cid)).first()
        except Exception as e:
            return redirect('/error.html?msg=查看信息失败')
        auth = CompanyAuthFile.objects.filter(company=c, status=2).exists()
        return render(request, 'company_info.html', {
            'c': c,
            'user': u,
            'auth': auth,
        })


class PositionDetailView(View):
    '''
    职位详细信息
    '''

    def get(self, request):
        pid = request.GET.get('id', 0)
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        try:
            p = PositionInfo.objects.filter(id=int(pid)).first()
            c = p.company
            sectors = c.industry_sector.all()
        except Exception as e:
            return redirect('/error.html?msg=查看信息失败')
        if u and u.type:
            return render(request, 'position_detail.html', {
                'user': u,
                'p': p,
                'c': c,
                'sectors': sectors,
            })
        if u:
            collection = PositionCollection.objects.filter(user_id=u.id, position_id=int(pid)).exists()
        else:
            collection = False
        PositionInfo.objects.filter(id=int(pid)).update(views_count=F('views_count') + 1)
        return render(request, 'position_detail1.html', {
            'user': u,
            'p': p,
            'c': c,
            'sectors': sectors,
            'collection': collection,
        })


class SubmitResumeView(View):
    '''
    投递简历
    '''

    def get(self, request):
        # 从session获取用户信息
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        # 获取职位id
        pid = request.GET.get('id', 0)
        try:
            p = PositionInfo.objects.filter(id=int(pid)).first()
            if not p:
                raise Exception
        except Exception as e:
            return redirect('/error.html?msg=没有找到职位信息')
        # 用户没有简历，提示错误
        if not hasattr(u, 'resume'):
            return redirect('/error.html?msg=没有找到简历信息')
        # 已经投递过简历，提示错误
        if SubmitResume.objects.filter(resume=u.resume, position=p).exists():
            return redirect('/error.html?msg=已经投过这个职位了')
        # 生成url
        url = 'http://%s/recruitment/unprocessed-resume.html' % settings.SELF_HOST_NAME
        # 创建并保存简历、职位关系对象
        SubmitResume.objects.create(resume=u.resume,
                                    position=p,
                                    sort=u.resume.default)
        # 生成邮件信息
        data = {'email': p.company.user.email,
                'url': url, 'name': p.company.abbreviation_name,
                'time': datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                'position': p.position,
                'add_time': p.addTime.strftime("%Y-%m-%d %H:%M:%S")}
        # 发送邮件
        send_submit_resume_email.delay(data)
        # 返回成功页面
        return render(request, 'success.html', {
            'user': u,
            'code': 2,
            'success': '投递成功',
            'msg': '恭喜，职位投递成功！',
        })


class ResumeView(View):
    '''
    查看简历
    '''

    def get(self, request):
        # 获取用户信息
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        # 获取token
        token = request.GET.get('token', None)
        if token:
            # 提取token存储的信息
            token = base64.b64decode(token.encode('utf-8')).decode('utf-8')
            dic = json.loads(token)
            # 被查看用户不存在，提示错误
            email = dic.get('email', '')
            user = User.objects.filter(email=email).first()
            if not user:
                return redirect('/error.html?msg=查看信息失败')
            # 简历、职位关系不存在，提示错误
            spid = dic.get('id', '')
            if spid:
                try:
                    SubmitResume.objects.filter(id=int(spid)).update(status=1)
                except Exception as e:
                    return redirect('/error.html?msg=查看信息失败')
            else:
                return redirect('/error.html?msg=查看信息失败')
            # 获取简历信息
            resume = user.resume if hasattr(user, 'resume') else None
            resume_info = resume.resume_info if hasattr(resume, 'resume_info') else None
            hope_work = resume.hope_work if hasattr(resume, 'hope_work') else None
            work_experiences = resume.work_experience.all() if hasattr(resume, 'work_experience') else None
            project_experiences = resume.project_experience.all() if hasattr(resume,
                                                                             'project_experience') else None
            educational_experiences = resume.educational_experience.all() if hasattr(resume,
                                                                                     'educational_experience') else None
            self_detail = resume.self_detail if hasattr(resume, 'self_detail') else None
            gallerys = resume.gallery.all() if hasattr(resume, 'gallery') else None
            # 返回简历信息页面
            return render(request, 'preview.html', {
                'user': user,
                'resume': resume,
                'resume_info': resume_info,
                'hope_work': hope_work,
                'work_experiences': work_experiences,
                'project_experiences': project_experiences,
                'educational_experiences': educational_experiences,
                'self_detail': self_detail,
                'gallerys': gallerys,
            })
        # token不存在，提示错误信息
        return redirect('/error.html?msg=查看信息失败')


class UpdatePwd(View):
    '''
    修改密码
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        return render(request, 'updatePwd.html', {
            'user': u,
        })

    def post(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        oldPassword = request.POST.get('oldPassword', '')
        newPassword = request.POST.get('newPassword', '')
        newPassword2 = request.POST.get('newPassword2', '')
        m = md5()
        m.update('zhaopin'.encode('utf8'))
        m.update(oldPassword.encode('utf8'))
        old_pwd = m.hexdigest()
        if u.pwd != old_pwd:
            return HttpResponse(json.dumps({'success': False, 'msg': '旧密码错误'}))
        if newPassword and newPassword == newPassword2 and 16 >= len(newPassword) >= 6:
            if newPassword == oldPassword:
                return HttpResponse(json.dumps({'success': False, 'msg': '旧密码不能与新密码相同'}))
            m = md5()
            m.update('zhaopin'.encode('utf8'))
            m.update(newPassword.encode('utf8'))
            pwd = m.hexdigest()
            User.objects.filter(email=email, pwd=old_pwd).update(pwd=pwd)
            return HttpResponse(json.dumps({'success': True}))
        return HttpResponse(json.dumps({'success': False, 'msg': '修改密码错误'}))


class CompanyListView(View):
    '''
    公司列表
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        workAddress = [
            ['ABCDEF', HotCity.objects.filter(first__in=[i for i in 'ABCDEF']).values_list('name')],
            ['GHIJ', HotCity.objects.filter(first__in=[i for i in 'GHIJ']).values_list('name')],
            ['KLMN', HotCity.objects.filter(first__in=[i for i in 'KLMN']).values_list('name')],
            ['OPQR', HotCity.objects.filter(first__in=[i for i in 'OPQR']).values_list('name')],
            ['STUV', HotCity.objects.filter(first__in=[i for i in 'STUV']).values_list('name')],
            ['WXYZ', HotCity.objects.filter(first__in=[i for i in 'WXYZ']).values_list('name')],
        ]
        hotCity = ['全国', '北京', '上海', '广州', '深圳', '成都', '杭州', '武汉', '南京']
        # development_stage = {'初创型': ['未融资'], '成长型': ['天使轮', 'A轮', 'B轮'], '成熟型': ['C轮', 'D轮以上'], '已上市': ['上市公司']}
        development_stage = {'初创型': ['未融资', '天使轮', ], '成长型': ['A轮', 'B轮', 'C轮', ], '成熟型': ['D轮以上'], '已上市': ['上市公司']}
        sectors = IndustrySector.objects.values_list('sector')
        cws = request.GET.get('ws', '')  # 城市
        cde = request.GET.get('de', '')  # 发展阶段
        cir = request.GET.get('ir', '')  # 行业领域
        page = request.GET.get('page', 1)  # 页码
        try:
            if not page:
                page = 1
            page = int(page)
        except Exception as e:
            return redirect('/error.html?msg=没有找到该页面')
        companys = Company.objects.order_by('-level')
        if cws and hotCity.index(cws):
            companys = companys.filter(city=cws)
        if cde in development_stage:
            companys = companys.filter(development_stage__in=development_stage[cde])
        if cir:
            companys = companys.filter(industry_sector__sector=cir)
        Pag_obj = my_Paginator(companys, 15, 6, page)
        companys_list = Pag_obj.current_page_data_list
        for i in range(len(companys_list)):
            if i % 3 == 0:
                setattr(companys_list[i], 'num', 1)
            else:
                setattr(companys_list[i], 'num', 0)
            setattr(companys_list[i], 'sectors', ','.join(j.sector for j in companys_list[i].industry_sector.all()))
            setattr(companys_list[i], 'position_infos',
                    PositionInfo.objects.filter(company_id=companys_list[i].id).order_by('-id')[:4])
        return render(request, 'companylist.html', {
            'user': u,
            'workAddress': workAddress,
            'hotCity': hotCity,
            'development_stage': development_stage,
            'sectors': sectors,
            'Pag_obj': Pag_obj,
            'companys_list': companys_list,
            'cws': cws,
            'cde': cde,
            'cir': cir,
            'page': page,
        })


class ErrorView(View):
    '''
    错误页面
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        msg = request.GET.get('msg', '没有找到该页面')
        return render(request, 'error.html', {
            'user': u,
            'msg': msg,
        })
