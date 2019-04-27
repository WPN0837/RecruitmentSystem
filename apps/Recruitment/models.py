from django.db import models
from django.utils.html import format_html


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
    company = models.OneToOneField('Company', on_delete=models.CASCADE, related_name='founder', verbose_name='公司',
                                   blank=True)

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
    company = models.OneToOneField('Company', verbose_name='公司', related_name='product', on_delete=models.CASCADE,
                                   blank=True)

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
    full_name = models.CharField(db_index=True, max_length=100, blank=True, verbose_name='公司全称')
    abbreviation_name = models.CharField(db_index=True, max_length=50, blank=True, verbose_name='公司简称', null=True)
    logo = models.ImageField(upload_to='Company/logo', verbose_name='公司Logo', null=True, blank=True)
    url = models.URLField(max_length=200, verbose_name='公司网址', blank=True, null=True)
    city = models.CharField(max_length=10, verbose_name='所在城市', blank=True, )
    industry_sector = models.ManyToManyField('IndustrySector', verbose_name='行业领域', blank=True, related_name='company')
    scope = models.CharField(max_length=50, verbose_name='公司规模', default=1)
    development_stage = models.CharField(max_length=50, verbose_name='发展阶段', default=0)
    desc = models.CharField(max_length=50, verbose_name='一句话介绍', blank=True)
    tags = models.ManyToManyField('CompanyTag', verbose_name='标签', related_name='company', blank=True)
    user = models.OneToOneField('common.User', verbose_name='用户', on_delete=models.CASCADE, related_name='company',
                                blank=True)
    level = models.IntegerField(db_index=True, verbose_name='等级', blank=True, default=0)

    def logo_data(self):
        return format_html(
            '<img src="{}" width="100px"/>',
            self.logo,
        )

    logo_data.short_description = 'Logo'

    class Meta:
        verbose_name = '公司信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.full_name

    @property
    def sector(self):
        return ','.join([i.sector for i in self.industry_sector.all()])


class CompanyIntroduction(models.Model):
    '''
    公司介绍
    '''
    introduction = models.TextField(verbose_name='公司介绍', blank=True)
    company = models.OneToOneField('Company', verbose_name='公司', on_delete=models.CASCADE, blank=True,
                                   related_name='introduction')

    class Meta:
        verbose_name = '公司介绍'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.company.abbreviation_name


class Position(models.Model):
    '''
    职位
    '''
    name = models.CharField(max_length=20, blank=True, verbose_name='职位名称', )
    level = models.IntegerField(db_index=True, verbose_name='等级', blank=True, default=1)
    hot = models.IntegerField(db_index=True, default=0, verbose_name='热度', blank=True)
    pid = models.ForeignKey('Position', on_delete=models.CASCADE, null=True, verbose_name='父级职位', blank=True,
                            related_name='son')

    class Meta:
        verbose_name = '职位'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class PositionInfo(models.Model):
    '''
    职位信息
    '''
    status_choices = (
        (0, '有效职位'),
        (1, '过期职位'),
        (2, '删除')
    )
    positionType = models.CharField(db_index=True, max_length=20, blank=True, verbose_name='职位类别')
    position = models.CharField(db_index=True, max_length=20, blank=True, verbose_name='职位名称')
    department = models.CharField(max_length=20, blank=True, verbose_name='所属部门', null=True)
    jobNature = models.CharField(max_length=20, blank=True, verbose_name='工作性质')
    salaryMin = models.IntegerField(blank=True, verbose_name='月薪下限')
    salaryMax = models.IntegerField(blank=True, verbose_name='月薪上限')
    workAddress = models.CharField(max_length=20, blank=True, verbose_name='工作城市')
    workYear = models.CharField(max_length=20, blank=True, verbose_name='工作经验')
    education = models.CharField(max_length=20, blank=True, verbose_name='学历要求')
    positionAdvantage = models.CharField(max_length=21, blank=True, verbose_name='职位诱惑')
    positionDetail = models.TextField(verbose_name='职位描述', blank=True, null=True)
    positionAddress = models.TextField(max_length=150, verbose_name='工作地址', blank=True)
    email = models.EmailField(verbose_name='接收简历邮箱', blank=True)
    positionLng = models.CharField(max_length=20, verbose_name='经度', blank=True, null=True)
    positionLat = models.EmailField(max_length=20, verbose_name='维度', blank=True, null=True)
    company = models.ForeignKey('Company', on_delete=models.CASCADE, verbose_name='所属公司', blank=True,
                                related_name='position_info')
    addTime = models.DateTimeField(verbose_name='发布时间', blank=True, auto_now_add=True)
    status = models.SmallIntegerField(verbose_name='状态', choices=status_choices, blank=True, default=0)
    views_count = models.IntegerField(verbose_name='浏览次数', default=0, blank=True)

    class Meta:
        verbose_name = '职位信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.position


class CompanyAuthFile(models.Model):
    '''
    公司认证文件
    '''
    status_choices = (
        (0, '未处理'),
        (1, '未通过'),
        (2, '通过')
    )
    file_path = models.FilePathField(verbose_name='路径')
    company = models.OneToOneField('Company', on_delete=models.CASCADE, blank=True, verbose_name='公司')
    status = models.SmallIntegerField(verbose_name='审核', choices=status_choices, default=0)

    def image_data(self):
        return format_html(
            '<img src="/{}" width="100px"/>',
            self.file_path,
        )

    image_data.short_description = '图片'

    class Meta:
        verbose_name = '公司认证文件'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.company.abbreviation_name
