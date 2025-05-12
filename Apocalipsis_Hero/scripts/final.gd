extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/levels_menu.tscn")
