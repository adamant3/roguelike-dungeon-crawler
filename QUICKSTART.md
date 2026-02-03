# Quick Start Guide

Get up and running with the Roguelike Dungeon Crawler in minutes!

## Prerequisites

You need **Godot Engine 4.3 or later** installed on your computer.

👉 [Download Godot](https://godotengine.org/download)

## Installation

1. **Clone or download this repository**
   ```bash
   git clone https://github.com/adamant3/roguelike-dungeon-crawler.git
   cd roguelike-dungeon-crawler
   ```

2. **Open in Godot**
   - Launch Godot Engine
   - Click "Import"
   - Navigate to the project folder
   - Select `project.godot`
   - Click "Import & Edit"

3. **Run the game**
   - Press **F5** or click the Play button (▶️) in the top-right
   - The game should launch in a new window

## Controls

### Desktop/PC
- **W** or **↑** - Move up
- **S** or **↓** - Move down  
- **A** or **←** - Move left
- **D** or **→** - Move right

You can move diagonally by pressing two keys at once!

### Mobile/Touch
- **Touch** anywhere on the lower part of the screen
- A virtual joystick will appear
- **Drag** to move in any direction
- **Release** to stop moving

### Testing Touch Controls on Desktop
The game emulates touch input from mouse clicks, so you can test the virtual joystick on your computer by clicking and dragging.

## What You'll See

When you run the game, you'll see:
- A **blue square** (the player) in the center of the screen
- A **dark gray floor**
- **Brown walls** on all sides
- The **camera follows** the player smoothly

Try moving around! The player can move in 8 directions and will collide with the walls.

## Project Structure

```
roguelike-dungeon-crawler/
├── scenes/          # Godot scene files (.tscn)
│   ├── player/      # Player character
│   ├── ui/          # User interface
│   └── levels/      # Game levels (main.tscn is the entry point)
├── scripts/         # GDScript code files (.gd)
│   ├── player/      # Player logic
│   ├── ui/          # UI controllers
│   └── systems/     # Game systems (camera, etc.)
├── assets/          # Game assets (currently empty placeholders)
│   ├── sprites/     # Images and textures
│   ├── audio/       # Sound effects and music
│   └── fonts/       # Font files
└── resources/       # Godot resource files (.tres)
```

## Next Steps

### Learn How It Works
Read the comprehensive comments in the code:
- `scripts/player/player.gd` - Player movement system
- `scripts/systems/camera_controller.gd` - Camera follow system
- `scripts/ui/virtual_joystick.gd` - Mobile touch controls

### Add Your Own Assets
Replace the placeholder colored rectangles:
1. Add your pixel art sprites to `assets/sprites/`
2. Import them in Godot
3. Replace the ColorRect nodes with Sprite2D nodes
4. Assign your sprites

### Extend the Game
Check out [DEVELOPMENT.md](DEVELOPMENT.md) for detailed guides on:
- Adding enemies
- Creating items and pickups
- Building new levels
- Implementing combat
- Creating UI elements

### Modify the Player
Select the Player scene and try changing these values in the Inspector:
- **Speed**: How fast the player moves
- **Acceleration**: How quickly they reach full speed

Press F5 to test your changes!

## Troubleshooting

### "Main scene not found" error
- Go to Project → Project Settings → Application → Run
- Set "Main Scene" to `res://scenes/levels/main.tscn`

### Player moves through walls
- Check collision layers: Player on layer 1, Walls on layer 2
- Open scenes/player/player.tscn and verify CollisionShape2D exists

### Virtual joystick doesn't appear
- The joystick only appears when you touch/click the screen
- It's positioned where you touch
- Make sure you're clicking on the lower 2/3 of the screen

### Pixel art looks blurry
- This is already configured correctly in project.godot
- If adding new sprites, set their texture filter to "Nearest" in the import tab

## Getting Help

- 📖 [Godot Documentation](https://docs.godotengine.org/)
- 💬 [Godot Community](https://godotengine.org/community)
- 🐛 [Report Issues](https://github.com/adamant3/roguelike-dungeon-crawler/issues)

## Have Fun!

This project is designed for learning. Feel free to:
- ✅ Break things and experiment
- ✅ Modify any code
- ✅ Add your own features
- ✅ Share your improvements

The best way to learn game development is by doing. Happy coding! 🎮✨
