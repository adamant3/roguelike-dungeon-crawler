extends CharacterBody2D
## Player character controller for the roguelike dungeon crawler
## Handles 8-directional movement with keyboard/touch input

# Movement speed in pixels per second
@export var move_speed: float = 200.0

# Input vector for movement direction (from -1 to 1 on each axis)
var input_vector: Vector2 = Vector2.ZERO

# Flag to check if using touch controls
var using_touch: bool = false


func _ready() -> void:
	"""Called when the node enters the scene tree for the first time"""
	# Check if the device has touch capabilities
	using_touch = DisplayServer.is_touchscreen_available()


func _physics_process(delta: float) -> void:
	"""Called every physics frame. Handles movement and physics"""
	# Get input from player
	get_input()
	
	# Apply movement
	move_player(delta)


func get_input() -> void:
	"""Reads input from keyboard or virtual joystick and updates input_vector"""
	# Reset input vector
	input_vector = Vector2.ZERO
	
	# Get input from action mappings (WASD/Arrow keys)
	# Input.get_action_strength returns 0.0 if not pressed, 1.0 if pressed
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Check if we have input from the virtual joystick via global autoload
	var joystick_input = MobileInput.get_joystick_vector()
	# Only use joystick input if keyboard input is not being used
	if input_vector.length() < 0.1:
		input_vector = joystick_input
	
	# Normalize the vector to prevent faster diagonal movement
	# This ensures the player moves at the same speed in all directions
	if input_vector.length() > 1.0:
		input_vector = input_vector.normalized()


func move_player(delta: float) -> void:
	"""Applies movement to the player based on input_vector"""
	# Calculate velocity: direction * speed
	velocity = input_vector * move_speed
	
	# Use Godot's built-in move_and_slide for smooth movement with collision
	move_and_slide()
	
	# Optional: Add sprite flipping based on movement direction
	# This would flip the sprite when moving left/right
	if input_vector.x < 0:
		$Sprite2D.flip_h = true
	elif input_vector.x > 0:
		$Sprite2D.flip_h = false
