extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pick_up_sound: AudioStreamPlayer2D = $PickUpSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	#añadir punto
	animation_player.play("pickup")
