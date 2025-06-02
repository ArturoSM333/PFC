extends Area2D

@export var damage_interval = 1.0

var damaged_bodies = {}
var laser_active: bool = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	monitoring = false  # Inicialmente desactivado para no detectar colisiones
	get_node("CollisionShape2D").disabled = true  # Desactivar colisión

func _process(delta):
	if not laser_active:
		return
	
	var current_time = Time.get_ticks_usec() / 1_000_000.0
	for body in damaged_bodies.keys():
		if body and body.has_method("take_damage"):
			var last_damage_time = damaged_bodies[body]
			if current_time - last_damage_time >= damage_interval:
				body.take_damage()
				damaged_bodies[body] = current_time
		else:
			damaged_bodies.erase(body)

func _on_body_entered(body):
	if body == owner:
		return
	if laser_active and body.has_method("take_damage") and body not in damaged_bodies:
		body.take_damage()
		damaged_bodies[body] = Time.get_ticks_usec() / 1_000_000.0

func _on_body_exited(body):
	if body in damaged_bodies:
		damaged_bodies.erase(body)

func activate_laser():
	laser_active = true
	monitoring = true
	get_node("CollisionShape2D").disabled = false

func deactivate_laser():
	laser_active = false
	monitoring = false
	get_node("CollisionShape2D").disabled = true
	damaged_bodies.clear()
