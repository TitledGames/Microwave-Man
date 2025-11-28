# Godot Game Project: Game Off 2025

## Project Overview

This is a 2D platformer game created with the Godot Engine for the Game Off 2025 game jam. The game features a player character that can move left and right, and jump. The objective of the game appears to be score-based, with a timer incrementing the score. The game has a simple heads-up display (HUD) that shows the score, messages, and a start button.

**Key Technologies:**

*   **Engine:** Godot Engine (version 4.5)
*   **Language:** GDScript
*   **Rendering:** GL Compatibility

**Architecture:**

The game is structured around a main scene (`main.tscn`) that brings together the player, the HUD, and the game world (tilemap).

*   **`main.gd`:** Manages the overall game state, including score, game over conditions, and starting a new game.
*   **`player.gd`:** Controls the player's movement, including jumping and horizontal motion.
*   **`hud.gd`:** Manages the user interface, including displaying messages, the score, and a "Game Over" screen.

## Building and Running

To run the game, you will need to have the Godot Engine installed. You can download it from the [official website](https://godotengine.org/).

1.  **Open the project:**
    *   Launch the Godot Engine.
    *   In the Project Manager, click "Import" and select the `project.godot` file in this directory.

2.  **Run the game:**
    *   Once the project is open in the editor, press the "Play" button (or F5) to run the game.

Alternatively, you can run the game from the command line:

```bash
godot
```

## Development Conventions

The project follows standard Godot and GDScript conventions.

*   **File Naming:** Scenes are named in `snake_case.tscn` and scripts in `snake_case.gd`.
*   **Input Handling:** Input actions are defined in the `project.godot` file and referenced in the scripts using `Input.is_action_just_pressed()` and `Input.get_axis()`.
*   **Signals:** The game uses signals to communicate between different nodes (e.g., the `start_game` signal from the HUD to the main scene).
