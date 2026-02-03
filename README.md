# Roguelike Dungeon Crawler

A 2D roguelike dungeon crawler game built with Godot 4.x featuring pixel art graphics, real-time action gameplay, and mobile support.

## 🎮 Features

### Current Features
- **8-Directional Player Movement**: Smooth character movement with WASD/Arrow keys
- **Mobile Support**: Virtual joystick for touch controls on mobile devices
- **Smooth Camera System**: Camera that follows the player with configurable bounds
- **Test Environment**: Basic test room with collision boundaries
- **Pixel Art Ready**: Project configured for pixel-perfect rendering

### Planned Features
- Multiple characters and builds
- Procedurally generated dungeons
- Extensive loot system
- Boss battles and varied enemies
- Different environments and biomes
- Story mode and endless mode
- Co-op multiplayer support

## 🚀 Getting Started

### Prerequisites
- [Godot 4.3+](https://godotengine.org/download) installed on your system

### Running the Project
1. Clone this repository
2. Open Godot Engine
3. Click "Import" and navigate to the project folder
4. Select `project.godot` and click "Import & Edit"
5. Press F5 or click the Play button to run the game

### Controls
- **Keyboard**: 
  - WASD or Arrow Keys for movement
- **Mobile/Touch**:
  - Touch anywhere on the lower 2/3 of the screen to activate virtual joystick
  - Drag to move in any direction

## 📁 Project Structure

```
/assets/              - Game assets (sprites, audio, fonts)
  /sprites/           - Sprite sheets and textures
    /player/          - Player character sprites
    /enemies/         - Enemy sprites
    /items/           - Item and loot sprites
    /tiles/           - Tileset textures
  /audio/             - Sound effects and music
    /sfx/             - Sound effects
    /music/           - Background music
  /fonts/             - Font files
  
/scenes/              - Godot scene files (.tscn)
  /player/            - Player-related scenes
  /enemies/           - Enemy scenes
  /items/             - Item scenes
  /ui/                - UI elements
  /levels/            - Level and room scenes
  /autoload/          - Autoload/singleton scenes
  
/scripts/             - GDScript files (.gd)
  /player/            - Player scripts
  /enemies/           - Enemy AI and behavior
  /items/             - Item logic
  /ui/                - UI controllers
  /systems/           - Game systems (camera, inventory, etc.)
  /autoload/          - Autoload scripts
  
/resources/           - Custom resources (.tres, .res)
```

## 🎨 Configuration

### Pixel Art Settings
The project is pre-configured for pixel-perfect rendering:
- Nearest neighbor texture filtering (no blur)
- 2D transform and vertex snapping enabled
- Default viewport: 1280x720 (configurable in project settings)

### Input Mapping
Input actions are defined in `project.godot`:
- `move_up`: W, Up Arrow
- `move_down`: S, Down Arrow
- `move_left`: A, Left Arrow
- `move_right`: D, Right Arrow

## 📝 Code Documentation

All scripts include comprehensive comments explaining:
- What each function does
- Parameter descriptions
- Return values
- Design decisions

### Key Scripts

#### Player Controller (`scripts/player/player.gd`)
Handles player movement with 8-directional support. Features:
- Smooth acceleration/deceleration
- Support for both keyboard and virtual joystick input
- Normalized diagonal movement (prevents faster diagonal speed)

#### Camera Controller (`scripts/systems/camera_controller.gd`)
Smooth camera follow system with:
- Configurable smoothing speed
- Optional boundary limits (for dungeon rooms)
- Automatic player tracking

#### Virtual Joystick (`scripts/ui/virtual_joystick.gd`)
Touch-friendly mobile controls:
- Appears only when needed (touch detected)
- Deadzone to prevent jitter
- Normalized output matching keyboard input

## 🔧 Extending the Project

### Adding New Enemies
1. Create a new scene in `/scenes/enemies/`
2. Create corresponding script in `/scripts/enemies/`
3. Use CharacterBody2D for movement
4. Add to collision layer 2

### Adding Items
1. Create item scene in `/scenes/items/`
2. Add sprite or placeholder visual
3. Implement pickup logic
4. Consider using Area2D for detection

### Creating New Levels
1. Duplicate `/scenes/levels/main.tscn`
2. Modify layout and add TileMap nodes
3. Update collision layers appropriately
4. Configure camera bounds for the room

## 🎯 Development Roadmap

- [ ] Implement basic combat system
- [ ] Add inventory system
- [ ] Create enemy AI
- [ ] Implement procedural dungeon generation
- [ ] Add loot and item system
- [ ] Create multiple character classes
- [ ] Add boss encounters
- [ ] Implement save/load system
- [ ] Add story mode
- [ ] Implement endless mode
- [ ] Add co-op multiplayer

## 📄 License

This project is a learning project and open for educational use.

## 🤝 Contributing

This is a learning project for beginners. Feel free to:
- Report issues
- Suggest improvements
- Add comments or documentation
- Create pull requests

## 💡 Learning Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [2D Movement in Godot](https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html)
