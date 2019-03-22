from django.shortcuts import HttpResponse, render
from django.views.decorators.csrf import csrf_exempt
from django.views import View


# Create your views here.

class IndexView(View):
    def get(self, request):
        return render(request, 'index.html', )
