class_name SaveManager
extends RefCounted

const SAVE_PATH = "user://scale_maze_save.cfg"
const SECTION_PROGRESS = "progress"
const SECTION_SETTINGS = "settings"

var config: ConfigFile

func _init() -> void:
	config = ConfigFile.new()
	load_data()

func load_data() -> void:
	var err = config.load(SAVE_PATH)
	if err != OK:
		# Set defaults
		config.set_value(SECTION_PROGRESS, "highest_unlocked", 1)
		config.set_value(SECTION_SETTINGS, "sound_enabled", true)
		config.save(SAVE_PATH)

func get_highest_unlocked() -> int:
	return config.get_value(SECTION_PROGRESS, "highest_unlocked", 1)

func set_highest_unlocked(lvl: int) -> void:
	var current = get_highest_unlocked()
	if lvl > current:
		config.set_value(SECTION_PROGRESS, "highest_unlocked", lvl)
		config.save(SAVE_PATH)

func is_level_completed(lvl: int) -> bool:
	return config.get_value(SECTION_PROGRESS, "completed_lvl_%d" % lvl, false)

func save_level_result(lvl: int, moves: int, time_spent: float) -> void:
	config.set_value(SECTION_PROGRESS, "completed_lvl_%d" % lvl, true)
	
	# Best moves
	var best_moves = config.get_value(SECTION_PROGRESS, "best_moves_lvl_%d" % lvl, 999999)
	if moves < best_moves:
		config.set_value(SECTION_PROGRESS, "best_moves_lvl_%d" % lvl, moves)
		
	# Best time
	var best_time = config.get_value(SECTION_PROGRESS, "best_time_lvl_%d" % lvl, 999999.0)
	if time_spent < best_time:
		config.set_value(SECTION_PROGRESS, "best_time_lvl_%d" % lvl, time_spent)
		
	# Unlock next level
	set_highest_unlocked(lvl + 1)
	config.save(SAVE_PATH)

func get_best_moves(lvl: int) -> int:
	return config.get_value(SECTION_PROGRESS, "best_moves_lvl_%d" % lvl, 0)

func get_best_time(lvl: int) -> float:
	return config.get_value(SECTION_PROGRESS, "best_time_lvl_%d" % lvl, 0.0)

func get_sound_enabled() -> bool:
	return config.get_value(SECTION_SETTINGS, "sound_enabled", false)

func set_sound_enabled(enabled: bool) -> void:
	config.set_value(SECTION_SETTINGS, "sound_enabled", enabled)
	config.save(SAVE_PATH)

func reset_all() -> void:
	config.clear()
	config.set_value(SECTION_PROGRESS, "highest_unlocked", 1)
	config.set_value(SECTION_SETTINGS, "sound_enabled", true)
	config.save(SAVE_PATH)
