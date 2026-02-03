# Development Guide

This guide provides detailed information for developers working on the Roguelike Dungeon Crawler project.

## Table of Contents
1. [Getting Started](#getting-started)
2. [Project Architecture](#project-architecture)
3. [Coding Standards](#coding-standards)
4. [Adding New Features](#adding-new-features)
5. [Testing](#testing)
6. [Common Tasks](#common-tasks)

## Getting Started

### Setting Up Your Environment

1. **Install Godot 4.3+**
   - Download from [godotengine.org](https://godotengine.org/download)
   - Use the Standard version (not .NET)

2. **Clone and Open**
   ```bash
   git clone https://github.com/adamant3/roguelike-dungeon-crawler.git
   cd roguelike-dungeon-crawler
   ```
   Then open the project in Godot by selecting the `project.godot` file.

3. **Test the Project**
   - Press F5 or click "Run Project"
   - You should see the test level with a controllable player character

## Project Architecture

### Scene Structure
The project follows a hierarchical scene structure:

```
Main Scene (main.tscn)
├── TestLevel (test_level.tscn)
│   └── TileMap
├── Player (player.tscn)
│   ├── Sprite2D
│   ├── CollisionShape2D
│   ├── Camera2D
│   └── AnimationPlayer
└── CanvasLayer
    └── VirtualJoystick (virtual_joystick.tscn)
```

### Script Organization

- **Player Scripts** (`scripts/player/`)
  - Handle player input, movement, and state
  - Use CharacterBody2D for physics-based movement
  
- **System Scripts** (`scripts/systems/`)
  - Core game systems (input, camera, etc.)
  - Reusable components used across the game
  
- **Utility Scripts** (`scripts/utils/`)
  - Helper functions and common utilities
  - Math, formatting, data structures, etc.

### Key Design Patterns

1. **Scene Instancing**: Reusable components are packaged as scenes
2. **Export Variables**: Use `@export` for designer-accessible properties
3. **Onready Variables**: Use `@onready` for node references
4. **Signals**: Use for decoupled communication between nodes

## Coding Standards

### GDScript Style

```gdscript
# Class documentation at the top
extends CharacterBody2D
## Brief description of what this class does
## More detailed information on a second line

# Constants in SCREAMING_SNAKE_CASE
const MAX_HEALTH: int = 100
const MOVEMENT_SPEED: float = 200.0

# Export variables (accessible in editor)
@export var speed: float = 200.0
@export_range(0, 1) var friction: float = 0.1

# Onready variables (initialized when node enters tree)
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

# Regular variables in snake_case
var current_health: int = MAX_HEALTH
var is_moving: bool = false

# Lifecycle methods first
func _ready() -> void:
	# Initialization code
	pass

func _physics_process(delta: float) -> void:
	# Physics updates
	pass

# Public methods (no underscore)
func take_damage(amount: int) -> void:
	current_health -= amount

# Private methods (underscore prefix)
func _update_animation() -> void:
	# Internal helper method
	pass
```

### Best Practices

1. **Type Hints**: Always use type hints for clarity
   ```gdscript
   func calculate_damage(base: float, multiplier: float) -> float:
       return base * multiplier
   ```

2. **Comments**: Explain *why*, not *what*
   ```gdscript
   # Good: Cache reference to avoid repeated lookups every frame
   var cached_node: Node = null
   
   # Bad: Set cached_node to null
   var cached_node: Node = null
   ```

3. **Error Handling**: Check for null and edge cases
   ```gdscript
   var node = get_node_or_null("Path/To/Node")
   if node:
       node.do_something()
   ```

4. **Performance**: Cache expensive operations
   ```gdscript
   # Cache in _ready()
   @onready var heavy_resource = load("res://path/to/resource.tres")
   
   # Don't reload every frame
   func _process(delta):
       # Bad: var resource = load("res://path/to/resource.tres")
       heavy_resource.use()
   ```

## Adding New Features

### Creating a New Enemy Type

1. **Create the Scene** (`scenes/enemies/goblin.tscn`)
   ```
   Goblin (CharacterBody2D)
   ├── Sprite2D
   ├── CollisionShape2D
   ├── AnimationPlayer
   └── HealthComponent (optional)
   ```

2. **Create the Script** (`scripts/enemies/goblin.gd`)
   ```gdscript
   extends CharacterBody2D
   ## Goblin enemy - basic melee attacker
   
   @export var speed: float = 100.0
   @export var health: int = 50
   @export var damage: int = 10
   
   func _physics_process(delta: float) -> void:
       # AI behavior here
       pass
   
   func take_damage(amount: int) -> void:
       health -= amount
       if health <= 0:
           die()
   
   func die() -> void:
       queue_free()
   ```

3. **Add Sprite** (`assets/sprites/enemies/goblin.svg` or `.png`)

### Creating a New Item

1. **Create the Scene** (`scenes/items/health_potion.tscn`)
   ```
   HealthPotion (Area2D)
   ├── Sprite2D
   ├── CollisionShape2D
   └── AnimationPlayer (optional)
   ```

2. **Create the Script** (`scripts/items/health_potion.gd`)
   ```gdscript
   extends Area2D
   ## Health potion - restores player health when collected
   
   @export var heal_amount: int = 25
   
   func _ready() -> void:
       body_entered.connect(_on_body_entered)
   
   func _on_body_entered(body: Node2D) -> void:
       if body.is_in_group("player"):
           body.heal(heal_amount)
           queue_free()
   ```

### Creating a New Level

1. **Create the Scene** (`scenes/levels/dungeon_floor_1.tscn`)
2. **Add TileMap** for floor and walls
3. **Place Enemies** and items
4. **Add Entry/Exit Points**
5. **Test** by setting it as the main scene temporarily

## Testing

### Manual Testing Checklist

When making changes, test:
- [ ] Player movement (8 directions, smooth, no stuttering)
- [ ] Collision detection (walls stop player)
- [ ] Camera following (smooth, no jitter)
- [ ] Animations playing correctly
- [ ] Touch controls (if testing mobile)

### Testing on Mobile

1. **Export for Android**
   - Project → Export
   - Select "Android" preset
   - Export APK

2. **Install on Device**
   ```bash
   adb install -r path/to/game.apk
   ```

3. **Test Touch Controls**
   - Virtual joystick should appear
   - Should be responsive and smooth

## Common Tasks

### Adding a New Input Action

1. Open `Project Settings` → `Input Map`
2. Add new action (e.g., "attack")
3. Assign keys/buttons
4. Use in code:
   ```gdscript
   if Input.is_action_just_pressed("attack"):
       perform_attack()
   ```

### Changing Project Resolution

1. Open `Project Settings` → `Display` → `Window`
2. Adjust `Viewport Width/Height` for internal resolution
3. Adjust `Window Width/Height Override` for window size
4. Ratio should match for proper scaling

### Creating a TileSet

1. Import tile images to `assets/sprites/tiles/`
2. Create new TileMap in scene
3. Click TileSet property → "New TileSet"
4. Add atlas source
5. Configure collision polygons
6. Paint tiles in the TileMap editor

### Debugging Tips

1. **Print Debugging**
   ```gdscript
   print("Player position: ", position)
   print("Velocity: ", velocity)
   ```

2. **Visual Debugging**
   - Enable `Debug` → `Visible Collision Shapes`
   - Enable `Debug` → `Visible Paths`

3. **Breakpoints**
   - Click left of line number in script editor
   - Run in debug mode (F5)
   - Inspect variables when breakpoint hits

4. **Remote Scene Tree**
   - While game is running, check `Remote` tab
   - See live scene tree and node properties

## Performance Optimization

### General Tips

1. **Object Pooling**: Reuse objects instead of creating/destroying
2. **Minimize _process/_physics_process**: Only update when necessary
3. **Use Groups**: Faster than checking node type
4. **Avoid String Comparisons**: Use enums or constants
5. **Profile**: Use `Debug` → `Profiler` to find bottlenecks

### Example: Object Pool

```gdscript
# scripts/utils/object_pool.gd
extends Node
## Simple object pool for reusing nodes

var pool: Array = []
var scene: PackedScene

func initialize(scene_path: String, initial_size: int) -> void:
	scene = load(scene_path)
	for i in range(initial_size):
		var instance = scene.instantiate()
		instance.set_process(false)
		pool.append(instance)

func get_object() -> Node:
	if pool.is_empty():
		return scene.instantiate()
	var obj = pool.pop_back()
	obj.set_process(true)
	return obj

func return_object(obj: Node) -> void:
	obj.set_process(false)
	pool.append(obj)
```

## Resources

- [Godot Documentation](https://docs.godotengine.org/en/stable/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Godot Recipes](https://kidscancode.org/godot_recipes/4.x/)
- [GDQuest Tutorials](https://www.gdquest.com/)

## Getting Help

- **Documentation**: Check the official Godot docs first
- **Community**: Join the Godot Discord or Reddit
- **Code Comments**: Read comments in existing scripts
- **This Project**: Check README.md for project overview
