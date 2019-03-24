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
app_name = 'user'
urlpatterns = [
    path('myresume.html', MyResumeView.as_view(), name='my_resume'),
    path('resume.html', ResumeView.as_view(), name='resume'),
    path('resumeinfo.html', ResumeInfoView.as_view(), name='resumeinfo'),
    path('resumeinfoimage.html', ResumeInfoImageView, name='resumeinfoimage'),
    path('hopework.html', HopeWorkView.as_view(), name='hopework'),
    path('workexperience.html', WorkExperienceView.as_view(), name='workexperience'),
]
