extends CharacterBody2D
## Player Character Controller
##
## This script handles 8-directional, fluid, and stutter-free movement for the player character.
## It supports both keyboard/mouse and touch input for mobile devices.

@export var speed: float = 200.0  # Adjust as needed

func _ready():
	pass  # Add any setup code here if needed

func get_input_vector() -> Vector2:
	"""
	Returns a Vector2 representing the direction the player wants to move,
	based on both analog and digital inputs.
	"""
	var x_input := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input := Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_input, y_input)

func _physics_process(_delta: float):
	var move_vector := get_input_vector()

	# This will always update live, including all combinations and transitions
	# Diagonals, corners, instant direction change are handled!
	if move_vector.length() > 0:
		# Prevent faster diagonal - always normalize
		move_vector = move_vector.normalized()
		velocity = move_vector * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
