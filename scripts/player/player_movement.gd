extends CharacterBody2D

@export var speed: float = 200.0

# For instant movement with snap (recommended for most games)
func get_input_vector() -> Vector2:
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_input, y_input)

func _physics_process(_delta):
	var move_vector = get_input_vector()
	if move_vector.length() > 0:
		move_vector = move_vector.normalized()
		velocity = move_vector * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
