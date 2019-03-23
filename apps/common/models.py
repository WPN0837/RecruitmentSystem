from django.db import models


class User(models.Model):
    '''
    用户登录账户信息
    '''
    identity_choice = (
        (0, '应聘者'),
        (1, '招聘者'),
    )
    email = models.EmailField(verbose_name='邮箱', blank=True, unique=True, )
    pwd = models.CharField(max_length=200, verbose_name='密码', blank=True)
    type = models.SmallIntegerField(verbose_name='身份', choices=identity_choice, blank=True)

    class Meta:
        verbose_name = '用户登录账户信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.email
