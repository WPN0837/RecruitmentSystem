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
from django.contrib import admin
from django.urls import path, include, re_path
from common.views import *
from Recruitment.views import PostJobView
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', IndexView.as_view(), name='index'),
    path('register.html', RegisterView.as_view(), name='register'),
    path('company-list.html', CompanyListView.as_view(), name='company_list'),
    path('login.html', LoginView.as_view(), name='login'),
    path('logout.html', LogoutView.as_view(), name='logout'),
    path('reset.html', Reset01View.as_view(), name='reset'),
    path('verification.html', Reset02View.as_view(), name='verification'),
    path('update-password.html', Reset03View.as_view(), name='reset_update'),
    path('code.html', CheckCodeView.as_view(), name='check_code'),
    path('activation.html', ActivationView.as_view(), name='activation'),
    path('recruitment.html', PostJobView.as_view(), name='PostJob'),
    path('about.html', AboutView.as_view(), name='about'),
    path('list.html', ListView.as_view(), name='list'),
    path('search.html', SearchView.as_view(), name='search'),
    path('company-detail.html', CompanyDetailView.as_view(), name='company_detail'),
    path('position-detail.html', PositionDetailView.as_view(), name='position_detail'),
    path('resume.html', ResumeView.as_view(), name='resume'),
    path('update-pwd.html', UpdatePwd.as_view(), name='update_pwd'),
    path('submit-resume.html', SubmitResumeView.as_view(), name='submit_resume'),
    path('error.html', ErrorView.as_view(), name='error'),
    path('user/', include('JobHunting.urls', namespace='user')),
    path('recruitment/', include('Recruitment.urls', namespace='recruitment')),
    re_path('((?!media).)* ', ErrorView.as_view())
]
if settings.DEBUG:
    # static files (images, css, javascript, etc.)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
