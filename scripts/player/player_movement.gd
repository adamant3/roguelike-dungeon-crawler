extends CharacterBody2D

@export var speed: float = 200.0

func _physics_process(_delta: float):
	var axis := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	# If both directions are pressed, axis (for that direction) will be zero (cancel out)
	if axis.length() > 0:
		velocity = axis.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
