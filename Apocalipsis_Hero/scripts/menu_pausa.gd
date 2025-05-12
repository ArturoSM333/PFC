extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label
@onready var v_box_container: VBoxContainer = $VBoxContainer
var pausado = false
var contador = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if contador == 0:
			pausado = true
			contador = contador + 1
		else:
			pausado = false
			contador = 0
		get_tree().paused = not get_tree().paused
		color_rect.visible = not color_rect.visible
		label.visible = not label.visible
		v_box_container.visible = not v_box_container.visible


func _on_retry_button_pressed() -> void:
	if pausado:
		get_tree().paused = not get_tree().paused
		color_rect.visible = not color_rect.visible
		label.visible = not label.visible
		v_box_container.visible = not v_box_container.visible
		pausado = false
		contador = 0
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	if pausado:
		get_tree().paused = not get_tree().paused
		color_rect.visible = not color_rect.visible
		label.visible = not label.visible
		v_box_container.visible = not v_box_container.visible
		pausado = false
		contador = 0
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")
