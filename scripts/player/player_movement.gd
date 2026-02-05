extends CharacterBody2D

@export var speed: float = 200.0
var smooth_move_vector := Vector2.ZERO
var smoothing := 0.2  # Lower = snappier, higher = smoother.

func get_input_vector() -> Vector2:
	"""
	Combine movement input from keyboard/gamepad/touch controls.

	Returns:
	    A Vector2 representing the desired movement direction
	"""
	var x_input = 0.0
	var y_input = 0.0

	# Handle WASD / Arrow keys input
	if Input.is_action_pressed("move_right"):
		x_input += 1
	if Input.is_action_pressed("move_left"):
		x_input -= 1
	if Input.is_action_pressed("move_down"):
		y_input += 1
	if Input.is_action_pressed("move_up"):
		y_input -= 1

	return Vector2(x_input, y_input)

func _physics_process(_delta: float):
	# Get the raw input vector
	var target = get_input_vector()

	# Smoothly interpolate between the current and target vectors
	smooth_move_vector = smooth_move_vector.lerp(target, smoothing)

	# If there's any input
	if smooth_move_vector.length() > 0:
		# Ensure diagonal speed is consistent
		var direction = smooth_move_vector.normalized()
		velocity = direction * speed * smooth_move_vector.length()
	else:
		# No input, stop
		velocity = Vector2.ZERO

	move_and_slide()
