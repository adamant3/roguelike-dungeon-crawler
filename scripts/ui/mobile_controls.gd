extends CanvasLayer
## Mobile Controls Manager
##
## This script manages the virtual joystick and action buttons for mobile devices.
## It automatically shows/hides controls based on the platform.

# Reference to the virtual joystick (if implemented)
@onready var virtual_joystick: Control = $VirtualJoystick if has_node("VirtualJoystick") else null
@onready var action_buttons: Control = $ActionButtons if has_node("ActionButtons") else null

func _ready():
	"""Initialize mobile controls based on platform"""
	# Check if we have a touchscreen (mobile/tablet device)
	# This is more reliable than OS.has_feature() which doesn't work well for web exports
	if DisplayServer.is_touchscreen_available():
		# Touch device - show controls
		show_controls()
	else:
		# PC/Desktop - hide controls
		hide_controls()

func show_controls():
	"""Show mobile controls"""
	if virtual_joystick:
		virtual_joystick.visible = true
	if action_buttons:
		action_buttons.visible = true

func hide_controls():
	"""Hide mobile controls"""
	if virtual_joystick:
		virtual_joystick.visible = false
	if action_buttons:
		action_buttons.visible = false
