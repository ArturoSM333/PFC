from django.db import models

class Usuarios(models.Model):
    nombre = models.CharField(max_length=20, unique=True)
    contrasena = models.CharField(max_length=30)
    niveles_completados = models.IntegerField(default=0)
