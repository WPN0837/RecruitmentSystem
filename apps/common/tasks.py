from RecruitmentSystem.celery import app
from django.core.mail import send_mail
from django.conf import settings
import json


@app.task
def send_register_email(email, token):
    email_title = '激活'
    email_body = '尊敬的{}用户，感谢您注册XX招聘，请点击下面链接跳转激活，' \
                 'http://127.0.0.1:8000/activation.html?token={}'.format(email, token)
    send_status = send_mail(email_title, email_body, settings.EMAIL_HOST_USER, [email])
    if send_status:
        pass
