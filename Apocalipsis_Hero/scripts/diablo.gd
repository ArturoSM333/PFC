extends CharacterBody2D

var direction = -1
var health = 2
var flashing = false

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackArea2D

const SPEED = 60

func _process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta

func _on_attack_area_entered(area: Area2D) -> void:
	var target = area.get_parent()
	if target.has_method("take_damage"):
		print("Enemigo golpea a:", target.name)
		target.take_damage(1)

func take_damage():
	if flashing:
		return

	health -= 1
	print("Vida restante del enemigo:", health)
	flash_red()

	if health <= 0:
		queue_free()

func flash_red() -> void:
	flashing = true
	modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.2).timeout
	modulate = Color(1, 1, 1)
	flashing = false
