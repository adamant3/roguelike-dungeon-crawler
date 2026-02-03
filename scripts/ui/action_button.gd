extends Button
## Action Button for Mobile Touch Controls
##
## This creates a touch-based action button that appears in the bottom-right
## corner of the screen for mobile devices. It can be used for combat,
## interactions, or any primary action in the game.

func _ready() -> void:
	# Hide the button on non-touch devices (desktop)
	if not DisplayServer.is_touchscreen_available():
		visible = false
	else:
		visible = true
	
	# Connect the button pressed signal to trigger the action input
	pressed.connect(_on_button_pressed)

## Called when the button is pressed
func _on_button_pressed() -> void:
	# Simulate the "action" input being pressed
	# This allows the same code to handle both keyboard and touch input
	var event = InputEventAction.new()
	event.action = "action"
	event.pressed = true
	Input.parse_input_event(event)
	
	# Optional: Add visual feedback or sound effects here
	pass
