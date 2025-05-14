import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from heroapp.models import Usuarios
from django.contrib.auth.hashers import make_password

@csrf_exempt
def register(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Unsupported HTTP method'}, status=405)

    # Obtener el username enviado en el cuerpo de la solicitud
    body = json.loads(request.body)
    new_username = body.get('username', None)

    if new_username is None:
        return JsonResponse({'error': 'Missing username in request body'}, status=400)

    try:
        Usuarios.objects.get(nombre=new_username)
    except Usuarios.DoesNotExist:
        # Si el usuario no existe en la base de datos obtenemos la contraseña
        new_password = body.get('contrasena', None)

        if new_password is None:
            # Error si falta la contraseña
            return JsonResponse({'error': 'Missing password in request body'}, status=400)

        # Cifrar contraseña
        hashed_password=make_password(new_password)

        # Guardar nuevo usuario y contraseña
        new_user = Usuarios()
        new_user.nombre = new_username
        new_user.contrasena = hashed_password
        new_user.save()

        # Mensaje de usuario creado correctamente
        return JsonResponse({'message': 'User created'}, status=201)

    # Si el usuario existe
    return JsonResponse({'error': 'Username already exists'}, status=409)


