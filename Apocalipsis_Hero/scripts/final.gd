extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var http_guardar: HTTPRequest = $HTTPRequest
var tutorial = "res://scenes/Tutorial.tscn"
var lvl1 = "res://scenes/Level_1.tscn"
var lvl2 = "res://scenes/Level_2.tscn"
# var lvl3 = "res://scenes/Level_3.tscn"

func _on_body_entered(body: Node2D) -> void:
	var escena_actual = get_tree().current_scene
	if escena_actual != null:
		var ruta_escena = escena_actual.scene_file_path
		print("Escena actual:", ruta_escena)

		if ruta_escena == tutorial and Global.niveles_completados < 1:
			Global.niveles_completados = 1
			await guardar_progreso()
		if ruta_escena == lvl1 and Global.niveles_completados < 2:
			Global.niveles_completados = 2 
			await guardar_progreso()
		if ruta_escena == lvl2 and Global.niveles_completados < 3:
			Global.niveles_completados = 3
			await guardar_progreso()
	get_tree().change_scene_to_file("res://scenes/levels_menu.tscn")
	
func guardar_progreso() -> void:
	var request_data = {
		"nombre": Global.nombre_usuario,
		"niveles_completados": Global.niveles_completados
	}
	var json_data = JSON.stringify(request_data)
	var headers = ["Content-Type: application/json"]
	var url = "http://127.0.0.1:8000/api/1/progreso"

	var http_request := HTTPRequest.new()
	add_child(http_request)

	var err := http_request.request(url, headers, HTTPClient.METHOD_POST, json_data)
	if err != OK:
		print("Error al hacer la solicitud HTTP:", err)
		http_request.queue_free()
		return

	# Esperamos la respuesta de forma asíncrona sin bloquear el hilo principal
	var result = await http_request.request_completed
	var response_code = result[1]
	var body = result[3]

	if response_code == 200:
		print("Progreso guardado correctamente.")
	else:
		var body_str = body.get_string_from_utf8()
		print("Error al guardar el progreso. Código:", response_code, "Respuesta:", body_str)

	http_request.queue_free()
