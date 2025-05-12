extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0
var slide = false
var dodging = false
var dodge_timer = 0.0
const DODGE_SPEED = 400.0  # Velocidad del dodge
const DODGE_DURATION = 0.3  # Duración del dodge en segundos
const SLIDE_DURATION = 0.5  # Duración del slide en segundos
var slide_timer = 0.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Iniciar slide
	if Input.is_action_just_pressed("slide") and is_on_floor() and not slide:
		print("Slide")
		slide = true
		slide_timer = SLIDE_DURATION
		animated_sprite.play("slide")
		collision_shape.scale.y = 0.5
		collision_shape.position.y = -12

	# Controlar la duración del slide
	if slide:
		slide_timer -= delta
		if slide_timer <= 0:
			end_slide()




	# Iniciar slide
	if Input.is_action_just_pressed("slide") and is_on_floor() and not slide:
		print("Slide")
		slide = true
		slide_timer = SLIDE_DURATION
		animated_sprite.play("slide")
		collision_shape.scale.y = 0.5
		collision_shape.position.y = -12

	# Controlar la duración del slide
	if slide:
		slide_timer -= delta
		if slide_timer <= 0:
			end_slide()



		# Iniciar dodge
	if Input.is_action_just_pressed("dodge") and not slide and not dodging:
		print("Dodge")
		dodging = true
		dodge_timer = DODGE_DURATION
		if animated_sprite.flip_h:
			velocity.x = -DODGE_SPEED
		else:
			velocity.x = DODGE_SPEED
		animated_sprite.play("dodge")

# Controlar la duración del dodge
	if dodging:
		dodge_timer -= delta
		if dodge_timer <= 0:
			end_dodge()
		
		
	# -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Change direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animations
	if not dodging and not slide:  # Solo cambiar animación si no está en slide ni dodge
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		
	# Apply movement
	if not dodging:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	
func end_slide():
	slide=false
	collision_shape.scale.y = 1
	collision_shape.position.y = -22
	
func end_dodge():
	dodging = false
	velocity.x = 0  # Detener el movimiento después del dodge
	if is_on_floor():
		animated_sprite.play("idle")  # Cambiar a idle si está en el suelo
		
