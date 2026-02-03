# Game Configuration Reference

This document explains the key configuration settings in the project.

## Project Settings (project.godot)

### Display Settings
```
window/size/viewport_width = 1280
window/size/viewport_height = 720
window/size/mode = 2              # Windowed mode
window/stretch/mode = "canvas_items"
window/stretch/aspect = "expand"
```

**What this means:**
- Base resolution is 1280x720 (16:9 aspect ratio)
- Window is resizable
- Content scales to fit while maintaining aspect ratio
- Good for both PC and mobile devices

### Rendering Settings (Pixel Art)
```
textures/canvas_textures/default_texture_filter = 0  # Nearest neighbor
2d/snap/snap_2d_transforms_to_pixel = true
2d/snap/snap_2d_vertices_to_pixel = true
```

**What this means:**
- Textures won't blur when scaled (pixel-perfect)
- Objects snap to pixel grid (no sub-pixel positioning)
- Perfect for retro/pixel art games

### Input Actions
```
move_up    = W, Up Arrow
move_down  = S, Down Arrow
move_left  = A, Left Arrow
move_right = D, Right Arrow
```

**Customizing:**
To add more actions (like attack, interact):
1. Open Project → Project Settings → Input Map
2. Add new action name
3. Add key bindings
4. Use in code: `Input.is_action_pressed("action_name")`

## Player Configuration

**File:** `scripts/player/player.gd`

```gdscript
@export var speed: float = 300.0           # Movement speed (pixels/second)
@export var acceleration: float = 10.0     # How quickly player accelerates
```

**Tweaking values:**
- **speed = 200**: Slower, more tactical gameplay
- **speed = 500**: Fast-paced, arcade-style
- **acceleration = 20**: Instant movement (no smoothing)
- **acceleration = 5**: Very smooth, floaty feel

## Camera Configuration

**File:** `scripts/systems/camera_controller.gd`

```gdscript
@export var smoothing_speed: float = 5.0   # Camera follow speed
@export var use_bounds: bool = false       # Enable boundary limits
@export var bounds_left: int = 0           # Left boundary
@export var bounds_top: int = 0            # Top boundary  
@export var bounds_right: int = 1280       # Right boundary
@export var bounds_bottom: int = 720       # Bottom boundary
```

**Use cases:**
- **smoothing_speed = 10**: Camera follows closely
- **smoothing_speed = 3**: More cinematic lag
- **use_bounds = true**: For confined dungeon rooms
- **use_bounds = false**: For large open areas

## Virtual Joystick Configuration

**File:** `scripts/ui/virtual_joystick.gd`

```gdscript
@export var max_distance: float = 64.0     # Joystick range (pixels)
@export var deadzone: float = 0.2          # Minimum input threshold
```

**Tweaking values:**
- **max_distance = 80**: Larger joystick, easier to use
- **max_distance = 40**: Compact, less screen space
- **deadzone = 0.1**: More sensitive (might be jittery)
- **deadzone = 0.3**: Less sensitive (might feel unresponsive)

## Collision Layers

**Purpose:** Control what objects can collide with each other

**Current setup:**
- **Layer 1**: Player
- **Layer 2**: Walls/Environment  
- **Layer 3**: Reserved for Enemies
- **Layer 4**: Reserved for Items

**How it works:**
- Player (Layer 1) collides with Walls (Layer 2)
- To make enemies collide with walls, set enemy to Layer 3, Mask 2
- To detect player touch items, set item Area2D to Mask 1

**Changing collision:**
1. Select the node (Player, Wall, etc.)
2. Look in Inspector → Collision
3. Set "Layer" (what this object IS)
4. Set "Mask" (what this object DETECTS)

## Scene Structure

### Main Scene (scenes/levels/main.tscn)
```
Main (Node2D)
├── Environment
│   ├── Floor (visual)
│   └── Walls (collision)
├── Player (instanced)
│   └── Camera2D
└── CanvasLayer
    └── VirtualJoystick (instanced)
```

**Why this structure:**
- **Node2D root**: 2D game space
- **Environment group**: Easy to replace/modify levels
- **Player instanced**: Reuse player in multiple levels
- **CanvasLayer**: UI stays on screen (doesn't move with camera)

## File Naming Conventions

Following Godot best practices:

**Scenes:** `snake_case.tscn`
- ✅ `player.tscn`, `health_bar.tscn`
- ❌ `Player.tscn`, `HealthBar.tscn`

**Scripts:** `snake_case.gd`
- ✅ `player.gd`, `enemy_ai.gd`
- ❌ `Player.gd`, `EnemyAI.gd`

**Classes:** `PascalCase` (in code)
```gdscript
class_name PlayerInventory  # ✅
class_name player_inventory # ❌
```

## Performance Considerations

### Current Performance Profile
- **Draw calls**: Minimal (simple shapes)
- **Physics objects**: 2 (Player + Walls)
- **Scripts active**: 3 (Player, Camera, Joystick)

**This is very lightweight!** You can easily add:
- 50+ enemies without issue
- Complex particle effects
- Multiple level layers
- Animated sprites

### When to Optimize
Watch for these signs:
- Frame rate drops below 60 FPS
- Input lag or stuttering
- Slow level loading

**Optimization strategies:**
1. Use object pooling for bullets/particles
2. Pause AI for off-screen enemies
3. Use VisibleOnScreenNotifier2D
4. Limit physics queries (raycasts)

## Extending Configuration

### Adding New Export Variables

In any script:
```gdscript
@export var my_variable: int = 100
@export_range(0, 100) var percentage: int = 50
@export_enum("Fast", "Medium", "Slow") var speed_preset: String = "Medium"
```

These appear in the Inspector and can be changed without editing code!

### Creating Custom Resources

For complex configurations, create a resource:

1. Create new script extending Resource
```gdscript
# player_stats.gd
extends Resource
class_name PlayerStats

@export var max_health: int = 100
@export var move_speed: float = 300
@export var damage: int = 10
```

2. Create instance via FileSystem
3. Assign to player via @export

## Need Help?

- Check [DEVELOPMENT.md](DEVELOPMENT.md) for implementation details
- See [QUICKSTART.md](QUICKSTART.md) for basic usage
- Read [README.md](README.md) for project overview
