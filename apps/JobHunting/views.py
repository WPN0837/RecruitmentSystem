from django.shortcuts import HttpResponse, render, redirect
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
from django.views import View
from common.models import User
from .models import *
import json
import uuid


# Create your views here.
class MyResumeView(View):
    '''
    我的简历
    '''

    def get(self, request):
        email = request.session.get('email', None)
        if email:
            user = User.objects.get(email=email)
            resume = user.resume if hasattr(user, 'resume') else None
            resume_info = resume.resume_info if hasattr(resume, 'resume_info') else None
            hope_work = resume.hope_work if hasattr(resume, 'hope_work') else None
            work_experience = resume.work_experience if hasattr(resume, 'work_experience') else None
            project_experience = resume.project_experience if hasattr(resume, 'project_experience') else None
            educational_experience = resume.educational_experience if hasattr(resume,
                                                                              'educational_experience') else None
            self_detail = resume.self_detail if hasattr(resume, 'self_detail') else None
            gallery = resume.gallery if hasattr(resume, 'gallery') else None
            return render(request, 'resume.html', {
                'user': user,
                'resume': resume,
                'resume_info': resume_info,
                'hope_work': hope_work,
                'work_experience': work_experience,
                'project_experience': project_experience,
                'educational_experience': educational_experience,
                'self_detail': self_detail,
                'gallery': gallery,
            })
        return redirect('login')


class ResumeView(View):
    '''
    简历
    '''

    def post(self, request):
        title = request.POST.get('title', None)
        rid = request.POST.get('rid', None)
        if rid:
            r = Resume.objects.filter(id=int(rid)).first()
            r.title = title
            r.save()
            res = {'success': True,
                   "content": {'resumeName': title, 'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}}
        else:
            email = request.session.get('email', None)
            u = User.objects.filter(email=email).first()
            r = Resume.objects.create(title=title, user=u)
            res = {'success': True,
                   "content": {'resumeName': title, 'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}}
        return HttpResponse(json.dumps(res))


@csrf_exempt
def ResumeInfoImageView(request):
    '''
    上传头像
    '''
    if request.method == 'POST':
        res = {'success': True, 'content': ''}
        rid = request.POST.get('rid', None)
        img = request.FILES['headPic']
        url = 'static/JobHunting/photo/' + str(uuid.uuid1()) + img._name
        res['content'] = url
        try:
            with open(url, 'wb')as IMG:
                for i in img.file:
                    IMG.write(i)
            r = Resume.objects.filter(id=int(rid)).first()
            if r:
                if hasattr(r, 'resume_info'):
                    ri = r.resume_info
                    ri.photo = url
                    ri.save()
                else:
                    ResumeInfo(photo=url, resume=r).save()
                r.save()
        except Exception as e:
            res['success'] = False
        finally:
            return HttpResponse(json.dumps(res))


class ResumeInfoView(View):
    '''
    基本信息
    '''

    def post(self, request):
        name = request.POST.get('name', None)
        gender = request.POST.get('gender', None)
        education = request.POST.get('education', None)
        work_ex = request.POST.get('work_ex', None)
        current_status = request.POST.get('current_status', None)
        phone = request.POST.get('phone', None)
        rid = request.POST.get('id', None)
        email = request.POST.get('email', None)
        r = Resume.objects.filter(id=int(rid)).first()
        if r:
            r.save()
            if hasattr(r, 'resume_info'):
                ri = r.resume_info
                ri.name = name
                ri.gender = gender
                ri.education = education
                ri.work_ex = work_ex
                ri.current_status = current_status
                ri.phone = phone
                ri.resume = r
                ri.save()
            else:
                ResumeInfo(name=name, gender=gender, education=education, work_ex=work_ex,
                           current_status=current_status, phone=phone, resume=r).save()
        res = {'success': True, 'content': {'url': "/user/myresume.html",
                                            'resume': {'workYear': work_ex, 'name': name, 'sex': gender,
                                                       'highestEducation': education,
                                                       'phone': phone, 'email': email, 'status': current_status}}}
        return HttpResponse(json.dumps(res))


class HopeWorkView(View):
    '''
    期望工作
    '''

    def post(self, request):
        city = request.POST.get('city', None)
        work_sort = request.POST.get('positionType', None)
        hope_position = request.POST.get('positionName', None)
        hope_wage = request.POST.get('salarys', None)
        rid = request.POST.get('id', None)
        resubmitToken = request.POST.get('resubmitToken', None)
        r = Resume.objects.filter(id=int(rid)).first()
        if r:
            r.save()
            if hasattr(r, 'hope_work'):
                ri = r.hope_work
                ri.city = city
                ri.work_sort = work_sort
                ri.hope_position = hope_position
                ri.hope_wage = hope_wage
                ri.save()
            else:
                HopeWork(city=city, work_sort=work_sort, hope_position=hope_position, hope_wage=hope_wage,
                         resume=r).save()
            res = {'success': True, 'resubmitToken': resubmitToken,
                   'content': {'expectJob': hope_position, 'isNew': '', 'jsonIds': '',
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S"),
                               'resume': {'expectJob': hope_position, 'city': city, 'positionType': work_sort,
                                          'positionName': hope_position,
                                          'salarys': hope_wage},
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score}}}
        else:
            res = {'success': False}
        return HttpResponse(json.dumps(res))


class WorkExperienceView(View):
    '''
    工作经历
    '''

    def post(self, request):
        company_name = request.POST.get('companyName', None)
        position = request.POST.get('positionName', None)
        start_year = request.POST.get('startYear', None)
        start_month = request.POST.get('startMonth', None)
        end_year = request.POST.get('endYear', None)
        end_month = request.POST.get('endMonth', None)
        rid = request.POST.get('id', None)
        resubmitToken = request.POST.get('resubmitToken', None)
        r = Resume.objects.filter(id=int(rid)).first()
        if r:
            r.save()
            if hasattr(r, 'work_experience'):
                ri = r.work_experience
                ri.company_name = company_name
                ri.position = position
                ri.start_year = start_year
                ri.start_month = start_month
                ri.end_year = end_year
                ri.end_month = end_month
                ri.save()
            else:
                ri = WorkExperience(company_name=company_name, position=position, start_year=start_year,
                                    start_month=start_month, end_year=end_year, end_month=end_month, resume=r).save()
            res = {'success': True, 'resubmitToken': resubmitToken,
                   'content': {'isNew': '', 'jsonIds': '', 'workExperiences': (
                       {'id': '', 'startYear': start_year, 'endYear': end_year, 'startMonth': start_month,
                        'endMonth': end_month, "startDate": start_year + ":" + start_month,
                        'endDate': end_year+":"+end_month, 'companyLogo': '', 'companyName': company_name, 'positionName': position}),
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }
        else:
            res = {'success': False}
        return HttpResponse(json.dumps(res))
