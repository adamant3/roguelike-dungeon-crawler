# roguelike-dungeon-crawler
A 2D roguelike dungeon crawler game built with Godot 4.x

## Getting Started

### Prerequisites
- Godot 4.3 or later

### Running the Game
1. Open the project in Godot 4.x
2. Press F5 to run the game
3. Use WASD or Arrow keys to move the player character around the test room

### Controls

#### PC
- **Movement**: WASD or Arrow keys
- **Action**: Space or Left Mouse Button (placeholder for future combat)

#### Mobile/Touch
- **Movement**: Virtual joystick (bottom-left corner)
- **Action**: Action button (bottom-right corner)

## Project Structure

```
/assets
  /sprites     - Pixel art sprites and graphics
  /audio       - Sound effects and music
  /fonts       - Font files
/scenes
  /player      - Player character scenes
  /enemies     - Enemy character scenes
  /ui          - User interface scenes
  /levels      - Level and dungeon scenes
  /items       - Item and loot scenes
/scripts
  /player      - Player scripts
  /enemies     - Enemy scripts
  /ui          - UI scripts
  /systems     - Game systems (game manager, dungeon generation, etc.)
  /items       - Item scripts
/resources     - Godot resources (themes, materials, etc.)
/autoloads     - Singleton/global scripts
```

## Features Implemented

### Core Systems
- ✅ 8-directional player movement using CharacterBody2D
- ✅ Smooth camera following
- ✅ Pixel-perfect rendering
- ✅ Virtual joystick for mobile/touch devices
- ✅ Action button for mobile
- ✅ Test scene with collision boundaries

### Project Configuration
- ✅ Optimized for pixel art (texture filtering disabled)
- ✅ Input mappings for PC and mobile
- ✅ 1280x720 default window size with proper scaling
- ✅ Touch input support

## Code Quality
- All code includes beginner-friendly comments
- Follows Godot 4.x conventions
- Modular design for easy expansion

## Future Features (Planned)
- Procedural dungeon generation
- Multiple playable characters
- Inventory and loot system
- Enemy AI
- Boss fights
- Co-op multiplayer
- Endless mode

## Technical Notes
- Built with Godot 4.3
- Uses CharacterBody2D for player physics
- Supports both PC and mobile platforms
- GDScript with comprehensive comments
