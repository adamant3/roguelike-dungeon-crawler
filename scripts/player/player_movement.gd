extends CharacterBody2D

@export var speed: float = 200.0  # Movement speed

func get_input() -> Vector2:
    """
    Calculate velocity based on directional input (W/A/S/D or Arrow Keys).
    """
    var move_vector: Vector2 = Vector2.ZERO  # Clear existing velocity each frame

    # Add direction for each key press
    if Input.is_action_pressed("move_right"):  # D or Right Arrow
        move_vector.x += 1
    if Input.is_action_pressed("move_left"):  # A or Left Arrow
        move_vector.x -= 1
    if Input.is_action_pressed("move_down"):  # S or Down Arrow
        move_vector.y += 1
    if Input.is_action_pressed("move_up"):  # W or Up Arrow
        move_vector.y -= 1

    # Normalize to maintain constant speed when moving diagonally
    if move_vector.length() > 0:
        move_vector = move_vector.normalized()

    return move_vector

func _physics_process(_delta: float) -> void:
    # Get the normalized directional input
    velocity = get_input() * speed

    # Use move_and_slide; no arguments because velocity is handled automatically
    move_and_slide()
