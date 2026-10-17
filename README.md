# Scale Maze Puzzle

**Scale Maze Puzzle** is a portrait sliding-picture puzzle game built with Godot 4.x and GDScript, inspired by the nostalgic plastic ruler/scale toys that contained a built-in sliding game.

---

## 🎮 Game Overview

- **Orientation:** Portrait (vertical only, 720 × 1280 base resolution).
- **Board Design:** Rounded translucent-plastic ruler with measurement ticks (cm/mm scale markings) along the top and bottom edges, soft plastic highlights, and a clean outline.
- **Grid Layout:** 3 rows × 5 columns (15 cells total: 14 picture tiles and 1 empty cell).
- **Controls:** Tap any tile directly adjacent (orthogonal: Up, Down, Left, Right) to the empty cell to slide it into place. Diagonal and non-adjacent moves are rejected.
- **Solvability:** Shuffled boards are generated exclusively using legal moves from the solved state, ensuring a 100% mathematically solvable puzzle every time.
- **Progression:** 10 levels with gradual difficulty progression, offline local saving via Godot's `ConfigFile` (`user://scale_maze_save.cfg`), move counter, and timer.

---

## 🖼️ Level Progression (10 Levels)

1. **Garden Windmill** (20 shuffles)
2. **Birds** (25 shuffles)
3. **Butterfly Garden** (30 shuffles)
4. **Farm Animals** (35 shuffles)
5. **Ocean Life** (40 shuffles)
6. **Space Scene** (45 shuffles)
7. **Train** (50 shuffles)
8. **Jungle** (55 shuffles)
9. **Castle** (60 shuffles)
10. **Rainbow Landscape** (65 shuffles)

---

## 📁 Project Structure

```text
ScaleMazePuzzle/
├── project.godot                     # Project configuration (Portrait, GL Compatibility, Touch emulation)
├── export_presets.cfg                # Android export preset (com.example.scalemazepuzzle)
├── icon.svg                          # Adaptive Vector App Icon
├── README.md                         # Project documentation
├── ScaleMazePuzzle_PLAN.md           # Implementation specification
├── scenes/
│   ├── HomeScreen.tscn               # Title, Play, Level Grid, How To Play modal
│   ├── GameScreen.tscn               # HUD, Target Preview, Ruler Board, Timer, Win Modal
│   └── PuzzleBoard.tscn              # 3x5 Ruler Puzzle Board with custom draw & tile slicing
├── scripts/
│   ├── home_screen.gd                # Home screen controller
│   ├── game_screen.gd                # Game screen controller & level flow
│   ├── puzzle_board.gd               # Ruler board drawing & slide tween animation
│   ├── puzzle_logic.gd               # Pure puzzle state, legal moves, shuffle, win detection
│   └── save_manager.gd               # Local persistence (levels, best moves, sound settings)
├── assets/
│   ├── images/                       # 10 custom SVG level illustrations (650x390, 5:3 ratio)
│   │   ├── level_1.svg to level_10.svg
│   ├── audio/                        # 16-bit PCM procedural sound effects
│   │   ├── slide.wav
│   │   └── win.wav
├── build/
│   └── ScaleMazePuzzle.pck           # Exported game package
└── tests/
    ├── test_puzzle_logic.gd          # Acceptance tests suite (10 test cases)
    ├── test_gameplay_flow.gd         # Gameplay integration test suite
    └── puzzle_logic_test_notes.md    # Test execution notes
```

---

## 🚀 Running the Game Locally

### 1. In Godot Editor:
```powershell
& "C:\Users\satya\Godot\godot.exe" -e --path "c:\Users\satya\Desktop\godotgame"
```

### 2. Direct Gameplay:
```powershell
& "C:\Users\satya\Godot\godot.exe" --path "c:\Users\satya\Desktop\godotgame"
```

### 3. Run Automated Tests:
```powershell
# Core puzzle logic acceptance test suite (10/10 tests):
& "C:\Users\satya\Godot\godot_console.exe" --headless -s tests/test_puzzle_logic.gd

# Gameplay integration test suite:
& "C:\Users\satya\Godot\godot_console.exe" --headless -s tests/test_gameplay_flow.gd
```

---

## 📱 Android Export & Setup Instructions

The Android export preset is configured in [`export_presets.cfg`](file:///c:/Users/satya/Desktop/godotgame/export_presets.cfg).

### Package Identifier
- Default Package ID: `com.example.scalemazepuzzle`
- **To change the Package ID:**
  Open `export_presets.cfg` and edit:
  ```ini
  package/unique_name="com.yourcompany.scalemazepuzzle"
  ```
  Or change it in Godot Editor via **Project > Export > Android > Options > Package > Unique Name**.

### Prerequisites for Android APK Generation
To export a debug APK, Godot requires the following tools configured in **Editor > Editor Settings > Export > Android**:

1. **Android SDK & Build Tools:**
   - Android SDK Path: e.g. `C:/Users/<Username>/AppData/Local/Android/Sdk`
   - Must contain `platform-tools/adb.exe` and `build-tools/<version>/apksigner.bat`.
   - Installable via Android Studio or command-line tools.

2. **Java Development Kit (JDK):**
   - OpenJDK 17 (e.g. Eclipse Temurin 17 or Microsoft OpenJDK 17).
   - Java SDK Path: e.g. `C:/Program Files/Eclipse Adoptium/jdk-17.x.x-hotspot/bin/jarsigner.exe`.

3. **Godot 4.7.2 Android Export Templates:**
   - Export templates matching version `4.7.2.stable` must be installed in:
     `%APPDATA%/Godot/export_templates/4.7.2.stable/android_debug.apk` and `android_release.apk`.
   - Downloadable from Godot Editor via **Editor > Manage Export Templates > Download and Install**, or manually from GitHub Releases.

4. **Export Command:**
   ```powershell
   & "C:\Users\satya\Godot\godot_console.exe" --headless --export-debug "Android" "build/ScaleMazePuzzle.apk"
   ```
