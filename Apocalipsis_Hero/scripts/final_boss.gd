extends CharacterBody2D

@onready var player = get_parent().find_child("Main_Character")
@onready var sprite = $Sprite2D
@onready var progress_bar: ProgressBar = $UI/ProgressBar
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var DEF=0
var direction : Vector2

var _health := 100

var health:
	get: return _health
	set(value):
		_health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and DEF == 0:
			DEF = 7
			find_child("FiniteStateMachine").change_state("ArmorBuff")


# Diccionario para controlar daño con intervalo
var last_damage_times = {}

const DAMAGE_INTERVAL = 1.0 # segundos

func _ready():
	set_physics_process(false)
	
	# conectar señales para detectar cuerpos tocando el enemigo
	collision_shape.get_parent().connect("body_entered", Callable(self, "_on_body_entered"))
	collision_shape.get_parent().connect("body_exited", Callable(self, "_on_body_exited"))

func _process(_delta):
	direction= player.position - position
	
	if direction.x<0:
		sprite.flip_h=true
	else:
		sprite.flip_h=false

func take_damage():
	health -= 10 - DEF


func _on_body_entered(body):
	if body == player:
		# marcar el tiempo inicial para que pueda recibir daño ya
		last_damage_times[body] = 0.0

func _on_body_exited(body):
	if body in last_damage_times:
		last_damage_times.erase(body)

func _physics_process(delta):
	# Movimiento normal
	velocity = direction.normalized() * 30
	move_and_collide(velocity * delta)
	
	# Si el jugador está tocando, comprobar tiempo para daño
	if player in last_damage_times:
		var current_time = Time.get_ticks_usec() / 1_000_000.0
		if current_time - last_damage_times[player] >= DAMAGE_INTERVAL:
			player.take_damage()
			last_damage_times[player] = current_time
