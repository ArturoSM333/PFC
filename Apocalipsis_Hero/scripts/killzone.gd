extends Area2D

@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var retry_button: Button = $CanvasLayer/retry_button
@onready var menu_button: Button = $CanvasLayer/menu_button
@onready var you_died: Label = $CanvasLayer/you_died
@onready var death_phrase: Label = $CanvasLayer/death_phrase

var death_messages = [
	"Oops! That looked painful...",
	"You have met a terrible fate.",
	"Better luck next time!",
	"The sea claims another soul.",
	"Game over, sailor.",
	"You fought valiantly… and lost.",
	"Even legends fall.",
	"Try again, brave one.",
	"That didn't go as planned!",
	"Your journey ends here… for now."
]

func _on_body_entered(body: Node2D) -> void:
	audio_stream_player_2d.play()
	if body.is_in_group("Player"):  # Usa un grupo para identificar al Main Character
		body.health = 0
	Engine.time_scale = 0.5
	death_phrase.text = death_messages.pick_random()
	canvas_modulate.visible = true
	menu_button.visible = true
	retry_button.visible = true
	you_died.visible = true
	death_phrase.visible = true
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 0


func _on_retry_pressed() -> void:
	Engine.time_scale = 1.0
	canvas_modulate.visible = false
	menu_button.visible = false
	retry_button.visible = false
	you_died.visible = false
	death_phrase.visible = false
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	Engine.time_scale = 1.0
	canvas_modulate.visible = false
	menu_button.visible = false
	retry_button.visible = false
	you_died.visible = false
	death_phrase.visible = false
	get_tree().change_scene_to_file("res://scenes/levels_menu.tscn")
