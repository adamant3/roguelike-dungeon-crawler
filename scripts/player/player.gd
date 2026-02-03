extends CharacterBody2D
## Player Character Script
##
## This script handles the player character's movement and behavior.
## It supports 8-directional movement using keyboard input (WASD/Arrow keys)
## and touch input via a virtual joystick for mobile devices.

# Movement speed in pixels per second
# This value can be adjusted to make the player move faster or slower
@export var speed: float = 200.0

## Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Initialize any player-specific setup here
	pass

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Get input direction from keyboard or touch controls
	var input_direction := _get_input_direction()
	
	# Normalize the direction vector to ensure consistent speed in all directions
	# Without normalization, diagonal movement would be faster (sqrt(2) times faster)
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	
	# Set the velocity based on input direction and speed
	velocity = input_direction * speed
	
	# Move the character using Godot 4's built-in physics
	# This handles collisions automatically
	move_and_slide()

## Gets the input direction from keyboard or virtual joystick
## Returns a Vector2 representing the movement direction
func _get_input_direction() -> Vector2:
	var direction := Vector2.ZERO
	
	# Check for keyboard input (WASD or Arrow keys)
	# Input.get_action_strength returns 1.0 if pressed, 0.0 if not
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Check for virtual joystick input (mobile controls)
	# The VirtualJoystick node will be accessible if it exists
	var joystick = get_tree().get_first_node_in_group("virtual_joystick")
	if joystick and joystick.has_method("get_output"):
		var joystick_direction = joystick.get_output()
		if joystick_direction.length() > 0:
			direction = joystick_direction
	
	return direction
