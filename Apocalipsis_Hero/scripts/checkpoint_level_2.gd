extends Area2D

@onready var health: Label = $"../Main_Character/Health"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/Level_2_Boss.tscn")
