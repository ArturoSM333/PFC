extends State

var can_transition : bool = false
@onready var collision_shape: CollisionShape2D = $"../../CollisionShape2D"

func enter():
	super.enter()
	animation_player.play("armor_buff")
	await animation_player.animation_finished
	can_transition = true
	
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
