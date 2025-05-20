extends Node2D
@onready var tutorial: Button = $Levels/Tutorial
@onready var tutorial_2: Area2D = $Levels/Tutorial2
@onready var level_1: Button = $Levels/Level_1
@onready var level_1_1: Area2D = $Levels/Level_1_1
@onready var level_2: Button = $Levels/Level_2
@onready var level_2_3: Area2D = $Levels/Level_2_3

func _ready() -> void:
	# --- Nivel 1 ---
	if Global.niveles_completados >= 1:
		level_1.text = "Level 1"
		level_1.disabled = false
		level_1_1.set_deferred("monitoring", true)
	else:
		level_1.text = "Blocked"
		level_1.disabled = true
		level_1_1.set_deferred("monitoring", false)

	# --- Nivel 2 ---
	if Global.niveles_completados >= 2:
		level_2.text = "Level 2"
		level_2.disabled = false
		level_2_3.set_deferred("monitoring", true)
	else:
		level_2.text = "Blocked"
		level_2.disabled = true
		level_2_3.set_deferred("monitoring", false)


		
func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_1.tscn")

func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_2.tscn")
	
	

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")
	
	
