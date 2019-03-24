from django.db import models
from common.models import City


class IndustrySector(models.Model):
    '''
    行业领域
    '''
    sector = models.CharField(max_length=20, verbose_name='领域名称', blank=True)

    class Meta:
        verbose_name = '行业领域'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.sector


class TagSort(models.Model):
    '''
    标签分类
    '''
    name = models.CharField(max_length=20, blank=True, verbose_name='标签分类名称')

    class Meta:
        verbose_name = '标签分类'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class CompanyTag(models.Model):
    '''
    公司标签
    '''
    name = models.CharField(max_length=20, blank=True, verbose_name='标签名称')
    tag_sort = models.ForeignKey('TagSort', verbose_name='标签类型', blank=True, on_delete=models.CASCADE,
                                 related_name='company_tag')

    class Meta:
        verbose_name = '公司标签'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class CompanyFoundingTeam(models.Model):
    '''
    公司创始团队信息
    '''
    founder_name = models.CharField(max_length=20, blank=True, verbose_name='创始人姓名')
    current_position = models.CharField(max_length=20, blank=True, verbose_name='当前职位')
    sina = models.URLField(max_length=200, blank=True, verbose_name='新浪微博')
    desc = models.CharField(max_length=500, blank=True, verbose_name='创始人简介')
    photo = models.ImageField(upload_to='Company/FoundingTeam/Founder', verbose_name='创始人头像')

    class Meta:
        verbose_name = '公司创始团队信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.founder_name


class CompanyProduct(models.Model):
    '''
    公司产品
    '''
    product_poster = models.ImageField(upload_to='Company/ProductPoster', verbose_name='产品海报')
    product_name = models.CharField(max_length=50, verbose_name='产品名称', blank=True)
    product_url = models.URLField(max_length=200, verbose_name='产品URL', blank=True, null=True)
    product_desc = models.CharField(max_length=500, verbose_name='产品简介', blank=True, null=True)

    class Meta:
        verbose_name = '公司产品'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.product_name


class Company(models.Model):
    '''
    公司信息
    '''
    scope_choices = (
        (0, '少于15人'),
        (1, '15到50人'),
        (2, '50到150人'),
        (3, '150到500人'),
        (4, '500到2000人'),
        (5, '2000人以上'),
    )
    development_stage_choices = (
        (0, '未融资'),
        (1, '天使轮'),
        (2, 'A轮'),
        (3, 'B轮'),
        (4, 'C轮'),
        (5, 'D轮以上'),
        (6, '上市公司'),
    )
    full_name = models.CharField(max_length=100, blank=True, verbose_name='公司全称')
    abbreviation_name = models.CharField(max_length=50, blank=True, verbose_name='公司简称', null=True)
    logo = models.ImageField(upload_to='Company/logo', verbose_name='公司Logo', blank=True)
    url = models.URLField(max_length=200, verbose_name='公司网址', blank=True, null=True)
    city = models.ForeignKey('common.City', verbose_name='所在城市', blank=True, on_delete=models.CASCADE, related_name='company')
    industry_sector = models.ManyToManyField('IndustrySector', verbose_name='行业领域', blank=True, related_name='company')
    scope = models.SmallIntegerField(choices=scope_choices, verbose_name='公司规模', default=1)
    development_stage = models.SmallIntegerField(verbose_name='发展阶段', choices=development_stage_choices, default=0)
    investment_agency = models.CharField(max_length=100, verbose_name='投资机构', null=True, blank=True)
    desc = models.CharField(max_length=50, verbose_name='一句话介绍', blank=True)

    class Meta:
        verbose_name = '公司信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.full_name
