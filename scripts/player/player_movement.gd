extends CharacterBody2D
## Player Character Controller
## 
## This script handles 8-directional movement for the player character.
## It supports both keyboard/mouse and touch input for mobile devices.

## Movement speed in pixels per second
## Exported variable means you can change this value in the Godot editor
@export var speed: float = 100.0

## How quickly the player accelerates (0-1, where 1 = instant)
## Lower values create smoother, more realistic movement
@export var acceleration: float = 0.15

## How quickly the player decelerates when no input is given (0-1)
## Higher values make the character stop more quickly
@export var friction: float = 0.25

# Current velocity - this is automatically used by move_and_slide()
# No need to declare it as it's built into CharacterBody2D

func _ready():
	"""Called when the node enters the scene tree"""
	# Set up any initialization here
	pass

func _physics_process(delta: float):
	"""Called every physics frame (default 60 times per second)
	
	Args:
		delta: Time elapsed since the previous frame (usually ~0.016 seconds)
	"""
	# Get input direction from keyboard/controller
	var input_vector = get_input_vector()
	
	# Apply movement based on input
	if input_vector.length() > 0:
		# Player is trying to move - accelerate towards target velocity
		# normalize() ensures diagonal movement isn't faster than cardinal movement
		# lerp() smoothly interpolates between current velocity and target velocity
		velocity = velocity.lerp(input_vector.normalized() * speed, acceleration)
	else:
		# No input - apply friction to slow down
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	# Move the character using Godot's built-in physics
	# This handles collisions automatically
	move_and_slide()

func get_input_vector() -> Vector2:
	"""Get the movement input from keyboard/gamepad/touch controls
	
	Returns:
		A Vector2 representing the direction the player wants to move
		(e.g., Vector2(1, 0) for right, Vector2(-1, -1) for up-left)
	"""
	# Get input strength for each direction (-1.0 to 1.0)
	# Input.get_action_strength returns analog values for gamepad sticks
	# or 0/1 for keyboard keys
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Return the input as a 2D vector
	return Vector2(x_input, y_input)
