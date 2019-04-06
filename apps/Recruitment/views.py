from django.shortcuts import HttpResponse, render, redirect
from django.views.decorators.csrf import csrf_exempt
from django.views import View
from common.models import User, City
from .models import IndustrySector, Company, TagSort, CompanyTag, CompanyFoundingTeam, CompanyProduct, \
    CompanyIntroduction, Position, PositionInfo
import json
import uuid


# Create your views here.
class ValidateCityView(View):
    def post(self, request):
        c = request.POST.get('city', None)
        if c and City.objects.filter(name=c).exists():
            res = {'success': True}
        else:
            res = {'success': False}
        return HttpResponse(json.dumps(res))


class PostJobView(View):
    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        if not u.type:
            return HttpResponse('error')
        if not hasattr(u, 'company'):
            return redirect('recruitment:company01')
        c = u.company
        p = Position.objects.filter(level=1).all()
        cpid = request.GET.get('id', None)
        cp = None
        natures = ['全职', '兼职', '实习']
        if cpid:
            try:
                cp = PositionInfo.objects.filter(id=int(cpid)).first()
            except Exception as e:
                return HttpResponse('error')
        return render(request, 'PostJob.html', {
            'user': u,
            'c': c,
            'p': p,
            'cp': cp,
            'natures': natures,
        })

    def post(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        if not u.type:
            return HttpResponse('error')
        if not hasattr(u, 'company'):
            return redirect('recruitment:company01')
        pid = request.POST.get('id', '')
        positionType = request.POST.get('positionType', None)
        position = request.POST.get('positionName', None)
        department = request.POST.get('department', None)
        jobNature = request.POST.get('jobNature', None)
        salaryMin = request.POST.get('salaryMin', None)
        salaryMax = request.POST.get('salaryMax', None)
        workAddress = request.POST.get('workAddress', None)
        workYear = request.POST.get('workYear', None)
        education = request.POST.get('education', None)
        positionAdvantage = request.POST.get('positionAdvantage', None)
        positionDetail = request.POST.get('positionDetail', None)
        positionAddress = request.POST.get('positionAddress', None)
        positionLng = request.POST.get('positionLng', None)
        positionLat = request.POST.get('positionLat', None)
        email = request.POST.get('email', None)
        c = u.company
        if pid:
            try:
                p = PositionInfo.objects.filter(id=int(pid)).update(positionType=positionType, position=position,
                                                                    department=department, jobNature=jobNature,
                                                                    salaryMin=salaryMin, salaryMax=salaryMax,
                                                                    workAddress=workAddress, workYear=workYear,
                                                                    education=education,
                                                                    positionAdvantage=positionAdvantage,
                                                                    positionDetail=positionDetail,
                                                                    positionAddress=positionAddress,
                                                                    positionLng=positionLng, positionLat=positionLat,
                                                                    email=email, )
            except Exception as e:
                return HttpResponse('error')
        else:
            p = PositionInfo(
                positionType=positionType, position=position, department=department, jobNature=jobNature,
                salaryMin=salaryMin, salaryMax=salaryMax, workAddress=workAddress, workYear=workYear,
                education=education, positionAdvantage=positionAdvantage, positionDetail=positionDetail,
                positionAddress=positionAddress, positionLng=positionLng, positionLat=positionLat, email=email,
                company=c
            )
            p.save()
        res = {'success': True, 'content': '/recruitment/positions.html'}
        return HttpResponse(json.dumps(res))


class AddCompany01View(View):
    def get(self, request):
        scopes = ['少于15人', '15-50人', '50-150人', '150-500人', '500-2000人', '2000人以上']
        stages = ['未融资', '天使轮', 'A轮', 'B轮', 'C轮', 'D轮及以上', '上市公司']
        sectors = IndustrySector.objects.all()
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        c = u.company
        return render(request, 'add_company_info01.html', {
            'sectors': sectors,
            'user': u,
            'stages': stages,
            'scopes': scopes,
            'c': c,
        })

    def post(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        cid = request.POST.get('companyId', None)
        full_name = request.POST.get('companyNameAll', None)
        abbreviation_name = request.POST.get('companyShortName', None)
        logo = request.POST.get('logo', None)
        url = request.POST.get('companyUrl', None)
        city = request.POST.get('city', None)
        industry_sector = request.POST.get('industryField', None)
        scope = request.POST.get('companySize', None)
        development_stage = request.POST.get('financeStage', None)
        desc = request.POST.get('companyFeatures', None)
        if cid:
            u.company.full_name = full_name
            u.company.abbreviation_name = abbreviation_name
            u.company.logo = logo
            u.company.url = url
            u.company.city = city
            u.company.scope = scope
            u.company.development_stage = development_stage
            u.company.desc = desc
            if industry_sector:
                u.company.industry_sector.clear()
                is_list = industry_sector.split(',')
                is_obj_list = IndustrySector.objects.filter(sector__in=is_list).all()
                for i in is_obj_list:
                    u.company.industry_sector.add(i)
            u.company.save()
        else:
            c = Company(full_name=full_name, abbreviation_name=abbreviation_name, logo=logo, url=url, city=city,
                        scope=scope, development_stage=development_stage, desc=desc, user=u)
            c.save()
            if industry_sector:
                is_list = industry_sector.split(',')
                is_obj_list = IndustrySector.objects.filter(sector__in=is_list).all()
                for i in is_obj_list:
                    c.industry_sector.add(i)
        return HttpResponse(json.dumps({'success': True}))


class AddCompany02View(View):
    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        c = u.company
        tag_sorts = TagSort.objects.all()
        c_tags = {i.name: CompanyTag.objects.filter(tag_sort=i) for i in tag_sorts}
        return render(request, 'add_company_info02.html', {
            'user': u,
            'c': c,
            'c_tags': c_tags,
        })

    def post(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        cid = u.company.id
        tags = request.POST.get('labels', None)
        if cid and tags:
            c = Company.objects.filter(id=int(cid)).first()
            c.tags.clear()
            tag_list = CompanyTag.objects.filter(name__in=tags.split(','))
            for i in tag_list:
                c.tags.add(i)
        else:
            return HttpResponse('')
        return HttpResponse('ok')


class AddCompany03View(View):
    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        c = u.company
        if not hasattr(u, 'company'):
            return redirect('recruitment:company01')
        if not hasattr(u.company, 'founder'):
            l = 500
        else:
            l = 500 - len(u.company.founder.desc)
        return render(request, 'add_company_info03.html', {
            'user': u,
            'c': c,
            'l': l,
        })

    def post(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        photo = request.POST.get('photo', None)
        founder_name = request.POST.get('name', None)
        current_position = request.POST.get('position', None)
        sina = request.POST.get('weibo', None)
        desc = request.POST.get('remark', None)
        c = u.company
        if c.founder:
            c.founder.founder_name = founder_name
            c.founder.current_position = current_position
            c.founder.sina = sina
            c.founder.desc = desc
            c.founder.photo = photo
            c.founder.save()
            return redirect('recruitment:company04')
        else:
            f = CompanyFoundingTeam(founder_name=founder_name, current_position=current_position, sina=sina,
                                    desc=desc,
                                    photo=photo)
            f.save()
            c.founder = f
            c.save()
            return redirect('recruitment:company04')


class AddCompany04View(View):
    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        if not hasattr(u, 'company'):
            return redirect('recruitment:company01')
        c = u.company
        if c.product:
            l = 500 - len(c.product.product_desc)
        else:
            l = 500
        return render(request, 'add_company_info04.html', {
            'user': u,
            'c': c,
            'l': l,
        })

    def post(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        if not hasattr(u, 'company'):
            return redirect('recruitment:company01')
        c = u.company
        product_poster = request.POST.get('productInfos[0].productPicUrl', None)
        product_name = request.POST.get('productInfos[0].product', None)
        product_url = request.POST.get('productInfos[0].productUrl', None)
        product_desc = request.POST.get('productInfos[0].productProfile', None)

        if c.product:
            CompanyProduct.objects.filter(company=c).update(product_poster=product_poster, product_url=product_url,
                                                                product_desc=product_desc,
                                                                product_name=product_name)
        else:
            if product_name:
                p = CompanyProduct(product_poster=product_poster, product_url=product_url,
                                   product_desc=product_desc,
                                   product_name=product_name, company=c)
                p.save()
        return redirect('recruitment:company05')


class AddCompany05View(View):
    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        if not hasattr(u, 'company'):
            return redirect('recruitment:company01')
        if not hasattr(u.company, 'introduction'):
            l = 1000
        else:
            l = 1000 - len(u.company.introduction.introduction)
        c = u.company
        return render(request, 'add_company_info05.html', {
            'user': u,
            'c': c,
            'l': l,
        })

    def post(self, request):
        print(request.POST)
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        introduction = request.POST.get('companyProfile', None)
        if introduction:
            c = u.company
            if hasattr(c, 'introduction'):
                c.introduction.introduction = introduction
                c.introduction.save()
                return redirect('recruitment:company06')
            else:
                CompanyIntroduction.objects.create(introduction=introduction, company=c)
                return redirect('recruitment:company06')
        return HttpResponse('error')


class AddCompany06View(View):
    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        c = u.company
        return render(request, 'add_company_info06.html', {
            'user': u,
            'c': c,
        })


class EffectivePositionsView(View):
    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        c = u.company
        positions = PositionInfo.objects.filter(status=0).all()
        pn = len(positions)
        return render(request, 'effective_positions.html', {
            'user': u,
            'c': c,
            'positions': positions,
            'pn': pn,
        })

    def post(self, request):
        pass


@csrf_exempt
def CompanyLogo(request):
    '''
    上传公司logo
    '''
    if request.method == 'POST':
        img = request.FILES['headPic']
        url = 'static/Company/logo/' + str(uuid.uuid1()) + img._name
        try:
            with open(url, 'wb')as IMG:
                for i in img.file:
                    IMG.write(i)
        except Exception as e:
            url = ''
        finally:
            return HttpResponse(url)


@csrf_exempt
def FounderPhoto(request):
    '''
    上传创始人头像
    :param request:
    :return:
    '''
    if request.method == 'POST':
        img = request.FILES['myfiles']
        url = 'static/Company/founder/' + str(uuid.uuid1()) + img._name
        try:
            with open(url, 'wb')as IMG:
                for i in img.file:
                    IMG.write(i)
        except Exception as e:
            url = ''
        finally:
            return HttpResponse(url)


@csrf_exempt
def ProductPoster(request):
    if request.method == 'POST':
        img = request.FILES['myfiles']
        url = 'static/Company/Product/' + str(uuid.uuid1()) + img._name
        try:
            with open(url, 'wb')as IMG:
                for i in img.file:
                    IMG.write(i)
        except Exception as e:
            url = ''
        finally:
            return HttpResponse(url)


@csrf_exempt
def PositionInfoImg(request):
    if request.method == 'POST':
        img = request.FILES['imgFile']
        url = 'static/Company/PositionInfoImg/' + str(uuid.uuid1()) + img._name
        try:
            with open(url, 'wb')as IMG:
                for i in img.file:
                    IMG.write(i)
        except Exception as e:
            url = ''
        finally:
            ret = {'error': 0,
                   'url': '/' + url,
                   'message': '',
                   }
            return HttpResponse(json.dumps(ret, ensure_ascii=False))


class PositionOfflineView(View):
    '''
    下线职位
    '''

    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        c = u.company
        positions = PositionInfo.objects.filter(status=1).all()
        pn = len(positions)
        return render(request, 'offline_positions.html', {
            'user': u,
            'c': c,
            'positions': positions,
            'pn': pn,
        })

    def post(self, request):
        pid = request.POST.get('id', None)
        if pid:
            try:
                PositionInfo.objects.filter(id=int(pid)).update(status=1)
            except Exception as e:
                res = {'success': False}
                return HttpResponse(json.dumps(res))
            res = {'success': True}
            return HttpResponse(json.dumps(res))
        res = {'success': False}
        return HttpResponse(json.dumps(res))


class PositionDeleteView(View):
    '''
    删除职位
    '''

    def post(self, request):
        pid = request.POST.get('id', None)
        if pid:
            try:
                PositionInfo.objects.filter(id=int(pid)).update(status=2)
            except Exception as e:
                res = {'success': False}
                return HttpResponse(json.dumps(res))
            res = {'success': True}
            return HttpResponse(json.dumps(res))
        res = {'success': False}
        return HttpResponse(json.dumps(res))


class PositionDetailView(View):
    '''
    职位详细信息
    '''

    def get(self, request):
        pid = request.GET.get('id', None)
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if pid:
            try:
                p = PositionInfo.objects.filter(id=int(pid)).first()
                c = p.company
                sectors = c.industry_sector.all()
            except Exception as e:
                return HttpResponse('error')
            return render(request, 'position_detail.html', {
                'user': u,
                'p': p,
                'c': c,
                'sectors': sectors,
            })
        return HttpResponse('error')


class MyCompanyDetailView(View):
    '''
    公司信息
    '''

    def get(self, request):

        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        if not hasattr(u, 'company'):
            return redirect('recruitment:company01')
        c = u.company
        return render(request, 'myhome.html', {
            'user': u,
            'c': c,
        })
