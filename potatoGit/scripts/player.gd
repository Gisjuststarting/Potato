extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite = $AnimatedSprite2D
var current_angle:float = 0.0
var is_jump:bool = false
var rot_direction:float = 1.0

func _physics_process(delta: float) -> void:	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta 		
		if is_jump:
			current_angle += delta*720*rot_direction
		rotation_degrees = current_angle
		if current_angle >360.0:
			rotation_degrees = 0.0
			
	else:
		current_angle = 0.0
		rotation_degrees = 0.0
		is_jump = false



	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY 
		is_jump = true
		#current_angle = 0
	




	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		rot_direction = direction
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
	
		
	
	
	if direction:
		velocity.x = direction * SPEED
		#print(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)		

	move_and_slide()
	
