class_name PuzzleBoard
extends Control

signal move_made(move_count: int)
signal puzzle_solved(move_count: int, elapsed_time: float)
signal board_shuffled()

const TILE_WIDTH = 130.0
const TILE_HEIGHT = 130.0
const BOARD_WIDTH = 650.0
const BOARD_HEIGHT = 390.0
const ANIM_DURATION = 0.15 # Smooth organic slide

@export var level_texture: Texture2D
@export var sound_enabled: bool = false

var logic: PuzzleLogic
var tile_nodes: Dictionary = {} # tile_id (0..13) -> Control node
var is_animating: bool = false

var slide_audio: AudioStreamPlayer
var win_audio: AudioStreamPlayer
var tiles_container: Control
var last_click_time_msec: int = 0

func _init() -> void:
	logic = PuzzleLogic.new()

func _ready() -> void:
	custom_minimum_size = Vector2(BOARD_WIDTH + 40.0, BOARD_HEIGHT + 74.0)
	size = custom_minimum_size
	
	_setup_audio()
	_setup_tiles_container()

func _setup_audio() -> void:
	slide_audio = AudioStreamPlayer.new()
	var slide_res = load("res://assets/audio/slide.wav")
	if slide_res:
		slide_audio.stream = slide_res
	add_child(slide_audio)

	win_audio = AudioStreamPlayer.new()
	var win_res = load("res://assets/audio/win.wav")
	if win_res:
		win_audio.stream = win_res
	add_child(win_audio)

func _setup_tiles_container() -> void:
	tiles_container = Control.new()
	tiles_container.name = "TilesContainer"
	# Position tiles inside ruler frame: 20px padding from left, 48px from top
	tiles_container.position = Vector2(20.0, 48.0)
	tiles_container.size = Vector2(BOARD_WIDTH, BOARD_HEIGHT)
	add_child(tiles_container)

## Draws the ruler-inspired plastic frame with measurement ticks and highlights
func _draw() -> void:
	var frame_rect = Rect2(Vector2.ZERO, size)
	
	# 1. Soft ambient drop shadow
	var shadow_style = StyleBoxFlat.new()
	shadow_style.bg_color = Color(0.1, 0.18, 0.35, 0.12)
	shadow_style.set_corner_radius_all(20)
	shadow_style.shadow_size = 14
	shadow_style.shadow_offset = Vector2(0, 6)
	draw_style_box(shadow_style, Rect2(Vector2(2, 4), size - Vector2(4, 4)))
	
	# 2. Transparent acrylic ruler body
	var ruler_style = StyleBoxFlat.new()
	ruler_style.bg_color = Color(0.95, 0.98, 1.0, 0.96)
	ruler_style.border_color = Color(0.22, 0.74, 0.97, 0.85) # Vibrant soft sky blue #38BDF8
	ruler_style.set_border_width_all(3)
	ruler_style.set_corner_radius_all(20)
	draw_style_box(ruler_style, frame_rect)
	
	# 3. Top glossy plastic specular reflection
	draw_line(Vector2(20, 5), Vector2(size.x - 20, 5), Color(1.0, 1.0, 1.0, 0.95), 2.5)
	
	# 4. Ruler measurement markings along top edge
	var tick_color = Color(0.01, 0.52, 0.78, 0.9) # #0284C7
	var num_major_ticks = 16
	var ruler_content_width = BOARD_WIDTH
	var tick_spacing = ruler_content_width / 15.0
	
	var font = ThemeDB.fallback_font
	var font_size = 12
	
	for i in range(num_major_ticks):
		var x = 20.0 + i * tick_spacing
		# Major cm tick
		draw_line(Vector2(x, 10), Vector2(x, 26), tick_color, 2.0)
		
		# Number label string
		draw_string(font, Vector2(x - 5, 40), str(i), HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, tick_color)
		
		# Minor mm ticks between major ticks
		if i < num_major_ticks - 1:
			for m in range(1, 5):
				var sub_x = x + m * (tick_spacing / 5.0)
				var h = 18 if m == 2 or m == 3 else 14
				draw_line(Vector2(sub_x, 10), Vector2(sub_x, h), tick_color, 1.0)
				
	# 5. Bottom edge fine mm ticks
	for j in range(31):
		var bx = 20.0 + j * (ruler_content_width / 30.0)
		var bh = 14 if j % 5 == 0 else 8
		draw_line(Vector2(bx, size.y - 8), Vector2(bx, size.y - 8 - bh), tick_color, 1.2)

## Sets the current level image texture and re-creates tile visuals
func set_level_image(tex: Texture2D) -> void:
	if not tiles_container:
		_setup_tiles_container()
	if not slide_audio:
		_setup_audio()
	level_texture = tex
	_rebuild_tiles()

## Builds or updates the 14 tile visual nodes
func _rebuild_tiles() -> void:
	for child in tiles_container.get_children():
		child.queue_free()
	tile_nodes.clear()
	
	for tile_id in range(14): # 0..13 (14 is empty space)
		var tile_btn = _create_tile_node(tile_id)
		tiles_container.add_child(tile_btn)
		tile_nodes[tile_id] = tile_btn
		
	update_tile_positions(false)

func _create_tile_node(tile_id: int) -> Control:
	var original_row = tile_id / PuzzleLogic.COLS
	var original_col = tile_id % PuzzleLogic.COLS
	
	var container = Control.new()
	container.size = Vector2(TILE_WIDTH, TILE_HEIGHT)
	container.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# 1. Tile card background with shadow & rounded corners
	var tile_card = Panel.new()
	tile_card.size = Vector2(TILE_WIDTH - 4.0, TILE_HEIGHT - 4.0)
	tile_card.position = Vector2(2.0, 2.0)
	tile_card.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var card_style = StyleBoxFlat.new()
	card_style.bg_color = Color(1.0, 1.0, 1.0, 1.0)
	card_style.set_corner_radius_all(10)
	card_style.border_color = Color(1.0, 1.0, 1.0, 0.9)
	card_style.set_border_width_all(2)
	card_style.shadow_color = Color(0.1, 0.15, 0.3, 0.15)
	card_style.shadow_size = 5
	card_style.shadow_offset = Vector2(0, 3)
	tile_card.add_theme_stylebox_override("panel", card_style)
	container.add_child(tile_card)
	
	# 2. Sliced Texture of the picture
	var tex_rect = TextureRect.new()
	tex_rect.size = Vector2(TILE_WIDTH - 6.0, TILE_HEIGHT - 6.0)
	tex_rect.position = Vector2(3.0, 3.0)
	tex_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	tex_rect.stretch_mode = TextureRect.STRETCH_SCALE
	
	if level_texture:
		var atlas = AtlasTexture.new()
		atlas.atlas = level_texture
		atlas.region = Rect2(original_col * TILE_WIDTH, original_row * TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT)
		tex_rect.texture = atlas
	
	container.add_child(tex_rect)
	
	# 3. Cute circular number badge in top-left
	var badge_bg = Panel.new()
	badge_bg.size = Vector2(22, 22)
	badge_bg.position = Vector2(7, 7)
	badge_bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var badge_style = StyleBoxFlat.new()
	badge_style.bg_color = Color(0.08, 0.14, 0.25, 0.6)
	badge_style.set_corner_radius_all(11)
	badge_bg.add_theme_stylebox_override("panel", badge_style)
	container.add_child(badge_bg)
	
	var badge_lbl = Label.new()
	badge_lbl.text = str(tile_id + 1)
	badge_lbl.size = Vector2(22, 22)
	badge_lbl.position = Vector2(7, 6)
	badge_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	badge_lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	badge_lbl.add_theme_font_size_override("font_size", 11)
	badge_lbl.add_theme_color_override("font_color", Color.WHITE)
	badge_lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
	container.add_child(badge_lbl)
	
	# 4. Touch & click input
	container.gui_input.connect(func(event: InputEvent):
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			_on_tile_clicked(tile_id)
		elif event is InputEventScreenTouch and event.pressed:
			_on_tile_clicked(tile_id)
	)
	
	return container

## Finds which grid cell (0..14) a tile_id currently occupies
func get_cell_of_tile(tile_id: int) -> int:
	for cell in range(PuzzleLogic.TOTAL_CELLS):
		if logic.grid[cell] == tile_id:
			return cell
	return -1

## Handles player click on a tile
func _on_tile_clicked(tile_id: int) -> void:
	var now = Time.get_ticks_msec()
	if now - last_click_time_msec < 90:
		return
	if is_animating or logic.is_game_over:
		return
		
	var cell_idx = get_cell_of_tile(tile_id)
	if cell_idx == -1:
		return
		
	if not logic.is_move_legal(cell_idx):
		return
		
	last_click_time_msec = now
	var target_cell = logic.empty_index
	var success = logic.make_player_move(cell_idx)
	if success:
		if sound_enabled and slide_audio and is_inside_tree():
			slide_audio.stop()
			slide_audio.play()
			
		emit_signal("move_made", logic.move_count)
		_animate_tile_move(tile_id, target_cell)

## Smoothly slides the tile into the target empty slot with cubic ease-out
func _animate_tile_move(tile_id: int, target_cell: int) -> void:
	is_animating = true
	var tile_node = tile_nodes[tile_id]
	var target_pos = _get_cell_position(target_cell)
	
	var tween = create_tween()
	tween.tween_property(tile_node, "position", target_pos, ANIM_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.finished.connect(func():
		is_animating = false
		if logic.is_solved():
			if sound_enabled and win_audio and is_inside_tree():
				win_audio.play()
			emit_signal("puzzle_solved", logic.move_count, logic.elapsed_time)
	)

## Computes 2D local position for a grid cell
func _get_cell_position(cell_index: int) -> Vector2:
	var r = cell_index / PuzzleLogic.COLS
	var c = cell_index % PuzzleLogic.COLS
	return Vector2(c * TILE_WIDTH, r * TILE_HEIGHT)

## Updates all tile positions to match current logic.grid
func update_tile_positions(animate: bool = false) -> void:
	for cell_index in range(PuzzleLogic.TOTAL_CELLS):
		var tile_id = logic.grid[cell_index]
		if tile_id != PuzzleLogic.EMPTY_TILE and tile_nodes.has(tile_id):
			var node = tile_nodes[tile_id]
			var target_pos = _get_cell_position(cell_index)
			if animate:
				create_tween().tween_property(node, "position", target_pos, ANIM_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			else:
				node.position = target_pos

## Shuffles the puzzle with legal moves and updates board
func shuffle_puzzle(moves: int = 30) -> void:
	logic.shuffle(moves)
	update_tile_positions(false)
	emit_signal("board_shuffled")

## Resets board to solved state
func reset_puzzle() -> void:
	logic.reset_to_solved()
	update_tile_positions(false)

func _process(delta: float) -> void:
	logic.update_timer(delta)
