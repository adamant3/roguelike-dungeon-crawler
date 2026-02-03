extends Node
## Global autoload for mobile input
## Provides access to virtual joystick from anywhere in the game

# Joystick vector that can be accessed globally
var joystick_vector: Vector2 = Vector2.ZERO


func get_joystick_vector() -> Vector2:
	"""Returns the current joystick input vector"""
	return joystick_vector


func set_joystick_vector(vec: Vector2) -> void:
	"""Sets the joystick input vector (called by the mobile input UI)"""
	joystick_vector = vec
