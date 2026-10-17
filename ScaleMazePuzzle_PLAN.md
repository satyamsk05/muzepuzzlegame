# Scale Maze Puzzle — Minimal Game Plan
**Document type:** AI-agent implementation specification  
**Platform:** Android  
**Orientation:** Portrait / Vertical only  
**Game technology:** Godot 4.x + GDScript  
**Optional native integration:** Kotlin only if a specific Android feature is later required  
**Project name:** `ScaleMazePuzzle`

---

## 1. Project Goal

Build a small, polished Android sliding-picture puzzle inspired by the old plastic ruler/scale toys that contained a tiny sliding game.

The player slides picture tiles into the empty space until the picture is complete. The game must be genuinely playable, work offline, support touch input, and export as an Android APK.

### Scope rule
Keep the first release minimal. Do **not** add accounts, a backend, online multiplayer, ads, purchases, analytics, or complicated progression in version 1.

## 2. Screen Orientation and Layout

- **Portrait (vertical) orientation only.**
- Never use landscape as the default or required layout.
- Design for common phone aspect ratios and safe areas.
- Main play area should resemble a long, horizontal plastic ruler placed within a portrait phone screen.
- Keep all buttons large enough for comfortable touch use.
- Avoid placing important controls under the system status/navigation bars.
- If the screen is short, scale the board and spacing down while keeping tiles tappable.

Suggested vertical layout:
1. Top app bar: game title and sound toggle.
2. Level / short instruction row.
3. Picture preview or target picture.
4. Main ruler-shaped sliding board.
5. Move counter and timer.
6. Restart / Shuffle controls.
7. Completion message and Next Level button, shown only when solved.

## 3. Core Gameplay

### Board
- Use a **3-row × 5-column grid** (15 cells total).
- Place **14 picture tiles and 1 empty cell** on the board.
- The board itself should look like a rounded transparent-plastic ruler: subtle translucent frame, small measurement ticks along the top/bottom edges, soft highlights, and a clean outline.
- The tiles should be easy to distinguish; decorative ruler marks must not interfere with gameplay.

### Controls
- Tap a tile directly adjacent to the empty cell (up, down, left, or right) to move it into the empty cell.
- A swipe gesture may be supported as an optional enhancement, but tapping adjacent tiles is the required interaction for version 1.
- Diagonal movement is not allowed.
- Ignore taps on non-adjacent tiles.
- Prevent multiple moves from being processed simultaneously during a tile animation.

### Puzzle rules
- Use an original image or a simple custom-drawn illustration, divided into 15 equal tile regions; one region is hidden as the empty cell.
- The solved board must display the image in its correct order with the empty cell in the final position.
- Generate shuffled boards using legal random moves from the solved state. This guarantees a solvable puzzle.
- Avoid immediately reversing the previous shuffle move when possible.
- Do not shuffle by random permutation unless a correct solvability test is implemented.
- Detect victory only when every tile is in its target index and the empty cell is in the designated final index.
- After victory, lock the board until the player selects Next Level or Play Again.

### Move and timer behavior
- Increment the move count only for valid player moves.
- Start the timer on the first valid player move, not when the screen opens.
- Stop the timer on victory and while paused.
- Restart resets the board, timer, and move count.
- Shuffle creates a new solvable board and resets the timer and move count.

## 4. Minimal Game Screens

### A. Home Screen
Include:
- Game title: **Scale Maze Puzzle**
- One primary **Play** button
- A small **How to Play** button
- Optional sound on/off toggle

Do not add login, profiles, social features, daily rewards, shops, or currencies.

### B. Game Screen
Include:
- Level number
- Small target-picture preview
- Ruler-shaped puzzle board
- Move counter
- Timer
- Restart button
- Shuffle button

### C. Win State
Show an unobtrusive success panel or overlay:
- “Puzzle Solved!”
- Final move count and time
- **Next Level** button
- **Play Again** button

Do not build a separate large victory scene unless it materially improves usability.

## 5. Level Design

Version 1 should have **10 levels**, using original, license-safe artwork or simple custom illustrations:
1. Garden windmill
2. Birds
3. Butterfly garden
4. Farm animals
5. Ocean life
6. Space scene
7. Train
8. Jungle
9. Castle
10. Rainbow landscape

For the minimal first build:
- Keep the board at 3 × 5 for all 10 levels.
- Increase challenge gradually by increasing the number of legal shuffle moves, not by creating unsolvable boards.
- Use a small set of original images or simple generated/drawn art.
- If all 10 illustrations are not ready, use 2–3 original images and clearly separate art completion from gameplay implementation. Do not block core gameplay on artwork.

## 6. Visual Style

Target style: **simple, nostalgic, colourful, clean**.

- Portrait mobile UI.
- A ruler-inspired board, not a literal recreation of any branded toy.
- Light background with a restrained colour palette.
- Rounded corners and subtle shadows.
- Slight translucent-plastic effect around the board.
- Clear tile borders and gentle slide animation.
- Large, readable labels and buttons.
- Avoid clutter, excessive particles, complex 3D, and heavy shaders.
- Use original artwork; do not copy logos or copyrighted character images.

## 7. Sound and Accessibility

- Sound is optional and off by default if no sound assets are available.
- If included, use a soft tile-slide sound and a short success sound.
- Provide a visible sound toggle.
- Ensure text has sufficient contrast.
- Do not rely on colour alone to communicate state.
- Ensure controls are large enough for touch.

## 8. Progress and Saving

Save locally on the device:
- Highest level unlocked
- Completed levels
- Best move count per level (optional)
- Sound preference

Use Godot's `ConfigFile` or another simple local persistence method. No server or user account is required.

## 9. Technical Architecture

### Primary engine
- Godot 4.x.
- GDScript for game logic and UI.
- Use a portrait project setting.
- Use Control nodes for the menus and HUD; use a suitable 2D node structure for the board and tiles.
- Keep scripts small and separated by responsibility.

### Suggested project structure
```text
ScaleMazePuzzle/
├── project.godot
├── README.md
├── PLAN.md
├── scenes/
│   ├── HomeScreen.tscn
│   ├── GameScreen.tscn
│   └── PuzzleBoard.tscn
├── scripts/
│   ├── home_screen.gd
│   ├── game_screen.gd
│   ├── puzzle_board.gd
│   ├── puzzle_logic.gd
│   └── save_manager.gd
├── assets/
│   ├── images/
│   └── audio/
└── tests/
    └── puzzle_logic_test_notes.md
```

The AI agent may adjust filenames if the final structure remains clear and maintainable.

### Responsibilities
- `puzzle_logic.gd`: board representation, legal moves, shuffle, solved-state detection.
- `puzzle_board.gd`: draw/display tiles, receive input, animate moves.
- `game_screen.gd`: HUD, timer, counters, restart/shuffle, win state and level flow.
- `home_screen.gd`: Play and How to Play.
- `save_manager.gd`: local progress and settings.

### Kotlin integration
Do not add Kotlin code to the first version unless required. Godot + GDScript is sufficient for the sliding puzzle. If native Android integration becomes necessary later, isolate it in a separate Android plugin and document its purpose. Do not mix game rules between Kotlin and GDScript.

## 10. Puzzle Logic Acceptance Requirements

The agent must verify these cases:
1. A tile adjacent to the empty cell moves successfully.
2. A non-adjacent tile does not move.
3. Diagonal movement is rejected.
4. The move counter increases only for a legal player move.
5. A newly shuffled board is always solvable.
6. The solved board is recognised correctly.
7. Timer starts on the first legal move.
8. Restart resets all current-game state.
9. Shuffle resets all current-game state.
10. Winning locks the board and shows the win state.
11. Next Level loads the next level correctly.
12. Progress and settings persist after closing/reopening the app.

Use automated tests where practical and manual testing for touch behavior and animations.

## 11. Android Export and Build

The AI agent must:
1. Create a valid Godot 4.x project.
2. Open and run it in the Godot editor before claiming success.
3. Configure portrait orientation.
4. Set an appropriate Android package ID, such as `com.example.scalemazepuzzle`, and document how to change it.
5. Explain the Android export template and Android SDK/JDK setup required by the selected Godot version.
6. Export a debug APK and verify the file exists.
7. Provide the exact APK output path.
8. State clearly which build and tests actually succeeded; never claim an APK was built if it was not.

## 12. Definition of Done

Version 1 is complete when:
- The app opens in portrait orientation.
- Home, game, and win states work.
- The ruler-inspired board is visible and responsive.
- Tiles slide correctly using touch.
- Shuffling always yields a solvable puzzle.
- Move count and timer work correctly.
- Ten level entries are available.
- Progress and sound preference save locally.
- The game works offline.
- Android APK export instructions are verified.
- No unrelated existing project has been modified.

## 13. Implementation Order for the AI Agent

Build in this order and report after each stage:
1. Create the project and portrait settings.
2. Implement and test puzzle logic without artwork.
3. Build the ruler board and tile interaction.
4. Add timer, move counter, restart, and shuffle.
5. Add home screen and win state.
6. Add level selection/progression and local saving.
7. Apply visual polish and original art.
8. Test on desktop, then export and test the Android APK.

**Final instruction:** Prioritise a small, reliable, fully playable first version over extra features. Ask before adding any feature outside this specification.
