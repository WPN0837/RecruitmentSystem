from django.contrib import admin
from .models import *


class UserAdmin(admin.ModelAdmin):
    list_display = ('email', 'type', 'activation')
    fields = ('email', 'type', 'activation')
    readonly_fields = ('email', 'type', 'activation')
    search_fields = ('email',)
    list_filter = ('type', 'activation')
    list_per_page = 30


class BannerAdmin(admin.ModelAdmin):
    search_fields = ('alt',)
    list_display = ('alt', 'url', 'level', 'img_data')
    readonly_fields = ('img_data',)


class SubmitResumeAdmin(admin.ModelAdmin):
    list_display = ('resume', 'position', 'status', 'sort', 'delete', 'offer', 'add_time',)
    readonly_fields = ('resume', 'position', 'add_time', 'status', 'sort', 'delete', 'offer')
    list_filter = ('status', 'sort', 'delete', 'offer')
    search_fields = ('resume', 'position',)
    list_per_page = 30


# Register your models here.
admin.site.register(User, UserAdmin)
admin.site.register(Province)
admin.site.register(City)
admin.site.register(HotCity)
admin.site.register(SubmitResume, SubmitResumeAdmin)
admin.site.register(Banner, BannerAdmin)
