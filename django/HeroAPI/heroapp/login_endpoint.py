from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.hashers import check_password
from .models import Usuarios
import json

@csrf_exempt
def login(request):
    if request.method != 'POST':
        return JsonResponse({"error": "Method not supported"}, status=405)

    try:
        # Obtener los datos enviados en el cuerpo de la solicitud
        data = json.loads(request.body)
        nombre = data.get('nombre')  # Obtener con .get para evitar KeyError
        contrasena = data.get('contrasena')

        if not nombre or not contrasena:
            return JsonResponse({"error": "Incomplete data"}, status=400)

    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON format"}, status=400)

    try:
        # Buscar el usuario en la base de datos
        usuario = Usuarios.objects.get(nombre=nombre)
    except Usuarios.DoesNotExist:
        # Mensaje genérico para mayor seguridad
        return JsonResponse({"error": "Incorrect username or password"}, status=401)

    # Verificar si la contraseña es correcta (asegurarse de usar contraseñas cifradas)
    if not check_password(contrasena, usuario.contrasena):
        # Mensaje genérico para mayor seguridad
        return JsonResponse({"error": "Incorrect username or password"}, status=401)


    # Configurar respuesta
    response = JsonResponse({
        "message": "Successful login",
        "niveles_completados": usuario.niveles_completados
    })
    return response
