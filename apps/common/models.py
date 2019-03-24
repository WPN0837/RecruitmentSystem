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
