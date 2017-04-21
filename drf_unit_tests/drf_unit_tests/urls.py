from django.conf.urls import url, include
from django.contrib import admin

from rest_framework import routers

from myapp import views

router = routers.DefaultRouter()
router.register(r'books', views.BookViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^', include('rest_framework.urls', namespace='rest_framework')),
]
