extends CharacterBody2D
## Player Character Controller
## 
## This script handles 8-directional movement for the player character.
## It supports both keyboard/mouse and touch input for mobile devices.

## Movement speed in pixels per second
## Exported variable means you can change this value in the Godot editor
@export var speed: float = 100.0

# Current velocity - this is automatically used by move_and_slide()
# No need to declare it as it's built into CharacterBody2D

func _ready():
	"""Called when the node enters the scene tree"""
	# Set up any initialization here
	pass

func _physics_process(_delta: float):

    var move_vector := Vector2.ZERO

    # Fetch input for each axis
    var up = Input.is_action_pressed("move_up")
    var down = Input.is_action_pressed("move_down")
    var left = Input.is_action_pressed("move_left")
    var right = Input.is_action_pressed("move_right")

    # Calculate movement direction
    move_vector.y -= int(up)
    move_vector.y += int(down)
    move_vector.x -= int(left)
    move_vector.x += int(right)

    # Opposing keys cancel movement on axis
    # If both up/down or both left/right, result is zero for that axis

    # Normalize to prevent faster diagonal movement
    if move_vector.length() > 0:
        move_vector = move_vector.normalized()

    # Apply velocity
    velocity = move_vector * speed

    # Move and slide (if using CharacterBody2D)
    move_and_slide()

func get_input_vector() -> Vector2:
	"""Get the movement input from keyboard/gamepad/touch controls
	
	Returns:
		A Vector2 representing the direction the player wants to move
		(e.g., Vector2(1, 0) for right, Vector2(-1, -1) for up-left)
	"""
	# Get input strength for each direction (-1.0 to 1.0)
	# Input.get_action_strength returns analog values for gamepad sticks
	# or 0/1 for keyboard keys
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Return the input as a 2D vector
	return Vector2(x_input, y_input)
