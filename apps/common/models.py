from django.db import models


class Province(models.Model):
    '''
    省份
    '''
    name = models.CharField(max_length=20, blank=True, verbose_name='省份名称')

    class Meta:
        verbose_name = '省份'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class City(models.Model):
    '''
    城市
    '''
    name = models.CharField(max_length=20, blank=True, verbose_name='城市名称')
    province = models.ForeignKey('Province', verbose_name='省份', on_delete=models.CASCADE, blank=True,
                                 related_name='city')

    class Meta:
        verbose_name = '城市'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class HotCity(models.Model):
    '''
    热门城市
    '''
    name = models.CharField(max_length=20, blank=True, verbose_name='城市名称')
    first = models.CharField(max_length=1, blank=True, verbose_name='拼音首字母')

    class Meta:
        verbose_name = '热门城市'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class User(models.Model):
    '''
    用户登录账户信息
    '''
    identity_choice = (
        (0, '应聘者'),
        (1, '招聘者'),
    )
    activation_choices = (
        (0, '未激活'),
        (1, '已激活')
    )
    email = models.EmailField(verbose_name='邮箱', blank=True, unique=True, )
    pwd = models.CharField(max_length=200, verbose_name='密码', blank=True)
    type = models.SmallIntegerField(verbose_name='身份', choices=identity_choice, blank=True)
    activation = models.SmallIntegerField(verbose_name='激活', choices=activation_choices, default=0, blank=True)

    class Meta:
        verbose_name = '用户登录账户信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.email


# from JobHunting.models import Resume
# from Recruitment.models import PositionInfo


class SubmitResume(models.Model):
    '''
    投递的简历
    '''
    status_choices = (
        (0, '未阅读'),
        (1, '已阅读')
    )
    sort_choices = (
        (0, '附件简历'),
        (1, '在线简历')
    )
    delete_choices = (
        (0, '删除'),
        (1, '未删除')
    )
    offer_choices = (
        (0, '未处理'),
        (1, '已通知面试'),
        (2, '待定'),
        (3, '不合适')
    )
    resume = models.ForeignKey('JobHunting.Resume', verbose_name='简历', blank=True, on_delete=models.CASCADE)
    position = models.ForeignKey('Recruitment.PositionInfo', verbose_name='职位', blank=True, on_delete=models.CASCADE)
    add_time = models.DateTimeField(verbose_name='投递时间', blank=True, auto_now_add=True)
    status = models.SmallIntegerField(verbose_name='简历状态', choices=status_choices, default=0, blank=True)
    sort = models.SmallIntegerField(verbose_name='简历类型', choices=sort_choices, default=1, blank=True)
    delete = models.SmallIntegerField(verbose_name='删除', choices=delete_choices, default=1, blank=True)
    offer = models.SmallIntegerField(verbose_name='简历是否通过状态', choices=offer_choices, default=0, blank=True)

    class Meta:
        verbose_name = '收藏职位'
        verbose_name_plural = verbose_name
        unique_together = ['resume', 'position']
