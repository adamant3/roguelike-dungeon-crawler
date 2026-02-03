extends Control
## Virtual Joystick for Mobile Touch Controls
##
## This creates a touch-based joystick that appears in the bottom-left corner
## of the screen for mobile devices. It provides analog movement control
## similar to console controller joysticks.

# The maximum distance the joystick knob can move from the center
@export var max_distance: float = 50.0

# The radius within which touch is detected to activate the joystick
@export var dead_zone: float = 10.0

# References to the joystick visual components
@onready var base: ColorRect = $Base
@onready var knob: ColorRect = $Base/Knob

# Track whether the joystick is currently being touched
var is_pressed: bool = false

# The current output vector from the joystick (-1 to 1 on each axis)
var output: Vector2 = Vector2.ZERO

# Track which touch index is controlling this joystick
var touch_index: int = -1

func _ready() -> void:
	# Hide the joystick on non-touch devices (desktop)
	# DisplayServer.is_touchscreen_available() checks if the device has touch input
	if not DisplayServer.is_touchscreen_available():
		visible = false
	else:
		visible = true
	
	# Add this node to the "virtual_joystick" group so the player can find it
	add_to_group("virtual_joystick")

func _input(event: InputEvent) -> void:
	# Only process input if the joystick is visible
	if not visible:
		return
	
	# Handle touch screen events
	if event is InputEventScreenTouch:
		_handle_touch(event)
	elif event is InputEventScreenDrag:
		_handle_drag(event)

## Handle initial touch down and touch release
func _handle_touch(event: InputEventScreenTouch) -> void:
	var touch_pos = event.position
	
	if event.pressed:
		# Check if the touch is within the joystick's base area
		var base_rect = Rect2(base.global_position, base.size)
		if base_rect.has_point(touch_pos) and touch_index == -1:
			# Start tracking this touch
			is_pressed = true
			touch_index = event.index
			_update_joystick(touch_pos)
	else:
		# Release the joystick if this is the tracked touch
		if event.index == touch_index:
			_reset_joystick()

## Handle touch drag (movement while touching)
func _handle_drag(event: InputEventScreenDrag) -> void:
	# Only process if this is the touch that activated the joystick
	if event.index == touch_index and is_pressed:
		_update_joystick(event.position)

## Update the joystick position based on touch position
func _update_joystick(touch_pos: Vector2) -> void:
	# Calculate the offset from the center of the joystick base
	var base_center = base.global_position + base.size / 2
	var offset = touch_pos - base_center
	
	# Limit the offset to the maximum distance
	if offset.length() > max_distance:
		offset = offset.normalized() * max_distance
	
	# Update the knob position
	knob.position = base.size / 2 + offset - knob.size / 2
	
	# Calculate the output vector (normalized to -1 to 1 range)
	if offset.length() > dead_zone:
		output = offset / max_distance
	else:
		output = Vector2.ZERO

## Reset the joystick to its neutral position
func _reset_joystick() -> void:
	is_pressed = false
	touch_index = -1
	output = Vector2.ZERO
	
	# Center the knob
	knob.position = (base.size - knob.size) / 2

## Get the current joystick output vector
## This is called by the player script to get movement direction
func get_output() -> Vector2:
	return output
