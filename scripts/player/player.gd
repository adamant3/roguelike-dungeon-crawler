extends CharacterBody2D
## Player controller script
## Handles 8-directional movement using WASD/Arrow keys
## Supports both keyboard and virtual joystick input

## Movement speed in pixels per second
@export var speed: float = 200.0

## Reference to the virtual joystick (if available)
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Any initialization code can go here
	pass

func _physics_process(delta: float) -> void:
	# Get input direction from keyboard
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Check if we should use virtual joystick input instead
	# The virtual joystick will set the input_direction via signals or direct access
	if has_node("/root/Main/CanvasLayer/VirtualJoystick"):
		var joystick = get_node_or_null("/root/Main/CanvasLayer/VirtualJoystick")
		if joystick and joystick.has_method("get_joystick_direction"):
			var joystick_dir = joystick.get_joystick_direction()
			if joystick_dir.length() > 0.1:  # Dead zone
				input_direction = joystick_dir
	
	# Normalize diagonal movement so player doesn't move faster diagonally
	if input_direction.length() > 1.0:
		input_direction = input_direction.normalized()
	
	# Set velocity based on input direction and speed
	velocity = input_direction * speed
	
	# Update animations based on movement
	update_animation(input_direction)
	
	# Move the character
	move_and_slide()

func update_animation(direction: Vector2) -> void:
	"""Updates the player animation based on movement direction"""
	if direction.length() > 0.1:
		# Player is moving - play walk animation
		if animation_player.current_animation != "walk":
			animation_player.play("walk")
	else:
		# Player is idle - play idle animation
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
