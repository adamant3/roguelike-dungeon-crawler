# Project Architecture

## Scene Hierarchy

```
main.tscn (Entry Point)
├── TestRoom (Node2D)
│   ├── TileMap
│   │   ├── Layer 0: Floor tiles
│   │   └── Layer 1: Wall tiles (with collision)
│   └── Player (CharacterBody2D)
│       ├── Sprite2D (16x16 knight sprite)
│       ├── CollisionShape2D (14x14 rectangle)
│       └── Camera2D (smooth following)
└── MobileControls (CanvasLayer)
    ├── VirtualJoystick (bottom-left)
    │   ├── Base (100x100 circle)
    │   └── Stick (60x60 circle, movable)
    └── ActionButtons (bottom-right)
        ├── PrimaryButton (Space/LMB)
        └── SecondaryButton (E/RMB)
```

## Script Architecture

### Player Movement (player_movement.gd)
- Extends: `CharacterBody2D`
- Handles: 8-directional movement with instant, responsive controls
- Exports: speed
- Input: Reads from Input actions (move_up, move_down, move_left, move_right)
- Features: Normalized diagonal movement for consistent speed

### Mobile Controls (mobile_controls.gd)
- Extends: `Control`
- Handles: Auto-show/hide based on platform detection
- Shows on: Mobile, Android, iOS
- Hides on: PC, Desktop

### Virtual Joystick (virtual_joystick.gd)
- Extends: `Control`
- Handles: Touch input for movement
- Simulates: Input actions for player movement
- Features: Dead zone, max distance clamping

## Asset Pipeline

### Sprites
All sprites use:
- Format: PNG with transparency
- Size: 16x16 pixels (except UI elements)
- Filtering: Nearest neighbor (pixel-perfect)
- Import settings: compress/mode=0, detect_3d/compress_to=0

### Tileset
- Resource: dungeon_tileset.tres
- Tile size: 16x16 pixels
- Sources:
  - Source 0: Floor tiles (no collision)
  - Source 1: Wall tiles (with collision polygons)

## Input System

### PC Controls
- Movement: WASD + Arrow Keys
- Primary Action: Space + Left Mouse Button
- Secondary Action: E + Right Mouse Button

### Mobile Controls
- Movement: Virtual joystick (touch and drag)
- Actions: Touch buttons (TouchScreenButton nodes)

## Display Configuration

### Viewport
- Base resolution: 320x180 (16:9)
- Window override: 1280x720 (4x scale)
- Stretch mode: canvas_items (maintains pixel art)
- Aspect: expand (fills screen)

### Rendering
- Default texture filter: Nearest (0)
- Renderer: GL Compatibility
- Pixel snap: Enabled via stretch mode
