extends CanvasLayer
## Mobile input handler for touch controls
## Provides a virtual joystick and action button for mobile devices

# Reference to the joystick control elements
@onready var joystick_bg: Control = $JoystickBackground
@onready var joystick_handle: Control = $JoystickHandle
@onready var action_button: Button = $ActionButton

# Maximum distance the joystick handle can move from center
const JOYSTICK_MAX_DISTANCE: float = 50.0

# Current touch index tracking the joystick
var joystick_touch_index: int = -1

# Current joystick vector (normalized)
var joystick_vector: Vector2 = Vector2.ZERO

# Original position of joystick background
var joystick_center: Vector2 = Vector2.ZERO


func _ready() -> void:
	"""Initialize mobile controls"""
	# Store the original center position of the joystick
	joystick_center = joystick_bg.global_position + joystick_bg.size / 2
	
	# Hide mobile controls on non-touch devices
	if not DisplayServer.is_touchscreen_available():
		visible = false
	
	# Make sure we're processing input
	set_process_input(true)


func _input(event: InputEvent) -> void:
	"""Handle touch input for virtual joystick"""
	# Check for touch screen events
	if event is InputEventScreenTouch:
		handle_touch(event)
	elif event is InputEventScreenDrag:
		handle_drag(event)


func handle_touch(event: InputEventScreenTouch) -> void:
	"""Process touch press/release events"""
	# Check if touch is within joystick area
	var touch_pos = event.position
	var joystick_rect = Rect2(
		joystick_bg.global_position,
		joystick_bg.size
	)
	
	if event.pressed:
		# Touch started
		if joystick_rect.has_point(touch_pos) and joystick_touch_index == -1:
			# Start tracking this touch for the joystick
			joystick_touch_index = event.index
			update_joystick(touch_pos)
	else:
		# Touch released
		if event.index == joystick_touch_index:
			# Reset joystick
			joystick_touch_index = -1
			joystick_vector = Vector2.ZERO
			reset_joystick_handle()


func handle_drag(event: InputEventScreenDrag) -> void:
	"""Process touch drag events"""
	if event.index == joystick_touch_index:
		update_joystick(event.position)


func update_joystick(touch_position: Vector2) -> void:
	"""Update joystick handle position and calculate input vector"""
	# Calculate offset from center
	var offset = touch_position - joystick_center
	
	# Limit the offset to max distance
	if offset.length() > JOYSTICK_MAX_DISTANCE:
		offset = offset.normalized() * JOYSTICK_MAX_DISTANCE
	
	# Update handle position (center it on the offset position)
	joystick_handle.global_position = joystick_center + offset - joystick_handle.size / 2
	
	# Calculate normalized input vector
	joystick_vector = offset / JOYSTICK_MAX_DISTANCE
	
	# Update global autoload
	MobileInput.set_joystick_vector(joystick_vector)


func reset_joystick_handle() -> void:
	"""Reset joystick handle to center position"""
	joystick_handle.global_position = joystick_center - joystick_handle.size / 2
	
	# Update global autoload
	MobileInput.set_joystick_vector(Vector2.ZERO)


func get_joystick_vector() -> Vector2:
	"""Returns the current joystick input vector (used by player)"""
	return joystick_vector


func _on_action_button_pressed() -> void:
	"""Handle action button press"""
	# Simulate the 'action' input being pressed
	# This can be used for attacks, interactions, etc.
	var action_event = InputEventAction.new()
	action_event.action = "action"
	action_event.pressed = true
	Input.parse_input_event(action_event)
