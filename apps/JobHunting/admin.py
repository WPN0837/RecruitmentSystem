from django.contrib import admin
from .models import *


# Register your models here.
class SubscriptionAdmin(admin.ModelAdmin):
    readonly_fields = (
        'email', 'city', 'finance_stage', 'industry_sector', 'position', 'salary', 'user', 'add_time')
    list_filter = ('cycle', 'finance_stage', 'salary',)
    list_display = ('email', 'cycle', 'city', 'finance_stage', 'industry_sector', 'position', 'salary', 'add_time')
    search_fields = ('position', 'city', 'industry_sector', 'email')
    list_per_page = 30


admin.site.register(ResumeFile)
admin.site.register(Resume)
admin.site.register(ResumeInfo)
admin.site.register(HopeWork)
admin.site.register(WorkExperience)
admin.site.register(ProjectExperience)
admin.site.register(EducationalExperience)
admin.site.register(SelfDetail)
admin.site.register(Gallery)
admin.site.register(PositionCollection)
admin.site.register(Subscription, SubscriptionAdmin)
