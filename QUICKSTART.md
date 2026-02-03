# Quick Start Guide

Get up and running with the Roguelike Dungeon Crawler in minutes!

## Prerequisites

- **Godot Engine 4.3 or later** ([Download here](https://godotengine.org/download))
- **Git** (for cloning the repository)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/adamant3/roguelike-dungeon-crawler.git
cd roguelike-dungeon-crawler
```

### 2. Open in Godot

1. Launch Godot Engine
2. Click **"Import"** in the project manager
3. Click **"Browse"** and navigate to the cloned repository
4. Select the `project.godot` file
5. Click **"Import & Edit"**

### 3. Run the Game

Press **F5** or click the **"Run Project"** button (play icon) in the top-right corner.

## Controls

### PC (Keyboard)
- **W / Up Arrow** - Move Up
- **S / Down Arrow** - Move Down
- **A / Left Arrow** - Move Left
- **D / Right Arrow** - Move Right

You can move in 8 directions by combining keys (e.g., W+D for diagonal movement).

### Mobile (Touch)
- **Virtual Joystick** - Appears in the bottom-left corner
- **Drag the joystick** to move in any direction

## What You'll See

The game starts in a test level:
- **Brown floor tiles** - The walkable area
- **Gray wall tiles** - Boundaries with collision
- **Blue character** - Your player (in the center)
- **Camera** - Follows your character smoothly

## Next Steps

### Exploring the Project
1. Check the **Scene Tree** (left panel) to see the game structure
2. Open **scenes/player/player.tscn** to see the player setup
3. Open **scripts/player/player.gd** to see the movement code

### Making Changes
1. **Adjust Player Speed**
   - Open `scenes/player/player.tscn`
   - Select the Player node
   - In the Inspector, change the "Speed" property
   - Run the game to test

2. **Change Window Size**
   - Go to `Project` → `Project Settings`
   - Navigate to `Display` → `Window`
   - Adjust `Window Width Override` and `Window Height Override`

3. **Add More Tiles**
   - Open `scenes/levels/test_level.tscn`
   - Select the TileMap node
   - Use the TileMap editor to paint more tiles

## Troubleshooting

### Game Won't Run
- **Check Console**: Look for error messages in the Output panel (bottom)
- **Verify Godot Version**: Must be 4.3 or later
- **Re-import Project**: Close and re-open the project in Godot

### Player Won't Move
- **Check Input Map**: `Project` → `Project Settings` → `Input Map`
- **Verify move_up, move_down, move_left, move_right actions exist**
- **Console Messages**: Look for any error messages

### Black Screen
- **Main Scene Set**: `Project` → `Project Settings` → `Application` → `Run`
- **Verify**: "Main Scene" should be `res://scenes/main.tscn`

## Project Structure Overview

```
roguelike-dungeon-crawler/
├── assets/          # Images, sounds, and other assets
│   ├── sprites/     # All sprite graphics
│   └── audio/       # Sound effects and music (placeholder)
├── scenes/          # Godot scene files
│   ├── player/      # Player character scene
│   ├── levels/      # Level/dungeon scenes
│   └── ui/          # User interface components
├── scripts/         # GDScript code files
│   ├── player/      # Player-related scripts
│   └── systems/     # Core game systems
├── project.godot    # Main project configuration
└── README.md        # Project documentation
```

## Learning Resources

### Godot Basics
- [Official Godot Documentation](https://docs.godotengine.org/en/stable/)
- [Your First 2D Game Tutorial](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html)

### GDScript Programming
- [GDScript Basics](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html)

### This Project
- **README.md** - Full project documentation
- **DEVELOPMENT.md** - Developer guide with code examples
- **Script Comments** - All scripts have explanatory comments

## Common First Tasks

### 1. Change Player Appearance
1. Create or find a 32x32 pixel sprite
2. Save it to `assets/sprites/player/`
3. Open `scenes/player/player.tscn`
4. Select the Sprite2D node
5. Drag your new sprite to the "Texture" property

### 2. Expand the Test Level
1. Open `scenes/levels/test_level.tscn`
2. Select the TileMap node
3. Use the paint tool to add more floor and wall tiles
4. Test by running the game (F5)

### 3. Adjust Movement Speed
1. Open `scenes/player/player.tscn`
2. Select the root Player node
3. Change "Speed" in the Inspector (default: 200)
4. Higher = faster, Lower = slower

### 4. Test on Mobile
1. Go to `Project` → `Export`
2. Select "Android" preset
3. Click "Export Project"
4. Install the APK on your device

## Need Help?

- **Read the Documentation**: Check README.md and DEVELOPMENT.md
- **Check Comments**: Scripts have detailed comments explaining the code
- **Godot Community**: Visit [Godot's Discord](https://discord.gg/godotengine) or [Reddit](https://www.reddit.com/r/godot/)
- **GitHub Issues**: Report bugs or ask questions on the project's GitHub

---

**Happy Game Development! 🎮**
