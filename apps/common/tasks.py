from RecruitmentSystem.celery import app
from django.core.mail import send_mail
from django.conf import settings
import json


@app.task
def send_register_email(data):
    email_title = '激活'
    email_body = '尊敬的{}用户，感谢您注册XX招聘，请点击下面链接跳转激活，' \
                 'http://127.0.0.1:8000/activation.html?token={}'.format(data['email'], data['token'])
    send_status = send_mail(email_title, email_body, settings.EMAIL_HOST_USER, [data['email']])
    if send_status:
        return True
    return False


@app.task
def send_reset_email(data):
    email_title = '重置密码'
    email_body = '您的验证码为  {}  ，如果不是您本人操作，请立即修改密码。'.format(data['code'])
    send_status = send_mail(email_title, email_body, settings.EMAIL_HOST_USER, [data['email']])
    if send_status:
        return True
    return False


@app.task
def send_submit_resume_email(data):
    email_title = '投递简历通知'
    email_body = '尊敬的{}公司HR,您于{}发布的职位收到简历投递，请立即查看\n简历地址：{}\n时间：{}'.format(data['name'], data['add_time'], data['url'],
                                                                          data['time'])
    send_status = send_mail(email_title, email_body, settings.EMAIL_HOST_USER, [data['email']])
    if send_status:
        return True
    return False
