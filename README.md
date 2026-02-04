# Roguelike Dungeon Crawler

A 2D roguelike dungeon crawler game built with Godot 4.x featuring pixel art graphics and real-time action gameplay.

## Features

- **Pixel-perfect graphics**: All sprites rendered with nearest-neighbor filtering for crisp pixel art
- **8-directional movement**: Smooth character movement with acceleration and deceleration
- **Cross-platform**: Supports both PC (keyboard/mouse) and Mobile (touch controls)
- **Mobile controls**: Virtual joystick and action buttons that auto-show on mobile devices
- **Camera system**: Smooth following camera with pixel-perfect positioning

## Getting Started

### Prerequisites

- Godot 4.x (tested with Godot 4.3)
- Download from: https://godotengine.org/download

### Opening the Project

1. Clone or download this repository
2. Open Godot Engine
3. Click "Import" on the project manager
4. Navigate to the project folder and select `project.godot`
5. Click "Import & Edit"

### Running the Game

1. Press **F5** or click the **Play** button in the top-right corner
2. The test room will load with the player character in the center
3. Use the controls below to move around

## Controls

### PC/Desktop
- **Movement**: WASD or Arrow Keys
- **Primary Action** (Attack/Interact): Space or Left Mouse Button
- **Secondary Action**: E or Right Mouse Button

### Mobile
- **Movement**: Virtual joystick (bottom-left corner)
- **Actions**: Touch buttons (bottom-right corner)

## Project Structure

```
/assets
  /sprites      - Pixel art sprites (player, tiles, UI elements)
  /audio        - Sound effects and music (empty for now)
  /fonts        - Custom fonts (empty for now)
/scenes
  /player       - Player character scene
  /enemies      - Enemy scenes (empty for now)
  /ui           - User interface scenes (mobile controls, HUD)
  /levels       - Level/room scenes (test_room.tscn)
  main.tscn     - Main game scene (entry point)
/scripts
  /player       - Player-related scripts (movement, combat, etc.)
  /systems      - Game systems (empty for now)
  /ui           - UI-related scripts
/resources
  - Shared resources like tilesets, materials, etc.
```

## Technical Details

### Pixel Art Configuration
The game is configured for pixel-perfect rendering:
- Base resolution: 320x180 (16:9 aspect ratio)
- Window scales up to 1280x720 by default
- Texture filtering: Nearest neighbor (no blur)
- Stretch mode: canvas_items (maintains pixel art look)

### Player Movement
The player uses a `CharacterBody2D` with:
- Configurable speed (default: 100 pixels/second)
- Smooth acceleration (lerp factor: 0.15)
- Smooth deceleration/friction (lerp factor: 0.25)
- Support for both digital (keyboard) and analog (gamepad/touch) input

### Mobile Support
Mobile controls automatically show/hide based on platform detection:
- Virtual joystick for movement (bottom-left)
- Action buttons for attacks/interactions (bottom-right)
- Touch-friendly sizes and spacing

## Customization

### Adjusting Player Speed
1. Open `scenes/player/player.tscn`
2. Select the Player node
3. In the Inspector, modify the "Speed" property

### Creating New Levels
1. Duplicate `scenes/levels/test_room.tscn`
2. Edit the TileMap to create your layout
3. Use source 0 for floor tiles, source 1 for wall tiles
4. Add enemies and items as needed

### Adding New Sprites
1. Place 16x16 PNG files in `assets/sprites/`
2. Ensure pixel art settings are applied (nearest neighbor filtering)
3. Create corresponding `.import` files or let Godot generate them

## Next Steps

Future features to implement:
- [ ] Combat system
- [ ] Enemy AI
- [ ] Procedural dungeon generation
- [ ] Inventory system
- [ ] Health and stats
- [ ] Items and equipment
- [ ] Multiple levels/floors
- [ ] Sound effects and music
- [ ] Menu system

## License

This project is open source and available for educational purposes.

## Credits

Built with [Godot Engine](https://godotengine.org/)
