# Implementation Guide

This document provides a detailed explanation of the implemented features for the Roguelike Dungeon Crawler project.

## Core Features

### 1. Project Configuration (project.godot)

**Pixel Art Settings:**
- Texture filtering disabled (`textures/canvas_textures/default_texture_filter=0`) for crisp pixel art
- Viewport stretch mode set to "viewport" for pixel-perfect scaling
- Default window size: 1280x720 with proper aspect ratio maintenance

**Input Mappings:**
- `move_up`: W key + Up Arrow
- `move_down`: S key + Down Arrow
- `move_left`: A key + Left Arrow
- `move_right`: D key + Right Arrow
- `action`: Space + Enter (for future combat/interaction)

**Mobile Support:**
- Configured for mobile export
- Touch input support enabled

### 2. Player Character (scripts/player/player.gd)

**8-Directional Movement:**
```gdscript
# Input is read from both keyboard and virtual joystick
# Diagonal movement is normalized to prevent faster movement
input_vector = input_vector.normalized()
```

**Key Features:**
- Extends `CharacterBody2D` (Godot 4.x physics body)
- Configurable movement speed (default: 200 pixels/second)
- Smooth collision handling via `move_and_slide()`
- Sprite flipping based on movement direction
- Integration with mobile input via global autoload

**Physics:**
- Uses Godot's built-in physics engine
- Collision detection works with StaticBody2D (walls)
- No acceleration/deceleration for tight, responsive controls

### 3. Camera System (scenes/player/player.tscn)

**Camera2D Configuration:**
- Attached to player node (follows player automatically)
- Position smoothing enabled (smoothing speed: 5.0)
- Pixel-perfect rendering support
- Automatically centers on player

**Benefits:**
- Smooth camera movement without jitter
- Proper for pixel art games
- Easy to extend for camera shake effects

### 4. Mobile Controls (scripts/ui/mobile_input.gd)

**Virtual Joystick:**
- Circular joystick with configurable max distance
- Touch tracking for multi-touch support
- Normalized output vector for consistent movement
- Only visible on touch-enabled devices

**Implementation Details:**
```gdscript
# Touch detection
if event is InputEventScreenTouch:
    handle_touch(event)
elif event is InputEventScreenDrag:
    handle_drag(event)
```

**Action Button:**
- Positioned in bottom-right corner
- Simulates keyboard "action" input
- Ready for combat system integration

**Global Autoload:**
- `MobileInput` autoload provides global access to joystick state
- Decoupled from player for modularity
- Can be accessed from any script in the game

### 5. Test Scene (scenes/levels/test_room.tscn)

**Components:**
- Background layer (dark purple-blue)
- Floor layer (lighter purple-blue)
- Collision boundaries (walls on all sides)
- Player spawn point (center of room)
- Mobile input UI overlay

**Collision System:**
- StaticBody2D with RectangleShape2D for walls
- Prevents player from moving outside room
- Ready for more complex level geometry

## Code Architecture

### Separation of Concerns

1. **Scripts:** All logic separated from scenes
2. **Scenes:** Visual structure and node hierarchy
3. **Autoloads:** Global state and cross-scene communication

### Extensibility

The code is structured to easily add:

**Inventory System:**
```gdscript
# Add to autoloads/
# Access via Inventory.add_item(), Inventory.get_items()
```

**Enemy AI:**
```gdscript
# Similar structure to player
# Can use same collision/physics system
# Would go in scripts/enemies/
```

**Procedural Dungeons:**
```gdscript
# Would go in scripts/systems/dungeon_generator.gd
# Can instantiate room scenes dynamically
```

## Best Practices Used

### 1. Comments and Documentation
- Every function has a docstring
- Complex logic is explained inline
- Variables have descriptive names

### 2. Godot Conventions
- `snake_case` for variables and functions
- `PascalCase` for classes
- `@export` for designer-configurable values
- Type hints for all function signatures

### 3. Performance
- Node references cached with `@onready`
- Minimal calculations per frame
- Input processed only when needed

### 4. Modularity
- Player movement logic separate from rendering
- Input handling decoupled from player
- Easy to swap out systems

## Testing the Game

### In Godot Editor:
1. Open project in Godot 4.3+
2. Press F5 to run
3. Player should spawn in center of room
4. Movement should work with WASD/Arrows
5. Player should collide with walls

### Expected Behavior:
- Player moves smoothly in all 8 directions
- Camera follows player with slight smoothing
- Player cannot move through walls
- Sprite flips when moving left/right
- Mobile controls hidden on PC (no touch screen)

## Future Integration Points

### Combat System:
```gdscript
# In player.gd, add:
func attack():
    # Spawn projectile or melee hitbox
    # Play animation
    # Trigger sound effect
```

### Health System:
```gdscript
# Add to player.gd:
@export var max_health: float = 100.0
var current_health: float = max_health

func take_damage(amount: float):
    current_health -= amount
    if current_health <= 0:
        die()
```

### Inventory:
```gdscript
# Create autoloads/inventory.gd:
var items: Array = []

func add_item(item):
    items.append(item)
```

## Troubleshooting

### Player Not Moving:
- Check input actions are defined in project.godot
- Verify player script is attached to Player node
- Check collision layers/masks

### Camera Not Following:
- Ensure Camera2D is child of Player node
- Check camera is enabled
- Verify position smoothing settings

### Mobile Controls Not Working:
- Ensure MobileInput autoload is configured
- Check touch input is enabled in project settings
- Verify scene includes mobile_input.tscn instance

## Performance Optimization Tips

For future development:
1. Use object pooling for projectiles/enemies
2. Implement spatial partitioning for large dungeons
3. Use visibility notifiers to pause off-screen objects
4. Consider TileMaps for efficient level rendering
5. Profile with Godot's built-in profiler

## Next Steps

Recommended order for implementing additional features:
1. Add basic attack animation and hitbox
2. Create first enemy type with simple AI
3. Implement health and damage system
4. Add basic loot drops
5. Create room templates for procedural generation
6. Implement simple inventory UI
7. Add sound effects and music
8. Polish and juice (particle effects, screen shake, etc.)
