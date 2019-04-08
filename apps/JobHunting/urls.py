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
    path('resume-upload.html', ResumeUploadView, name='resumeupload'),
    path('resume-del.html', ResumeDelView, name='resumedel'),
    path('hopework.html', HopeWorkView.as_view(), name='hopework'),
    path('workexperience.html', WorkExperienceView.as_view(), name='workexperience'),
    path('projectexperience.html', ProjectExperienceView.as_view(), name='projectexperience'),
    path('educationalexperience.html', EducationalExperienceView.as_view(), name='educationalexperience'),
    path('selfdetail.html', SelfDetailView.as_view(), name='selfdetail'),
    path('gallery.html', GalleryView.as_view(), name='gallery'),
    path('gallerydel.html', GalleryDelView.as_view(), name='gallerydel'),
    path('resume/preview.html', ResumePreviewView.as_view(), name='preview'),
    path('educationalexperiencedel.html', EducationalExperienceDelView.as_view(), name='educationalexperiencedel'),
    path('projectexperiencedeldel.html', ProjectExperienceViewDelView.as_view(), name='projectexperiencedeldel'),
    path('workExperiencedel.html', WorkExperienceDelView.as_view(), name='workExperiencedel'),
    path('default-resume.html', DefaultResumeView.as_view(), name='default_resume'),
    path('my-collection.html', MyCollectionView.as_view(), name='my_collection'),
    path('my-subscription.html', MySubscriptionView.as_view(), name='my_subscription'),
]
