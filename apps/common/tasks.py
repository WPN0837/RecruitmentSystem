from RecruitmentSystem.celery import app
from django.core.mail import send_mail
from django.conf import settings
from datetime import datetime
from JobHunting.models import Subscription
from Recruitment.models import PositionInfo, Company
from django.core.mail import EmailMessage


@app.task
def send_register_email(data):
    '''
    激活邮件
    :param data:
    :return:
    '''
    email_title = '激活'
    email_body = '尊敬的{}用户，感谢您注册寻寻招聘，请点击下面链接跳转激活，' \
                 'http://{}/activation.html?token={}'.format(data['email'], settings.SELF_HOST_NAME, data['token'])
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
    return SM(email_title=email_title, email_body=email_body, email=[data['email']])


@app.task
def send_subscription_3_email():
    '''
    订阅邮件
    :param data:
    :return:
    '''
    filter(3)


@app.task
def send_subscription_7_email():
    '''
    订阅邮件
    :param data:
    :return:
    '''
    filter(7)


def SM(email_title, email_body, email):
    '''
    发送html格式邮件
    :param email_title:
    :param email_body:
    :param email:
    :return:
    '''
    try:
        send_status = EmailMessage(email_title, email_body, settings.EMAIL_HOST_USER, email)
        send_status.content_subtype = 'html'
        send_status.send()
    except Exception as e:
        return False
    return True


def filter(days=0):
    salary = ['2k以下', '2k-5k', '5k-10k', '10k-15k', '15k-25k', '25k-50k', '50k以上']
    development_stage = {'初创型': ['未融资', '天使轮', ], '成长型': ['A轮', 'B轮', 'C轮', ], '成熟型': ['D轮以上'], '已上市': ['上市公司']}
    email_title = '订阅邮件'
    s = Subscription.objects.filter(cycle=days).all()
    for i in s:
        email = i.email
        name = i.user.resume.resume_info.name
        positions = PositionInfo.objects.filter(workAddress=i.city, position=i.position,
                                                company__development_stage__in=development_stage[i.finance_stage],
                                                company__industry_sector__sector=i.industry_sector).order_by('-id')[:10]
        if i.salary in salary:
            csy_positions = []
            if salary.index(i.salary) == 0:
                for j in positions:
                    if j.salaryMin <= 2:
                        csy_positions.append(j)
            elif salary.index(i.salary) == 6:
                for j in positions:
                    if j.salaryMax >= 50:
                        csy_positions.append(j)
            else:
                mi, ma = [j.strip('k') for j in i.salary.split('-')]
                for j in positions:
                    if j.salaryMin <= int(mi) <= j.salaryMax and j.salaryMin <= int(ma) <= j.salaryMax:
                        csy_positions.append(j)
            positions = csy_positions
        if not positions:
            email_body = '''<p>{name}先生/女士：</p><p>　　您好！</p><p>　　很抱歉，最近{days}天没有符合您的订阅通知的职位！</p><p style="text-align: right;">　　{time}</p>'''.format(
                name=name, days=days, time=datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        else:
            email_body = '<p>{name}先生/女士：</p><p>　　您好！</p><p>　　请查收，最近{days}天您的订阅的职位信息</p>'.format(name=name, days=days)
            email_body += '<table><tr><td>公司名称</td><td>职位名称</td><td>城市</td></tr>'
            for j in positions:
                email_body += '<tr><td><a href="http://{host}/company-detail.html?id={company_id}">{company_name}</a></td><td><a href="http://{host}/position-detail.html?id={positon_id}">{positon_name}</a></td><td>{positon_city}</td></tr>'.format(
                    company_name=j.company.full_name, company_id=j.company.id, host=settings.SELF_HOST_NAME,
                    positon_name=j.position, positon_id=j.id, positon_city=j.workAddress)
            email_body += '</table><p style="text-align: right;">　　{time}</p>'.format(
                time=datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        SM(email_title=email_title, email_body=email_body, email=[email, ])