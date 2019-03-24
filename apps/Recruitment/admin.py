from django.contrib import admin
from .models import *


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
    list_display = ('full_name', 'abbreviation_name', 'logo', 'url', 'city',
                    'development_stage', 'investment_agency', 'desc')


admin.site.register(IndustrySector, IndustrySectorAdmin)
admin.site.register(TagSort, TagSortAdmin)
admin.site.register(CompanyTag, CompanyTagAdmin)
admin.site.register(CompanyFoundingTeam, CompanyFoundingTeamAdmin)
admin.site.register(CompanyProduct, CompanyProductAdmin)
admin.site.register(Company, CompanyAdmin)
