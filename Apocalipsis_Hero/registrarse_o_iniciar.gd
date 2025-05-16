extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boton_ir_a_inicio_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/iniciar_sesion.tscn")


func _on_boton_ir_a_registro_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/registrarse.tscn")


func _on_boton_volver_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")
