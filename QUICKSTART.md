# Quick Start Guide

## Opening the Project

1. **Install Godot 4.3 or later**
   - Download from [https://godotengine.org/download](https://godotengine.org/download)
   - Make sure to get version 4.3 or later

2. **Open the project**
   - Launch Godot
   - Click "Import"
   - Navigate to this project folder
   - Select the `project.godot` file
   - Click "Import & Edit"

3. **Run the game**
   - Press **F5** (or click the play button in the top-right)
   - The game will launch showing a test room with the player in the center

## Controls

### Desktop/PC
- **W** or **↑**: Move up
- **A** or **←**: Move left
- **S** or **↓**: Move down
- **D** or **→**: Move right
- **Space** or **Left Click**: Action (placeholder)

### Mobile/Touch
- **Virtual Joystick** (bottom-left): Drag to move
- **Action Button** (bottom-right): Tap for action (placeholder)

## Testing on Mobile

### Android Export
1. In Godot, go to **Project → Export**
2. Add **Android** export preset
3. Configure Android SDK path
4. Click **Export Project**

### iOS Export
1. Requires a Mac with Xcode installed
2. In Godot, go to **Project → Export**
3. Add **iOS** export preset
4. Click **Export Project**

### Testing Touch Controls on Desktop
To test the mobile controls without a physical device:
1. The touch controls automatically hide on desktop
2. To test them, you can temporarily modify `virtual_joystick.gd`:
   ```gdscript
   func _ready() -> void:
       visible = true  # Force visible for testing
       add_to_group("virtual_joystick")
   ```
3. Do the same for `action_button.gd`
4. Remember to revert these changes after testing!

## Modifying the Player

### Change Movement Speed
1. Open `scenes/player/player.tscn`
2. Select the root "Player" node
3. In the Inspector, find the **Script Variables** section
4. Change the **Speed** value (default: 200)

### Change Player Sprite
1. Create or import your sprite into `assets/sprites/`
2. Open `scenes/player/player.tscn`
3. Select the "Sprite2D" node
4. In the Inspector, change the **Texture** property
5. Adjust the **CollisionShape2D** to match your sprite size

## Next Steps

### Add Your First Enemy
1. Create a new scene: `scenes/enemies/enemy.tscn`
2. Add a CharacterBody2D as the root
3. Add Sprite2D and CollisionShape2D as children
4. Create a script: `scripts/enemies/enemy.gd`
5. Implement basic AI (e.g., move toward player)

### Add a Health System
1. Create `scripts/systems/health.gd`
2. Add variables for max_health and current_health
3. Add methods: `take_damage()`, `heal()`, `is_alive()`
4. Add this script to the player (and later enemies)

### Add an Inventory UI
1. Create `scenes/ui/inventory.tscn`
2. Use a GridContainer for item slots
3. Create `scripts/ui/inventory.gd`
4. Implement add_item(), remove_item(), etc.

## Common Issues

### "Scene not found" error
- Make sure the main scene is set in `project.godot`
- Should be: `run/main_scene="res://scenes/main.tscn"`

### Player falls through walls
- Check that walls have CollisionShape2D nodes
- Ensure the player has a CollisionShape2D
- Verify collision layers in Project Settings

### Player sprite not showing
- Make sure `player.svg` exists in `assets/sprites/`
- Check that the Sprite2D node has the texture assigned
- Reimport the texture if needed (right-click → Reimport)

### Touch controls not showing on mobile
- Touch controls only show if `DisplayServer.is_touchscreen_available()` returns true
- Test on an actual mobile device or use the testing method above

## Learning Resources

### Godot Documentation
- [Official Godot 4 Documentation](https://docs.godotengine.org/en/stable/)
- [CharacterBody2D](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)
- [Input Handling](https://docs.godotengine.org/en/stable/tutorials/inputs/index.html)

### Tutorials
- [GDQuest - Godot Tutorials](https://www.gdquest.com/)
- [Brackeys - Game Development](https://www.youtube.com/user/Brackeys)
- [HeartBeast - Godot RPG Tutorial](https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a)

## Project Structure Explained

```
roguelike-dungeon-crawler/
├── assets/           # All game assets
│   ├── sprites/     # Images and sprite sheets
│   ├── audio/       # Sound effects and music
│   └── fonts/       # Custom fonts
├── scenes/          # All Godot scenes (.tscn files)
│   ├── player/      # Player-related scenes
│   ├── enemies/     # Enemy scenes
│   ├── ui/          # User interface scenes
│   ├── levels/      # Level and dungeon scenes
│   ├── items/       # Item and pickup scenes
│   └── main.tscn    # Main game scene (entry point)
├── scripts/         # All GDScript files
│   ├── player/      # Player behavior scripts
│   ├── enemies/     # Enemy AI scripts
│   ├── ui/          # UI behavior scripts
│   ├── systems/     # Game systems (health, inventory, etc.)
│   └── items/       # Item behavior scripts
├── resources/       # Godot resources (themes, materials)
├── autoloads/       # Global singleton scripts
├── project.godot    # Main project configuration
└── icon.svg         # Project icon
```

## Tips for Beginners

1. **Start Small**: Focus on one feature at a time
2. **Use Comments**: Document your code as you write it
3. **Test Often**: Press F5 frequently to test changes
4. **Learn Groups**: Use groups to organize and find nodes (like the virtual_joystick group)
5. **Read the Docs**: The Godot documentation is excellent
6. **Join the Community**: The Godot Discord and forums are very helpful

## Need Help?

- Check the [Godot Q&A](https://ask.godotengine.org/)
- Join the [Godot Discord](https://discord.gg/godotengine)
- Search [r/godot on Reddit](https://www.reddit.com/r/godot/)
- Review the IMPLEMENTATION.md file for detailed technical information

Happy game developing! 🎮
