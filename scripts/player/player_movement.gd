extends CharacterBody2D

@export var speed: float = 200.0
var smooth_move_vector := Vector2.ZERO
var smoothing := 0.2 # Lower = more instant, higher = smoother; try 0.1–0.3

func get_input_vector() -> Vector2:
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_input, y_input)

func _physics_process(_delta):
	var target = get_input_vector()
	smooth_move_vector = smooth_move_vector.lerp(target, smoothing)
	if smooth_move_vector.length() > 0:
		var direction = smooth_move_vector.normalized()
		velocity = direction * speed * smooth_move_vector.length()
	else:
		velocity = Vector2.ZERO
	move_and_slide()
