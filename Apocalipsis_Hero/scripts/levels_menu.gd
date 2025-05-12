extends Node2D


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_1.tscn")

func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_2.tscn")
	
	

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")
	
	
