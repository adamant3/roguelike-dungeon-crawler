# Beginner's Guide to This Project

Welcome! This guide will help you understand and work with this Godot project, even if you're new to game development.

## What is Godot?

Godot is a free, open-source game engine. It uses a language called GDScript (similar to Python) and a node-based scene system.

## Understanding the Project Structure

### Scenes vs Scripts

**Scenes (.tscn files):**
- Visual layout of game objects
- Like a blueprint or prefab
- Contains nodes arranged in a tree
- Example: `player.tscn` contains the player sprite, collision, and camera

**Scripts (.gd files):**
- The "brain" of your game objects
- Written in GDScript
- Makes things move, react, and interact
- Example: `player.gd` makes the player move when you press keys

### Key Concepts

#### Nodes
Everything in Godot is a node. Nodes can be:
- Visual (Sprite2D, ColorRect)
- Physics (CharacterBody2D, StaticBody2D)
- Logical (Timer, AudioStreamPlayer)

Nodes are organized in a tree structure, like a family tree.

#### Signals
Godot's way of sending messages between nodes. Like a doorbell - one node "rings" and others respond.

Example:
```gdscript
# Button emits 'pressed' signal
# We connect it to our function
button.pressed.connect(_on_button_pressed)
```

## Understanding the Code

### Player Movement (player.gd)

```gdscript
extends CharacterBody2D
```
This means our player is a physics body that can move and collide with things.

```gdscript
@export var move_speed: float = 200.0
```
`@export` makes this variable appear in the Godot editor, so you can change it without editing code!

```gdscript
func _physics_process(delta: float) -> void:
```
This function runs 60 times per second (once per physics frame). Perfect for movement!

```gdscript
velocity = input_vector * move_speed
move_and_slide()
```
This calculates how fast and where to move, then actually moves the player.

### Mobile Controls (mobile_input.gd)

```gdscript
@onready var joystick_bg: Control = $JoystickBackground
```
`@onready` means "grab this node when the scene is ready." The `$` is shorthand for getting a child node.

```gdscript
if event is InputEventScreenTouch:
```
This checks if someone touched the screen. Works on mobile devices and touch laptops!

## Making Changes

### Changing Player Speed

1. Open Godot
2. Open `scenes/player/player.tscn`
3. Click on the "Player" node
4. In the Inspector panel, find "Move Speed"
5. Change the value (higher = faster)
6. Press F5 to test!

### Adding a New Movement Key

1. Open `Project -> Project Settings -> Input Map`
2. Find the action (like "move_up")
3. Click the + icon to add another key
4. Press the key you want
5. Done! No code changes needed.

### Changing Room Colors

1. Open `scenes/levels/test_room.tscn`
2. Click on "Background" or "Floor" node
3. In the Inspector, find "Color"
4. Click the color box to pick a new color

## Common Tasks

### Adding a New Scene

1. Right-click in the FileSystem panel
2. Choose "New Scene"
3. Select a root node type
4. Add child nodes as needed
5. Save with Ctrl+S

### Creating a New Script

1. Select a node in the Scene panel
2. Click the "Attach Script" button (scroll icon)
3. Choose location and name
4. Click Create

### Testing Your Changes

- Press **F5** to run the game
- Press **F6** to run current scene only
- Press **F8** to stop

## Godot Basics

### Important Keyboard Shortcuts

- **F5** - Run project
- **F6** - Run current scene
- **F7** - Step into (debugging)
- **F8** - Stop
- **Ctrl+S** - Save scene
- **Ctrl+Shift+S** - Save scene as
- **Ctrl+D** - Duplicate node

### The Godot Interface

**Scene Panel (top-left):**
- Shows your node tree
- Click to select nodes
- Drag to rearrange

**Inspector Panel (right):**
- Shows properties of selected node
- Change values here
- Export variables appear here

**FileSystem Panel (bottom-left):**
- All your project files
- Drag to Scene panel to instantiate
- Double-click to open

**Viewport (center):**
- Visual preview of your scene
- Click and drag objects
- Use mouse wheel to zoom

## Learning Resources

### Official Godot Documentation
https://docs.godotengine.org/

Key pages for this project:
- CharacterBody2D
- Input handling
- Signals

### Recommended Learning Path

1. **Godot's official "Your First Game" tutorial**
   - Learn the interface
   - Make a simple game
   - ~2 hours

2. **Understand our Player script**
   - Read all the comments
   - Try changing values
   - Break things and fix them!

3. **Add a simple feature**
   - Maybe a speed boost when holding Shift?
   - Or a jump ability?
   - Start small!

## Tips for Beginners

### 1. Read the Comments
Every function in this project has comments explaining what it does. Read them!

### 2. Experiment
- Change numbers and see what happens
- Godot won't break if you try things
- Use Ctrl+Z if something goes wrong

### 3. Use Print Statements
```gdscript
print("Player position: ", position)
print("Input vector: ", input_vector)
```
These help you understand what's happening.

### 4. Check the Output Tab
Bottom of Godot shows errors and print statements. Check it often!

### 5. Start Small
Don't try to build everything at once. Add one feature, test it, then add another.

## Troubleshooting

### "Scene not found" Error
- Check `project.godot` has correct main scene path
- Make sure scene file exists
- Try right-click scene -> "Set as Main Scene"

### Script Errors
- Read the error message in the Output tab
- Check line number mentioned
- Look for typos or missing colons

### Player Not Visible
- Check if Sprite2D node exists
- Verify player position isn't off-screen
- Look at camera settings

### Can't Move Player
- Check input actions are set up
- Verify script is attached
- Check collision layers

## Next Steps

Ready to add features? Try these in order:

### Easy
1. Change player color/size
2. Adjust movement speed
3. Add a simple debug print on keypress

### Medium
1. Add a dash ability (double-tap direction)
2. Create a second room and door to it
3. Add a health bar UI

### Advanced
1. Implement enemy that chases player
2. Add collectible items
3. Save/load system

## Getting Help

### In This Project
- Read IMPLEMENTATION.md for technical details
- Check PROJECT_STRUCTURE.md for file organization
- All code has explanatory comments

### Online
- Godot Discord server
- r/godot on Reddit
- Godot Forums
- Stack Overflow (tag: godot)

### Ask Good Questions
1. What did you try?
2. What did you expect?
3. What actually happened?
4. What error messages do you see?

## Glossary

**Node:** A building block in Godot. Everything is a node.

**Scene:** A collection of nodes saved as a file. Can be reused.

**Signal:** A way for nodes to communicate. Like an event system.

**Script:** Code that controls how nodes behave.

**Export:** Makes a variable editable in the Godot editor.

**Delta:** Time since last frame. Used for frame-rate independent movement.

**Velocity:** How fast and which direction something is moving.

**Vector2:** A 2D point or direction (x, y).

**Autoload:** A script that's always loaded and globally accessible.

**Instance:** A copy of a scene added to another scene.

## Project-Specific Terms

**CharacterBody2D:** Physics body for characters that move (not affected by gravity in 2D).

**move_and_slide():** Godot function that moves the body and handles collisions.

**Input.get_action_strength():** Gets how much a button is pressed (0.0 to 1.0).

**Virtual Joystick:** On-screen control for mobile devices.

**Autoload (MobileInput):** Global script that manages mobile input state.

## Final Tips

1. **Save Often:** Ctrl+S is your friend
2. **Test Often:** Press F5 frequently
3. **Read Error Messages:** They usually tell you exactly what's wrong
4. **Don't Fear Breaking Things:** You can always undo or revert
5. **Have Fun:** Game development is creative and rewarding!

Remember: Every expert was once a beginner. Take your time, experiment, and enjoy learning!
