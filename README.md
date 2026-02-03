# Roguelike Dungeon Crawler

A 2D roguelike dungeon crawler game built with Godot 4.x featuring pixel art graphics, real-time action combat, and procedural dungeon generation.

## Features

### Current Implementation
- ✅ 8-directional player movement with smooth physics
- ✅ Pixel-perfect rendering for retro aesthetic
- ✅ Camera system that follows the player
- ✅ Mobile touch controls (virtual joystick + action button)
- ✅ PC controls (WASD/Arrow keys + Spacebar/Enter)
- ✅ Test scene with basic room and collision boundaries
- ✅ Well-commented, beginner-friendly code

### Planned Features
- 🔲 Procedural dungeon generation
- 🔲 Multiple playable characters
- 🔲 Inventory and loot system
- 🔲 Enemy AI with various behaviors
- 🔲 Boss fights
- 🔲 Co-op multiplayer support
- 🔲 Endless mode

## Getting Started

### Requirements
- Godot 4.3 or higher
- No additional dependencies required

### How to Run
1. Clone this repository
2. Open the project in Godot 4.x
3. Press **F5** to run the game
4. Use **WASD** or **Arrow Keys** to move the player
5. On touch devices, use the virtual joystick (bottom-left) to move

## Project Structure

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for detailed information about the project organization.

```
/assets          - Game assets (sprites, audio, fonts)
/scenes          - Godot scene files
/scripts         - GDScript files
/resources       - Godot resources (themes, materials)
/autoloads       - Global singleton scripts
```

## Controls

### PC
- **WASD** / **Arrow Keys** - Move player
- **Space** / **Enter** - Action (future: attack/interact)

### Mobile
- **Virtual Joystick** (bottom-left) - Move player
- **Action Button** (bottom-right) - Action (future: attack/interact)

## Technical Details

- Built with Godot 4.3
- Uses CharacterBody2D for physics-based movement
- Configured for pixel art (texture filtering disabled)
- Viewport resolution: 1280x720 (scales to fit window)
- Supports both PC and mobile platforms

## Code Quality

All code includes:
- Clear, beginner-friendly comments
- Docstrings for functions explaining their purpose
- Descriptive variable names
- Godot naming conventions (snake_case)
- Modular design for extensibility

## Development Notes

This project is structured to support future features like:
- Procedural dungeon generation systems
- Multiple character classes with unique abilities
- Complex inventory and loot systems
- Advanced enemy AI behaviors
- Multiplayer networking

## License

This project is provided as-is for educational and development purposes.
