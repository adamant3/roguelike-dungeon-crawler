# Roguelike Dungeon Crawler

A 2D roguelike dungeon crawler game built with Godot 4.x, featuring pixel art graphics and real-time action combat.

## 🎮 Features

- **Pixel Art Style**: Optimized for classic pixel art aesthetics with nearest neighbor filtering
- **8-Directional Movement**: Smooth, responsive character movement using WASD/Arrow keys
- **Cross-Platform**: Designed for both PC (keyboard) and Mobile (touch controls)
- **Real-time Action Combat**: Fast-paced gameplay mechanics

## 🚀 Getting Started

### Prerequisites

- Godot 4.3 or later
- For Android export: Android SDK with appropriate build tools

### Opening the Project

1. Clone this repository
2. Open Godot 4.3+
3. Click "Import" and navigate to the project folder
4. Select `project.godot` and import

### Running the Game

1. Open the project in Godot
2. Press F5 or click the "Run Project" button
3. The game will start in the test level with the player character

## 📁 Project Structure

```
/assets
  /sprites      - All sprite assets (player, enemies, items, tiles, UI)
  /audio        - Sound effects and music
/scenes         - Godot scene files (.tscn)
  /player       - Player character scene
  /enemies      - Enemy scenes
  /items        - Item and pickup scenes
  /levels       - Level and dungeon scenes
  /ui           - UI components and menus
/scripts        - GDScript files (.gd)
  /player       - Player controller scripts
  /enemies      - Enemy AI and behavior
  /items        - Item functionality
  /systems      - Core game systems (input, camera, etc.)
  /utils        - Helper functions and utilities
/resources      - Godot resources (materials, animations, etc.)
```

## 🎯 Current Implementation

### Player Character
- **Scene**: `scenes/player/player.tscn`
- **Script**: `scripts/player/player.gd`
- Features:
  - 8-directional movement with WASD/Arrow keys
  - CharacterBody2D with collision detection
  - Simple idle and walk animations
  - Smooth camera follow system
  - Configurable movement speed (default: 200 px/s)

### Mobile Controls
- **Scene**: `scenes/ui/virtual_joystick.tscn`
- **Script**: `scripts/systems/virtual_joystick.gd`
- Features:
  - Virtual joystick for touch input
  - Automatically hidden on non-touch devices
  - Smooth directional input
  - Visual feedback with knob movement

### Test Level
- **Scene**: `scenes/levels/test_level.tscn`
- Features:
  - TileMap-based level design
  - Floor tiles (walkable area)
  - Wall tiles with collision (boundaries)
  - 30x20 tile room for testing movement

### Project Settings

#### Display
- Base resolution: 640x360
- Window size: 1280x720 (2x scale)
- Stretch mode: viewport

#### Rendering
- Texture filtering: Nearest neighbor (pixel perfect)
- 2D pixel snap enabled for transforms and vertices
- GL Compatibility renderer for maximum compatibility

#### Input Mapping
- `move_up`: W / Up Arrow
- `move_down`: S / Down Arrow
- `move_left`: A / Left Arrow
- `move_right`: D / Right Arrow

## 🔧 Development

### Adding New Content

#### Creating a New Enemy
1. Create scene in `scenes/enemies/`
2. Add script in `scripts/enemies/`
3. Create sprite in `assets/sprites/enemies/`

#### Creating a New Item
1. Create scene in `scenes/items/`
2. Add script in `scripts/items/`
3. Create sprite in `assets/sprites/items/`

#### Creating a New Level
1. Create scene in `scenes/levels/`
2. Use the existing TileMap tileset or create a new one
3. Add collision layers for walls and obstacles

### Code Style
- Use GDScript for all scripts
- Add comments explaining functionality (beginner-friendly)
- Follow Godot naming conventions (PascalCase for classes, snake_case for variables)
- Keep code modular and reusable

## 📦 Export

### Windows
Export preset is configured in `export_presets.cfg`:
- Target: x86_64
- Ready to export via Project → Export

### Android
Export preset is configured in `export_presets.cfg`:
- Package name: `com.adamant3.roguelikedungeoncrawler`
- Requires Android SDK setup in Godot
- ARM64 architecture enabled
- Immersive mode enabled for full-screen experience

## 🗺️ Future Roadmap

- [ ] Procedural dungeon generation
- [ ] Combat system with multiple weapons
- [ ] Enemy AI and behaviors
- [ ] Loot system with item rarities
- [ ] Character progression and builds
- [ ] Story mode with levels
- [ ] Endless/survival mode
- [ ] Co-op multiplayer support
- [ ] Enhanced UI and menus
- [ ] Save/load system
- [ ] Sound effects and music
- [ ] Particle effects and polish

## 📝 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.
