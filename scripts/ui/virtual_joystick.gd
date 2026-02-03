extends Control
## Virtual joystick for mobile touch controls
##
## This creates an on-screen joystick that appears when the player touches
## the screen. It only shows on mobile devices or when touch input is detected.

## The outer circle (background) of the joystick
@onready var base: Control = $Base

## The inner circle (stick) that moves around
@onready var stick: Control = $Base/Stick

## Maximum distance the stick can move from center (in pixels)
@export var max_distance: float = 64.0

## Threshold before input is registered (prevents tiny movements)
@export var deadzone: float = 0.2

# Current output value (normalized direction vector)
var output: Vector2 = Vector2.ZERO

# Whether the joystick is currently being used
var is_active: bool = false

# ID of the touch/click currently controlling the joystick
var current_touch_id: int = -1


func _ready() -> void:
	"""
	Set up the virtual joystick when it's added to the scene.
	"""
	# Add to a group so the player can find it
	add_to_group("virtual_joystick")
	
	# Hide by default - it will show when touched
	visible = false
	
	# On desktop, hide the joystick unless emulating touch
	if not OS.has_feature("mobile") and not DisplayServer.is_touchscreen_available():
		visible = false


func _input(event: InputEvent) -> void:
	"""
	Handle touch/mouse input events.
	
	Args:
		event: The input event (touch, mouse, etc.)
	"""
	# Handle touch screen press
	if event is InputEventScreenTouch:
		if event.pressed:
			# Touch started - activate joystick at touch position
			_activate_joystick(event.position, event.index)
		else:
			# Touch released - deactivate if it's our touch
			if event.index == current_touch_id:
				_deactivate_joystick()
	
	# Handle touch/mouse drag
	elif event is InputEventScreenDrag:
		if event.index == current_touch_id and is_active:
			_update_joystick(event.position)
	
	# Handle mouse button for testing on desktop
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_activate_joystick(event.position, 0)
			else:
				if current_touch_id == 0:
					_deactivate_joystick()
	
	# Handle mouse motion when active
	elif event is InputEventMouseMotion:
		if is_active and current_touch_id == 0:
			_update_joystick(event.position)


func _activate_joystick(touch_position: Vector2, touch_id: int) -> void:
	"""
	Activate the joystick at the given position.
	
	Args:
		touch_position: Where the user touched the screen
		touch_id: ID of this touch event
	"""
	# Only activate if not already active or on bottom half of screen
	# (so we don't interfere with UI buttons that might be on top)
	if not is_active and touch_position.y > get_viewport_rect().size.y / 3:
		is_active = true
		current_touch_id = touch_id
		
		# Position the joystick base at the touch point
		base.global_position = touch_position - base.size / 2
		
		# Reset stick to center
		stick.position = base.size / 2 - stick.size / 2
		
		# Show the joystick
		visible = true


func _update_joystick(touch_position: Vector2) -> void:
	"""
	Update the joystick stick position based on touch movement.
	
	Args:
		touch_position: Current position of the touch/mouse
	"""
	if not is_active:
		return
	
	# Calculate offset from center of base
	var base_center := base.global_position + base.size / 2
	var offset := touch_position - base_center
	
	# Limit the offset to max_distance
	if offset.length() > max_distance:
		offset = offset.normalized() * max_distance
	
	# Update stick position
	stick.position = base.size / 2 + offset - stick.size / 2
	
	# Calculate output (normalized direction)
	output = offset / max_distance
	
	# Apply deadzone
	if output.length() < deadzone:
		output = Vector2.ZERO


func _deactivate_joystick() -> void:
	"""
	Deactivate the joystick when touch is released.
	"""
	is_active = false
	current_touch_id = -1
	output = Vector2.ZERO
	visible = false


func get_output() -> Vector2:
	"""
	Get the current joystick output direction.
	
	Returns:
		Normalized Vector2 representing joystick direction
	"""
	return output
