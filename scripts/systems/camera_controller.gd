extends Camera2D
## Smooth camera that follows the player
##
## This camera smoothly tracks the player's position and can be configured
## to stay within bounds (useful for individual dungeon rooms).

## How quickly the camera follows the player (0-1, higher = faster)
@export var smoothing_speed: float = 5.0

## Enable camera bounds (useful for keeping camera within a room)
@export var use_bounds: bool = false

## Camera boundary limits (in pixels)
@export var bounds_left: int = 0
@export var bounds_top: int = 0
@export var bounds_right: int = 1280
@export var bounds_bottom: int = 720

# Reference to the player node
var player: Node2D = null


func _ready() -> void:
	"""
	Called when the camera is added to the scene.
	Finds and stores a reference to the player.
	"""
	# Make this the current active camera
	make_current()
	
	# Find the player node in the scene
	# We look for any node in the "player" group
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	
	# Configure camera bounds if enabled
	if use_bounds:
		limit_left = bounds_left
		limit_top = bounds_top
		limit_right = bounds_right
		limit_bottom = bounds_bottom


func _physics_process(delta: float) -> void:
	"""
	Called every physics frame.
	Smoothly moves the camera to follow the player.
	
	Args:
		delta: Time elapsed since last frame
	"""
	if player:
		# Smoothly interpolate the camera position toward the player
		# lerp() blends between current position and target position
		global_position = global_position.lerp(player.global_position, smoothing_speed * delta)
