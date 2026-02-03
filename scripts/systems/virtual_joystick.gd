extends Control
## Virtual Joystick for mobile touch controls
## Displays a joystick UI that the player can drag to control movement
## Automatically hidden on non-touch devices

## The joystick base (outer circle)
@onready var joystick_base: TextureRect = $JoystickBase
## The joystick knob (inner circle that moves)
@onready var joystick_knob: TextureRect = $JoystickBase/JoystickKnob

## Maximum distance the knob can move from center
@export var max_distance: float = 50.0

## Current touch index (-1 means not being touched)
var touch_index: int = -1
## Base position of the joystick
var base_position: Vector2 = Vector2.ZERO
## Current joystick direction (normalized)
var joystick_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Hide joystick on PC (non-touch devices)
	if not OS.has_feature("mobile"):
		visible = false
	
	# Store the base position
	base_position = joystick_base.position + joystick_base.size / 2

func _input(event: InputEvent) -> void:
	# Handle touch/mouse events
	if event is InputEventScreenTouch:
		if event.pressed:
			# Check if touch is within joystick area
			var touch_pos = event.position
			var distance = base_position.distance_to(touch_pos)
			if distance < max_distance * 2:  # Larger activation area
				touch_index = event.index
		else:
			# Release touch
			if event.index == touch_index:
				reset_joystick()
	
	elif event is InputEventScreenDrag and event.index == touch_index:
		# Update joystick position based on drag
		var touch_pos = event.position
		var direction = touch_pos - base_position
		var distance = direction.length()
		
		if distance > max_distance:
			direction = direction.normalized() * max_distance
		
		# Update knob position
		joystick_knob.position = joystick_base.size / 2 + direction - joystick_knob.size / 2
		
		# Calculate normalized direction for movement
		joystick_direction = direction / max_distance

func reset_joystick() -> void:
	"""Reset joystick to center position"""
	touch_index = -1
	joystick_direction = Vector2.ZERO
	joystick_knob.position = (joystick_base.size - joystick_knob.size) / 2

func get_joystick_direction() -> Vector2:
	"""Returns the current joystick direction (normalized)"""
	return joystick_direction
