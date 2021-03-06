from django.shortcuts import HttpResponse, render, redirect
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
from django.views import View
from common.models import User, SubmitResume
from Recruitment.models import PositionInfo, Position, IndustrySector
from .models import *
import json
import uuid
from utils.Paginator import my_Paginator


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
            work_experiences = resume.work_experience.all() if hasattr(resume, 'work_experience') else None
            project_experiences = resume.project_experience.all() if hasattr(resume,
                                                                             'project_experience') else None
            educational_experiences = resume.educational_experience.all() if hasattr(resume,
                                                                                     'educational_experience') else None
            self_detail = resume.self_detail if hasattr(resume, 'self_detail') else None
            gallerys = resume.gallery.all() if hasattr(resume, 'gallery') else None
            return render(request, 'resume.html', {
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
                   "content": {'resumeName': title, 'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S"),
                               'rid': r.id}}
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


@csrf_exempt
def ResumeUploadView(request):
    '''
    上传简历
    '''
    if request.method == 'POST':
        res = {}
        uid = request.POST.get('userId', '')
        img = request.FILES['newResume']
        url = 'static/JobHunting/resume/' + str(uuid.uuid1()) + img._name
        try:
            with open(url, 'wb')as IMG:
                for i in img.file:
                    IMG.write(i)
            u = User.objects.filter(id=int(uid)).first()
            r = u.resume
            if hasattr(r, 'resume_file'):
                r.resume_file.resume_file = url
                r.resume_file.save()
            else:
                ResumeFile.objects.create(resume=r, resume_file=url)
            res = {'success': True,
                   'content': {'nearbyName': r.title, 'time': r.resume_file.addTime.strftime("%Y-%m-%d %H:%M:%S"),
                               'url': url},
                   'code': 1}
        except Exception as e:
            res['success'] = False
            res['code'] = 0
        finally:
            return HttpResponse(json.dumps(res))


def ResumeDelView(request):
    '''
    删除简历
    :param request:
    :return:
    '''
    if request.method == 'GET':
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        try:
            if u.type:
                return redirect('/error.html?msg=删除简历失败')
            if not hasattr(u, 'resume'):
                return redirect('user:my_resume')
            if not hasattr(u.resume, 'resume_file'):
                return HttpResponse(json.dumps({'success': False}))
            ResumeFile.objects.filter(resume=u.resume).delete()
            u.resume.default = 1
            u.resume.save()
        except Exception as e:
            return HttpResponse(json.dumps({'success': False}))
        return HttpResponse(json.dumps({'success': True}))


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
        res = {'success': True,
               'content': {'url': "/",
                           'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S"),
                           'isNew': True,
                           'jsonIds': json.dumps(
                               ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                           'infoCompleteStatus': {'score': r.score},
                           'resume': {'workYear': work_ex, 'name': name, 'sex': gender, 'highestEducation': education,
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
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'content': {'expectJob': '%s | %s | %s | %s' % (city, work_sort, hope_wage, hope_position),
                               'isNew': True,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
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
        wid = request.POST.get('expid', None)
        rid = request.POST.get('id', None)
        resubmitToken = request.POST.get('resubmitToken', None)
        r = Resume.objects.filter(id=int(rid)).first()
        r.save()
        if wid:
            w = WorkExperience.objects.filter(id=int(wid)).first()
            w.company_name = company_name
            w.position = position
            w.start_year = start_year
            w.start_month = start_month
            w.end_year = end_year
            w.end_month = end_month
            w.save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'content': {'isNew': False,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'workExperiences': (
                                   {'id': '', 'startYear': start_year, 'endYear': end_year, 'startMonth': start_month,
                                    'endMonth': end_month, "startDate": start_year + ":" + start_month,
                                    'endDate': end_year + ":" + end_month, 'companyLogo': '',
                                    'companyName': company_name,
                                    'positionName': position}),
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }
        else:
            w = WorkExperience(company_name=company_name, position=position, start_year=start_year,
                               start_month=start_month, end_year=end_year, end_month=end_month, resume=r)
            w.save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'content': {'isNew': True,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'workExperiences': (
                                   {'id': '', 'startYear': start_year, 'endYear': end_year, 'startMonth': start_month,
                                    'endMonth': end_month, "startDate": start_year + ":" + start_month,
                                    'endDate': end_year + ":" + end_month, 'companyLogo': '',
                                    'companyName': company_name,
                                    'positionName': position}),
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }

        return HttpResponse(json.dumps(res))


class WorkExperienceDelView(View):
    '''
    删除工作经验
    '''

    def post(self, request):
        email = request.session.get('email', '')
        user = User.objects.filter(email=email).first()
        if not user:
            return redirect('login')
        wid = request.POST.get('id', None)
        if WorkExperience.objects.filter(id=int(wid)).exists():
            WorkExperience.objects.filter(id=int(wid)).delete()
            res = {'success': True}
            return HttpResponse(json.dumps(res))


class ProjectExperienceView(View):
    '''
    项目经验
    '''

    def post(self, request):
        project_name = request.POST.get('projectName', None)
        position = request.POST.get('positionName', None)
        start_year = request.POST.get('startYear', None)
        start_month = request.POST.get('startMonth', None)
        end_year = request.POST.get('endYear', None)
        end_month = request.POST.get('endMonth', None)
        project_detail = request.POST.get('projectRemark', None)
        pid = request.POST.get('projectid', None)
        rid = request.POST.get('id', None)
        resubmitToken = request.POST.get('resubmitToken', None)
        r = Resume.objects.filter(id=int(rid)).first()
        r.save()
        if pid:
            p = ProjectExperience.objects.filter(id=int(pid)).first()
            p.project_name = project_name
            p.position = position
            p.start_year = start_year
            p.start_month = start_month
            p.end_year = end_year
            p.end_month = end_month
            p.project_detail = project_detail
            p.save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'code': '',
                   'content': {'isNew': False,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'projectExperience': {'id': p.id, 'projectName': project_name, 'positionName': position,
                                                     'startYear': start_year,
                                                     'startMonth': start_month, 'endYear': end_year,
                                                     'endMonth': end_month,
                                                     'projectNameAndRemark': project_name + ":" + project_detail,
                                                     'startDate': start_year + "." + start_month,
                                                     'endDate': end_year + "." + end_month,
                                                     'projectRemark': project_detail},
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }
        else:
            p = ProjectExperience(project_name=project_name, position=position, start_year=start_year,
                                  project_detail=project_detail,
                                  start_month=start_month, end_year=end_year, end_month=end_month, resume=r)
            p.save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'code': '',
                   'content': {'isNew': True,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'projectExperience': {'id': p.id, 'projectName': project_name, 'positionName': position,
                                                     'startYear': start_year,
                                                     'startMonth': start_month, 'endYear': end_year,
                                                     'endMonth': end_month,
                                                     'projectNameAndRemark': project_name + ":" + project_detail,
                                                     'startDate': start_year + "." + start_month,
                                                     'endDate': end_year + "." + end_month,
                                                     'projectRemark': project_detail},
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }
        return HttpResponse(json.dumps(res))


class ProjectExperienceViewDelView(View):
    '''
    删除项目经验
    '''

    def post(self, request):
        email = request.session.get('email', '')
        user = User.objects.filter(email=email).first()
        if not user:
            return redirect('login')
        pid = request.POST.get('id')
        if ProjectExperience.objects.filter(id=int(pid)).exists():
            ProjectExperience.objects.filter(id=int(pid)).delete()
            res = {'sueccess': True}
            return HttpResponse(json.dumps(res))


class EducationalExperienceView(View):
    '''
    教育经历
    '''

    def post(self, request):
        school_name = request.POST.get('schoolName', None)
        education = request.POST.get('education', None)
        professional = request.POST.get('professional', None)
        start_year = request.POST.get('startYear', None)
        end_year = request.POST.get('endYear', None)
        rid = request.POST.get('id', None)
        eid = request.POST.get('eduid', None)
        resubmitToken = request.POST.get('resubmitToken', None)
        r = Resume.objects.filter(id=int(rid)).first()
        r.save()
        if eid:
            e = EducationalExperience.objects.filter(id=int(eid)).first()
            e.school_name = school_name
            e.education = education
            e.professional = professional
            e.start_year = start_year
            e.end_year = end_year
            e.save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'code': '',
                   'content': {'isNew': False,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'educationExperiences': ({'id': e.id, 'schoolName': school_name, 'education': education,
                                                         'startYear': start_year, 'endYear': end_year,
                                                         'professional': professional,
                                                         'startDate': start_year,
                                                         'endDate': end_year, }),
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }
        else:
            e = EducationalExperience(school_name=school_name, education=education, start_year=start_year,
                                      professional=professional, end_year=end_year, resume=r)
            e.save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'code': '',
                   'content': {'isNew': True,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'educationExperiences': ({'id': e.id, 'schoolName': school_name, 'education': education,
                                                         'startYear': start_year, 'endYear': end_year,
                                                         'professional': professional,
                                                         'startDate': start_year,
                                                         'endDate': end_year, }),
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }
        return HttpResponse(json.dumps(res))


class EducationalExperienceDelView(View):
    '''
    删除教育经历
    '''

    def post(self, request):
        eid = request.POST.get('id', None)
        if eid:
            if EducationalExperience.objects.filter(id=int(eid)).exists():
                EducationalExperience.objects.filter(id=int(eid)).delete()
                res = {'success': True}
                return HttpResponse(json.dumps(res))


class SelfDetailView(View):
    '''
    自我描述
    '''

    def post(self, request):
        detail = request.POST.get('myRemark', None)
        rid = request.POST.get('id', None)
        resubmitToken = request.POST.get('resubmitToken', None)
        r = Resume.objects.filter(id=int(rid)).first()
        if r:
            r.save()
            if hasattr(r, 'self_detail'):
                ri = r.self_detail
                ri.detail = detail
                ri.save()
            else:
                ri = SelfDetail(detail=detail, resume=r).save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'code': '',
                   'content': {'isNew': True,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'resume': {'id': '', 'myRemark': detail},
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }
        else:
            res = {'success': False}
        return HttpResponse(json.dumps(res))


class GalleryView(View):
    '''
    作品展示
    '''

    def post(self, request):
        print(request.POST)
        url = request.POST.get('url', None)
        detail = request.POST.get('workName', None)
        rid = request.POST.get('id', None)
        resubmitToken = request.POST.get('resubmitToken', None)
        gid = request.POST.get('wsid', None)
        r = Resume.objects.filter(id=int(rid)).first()
        r.save()
        if gid:
            g = Gallery.objects.filter(id=int(gid)).first()
            g.url = url
            g.detail = detail
            g.save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'code': 3,
                   'content': {'isNew': False,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'workShow': {'id': g.id, 'url': url, 'workName': detail},
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }
        else:
            ri = Gallery(detail=detail, url=url, resume=r)
            ri.save()
            res = {'success': True,
                   'resubmitToken': resubmitToken,
                   'code': 3,
                   'content': {'isNew': True,
                               'jsonIds': json.dumps(
                                   ({'resumeId': {'n': rid}, 'expId': '', 'eduId': '', 'projectId': '', 'showId': ''})),
                               'workShow': {'id': ri.id, 'url': url, 'workName': detail},
                               'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score},
                               'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S")}, }

        return HttpResponse(json.dumps(res))


class GalleryDelView(View):
    '''
    删除作品
    '''

    def post(self, request):
        email = request.session.get('email', '')
        user = User.objects.filter(email=email).first()
        if not user:
            return redirect('login')
        gid = request.POST.get('id', None)
        # rid = request.POST.get('rid', None)
        # r = Resume.objects.filter(id=int(rid)).first()
        # r.save()
        if Gallery.objects.filter(id=int(gid)).exists():
            Gallery.objects.filter(id=int(gid)).delete()
            res = {'success': True,
                   'content': {
                       'workShows': '1',
                       # 'refreshTime': r.last_time.strftime("%Y-%m-%d %H:%M:%S"),
                       # 'infoCompleteStatus': {'msg': '', 'nextStage': '', 'score': r.score}
                   }}
            return HttpResponse(json.dumps(res))


class ResumePreviewView(View):
    '''
    预览简历
    '''

    def get(self, request):
        email = request.session.get('email', '')
        user = User.objects.filter(email=email).first()
        if not user:
            return redirect('login')
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


class DefaultResumeView(View):
    '''
    默认简历设置
    '''

    def get(self, request):
        res = {'success': True, 'content': [{'isDefault': True, 'type': '附件简历', 'perfect': True},
                                            {'isDefault': True, 'type': '在线简历', 'perfect': True}]}
        email = request.session.get('email', '')
        user = User.objects.filter(email=email).first()
        if not user:
            return redirect('login')
        if not hasattr(user, 'resume'):
            return redirect('user:my_resume')
        if user.resume.default:
            res['content'][0]['isDefault'] = False
        else:
            res['content'][1]['isDefault'] = False
        if not hasattr(user.resume, 'resume_file'):
            res['content'][0]['perfect'] = False
        return HttpResponse(json.dumps(res))

    def post(self, request):
        t = request.POST.get('type', None)
        email = request.session.get('email', '')
        user = User.objects.filter(email=email).first()
        if not user:
            return HttpResponse(json.dumps({'success': False, 'msg': '修改失败1'}))
        if t:
            try:
                t = int(t)
            except Exception as e:
                return HttpResponse(json.dumps({'success': False, 'msg': '修改失败2'}))
            if not hasattr(user, 'resume'):
                return HttpResponse(json.dumps({'success': False, 'msg': '修改失败3'}))
            if t == 1:
                user.resume.default = 1
                user.resume.save()
            elif t == 0:
                user.resume.default = 0
                user.resume.save()
            else:
                return HttpResponse(json.dumps({'success': False, 'msg': '修改失败4'}))
        return HttpResponse(json.dumps({'success': True}))


class MyCollectionView(View):
    '''
    我收藏的职位
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        page = request.GET.get('page', 1)  # 页码
        try:
            page = int(page)
        except Exception as e:
            return redirect('/error.html?msg=没有找到该页面')
        pcs = PositionCollection.objects.filter(user=u).order_by('-id')
        pcs = my_Paginator(pcs, 10, 6, page)
        return render(request, 'collections.html', {
            'user': u,
            'pcs': pcs,
            'page': page,
        })

    def post(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return HttpResponse(json.dumps({'success': False, 'msg': '您还没有登录'}))
        objid = request.POST.get('positionId', 0)
        t = request.POST.get('type', '')
        try:
            t = int(t)
            objid = int(objid)
        except Exception as e:
            return HttpResponse(json.dumps({'success': False, 'msg': '操作失败'}))
        if t == 1:
            if not PositionInfo.objects.filter(id=objid).exists():
                return HttpResponse(json.dumps({'success': False, 'msg': '收藏错误'}))
            if not PositionCollection.objects.filter(user_id=u.id, position_id=objid).exists():
                PositionCollection.objects.create(user=u, position_id=objid)
            return HttpResponse(json.dumps({'success': True, 'content': {'showStts': 0}}))
        elif t == 0:
            if not PositionInfo.objects.filter(id=objid).exists():
                return HttpResponse(json.dumps({'success': False, 'msg': '取消收藏错误'}))
            if PositionCollection.objects.filter(user_id=u.id, position_id=objid).exists():
                PositionCollection.objects.filter(user=u, position_id=objid).delete()
            return HttpResponse(json.dumps({'success': True, 'content': {'showStts': 1}}))
        else:
            return HttpResponse(json.dumps({'success': False, 'msg': '操作失败'}))


class MySubscriptionView(View):
    '''
    我的订阅
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        s = Subscription.objects.filter(user=u).first()
        return render(request, 'subscribe01.html', {
            'user': u,
            's': s,
        })


class EditSubscriptionView(View):
    '''
    添加订阅
    '''

    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        sid = request.GET.get('id', '')
        p = Position.objects.filter(level=1).all()
        isr = IndustrySector.objects.all()
        sa = ['2k以下', '2k-5k', '5k-10k', '10k-15k', '15k-25k', '25k-50k', '50k以上']
        fs = [['初创型', '刚成立或已获得天使投资'], ['成长型', '已获得A轮/B轮/C轮融资'], ['成熟型', '有D轮及以上的融资'], ['上市公司', '上市公司']]
        s = None
        if sid:
            try:
                s = Subscription.objects.filter(id=int(sid)).first()
            except Exception as e:
                return redirect('/error.html?msg=没有找到相关信息')
        return render(request, 'subscribe.html', {
            'user': u,
            'p': p,
            'isr': isr,
            'sa': sa,
            's': s,
            'fs': fs,
        })

    def post(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        sid = request.POST.get('id', '')
        cycle = request.POST.get('sendMailPer', '')
        email = request.POST.get('email', '')
        city = request.POST.get('city', '')
        finance_stage = request.POST.get('financeStage', '')
        industry_sector = request.POST.get('industryField', '')
        position = request.POST.get('positionName', '')
        salary = request.POST.get('salary', '')
        if sid:
            try:
                sid = int(sid)
                Subscription.objects.filter(user=u, id=sid).update(email=email, city=city, cycle=cycle,
                                                                   finance_stage=finance_stage,
                                                                   salary=salary,
                                                                   industry_sector=industry_sector,
                                                                   position=position)
            except Exception as e:
                return redirect('/error.html?msg=没有找到相关信息')
        else:
            if Subscription.objects.filter(user=u).exists():
                return HttpResponse(json.dumps(
                    {'success': False, 'content': {'commonError': '最多只能创建一个订阅器', 'cityError': '', 'stageError': ''}}))
            try:
                Subscription.objects.create(email=email, city=city, cycle=cycle, finance_stage=finance_stage,
                                            salary=salary,
                                            industry_sector=industry_sector, position=position, user=u)
            except Exception as e:
                return redirect('/error.html?msg=订阅失败')
        return HttpResponse(json.dumps({'success': True, 'code': 0}))


class DelSubscriptionView(View):
    '''
    删除订阅
    '''

    def post(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        sid = request.POST.get('id', '')
        if sid:
            try:
                Subscription.objects.filter(id=int(sid)).delete()
            except Exception as e:
                return HttpResponse(json.dumps({'success': False, 'msg': '删除失败'}))
            return HttpResponse(json.dumps({'success': True}))
        return HttpResponse(json.dumps({'success': False, 'msg': '删除失败'}))


class ResumeStatusView(View):
    '''
    投递的简历状态
    '''
    def get(self, request):
        email = request.session.get('email', '')
        u = User.objects.filter(email=email).first()
        if not u:
            return redirect('login')
        tag = request.GET.get('tag', '0')
        page = request.GET.get('page', 1)
        try:
            page = int(page)
        except Exception as e:
            return redirect('/error.html?msg=没有找到该页面')
        srs = SubmitResume.objects.filter(resume__user=u).order_by('-id')
        if tag == '1':
            srs = srs.filter(status=1)
        elif tag == '2':
            srs = srs.filter(offer=1)
        elif tag == '3':
            srs = srs.filter(offer=3)
        else:
            tag = '0'
        srs = my_Paginator(srs, 10, 6, page)
        return render(request, 'delivery.html', {
            'user': u,
            'srs': srs,
            'tag': tag,
            'page': page,
        })
