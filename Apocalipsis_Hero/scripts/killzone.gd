extends Area2D

@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	audio_stream_player_2d.play()
	if body.is_in_group("Player"):  # Usa un grupo para identificar al Main Character
		body.health = 0
	Engine.time_scale = 0.5
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	#Es provisional, cuando pueda poner una pestaña de game over o algo
