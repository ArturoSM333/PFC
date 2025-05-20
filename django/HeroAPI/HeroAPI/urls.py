"""
URL configuration for HeroAPI project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from heroapp import register_endpoint
from heroapp import login_endpoint
from heroapp import levels_endpoint

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/1/users', register_endpoint.register),
    path('api/1/sessions', login_endpoint.login),
    path('api/1/progreso', levels_endpoint.actualizar_niveles)
]
