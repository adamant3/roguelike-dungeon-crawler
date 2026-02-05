extends CharacterBody2D

@export var speed: int = 200  # Movement speed value
var velocity: Vector2 = Vector2.ZERO  # Holds current velocity

func get_input() -> void:
    """
    Processes input from directional actions and calculates the velocity vector.
    Opposing inputs cancel each other out.
    """
    velocity = Vector2()  # Reset velocity every frame
    if Input.is_action_pressed("move_right"):  # D or Right Arrow
        velocity.x += 1
    if Input.is_action_pressed("move_left"):  # A or Left Arrow
        velocity.x -= 1
    if Input.is_action_pressed("move_down"):  # S or Down Arrow
        velocity.y += 1
    if Input.is_action_pressed("move_up"):  # W or Up Arrow
        velocity.y -= 1

    # Normalize for consistent speed in all directions (especially diagonals)
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed

func _physics_process(delta: float) -> void:
    # Update the velocity based on inputs
    get_input()

    # Move the player with the computed velocity
    move_and_slide(velocity)
