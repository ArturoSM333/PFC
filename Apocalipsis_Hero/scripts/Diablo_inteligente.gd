extends CharacterBody2D
class_name Enemy
var speed = 90
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var direction =1
var player = null

func _ready() -> void:
	player=get_tree().get_nodes_in_group("Player")[0]
	
func _process(delta: float) -> void:
	follow()
	adjust_orientation()
	
func follow():
	if player != null:
		velocity = position.direction_to(player.position) * speed 
		
	move_and_slide()
		
func adjust_orientation() -> void:
	if player != null:
		# Si el enemigo está a la derecha del jugador, mira a la izquierda, y viceversa
		if player.position.x > position.x:
			direction = -1
			animated_sprite_2d.flip_h = false
		else:
			direction = 1
			animated_sprite_2d.flip_h = true
