from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from .models import Usuarios
import json


@csrf_exempt
def actualizar_niveles(request):
    if request.method != 'POST':
        return JsonResponse({"error": "Método no permitido"}, status=405)

    try:
        data = json.loads(request.body)
        nombre = data.get('nombre')
        niveles_completados = data.get('niveles_completados')

        # Validación básica
        if not nombre or niveles_completados is None:
            return JsonResponse({"error": "Datos incompletos"}, status=400)

        try:
            usuario = Usuarios.objects.get(nombre=nombre)
        except Usuarios.DoesNotExist:
            return JsonResponse({"error": "Usuario no encontrado"}, status=404)

        # Solo actualizamos si es mayor el nuevo progreso
        if niveles_completados > usuario.niveles_completados:
            usuario.niveles_completados = niveles_completados
            usuario.save()

        return JsonResponse({"message": "Progreso actualizado correctamente"})

    except json.JSONDecodeError:
        return JsonResponse({"error": "JSON inválido"}, status=400)
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)
