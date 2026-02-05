extends CharacterBody2D

@export var speed: float = 200.0  # Movement speed

func get_input() -> void:
	"""
    Processes keyboard inputs (ui_up, ui_down, ui_left, ui_right).
	"""
	# Read keyboard input using the default ui_ actions
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

