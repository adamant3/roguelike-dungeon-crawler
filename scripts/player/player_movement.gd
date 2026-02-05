extends CharacterBody2D

@export var speed: float = 200.0
var smooth_move_vector := Vector2.ZERO
var smoothing := 0.15  # Lower = faster transitions, higher = more smoothing.

func get_input_vector() -> Vector2:
	"""
	Process multiple inputs simultaneously and calculate the resulting vector.

	Returns:
		A Vector2 representing the final combined direction of all active inputs.
	"""
	var move_vector := Vector2.ZERO

	# Collect input from each key (can handle simultaneous presses)
	if Input.is_action_pressed("move_right"):
		move_vector.x += 1
	if Input.is_action_pressed("move_left"):
		move_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		move_vector.y += 1
	if Input.is_action_pressed("move_up"):
		move_vector.y -= 1

	return move_vector

func _physics_process(_delta: float):
	# Get the combined input vector
	var target_vector = get_input_vector()

	# Smooth the transition between the current vector and the input vector
	smooth_move_vector = smooth_move_vector.lerp(target_vector, smoothing)

	# Normalize the resulting vector and apply movement
	if smooth_move_vector.length() > 0:
		var direction = smooth_move_vector.normalized()
		velocity = direction * speed * smooth_move_vector.length()
	else:
		velocity = Vector2.ZERO

	# Apply movement using move_and_slide
	move_and_slide()
