extends CharacterBody2D

@export var speed: float = 200.0  # Movement speed, change as desired.

func _physics_process(delta: float) -> void:
	# Use Input.get_vector() to combine and normalize input
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Apply velocity based on normalized direction
	velocity = direction * speed

	# Use move_and_slide to handle collisions
	move_and_slide()
