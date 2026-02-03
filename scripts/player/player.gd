extends CharacterBody2D
## Player controller script for 8-directional movement
##
## This script handles player movement using WASD or Arrow keys.
## It supports 8-directional movement (up, down, left, right, and diagonals)
## and works with both keyboard and virtual joystick input.

# Export variables can be edited in the Godot editor inspector
## How fast the player moves (pixels per second)
@export var speed: float = 300.0

## Acceleration multiplier - how quickly the player reaches full speed
@export var acceleration: float = 10.0

## Reference to the virtual joystick (for mobile controls)
var virtual_joystick: Node = null


func _ready() -> void:
	"""
	Called when the node is added to the scene.
	This is where we do initial setup.
	"""
	# Try to find the virtual joystick in the scene
	# We'll use this for mobile/touch input
	virtual_joystick = get_tree().get_first_node_in_group("virtual_joystick")


func _physics_process(delta: float) -> void:
	"""
	Called every frame at a fixed rate (usually 60 times per second).
	This is where we handle movement physics.
	
	Args:
		delta: Time elapsed since the last frame (in seconds)
	"""
	# Get the input direction from keyboard or joystick
	var input_direction: Vector2 = _get_input_direction()
	
	# Calculate the desired velocity based on input and speed
	var target_velocity: Vector2 = input_direction * speed
	
	# Smoothly interpolate from current velocity to target velocity
	# This creates smooth acceleration/deceleration instead of instant movement
	velocity = velocity.lerp(target_velocity, acceleration * delta)
	
	# Move the character and handle collisions
	# This is a built-in function that handles all the physics
	move_and_slide()


func _get_input_direction() -> Vector2:
	"""
	Gets the movement direction from input sources.
	Checks both keyboard input and virtual joystick.
	
	Returns:
		A normalized Vector2 representing the direction to move
		(0,0) if no input, or a direction vector with length 1.0
	"""
	var direction := Vector2.ZERO
	
	# Check if we have a virtual joystick (mobile controls)
	if virtual_joystick and virtual_joystick.has_method("get_output"):
		# Get input from the virtual joystick
		direction = virtual_joystick.get_output()
	
	# If no joystick input, check keyboard
	if direction.length() < 0.1:
		# Input.get_action_strength returns a value between 0 and 1
		# We use it to create a direction vector
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Normalize the direction vector so diagonal movement isn't faster
	# Without this, moving diagonally would be 1.414x faster (sqrt(2))
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	return direction
