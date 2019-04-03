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
]
