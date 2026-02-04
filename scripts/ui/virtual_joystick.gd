extends Control
## Virtual Joystick
##
## A touch-screen joystick for mobile movement input.
## Simulates the movement input actions (move_up, move_down, move_left, move_right).

## The joystick base (background circle)
@onready var base: TextureRect = $Base
## The joystick stick (the movable part)
@onready var stick: TextureRect = $Base/Stick

## Maximum distance the stick can move from center
@export var max_distance: float = 50.0

## The current touch index being tracked
var touch_index: int = -1
## The joystick's output vector
var output: Vector2 = Vector2.ZERO

func _ready():
	"""Initialize the joystick"""
	# Reset the stick to center
	if stick:
		stick.position = Vector2.ZERO

func _process(_delta):
	"""Update input actions based on joystick position"""
	# Simulate input actions for the player
	if output.length() > 0.1:  # Dead zone
		# Set the action strengths
		Input.action_press("move_right" if output.x > 0 else "move_left", abs(output.x))
		Input.action_press("move_down" if output.y > 0 else "move_up", abs(output.y))
	else:
		# Release all movement actions
		Input.action_release("move_up")
		Input.action_release("move_down")
		Input.action_release("move_left")
		Input.action_release("move_right")

func _gui_input(event: InputEvent):
	"""Handle touch input"""
	if event is InputEventScreenTouch:
		if event.pressed:
			# Touch started
			touch_index = event.index
			_update_stick_position(event.position)
		elif event.index == touch_index:
			# Touch ended
			touch_index = -1
			_reset_stick()
	
	elif event is InputEventScreenDrag:
		if event.index == touch_index:
			# Touch moved
			_update_stick_position(event.position)

func _update_stick_position(touch_pos: Vector2):
	"""Update the stick position based on touch location"""
	if not stick or not base:
		return
	
	# Calculate offset from base center
	var base_center = base.size / 2
	var offset = touch_pos - base_center
	
	# Clamp to max distance
	if offset.length() > max_distance:
		offset = offset.normalized() * max_distance
	
	# Update stick position
	stick.position = offset
	
	# Calculate normalized output (-1 to 1)
	output = offset / max_distance

func _reset_stick():
	"""Reset the stick to center position"""
	if stick:
		stick.position = Vector2.ZERO
	output = Vector2.ZERO
