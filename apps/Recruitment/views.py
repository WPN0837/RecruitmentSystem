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
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
            if u and u.type:
                if hasattr(u, 'company'):
                    c = u.company
                    p = Position.objects.filter(level=1).all()
                    return render(request, 'PostJob.html', {
                        'user': u,
                        'c': c,
                        'p': p,
                    })
                else:
                    return redirect('recruitment:company01')
            else:
                return render(request, 'error.html', {'msg': ''})
        else:
            return redirect('login')

    def post(self, request):
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
        cid = request.POST.get('companyId', None)
        if cid:
            try:
                c = Company.objects.filter(id=int(cid)).first()
            except Exception as e:
                return HttpResponse('error')
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
        return HttpResponse('error')


class AddCompany01View(View):
    def get(self, request):
        sectors = IndustrySector.objects.all()
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        if hasattr(u, 'company'):
            return redirect('recruitment:company02')
        return render(request, 'add_company_info01.html', {
            'sectors': sectors,
            'user': u,
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
            pass
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
        cid = request.POST.get('companyId', None)
        tags = request.POST.get('labels', None)
        if cid and tags:
            c = Company.objects.filter(id=int(cid)).first()
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
        return render(request, 'add_company_info03.html', {
            'user': u,
            'c': c,
        })

    def post(self, request):
        cid = request.POST.get('companyId', None)
        photo = request.POST.get('photo', None)
        founder_name = request.POST.get('name', None)
        current_position = request.POST.get('position', None)
        sina = request.POST.get('weibo', None)
        desc = request.POST.get('remark', None)
        if cid:
            try:
                c = Company.objects.filter(id=int(cid)).first()
            except ValueError as e:
                return HttpResponse('error')
            if c:
                f = CompanyFoundingTeam(founder_name=founder_name, current_position=current_position, sina=sina,
                                        desc=desc,
                                        photo=photo)
                f.save()
                c.founder = f
                c.save()
                return redirect('recruitment:company04')
        return HttpResponse('error')


class AddCompany04View(View):
    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        c = u.company
        return render(request, 'add_company_info04.html', {
            'user': u,
            'c': c,
        })

    def post(self, request):
        cid = request.POST.get('companyId', None)
        product_poster0 = request.POST.get('productInfos[0].productPicUrl', None)
        product_name0 = request.POST.get('productInfos[0].product', None)
        product_url0 = request.POST.get('productInfos[0].productUrl', None)
        product_desc0 = request.POST.get('productInfos[0].productProfile', None)
        product_poster1 = request.POST.get('productInfos[1].productPicUrl', None)
        product_name1 = request.POST.get('productInfos[1].product', None)
        product_url1 = request.POST.get('productInfos[1].productUrl', None)
        product_desc1 = request.POST.get('productInfos[1].productProfile', None)
        product_poster2 = request.POST.get('productInfos[2].productPicUrl', None)
        product_name2 = request.POST.get('productInfos[2].product', None)
        product_url2 = request.POST.get('productInfos[2].productUrl', None)
        product_desc2 = request.POST.get('productInfos[2].productProfile', None)
        if cid:
            try:
                c = Company.objects.filter(id=int(cid)).first()
            except ValueError as e:
                return HttpResponse('error')
            if c:
                if product_name0:
                    p0 = CompanyProduct(product_poster=product_poster0, product_url=product_url0,
                                        product_desc=product_desc0,
                                        product_name=product_name0, company=c)
                    p0.save()
                if product_name1:
                    p1 = CompanyProduct(product_poster=product_poster1, product_url=product_url1,
                                        product_desc=product_desc1,
                                        product_name=product_name1, company=c)
                    p1.save()

                if product_name2:
                    p2 = CompanyProduct(product_poster=product_poster2, product_url=product_url2,
                                        product_desc=product_desc2,
                                        product_name=product_name2, company=c)
                    p2.save()
                return redirect('recruitment:company05')
        return HttpResponse('error')


class AddCompany05View(View):
    def get(self, request):
        email = request.session.get('email', None)
        if email:
            u = User.objects.filter(email=email).first()
        else:
            return redirect('login')
        c = u.company
        return render(request, 'add_company_info05.html', {
            'user': u,
            'c': c,
        })

    def post(self, request):
        print(request.POST)
        cid = request.POST.get('companyId', None)
        introduction = request.POST.get('companyProfile', None)
        if cid:
            try:
                c = Company.objects.filter(id=int(cid)).first()
            except ValueError as e:
                return HttpResponse('error')
            if c:
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
        return render(request, 'effective_positions.html', {
            'user': u,
            'c': c,
            'positions': positions,
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
