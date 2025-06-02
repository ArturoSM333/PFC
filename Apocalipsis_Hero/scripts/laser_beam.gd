extends State

@onready var pivot: Node2D = $"../../Pivot"
var can_transition: bool = false
@onready var laser_area: Area2D = $"../../Pivot/LaserArea"


func enter():
	super.enter()
	await play_animation("laser_cast")
	laser_area.activate_laser()
	await play_animation("laser")
	laser_area.deactivate_laser()
	can_transition=true


func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished

func set_target():
	var target_pos = player.global_position + Vector2(0, -30) 
	var direction = target_pos - pivot.global_position
	pivot.rotation = direction.angle()

func transition():
	if can_transition:
		can_transition=false
		get_parent().change_state("Dash")
