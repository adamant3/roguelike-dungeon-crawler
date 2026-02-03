# Project Structure

This Godot 4.x roguelike dungeon crawler project is organized for clarity and scalability.

## Folder Organization

### `/assets`
Contains all game assets:
- `/sprites` - Pixel art graphics for characters, enemies, items, etc.
- `/audio` - Sound effects and background music
- `/fonts` - Custom fonts for UI

### `/scenes`
Contains all Godot scene files (.tscn):
- `/player` - Player character scenes
- `/enemies` - Enemy character scenes
- `/ui` - User interface elements (HUD, menus, mobile controls)
- `/levels` - Level/room scenes including procedurally generated dungeons
- `/items` - Weapon, armor, and consumable item scenes

### `/scripts`
Contains all GDScript files (.gd):
- `/player` - Player character logic
- `/enemies` - Enemy AI and behavior
- `/ui` - UI functionality
- `/systems` - Game systems (dungeon generation, inventory, etc.)
- `/items` - Item behavior and effects

### `/resources`
Contains Godot resource files:
- Custom themes
- Materials
- Shader resources

### `/autoloads`
Contains singleton/global scripts that are always loaded:
- Game managers
- Global state
- Input handlers

## Getting Started

1. Open the project in Godot 4.x
2. Press F5 to run the test scene
3. Use WASD or Arrow keys to move the player
4. On touch devices, use the virtual joystick in the bottom-left corner

## Code Style

- All scripts use clear, beginner-friendly comments
- Functions include docstrings explaining their purpose
- Variables are named descriptively
- Code follows Godot's naming conventions (snake_case for variables/functions, PascalCase for classes)
