from django.contrib import admin
from .models import *
from django.forms.forms import mark_safe


# Register your models here.

class IndustrySectorAdmin(admin.ModelAdmin):
    list_display = ('sector',)


class TagSortAdmin(admin.ModelAdmin):
    list_display = ('name',)


class CompanyTagAdmin(admin.ModelAdmin):
    list_display = ('name', 'tag_sort')


class CompanyFoundingTeamAdmin(admin.ModelAdmin):
    list_display = ('founder_name', 'current_position', 'sina', 'desc', 'photo')


class CompanyProductAdmin(admin.ModelAdmin):
    list_display = ('product_poster', 'product_name', 'product_url', 'product_desc',)


class CompanyAdmin(admin.ModelAdmin):
    list_display = ('full_name', 'abbreviation_name', 'logo_data', 'url', 'city',
                    'development_stage')
    fields = ('full_name', 'abbreviation_name', 'logo_data', 'logo', 'url', 'city',
              'development_stage', 'industry_sector', 'scope', 'desc', 'tags', 'user', 'level')
    list_filter = ('city', 'development_stage', 'scope', 'level')
    search_fields = ('full_name', 'abbreviation_name')
    readonly_fields = ('full_name', 'abbreviation_name', 'logo_data', 'logo', 'url', 'city',
                       'development_stage', 'industry_sector', 'scope', 'desc', 'tags', 'user',)
    list_per_page = 10


class CompanyAuthFileAdmin(admin.ModelAdmin):
    readonly_fields = ('image_data', 'company')
    list_display = ('company', 'image_data', 'status')
    list_filter = ('status',)
    fields = ('company', 'image_data', 'status')


class PositionInfoAdmin(admin.ModelAdmin):
    list_display = (
        'positionType', 'position', 'department', 'workAddress', 'company', 'addTime', 'status', 'views_count')
    fields = (
        'positionType', 'position', 'department', 'jobNature', 'salaryMin', 'salaryMax', 'workAddress', 'workYear',
        'education', 'positionAdvantage', 'positionDetail', 'positionAddress', 'email', 'positionLng', 'positionLat',
        'company', 'addTime', 'status', 'views_count')
    readonly_fields = (
        'positionType', 'position', 'department', 'jobNature', 'salaryMin', 'salaryMax', 'workAddress', 'workYear',
        'education', 'positionAdvantage', 'positionDetail', 'positionAddress', 'email', 'positionLng', 'positionLat',
        'company', 'addTime', 'status', 'views_count')
    list_filter = ('department', 'jobNature', 'workYear',
                   'education', 'status')
    search_fields = ('positionType', 'position', 'workAddress', 'company')
    list_per_page = 30


class PositionAdmin(admin.ModelAdmin):
    list_display = ('name', 'level', 'hot', 'pid')
    search_fields = ('name',)
    list_filter = ('level',)
    list_per_page = 30


admin.site.register(Company, CompanyAdmin)
admin.site.register(PositionInfo, PositionInfoAdmin)
admin.site.register(CompanyAuthFile, CompanyAuthFileAdmin)
admin.site.register(IndustrySector, IndustrySectorAdmin)
admin.site.register(TagSort, TagSortAdmin)
admin.site.register(CompanyTag, CompanyTagAdmin)
admin.site.register(CompanyFoundingTeam, CompanyFoundingTeamAdmin)
admin.site.register(CompanyProduct, CompanyProductAdmin)
admin.site.register(Position, PositionAdmin)
admin.site.register(CompanyIntroduction)
