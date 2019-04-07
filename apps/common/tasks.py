from RecruitmentSystem.celery import app
from django.core.mail import send_mail
from django.conf import settings
import json


@app.task
def send_register_email(data):
    '''
    激活邮件
    :param data:
    :return:
    '''
    email_title = '激活'
    email_body = '尊敬的{}用户，感谢您注册XX招聘，请点击下面链接跳转激活，' \
                 'http://127.0.0.1:8000/activation.html?token={}'.format(data['email'], data['token'])
    send_status = send_mail(email_title, email_body, settings.EMAIL_HOST_USER, [data['email']])
    if send_status:
        return True
    return False


@app.task
def send_reset_email(data):
    '''
    重置密码邮件
    :param data:
    :return:
    '''
    email_title = '重置密码'
    email_body = '您的验证码为  {}  ，如果不是您本人操作，请立即修改密码。'.format(data['code'])
    send_status = send_mail(email_title, email_body, settings.EMAIL_HOST_USER, [data['email']])
    if send_status:
        return True
    return False


@app.task
def send_submit_resume_email(data):
    '''
    投递简历通知邮件(通知company)
    :param data:
    :return:
    '''
    email_title = '投递简历通知'
    email_body = '尊敬的{}公司HR,您于{}发布的职位收到简历投递，请立即查看\n简历地址：{}\n时间：{}'.format(data['name'], data['add_time'], data['url'],
                                                                          data['time'])
    send_status = send_mail(email_title, email_body, settings.EMAIL_HOST_USER, [data['email']])
    if send_status:
        return True
    return False


@app.task
def send_submit_resume_pass_email(data):
    '''
    简历不适合通知邮件
    :param data:
    :return:
    '''
    email_title = '简历通知'
    email_body = '{}\n{}'.format(data['content'], data['time'])
    send_status = send_mail(email_title, email_body, settings.EMAIL_HOST_USER, [data['email']])
    if send_status:
        return True
    return False


from django.core.mail import EmailMessage


@app.task
def send_inter_email(data):
    '''
    面试通知邮件
    :param data:
    :return:
    '''
    email_title = data['subject']
    email_body = '''<p>{name}先生/女士：</p><p>　　您好！</p><p>　　很高兴收阅您对{positionName}岗位的应聘简历，感谢您对我公司的信任和选择。您的简历已通过我公司的初步筛选，为了促进双方进一步了解，诚邀您到我们公司参加面试。具体事宜如下：</p><p>　　1、 面试时间：{interTime}</p><p>　　2、 面试地点：{interAdd}</p><p>　　3、 联系人：{linkMan}</p><p>　　4、 联系电话：{linkPhone}</p><p>　　5、 为提高面试成功率，请您准备以下资料</p><p>　　1）简历一份；</p><p>　　2）身份证原件及复件一份；</p><p>　　3） 学历、学位证书原件及复印件一份；</p><p>　　4）职称证书及复印件一份；</p><p>　　5） 职业资格证书及及复印件一份；</p><p>　　6） 其它能够证明您个人工作能力与业绩的材料。</p><p>　　6、 路线提示</p><p>　　{content}</p><p>　　最后，建议在面试前在我公司网站再次进行了解，便于您充分确认我公司与岗位要求，祝您面试愉快。若有疑问或需改期请及时与我联系。建议采用规定时间，避免再次协调对双方的耽误。面试通过后，会在两周后确认通知。 {companyName}</p><p style="text-align: right;">　　（人事行政部）</p><p style="text-align: right;">　　{time}</p>'''.format(
        name=data['name'], positionName=data['positionName'], interTime=data['interTime'], linkMan=data['linkMan'],
        content=data['content'], time=data['time'], companyName=data['companyName'], interAdd=data['interAdd'],
        linkPhone=data['linkPhone'])
    try:
        send_status = EmailMessage(email_title, email_body, settings.EMAIL_HOST_USER, [data['email']])
        send_status.content_subtype = 'html'
        send_status.send()
    except Exception as e:
        return False
    return True
