extends Control

# Conexión a nodos de la escena
@onready var http_request: HTTPRequest = $HTTPRequest
@onready var status_label: Label = $status_label
@onready var campo_nombre: LineEdit = $campo_nombre
@onready var campo_contrasena: LineEdit = $campo_contrasena
var nombre 
var niveles_completados = 0

func _ready():
	# Conecta la señal de solicitud completada del HTTPRequest
	if http_request != null:
		http_request.request_completed.connect(_on_request_completed)
	else:
		print("Error: 'http_request' no está correctamente asignado.")

func _on_boton_continuar_iniciando_sesion_pressed() -> void:
	# Obtenemos los datos del formulario
	nombre = campo_nombre.text.strip_edges()
	var contrasena = campo_contrasena.text.strip_edges()

	# Validamos que no estén vacíos
	if nombre == "" or contrasena == "":
		status_label.text = "Por favor completa todos los campos."
		return

	# Creamos el cuerpo de la solicitud en formato JSON
	var request_data = {
		"nombre": nombre,
		"contrasena": contrasena
	}
	var json_data = JSON.stringify(request_data)

	# Enviamos la solicitud HTTP POST
	var url = "http://127.0.0.1:8000/api/1/sessions"
	#esto lo pongo para q de error, acordarse de sessions en vez de users
	var headers = ["Content-Type: application/json"]  # Header indicando que es JSON

	# Usamos el tipo HTTPClient.Method para el método, no un string
	var method = HTTPClient.METHOD_POST  # Usamos el valor de tipo HTTPClient.Method
	
	# Aquí pasamos los parámetros correctos
	http_request.request(url, headers, method, json_data)

	# Actualizar el estado mientras se procesa la solicitud
	status_label.text = "Iniciando sesión..."

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		# Convertir el cuerpo de la respuesta a una cadena UTF-8
		var body_string = body.get_string_from_utf8() if body is PackedByteArray else str(body)
		print("Respuesta del servidor (cruda):", body_string)

		# Parsear el JSON
		var json = JSON.new()
		var error = json.parse(body_string)
		if error == OK:
			var response = json.get_data()
			print("JSON Parseado:", response)
			# Asignar niveles_completados si existe en la respuesta
			if response.has("niveles_completados"):
				Global.niveles_completados = response["niveles_completados"]
				print("Niveles completados:", niveles_completados)
			else:
				print("Advertencia: 'niveles_completados' no encontrado en la respuesta.")
			
			Global.nombre_usuario = nombre
			status_label.text = nombre + "has iniciado sesión."
			get_tree().change_scene_to_file("res://scenes/levels_menu.tscn")
		else:
			print("Error al parsear JSON:", json.get_error_message())
			status_label.text = "Error en la respuesta del servidor."
	else:
		# Manejo de errores HTTP
		var body_string = body.get_string_from_utf8() if body is PackedByteArray else str(body)
		print("Error HTTP " + str(response_code) + " - " + body_string.substr(0, 100))
		status_label.text = "Error HTTP: " + str(response_code)


func _on_boton_atras_iniciar_sesion_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/inicio_o_registro.tscn")
