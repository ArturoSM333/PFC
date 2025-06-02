extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("idle")
	
func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var target_pos = player.global_position + Vector2(0, -15)  
	owner.direction = target_pos - owner.global_position
	var distance = owner.direction.length()
	get_parent().change_state("LaserBeam")
