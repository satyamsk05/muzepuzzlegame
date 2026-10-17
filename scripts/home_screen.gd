class_name HomeScreen
extends Control

var save_manager: SaveManager

@onready var gem_label: Label = $TopBar/GemBox/GemCount
@onready var lives_box: HBoxContainer = $TopBar/LivesBox
@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var path_canvas: Control = $ScrollContainer/PathArea
@onready var path_line: Line2D = $ScrollContainer/PathArea/RoadLine
@onready var mascot_companion: Control = $ScrollContainer/PathArea/MascotCompanion
@onready var sound_btn: Button = $TopBar/SoundBtn

const TOTAL_LEVELS = 10
var _level_positions: Array[Vector2] = []
var _mascot_base_pos: Vector2 = Vector2.ZERO
var _anim_time: float = 0.0

func _ready() -> void:
	save_manager = SaveManager.new()
	_update_sound_button()
	_build_winding_path()
	_update_gem_count()
	_setup_bottom_navigation()
	
	if sound_btn and not sound_btn.pressed.is_connected(_on_sound_pressed):
		sound_btn.pressed.connect(_on_sound_pressed)

func _process(delta: float) -> void:
	_anim_time += delta * 2.5
	if mascot_companion and mascot_companion.visible:
		mascot_companion.position.y = _mascot_base_pos.y + sin(_anim_time) * 6.0

func _update_gem_count() -> void:
	var completed = 0
	for i in range(1, TOTAL_LEVELS + 1):
		if save_manager.is_level_completed(i):
			completed += 1
	# Show gems based on progress
	gem_label.text = "%d" % (completed * 5 + 15)

func _build_winding_path() -> void:
	# Clean existing nodes except RoadLine and MascotCompanion
	for child in path_canvas.get_children():
		if child != path_line and child != mascot_companion:
			child.queue_free()

	path_line.clear_points()
	_level_positions.clear()

	# Sine wave path going from level 10 down to level 1
	# Level 1 at bottom, Level 10 at top
	var start_y = 150.0
	var step_y = 120.0
	var center_x = 360.0
	var amplitude = 120.0

	for i in range(TOTAL_LEVELS):
		var y = start_y + (TOTAL_LEVELS - 1 - i) * step_y
		# Alternate left and right curve
		var phase = i * 0.95
		var x = center_x + sin(phase) * amplitude
		_level_positions.append(Vector2(x, y))

	# Populate smooth line points
	path_line.width = 82.0
	path_line.default_color = Color("#3B82F6")
	path_line.joint_mode = Line2D.LINE_JOINT_ROUND
	path_line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	path_line.end_cap_mode = Line2D.LINE_CAP_ROUND
	path_line.antialiased = true

	path_line.add_point(Vector2(_level_positions[0].x, _level_positions[0].y + 60))
	for pt in _level_positions:
		path_line.add_point(pt)
	path_line.add_point(Vector2(_level_positions[TOTAL_LEVELS - 1].x, _level_positions[TOTAL_LEVELS - 1].y - 60))

	var highest = save_manager.get_highest_unlocked()

	# Create Level Nodes
	for i in range(TOTAL_LEVELS):
		var lvl_num = i + 1
		var pos = _level_positions[i]
		var is_unlocked = (lvl_num <= highest)
		var is_done = save_manager.is_level_completed(lvl_num)
		var is_current = (lvl_num == highest)

		var node_root = Control.new()
		node_root.position = pos - Vector2(48, 48)
		node_root.custom_minimum_size = Vector2(96, 96)
		path_canvas.add_child(node_root)

		# Texture button
		var btn = TextureButton.new()
		btn.custom_minimum_size = Vector2(96, 96)
		btn.size = Vector2(96, 96)
		btn.ignore_texture_size = false
		btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED

		if not is_unlocked:
			btn.texture_normal = load("res://assets/ui/level_node_locked.svg")
			btn.disabled = true
		elif is_current:
			btn.texture_normal = load("res://assets/ui/level_node_current.svg")
		else:
			btn.texture_normal = load("res://assets/ui/level_node_unlocked.svg")

		node_root.add_child(btn)

		# Label with level number (if unlocked)
		if is_unlocked:
			var lbl = Label.new()
			lbl.text = "%d" % lvl_num
			lbl.size = Vector2(96, 96)
			lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
			if is_current:
				lbl.add_theme_color_override("font_color", Color("#0F172A"))
				lbl.add_theme_font_size_override("font_size", 28)
			else:
				lbl.add_theme_color_override("font_color", Color.WHITE)
				lbl.add_theme_font_size_override("font_size", 26)
			node_root.add_child(lbl)

			# Click callback -> opens LoadingScreen!
			btn.pressed.connect(func(): _start_loading_level(lvl_num - 1))

		# Stars below completed levels
		if is_done:
			var star_box = HBoxContainer.new()
			star_box.size = Vector2(96, 24)
			star_box.position = Vector2(0, 98)
			star_box.alignment = BoxContainer.ALIGNMENT_CENTER
			star_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
			star_box.add_theme_constant_override("separation", 2)
			for s in range(3):
				var star_tex = TextureRect.new()
				star_tex.custom_minimum_size = Vector2(18, 18)
				star_tex.texture = load("res://assets/ui/star_3d.svg")
				star_tex.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
				star_tex.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
				star_box.add_child(star_tex)
			node_root.add_child(star_box)

		# Place floating companion beside current level
		if is_current:
			var companion_offset_x = -95.0 if pos.x > 360 else 95.0
			_mascot_base_pos = pos + Vector2(companion_offset_x, -20)
			mascot_companion.position = _mascot_base_pos
			mascot_companion.visible = true

	# Auto-scroll to current level after render
	call_deferred("_scroll_to_current_level", highest)

func _scroll_to_current_level(highest: int) -> void:
	var idx = clamp(highest - 1, 0, TOTAL_LEVELS - 1)
	var target_y = _level_positions[idx].y - 300
	scroll_container.scroll_vertical = int(clamp(target_y, 0, 1500))

func _start_loading_level(lvl_idx: int) -> void:
	var loading_scene = load("res://scenes/LoadingScreen.tscn").instantiate() as LoadingScreen
	loading_scene.target_level_index = lvl_idx
	get_tree().root.add_child(loading_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = loading_scene

func _setup_bottom_navigation() -> void:
	var nav_path = $BottomDock/DockContainer/HBox/NavPath
	var nav_learn = $BottomDock/DockContainer/HBox/NavLearn
	var nav_progress = $BottomDock/DockContainer/HBox/NavProgress
	var nav_profile = $BottomDock/DockContainer/HBox/NavProfile

	if nav_learn:
		nav_learn.pressed.connect(func(): _show_nav_feedback("Learn mode coming soon!"))
	if nav_progress:
		nav_progress.pressed.connect(func(): _show_nav_feedback("Unit 1: %d/%d Solved" % [save_manager.get_highest_unlocked() - 1, TOTAL_LEVELS]))
	if nav_profile:
		nav_profile.pressed.connect(func(): _show_nav_feedback("Gems: %s | Levels: %d" % [gem_label.text, TOTAL_LEVELS]))

func _show_nav_feedback(msg: String) -> void:
	var toast = Label.new()
	toast.text = msg
	toast.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	toast.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	toast.position = Vector2(160, 1050)
	toast.size = Vector2(400, 48)
	var sb = StyleBoxFlat.new()
	sb.bg_color = Color(0.1, 0.12, 0.25, 0.95)
	sb.set_corner_radius_all(20)
	sb.set_border_width_all(1)
	sb.border_color = Color("#818CF8")
	toast.add_theme_stylebox_override("normal", sb)
	toast.add_theme_color_override("font_color", Color.WHITE)
	toast.add_theme_font_size_override("font_size", 16)
	add_child(toast)
	var tw = create_tween()
	tw.tween_interval(1.5)
	tw.tween_property(toast, "modulate:a", 0.0, 0.4)
	tw.tween_callback(toast.queue_free)

func _on_sound_pressed() -> void:
	var new_state = not save_manager.get_sound_enabled()
	save_manager.set_sound_enabled(new_state)
	_update_sound_button()

func _update_sound_button() -> void:
	if not sound_btn:
		return
	sound_btn.expand_icon = true
	if save_manager.get_sound_enabled():
		sound_btn.icon = load("res://assets/icons/sound_on.svg")
	else:
		sound_btn.icon = load("res://assets/icons/sound_off.svg")
