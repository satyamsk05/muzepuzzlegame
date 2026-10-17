class_name GameScreen
extends Control

const LEVELS = [
	{"name": "Garden Windmill", "image": "res://assets/images/level_1.svg", "shuffles": 20},
	{"name": "Birds", "image": "res://assets/images/level_2.svg", "shuffles": 25},
	{"name": "Butterfly Garden", "image": "res://assets/images/level_3.svg", "shuffles": 30},
	{"name": "Farm Animals", "image": "res://assets/images/level_4.svg", "shuffles": 35},
	{"name": "Ocean Life", "image": "res://assets/images/level_5.svg", "shuffles": 40},
	{"name": "Space Scene", "image": "res://assets/images/level_6.svg", "shuffles": 45},
	{"name": "Train", "image": "res://assets/images/level_7.svg", "shuffles": 50},
	{"name": "Jungle", "image": "res://assets/images/level_8.svg", "shuffles": 55},
	{"name": "Castle", "image": "res://assets/images/level_9.svg", "shuffles": 60},
	{"name": "Rainbow Landscape", "image": "res://assets/images/level_10.svg", "shuffles": 65}
]

var current_level_index: int = 0
var save_manager: SaveManager

@onready var puzzle_board: PuzzleBoard = $BoardContainer/PuzzleBoard
@onready var level_title_label: Label = $TopArea/Header/LevelCard/VBox/LevelTitle
@onready var best_record_label: Label = $TopArea/Header/LevelCard/VBox/BestRecord
@onready var preview_texture: TextureRect = $TopArea/PreviewCard/VBox/CenterBox/PreviewFrame/PreviewTexture
@onready var moves_icon: TextureRect = $StatsCard/HBox/MovesBox/MovesIcon
@onready var moves_label: Label = $StatsCard/HBox/MovesBox/MovesLabel
@onready var timer_icon: TextureRect = $StatsCard/HBox/TimerBox/TimerIcon
@onready var timer_label: Label = $StatsCard/HBox/TimerBox/TimerLabel
@onready var back_btn: Button = $TopArea/Header/BackButton
@onready var sound_btn: Button = $TopArea/Header/SoundButton
@onready var restart_btn: Button = $ButtonsArea/RestartButton
@onready var shuffle_btn: Button = $ButtonsArea/ShuffleButton

# Win overlay controls
@onready var win_overlay: ColorRect = $WinOverlay
@onready var trophy_icon: TextureRect = $WinOverlay/CenterContainer/WinCard/VBox/TrophyCenter/TrophyIcon
@onready var win_stats_label: Label = $WinOverlay/CenterContainer/WinCard/VBox/WinStats
@onready var next_level_btn: Button = $WinOverlay/CenterContainer/WinCard/VBox/Buttons/NextLevelBtn
@onready var play_again_btn: Button = $WinOverlay/CenterContainer/WinCard/VBox/Buttons/PlayAgainBtn

func _ready() -> void:
	_ensure_references()
	_apply_theme_styles()
	_update_sound_button_label()
	
	puzzle_board.move_made.connect(_on_move_made)
	puzzle_board.puzzle_solved.connect(_on_puzzle_solved)
	puzzle_board.board_shuffled.connect(_on_board_shuffled)
	
	load_level(current_level_index)

func _ensure_references() -> void:
	if not save_manager:
		save_manager = SaveManager.new()
	if not puzzle_board:
		puzzle_board = $BoardContainer/PuzzleBoard
		level_title_label = $TopArea/Header/LevelCard/VBox/LevelTitle
		best_record_label = $TopArea/Header/LevelCard/VBox/BestRecord
		preview_texture = $TopArea/PreviewCard/VBox/CenterBox/PreviewFrame/PreviewTexture
		moves_icon = $StatsCard/HBox/MovesBox/MovesIcon
		moves_label = $StatsCard/HBox/MovesBox/MovesLabel
		timer_icon = $StatsCard/HBox/TimerBox/TimerIcon
		timer_label = $StatsCard/HBox/TimerBox/TimerLabel
		back_btn = $TopArea/Header/BackButton
		sound_btn = $TopArea/Header/SoundButton
		restart_btn = $ButtonsArea/RestartButton
		shuffle_btn = $ButtonsArea/ShuffleButton
		win_overlay = $WinOverlay
		trophy_icon = $WinOverlay/CenterContainer/WinCard/VBox/TrophyCenter/TrophyIcon
		win_stats_label = $WinOverlay/CenterContainer/WinCard/VBox/WinStats
		next_level_btn = $WinOverlay/CenterContainer/WinCard/VBox/Buttons/NextLevelBtn
		play_again_btn = $WinOverlay/CenterContainer/WinCard/VBox/Buttons/PlayAgainBtn

func _apply_theme_styles() -> void:
	UIStyles.apply_pill_button(back_btn, 15)
	UIStyles.apply_pill_button(sound_btn, 15)
	
	back_btn.icon = load("res://assets/icons/home.svg")
	back_btn.expand_icon = true
	
	# Restart button: Soft amber card
	var r_style = StyleBoxFlat.new()
	r_style.bg_color = Color("#FFFBEB")
	r_style.set_corner_radius_all(20)
	r_style.border_color = Color("#FDE68A")
	r_style.set_border_width_all(2)
	r_style.shadow_color = Color(0.8, 0.6, 0.1, 0.1)
	r_style.shadow_size = 6
	r_style.shadow_offset = Vector2(0, 3)
	restart_btn.add_theme_stylebox_override("normal", r_style)
	var r_pressed = r_style.duplicate() as StyleBoxFlat
	r_pressed.bg_color = Color("#FEF3C7")
	restart_btn.add_theme_stylebox_override("pressed", r_pressed)
	restart_btn.add_theme_stylebox_override("hover", r_style)
	restart_btn.add_theme_color_override("font_color", Color("#B45309"))
	restart_btn.icon = load("res://assets/icons/reload.svg")
	restart_btn.expand_icon = true
	
	# Shuffle button: Vibrant indigo tactile
	var s_style = UIStyles.make_btn_style(Color("#6366F1"), Color("#4F46E5"), 20, 0.28)
	var s_hover = UIStyles.make_btn_style(Color("#818CF8"), Color("#4F46E5"), 20, 0.35)
	var s_pressed = UIStyles.make_btn_style(Color("#4F46E5"), Color.TRANSPARENT, 20, 0.1)
	shuffle_btn.add_theme_stylebox_override("normal", s_style)
	shuffle_btn.add_theme_stylebox_override("hover", s_hover)
	shuffle_btn.add_theme_stylebox_override("pressed", s_pressed)
	shuffle_btn.add_theme_color_override("font_color", Color.WHITE)
	shuffle_btn.icon = load("res://assets/icons/shuffle.svg")
	shuffle_btn.expand_icon = true
	
	# Stats card icons
	if moves_icon:
		moves_icon.texture = load("res://assets/icons/moves.svg")
	if timer_icon:
		timer_icon.texture = load("res://assets/icons/timer.svg")
	
	# Win overlay buttons & icon
	UIStyles.apply_primary_button(next_level_btn, 20)
	UIStyles.apply_secondary_button(play_again_btn, 18)
	next_level_btn.icon = load("res://assets/icons/forward.svg")
	next_level_btn.expand_icon = true
	play_again_btn.icon = load("res://assets/icons/reload.svg")
	play_again_btn.expand_icon = true
	if trophy_icon:
		trophy_icon.texture = load("res://assets/icons/trophy.svg")

func _process(_delta: float) -> void:
	if puzzle_board and puzzle_board.logic:
		var elapsed = puzzle_board.logic.elapsed_time
		var mins = int(elapsed) / 60
		var secs = int(elapsed) % 60
		timer_label.text = "%02d:%02d" % [mins, secs]

func load_level(idx: int) -> void:
	_ensure_references()
	current_level_index = clamp(idx, 0, LEVELS.size() - 1)
	var lvl_data = LEVELS[current_level_index]
	var lvl_number = current_level_index + 1
	
	level_title_label.text = "Level %d: %s" % [lvl_number, lvl_data["name"]]
	
	# Load image
	var tex = load(lvl_data["image"]) as Texture2D
	preview_texture.texture = tex
	puzzle_board.set_level_image(tex)
	
	# Update best record display
	var best_m = save_manager.get_best_moves(lvl_number)
	if best_m > 0:
		best_record_label.text = "Best: %d moves" % best_m
	else:
		best_record_label.text = "Best: --"
	
	# Shuffle board with this level's difficulty
	puzzle_board.sound_enabled = save_manager.get_sound_enabled()
	puzzle_board.shuffle_puzzle(lvl_data["shuffles"])
	
	moves_label.text = "Moves: 0"
	win_overlay.visible = false

func _on_move_made(move_count: int) -> void:
	moves_label.text = "Moves: %d" % move_count

func _on_board_shuffled() -> void:
	moves_label.text = "Moves: 0"

func _on_puzzle_solved(moves: int, elapsed_time: float) -> void:
	var lvl_num = current_level_index + 1
	save_manager.save_level_result(lvl_num, moves, elapsed_time)
	
	var mins = int(elapsed_time) / 60
	var secs = int(elapsed_time) % 60
	win_stats_label.text = "Completed in %d moves!\nTime: %02d:%02d" % [moves, mins, secs]
	
	if current_level_index >= LEVELS.size() - 1:
		next_level_btn.text = "Play Again (Completed)"
	else:
		next_level_btn.text = "Next Level"
		
	win_overlay.visible = true

func _on_restart_button_pressed() -> void:
	puzzle_board.reset_puzzle()
	moves_label.text = "Moves: 0"

func _on_shuffle_button_pressed() -> void:
	var lvl_data = LEVELS[current_level_index]
	puzzle_board.shuffle_puzzle(lvl_data["shuffles"])
	moves_label.text = "Moves: 0"

func _on_sound_button_pressed() -> void:
	var new_state = not save_manager.get_sound_enabled()
	save_manager.set_sound_enabled(new_state)
	puzzle_board.sound_enabled = new_state
	_update_sound_button_label()

func _update_sound_button_label() -> void:
	sound_btn.expand_icon = true
	if save_manager.get_sound_enabled():
		sound_btn.icon = load("res://assets/icons/sound_on.svg")
		sound_btn.text = "Sound: ON"
	else:
		sound_btn.icon = load("res://assets/icons/sound_off.svg")
		sound_btn.text = "Sound: OFF"

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/HomeScreen.tscn")

func _on_next_level_pressed() -> void:
	win_overlay.visible = false
	if current_level_index < LEVELS.size() - 1:
		load_level(current_level_index + 1)
	else:
		load_level(0)

func _on_play_again_pressed() -> void:
	win_overlay.visible = false
	load_level(current_level_index)
