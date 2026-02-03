# Development Guide

This guide helps you understand and extend the Roguelike Dungeon Crawler project.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Getting Started](#getting-started)
3. [Architecture](#architecture)
4. [Adding Features](#adding-features)
5. [Best Practices](#best-practices)

## Project Overview

This is a 2D roguelike dungeon crawler built with Godot 4.3+ featuring:
- Real-time action gameplay
- 8-directional movement
- Mobile support with virtual joystick
- Pixel art style with proper rendering settings
- Modular, extensible architecture

## Getting Started

### Opening the Project
1. Install [Godot 4.3+](https://godotengine.org/download)
2. Open Godot
3. Click "Import" and select `project.godot`
4. Click "Import & Edit"

### Running the Game
- Press **F5** to run the project
- Press **F6** to run the current scene
- Press **F8** to step through code (debugging)

### Project Settings
Key settings configured in `project.godot`:
- Resolution: 1280x720 (expandable)
- Pixel snap enabled for pixel-perfect rendering
- Texture filtering set to "Nearest" (no blur)
- Input actions for movement
- Touch emulation enabled for desktop testing

## Architecture

### Scene Structure

```
main.tscn (Root Scene)
├── Environment (Node2D)
│   ├── Floor (ColorRect)
│   └── Walls (StaticBody2D with CollisionShapes)
├── Player (CharacterBody2D) [instance]
│   └── Camera2D
└── CanvasLayer
    └── VirtualJoystick [instance]
```

### Script Organization

**Player Scripts** (`/scripts/player/`)
- `player.gd`: Main player controller with movement logic

**System Scripts** (`/scripts/systems/`)
- `camera_controller.gd`: Camera follow system

**UI Scripts** (`/scripts/ui/`)
- `virtual_joystick.gd`: Touch controls for mobile

### Collision Layers

The project uses Godot's collision layer system:
- **Layer 1**: Player
- **Layer 2**: Walls and obstacles
- **Layer 3**: (Reserved for enemies)
- **Layer 4**: (Reserved for items)

Configure these in the Inspector for each physics body.

## Adding Features

### Creating a New Enemy

1. **Create the Enemy Scene**
   ```
   File -> New Scene -> CharacterBody2D
   Save as: scenes/enemies/enemy_name.tscn
   ```

2. **Add Visual Representation**
   - Add Sprite2D or ColorRect as child
   - Set texture or color

3. **Add Collision**
   - Add CollisionShape2D as child
   - Set appropriate shape and size
   - Set collision layer to 3

4. **Create Enemy Script**
   ```gdscript
   # scripts/enemies/enemy_name.gd
   extends CharacterBody2D
   
   @export var speed: float = 150.0
   @export var health: int = 100
   
   func _ready() -> void:
       add_to_group("enemies")
   
   func _physics_process(delta: float) -> void:
       # Add AI logic here
       move_and_slide()
   
   func take_damage(amount: int) -> void:
       health -= amount
       if health <= 0:
           queue_free()
   ```

5. **Attach Script to Scene**
   - Open the enemy scene
   - Select root node
   - Attach the script

### Adding Items/Pickups

1. **Create Item Scene**
   ```
   File -> New Scene -> Area2D
   Save as: scenes/items/item_name.tscn
   ```

2. **Set Up Detection**
   - Add CollisionShape2D
   - Connect `body_entered` signal
   - Set collision mask to detect player (layer 1)

3. **Create Item Script**
   ```gdscript
   # scripts/items/item_name.gd
   extends Area2D
   
   @export var heal_amount: int = 25
   
   func _ready() -> void:
       body_entered.connect(_on_body_entered)
   
   func _on_body_entered(body: Node2D) -> void:
       if body.is_in_group("player"):
           # Apply item effect
           print("Item collected!")
           queue_free()
   ```

### Creating New Levels

1. **Duplicate Template**
   - Copy `scenes/levels/main.tscn`
   - Rename appropriately

2. **Design the Level**
   - Modify wall positions
   - Add enemies (instance enemy scenes)
   - Add items and pickups
   - Place spawn points

3. **Update Camera Bounds**
   - Select Camera2D in player
   - Enable "Use Bounds"
   - Set boundary values to match room size

### Implementing Combat

Here's a basic combat system starter:

**Player Combat** (`scripts/player/player_combat.gd`):
```gdscript
extends Node

@export var damage: int = 10
@export var attack_cooldown: float = 0.5

var can_attack: bool = true

func attack() -> void:
    if not can_attack:
        return
    
    can_attack = false
    
    # Get enemies in range
    var space_state = get_world_2d().direct_space_state
    # ... implement attack logic
    
    # Cooldown timer
    await get_tree().create_timer(attack_cooldown).timeout
    can_attack = true
```

### Adding UI Elements

1. **Create UI Scene**
   ```
   scenes/ui/health_bar.tscn
   ```

2. **Use CanvasLayer**
   - UI should be in CanvasLayer for screen-space rendering
   - Use anchors for responsive layout

3. **Update UI from Game Events**
   - Use signals to decouple game logic from UI
   ```gdscript
   # In player script
   signal health_changed(new_health, max_health)
   
   # In UI script
   func _ready() -> void:
       var player = get_tree().get_first_node_in_group("player")
       player.health_changed.connect(_on_player_health_changed)
   ```

## Best Practices

### Code Style

Follow [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html):

```gdscript
# Use snake_case for variables and functions
var player_health: int = 100

# Use PascalCase for classes and nodes
class_name PlayerInventory

# Use CONSTANT_CASE for constants
const MAX_HEALTH: int = 100

# Add type hints
func calculate_damage(base_damage: int, multiplier: float) -> int:
    return int(base_damage * multiplier)

# Document with comments
## This function handles player movement
## Returns true if movement occurred
func move_player(direction: Vector2) -> bool:
    pass
```

### Performance Tips

1. **Use Object Pooling** for frequently spawned objects (bullets, particles)
2. **Limit physics queries** - don't raycast every frame
3. **Use groups** for finding nodes instead of searching entire tree
4. **Optimize with visibility** - pause/disable offscreen entities

### Signals vs. Direct Calls

**Use Signals When:**
- Decoupling systems (UI from game logic)
- Multiple listeners needed
- Cross-scene communication

**Use Direct Calls When:**
- Simple parent-child communication
- Performance-critical code
- One-way communication

### Scene Instances

**Pros of Instancing:**
- Reusable components
- Changes propagate to all instances
- Cleaner project structure

**When to Instance:**
- Enemies (create template, instance many)
- Items and pickups
- UI elements
- Projectiles

### Mobile Considerations

1. **Touch Targets**: Make buttons at least 64x64 pixels
2. **Virtual Controls**: Position in corners, make semi-transparent
3. **Performance**: Test on lower-end devices
4. **Screen Sizes**: Use anchors and margins for responsive UI

### Debugging Tips

```gdscript
# Print debugging
print("Player position: ", global_position)
print_debug("Debug info")  # Includes file and line number

# Draw debug shapes
func _draw() -> void:
    draw_circle(Vector2.ZERO, 50, Color.RED)

# Breakpoints
# Click left of line number in script editor
# Run with F5, execution will pause at breakpoint

# Remote scene tree
# Use "Remote" tab in Scene dock while game runs
# Inspect node properties live
```

### Version Control

**Commit Often:**
- After each feature
- Before major refactors
- When tests pass

**Good Commit Messages:**
```
Add enemy pathfinding system
Fix player collision with walls
Implement health bar UI
```

**What to Ignore:**
Already in `.gitignore`:
- `.godot/` (Godot's cache)
- `.import/` (import cache)
- `export/` (exported builds)

## Common Issues

### Problem: Player passes through walls
**Solution:** Check collision layers and masks. Player should be on layer 1, mask layer 2. Walls on layer 2, mask layer 1.

### Problem: Diagonal movement too fast
**Solution:** Normalize the input vector (already done in player.gd)

### Problem: Camera jittery
**Solution:** Increase smoothing_speed or move camera update to `_physics_process`

### Problem: Touch controls not working
**Solution:** Check that InputEventScreenTouch is enabled in project settings

### Problem: Pixel art looks blurry
**Solution:** 
1. Set texture filter to "Nearest" in import settings
2. Enable pixel snap in project settings
3. Use power-of-2 texture sizes

## Resources

- [Godot Docs](https://docs.godotengine.org/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html)
- [Godot Q&A](https://ask.godotengine.org/)
- [Godot Discord](https://discord.gg/godotengine)

## Next Steps

Now that you understand the basics, consider implementing:
1. Health system for player and enemies
2. Simple combat mechanics
3. Inventory system
4. Procedural dungeon generation
5. Save/load functionality
6. Sound effects and music
7. Particle effects
8. Main menu and pause screen

Happy developing! 🎮
