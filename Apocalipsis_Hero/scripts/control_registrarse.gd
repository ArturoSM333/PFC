extends Control

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var status_label: Label = $status_label
@onready var campo_nombre: LineEdit = $campo_nombre
@onready var campo_contrasena: LineEdit = $campo_contrasena

var nombre: String

func _ready():
	if http_request:
		http_request.request_completed.connect(_on_request_completed)
	else:
		print("Error: http_request no asignado.")

func _on_boton_registrarse_pressed():
	nombre = campo_nombre.text.strip_edges()
	var contrasena = campo_contrasena.text.strip_edges()

	if nombre == "" or contrasena == "":
		status_label.text = "Por favor completa todos los campos."
		return

	var request_data = {
		"username": nombre,
		"contrasena": contrasena
	}
	var json_data = JSON.stringify(request_data)

	var url = "http://127.0.0.1:8000/api/1/users"
	var headers = ["Content-Type: application/json"]
	var method = HTTPClient.METHOD_POST

	http_request.request(url, headers, method, json_data)
	status_label.text = "Registrando usuario..."

func _on_request_completed(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8() if body is PackedByteArray else str(body)
	print("Respuesta del servidor:", body_string)

	if response_code == 201:
		status_label.text = "Usuario creado con éxito."
		get_tree().change_scene_to_file("res://scenes/inicio_o_registro.tscn")
	elif response_code == 409:
		status_label.text = "El usuario ya existe."
	else:
		status_label.text = "Error HTTP: " + str(response_code)


func _on_boton_atras_registro_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/inicio_o_registro.tscn")
