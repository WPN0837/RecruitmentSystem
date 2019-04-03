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
from django.urls import path, include
from common.views import IndexView, RegisterView, LoginView, LogoutView, CheckCodeView, ActivationView, Reset01View, \
    Reset02View, Reset03View
from Recruitment.views import PostJobView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', IndexView.as_view(), name='index'),
    path('register.html', RegisterView.as_view(), name='register'),
    path('login.html', LoginView.as_view(), name='login'),
    path('logout.html', LogoutView.as_view(), name='logout'),
    path('reset.html', Reset01View.as_view(), name='reset'),
    path('verification.html', Reset02View.as_view(), name='verification'),
    path('update-password.html', Reset03View.as_view(), name='reset_update'),
    path('code.html', CheckCodeView.as_view(), name='check_code'),
    path('activation.html', ActivationView.as_view(), name='activation'),
    path('recruitment.html', PostJobView.as_view(), name='PostJob'),
    path('user/', include('JobHunting.urls', namespace='user')),
    path('recruitment/', include('Recruitment.urls', namespace='recruitment')),
]
