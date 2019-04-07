"""RecruitmentSystem URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path
from .views import *

app_name = 'recruitment'
urlpatterns = [
    path('company-info.html', AddCompany01View.as_view(), name='company01'),
    path('company-tags.html', AddCompany02View.as_view(), name='company02'),
    path('company-founder.html', AddCompany03View.as_view(), name='company03'),
    path('company-product.html', AddCompany04View.as_view(), name='company04'),
    path('company-introduction.html', AddCompany05View.as_view(), name='company05'),
    path('company-success.html', AddCompany06View.as_view(), name='company06'),
    path('positions.html', EffectivePositionsView.as_view(), name='positions'),
    path('validate_city', ValidateCityView.as_view(), name='validate_city'),
    path('company_logo.html', CompanyLogo, name='company_logo'),
    path('founder_photo.html', FounderPhoto, name='founder_photo'),
    path('product_poster.html', ProductPoster, name='product_poster'),
    path('position_info_img.html', PositionInfoImg, name='position_info_img'),
    path('position-offline.html', PositionOfflineView.as_view(), name='position_offline'),
    path('position-delete.html', PositionDeleteView.as_view(), name='position_delete'),
    path('position-detail.html', PositionDetailView.as_view(), name='position_detail'),
    path('post-position.html', PostPositionView.as_view(), name='post_position'),
    path('my-home-detail.html', MyCompanyDetailView.as_view(), name='my_home_detail'),
    path('unprocessed-resume.html', UnprocessedResumeView.as_view(), name='unprocessed_resume'),
    path('not_suitable_resume-all.html', NotSuitableResumeViewAll.as_view(), name='not_suitable_resume_all'),
    path('not_suitable_resume.html', NotSuitableResumeView.as_view(), name='not_suitable_resume'),
    path('indefinite-resume.html', IndefiniteResumeView.as_view(), name='indefinite_resume'),
    path('interview-resume.html', InterviewResumeView.as_view(), name='interview_resume'),
    path('send-mail.html', SendMailView.as_view(), name='send_mail'),
    path('interview.html', InterviewView.as_view(), name='interview'),
    path('send_inter_mail.html', SendInterMailView.as_view(), name='send_inter_mail'),
    path('resume-del.html', ResumeDelView.as_view(), name='resume_del'),
    path('resume-del-all.html', ResumeDelViewAll.as_view(), name='resume_del_all'),
]
