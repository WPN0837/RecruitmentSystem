from django.db import models
from datetime import datetime
from common.models import User, City


class Resume(models.Model):
    '''
    简历信息
    '''
    title = models.CharField(max_length=20, blank=True, verbose_name='简历标题')
    last_time = models.DateTimeField(auto_now=True, verbose_name='最后一次更新时间')
    user = models.OneToOneField('common.User', verbose_name='所属用户', on_delete=models.CASCADE, related_name='resume',
                                blank=True)

    class Meta:
        verbose_name = '简历信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title

    @property
    def score(self):
        res = 0
        if hasattr(self, 'resume_info') and hasattr(self.resume_info, 'score'):
            res += self.resume_info.score
        if hasattr(self, 'hope_work') and hasattr(self.hope_work, 'score'):
            res += self.hope_work.score
        if hasattr(self, 'work_experience') and hasattr(self.work_experience, 'score'):
            res += self.work_experience.score
        if hasattr(self, 'project_experience') and hasattr(self.project_experience, 'score'):
            res += self.project_experience.score
        if hasattr(self, 'educational_experience') and hasattr(self.educational_experience, 'score'):
            res += self.educational_experience.score
        if hasattr(self, 'self_detail') and hasattr(self.self_detail, 'score'):
            res += self.self_detail.score
        if hasattr(self, 'gallery') and hasattr(self.gallery, 'score'):
            res += self.gallery.score
        return res


class ResumeInfo(models.Model):
    '''
    基本信息
    '''
    resume = models.OneToOneField('Resume', verbose_name='简历', on_delete=models.CASCADE, related_name='resume_info')
    name = models.CharField(max_length=20, verbose_name='姓名', blank=True)
    gender = models.CharField(verbose_name='性别', max_length=2, blank=True)
    education = models.CharField(verbose_name='学历', max_length=20, blank=True)
    work_ex = models.CharField(verbose_name='工作经验', max_length=20, blank=True)
    photo = models.ImageField(upload_to='JobHunting/photo', verbose_name='头像', blank=True)
    phone = models.CharField(max_length=15, verbose_name='手机号', blank=True)
    current_status = models.CharField(verbose_name='当前状态', max_length=20, blank=True)
    score = models.IntegerField(default=15, verbose_name='分数')

    class Meta:
        verbose_name = '基本信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class HopeWork(models.Model):
    '''
    期望工作
    '''
    resume = models.OneToOneField('Resume', verbose_name='简历', on_delete=models.CASCADE, related_name='hope_work')
    city = models.CharField(verbose_name='期望城市', blank=True, max_length=10)
    work_sort = models.CharField(verbose_name='工作类型', max_length=20, blank=True)
    hope_position = models.CharField(max_length=20, blank=True, verbose_name='期望职位')
    hope_wage = models.CharField(verbose_name='期望薪资', max_length=20, blank=True)
    score = models.IntegerField(default=15, verbose_name='分数')

    class Meta:
        verbose_name = '期望工作'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.hope_position


class WorkExperience(models.Model):
    '''
    工作经历
    '''
    resume = models.OneToOneField('Resume', verbose_name='简历', on_delete=models.CASCADE, related_name='work_experience')
    company_name = models.CharField(max_length=50, verbose_name='公司名称', blank=True)
    position = models.CharField(max_length=20, verbose_name='职位名称', blank=True)
    start_year = models.CharField(verbose_name='开始年份', max_length=10, blank=True)
    start_month = models.CharField(verbose_name='开始月份', max_length=10, blank=True)
    end_year = models.CharField(verbose_name='结束年份', max_length=10, blank=True)
    end_month = models.CharField(verbose_name='结束月份', max_length=10, blank=True)
    score = models.IntegerField(default=15, verbose_name='分数')

    class Meta:
        verbose_name = '工作经历'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.company_name


class ProjectExperience(models.Model):
    '''
    项目经验
    '''
    resume = models.OneToOneField('Resume', verbose_name='简历', on_delete=models.CASCADE,
                                  related_name='project_experience')
    project_name = models.CharField(max_length=20, verbose_name='项目名称', blank=True)
    position = models.CharField(max_length=20, verbose_name='担任职务', blank=True)
    start_year = models.CharField(verbose_name='开始年份', max_length=10, blank=True)
    start_month = models.CharField(verbose_name='开始月份', max_length=10, blank=True)
    end_year = models.CharField(verbose_name='结束年份', max_length=10, blank=True)
    end_month = models.CharField(verbose_name='结束月份', max_length=10, blank=True)
    project_detail = models.CharField(max_length=500, verbose_name='项目描述', blank=True)
    score = models.IntegerField(default=15, verbose_name='分数')

    class Meta:
        verbose_name = '项目经验'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.project_name


class EducationalExperience(models.Model):
    '''
    教育经历
    '''
    education_choices = (
        (0, '大专'),
        (1, '本科'),
        (2, '硕士'),
        (3, '博士'),
        (4, '其他'),
    )
    resume = models.OneToOneField('Resume', verbose_name='简历', on_delete=models.CASCADE,
                                  related_name='educational_experience')
    school_name = models.CharField(max_length=20, verbose_name='学校名称', blank=True)
    education = models.SmallIntegerField(verbose_name='学历', choices=education_choices, blank=True)
    professional = models.CharField(max_length=20, verbose_name='专业名称', blank=True)
    start_year = models.CharField(verbose_name='开始年份', max_length=10, blank=True)
    end_year = models.CharField(verbose_name='结束年份', max_length=10, blank=True)
    score = models.IntegerField(default=15, verbose_name='分数')

    class Meta:
        verbose_name = '教育经历'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.school_name


class SelfDetail(models.Model):
    '''
    自我描述
    '''
    resume = models.OneToOneField('Resume', verbose_name='简历', on_delete=models.CASCADE,
                                  related_name='self_detail')
    detail = models.CharField(max_length=500, verbose_name='自我描述', blank=True)
    score = models.IntegerField(default=10, verbose_name='分数')

    class Meta:
        verbose_name = '自我描述'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.resume.title


class Gallery(models.Model):
    '''
    作品展示
    '''
    resume = models.OneToOneField('Resume', verbose_name='简历', on_delete=models.CASCADE,
                                  related_name='gallery')
    url = models.URLField(verbose_name='作品链接', blank=True)
    detail = models.CharField(max_length=500, verbose_name='作品描述', blank=True)
    score = models.IntegerField(default=15, verbose_name='分数')

    class Meta:
        verbose_name = '作品展示'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.resume.title
