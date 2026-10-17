extends SceneTree

func _init() -> void:
	print("--- Running Scale Maze Puzzle Gameplay Flow Test ---")
	
	# 1. Test HomeScreen instantiation
	var home_scene = load("res://scenes/HomeScreen.tscn")
	if not home_scene:
		print("[FAIL] Could not load HomeScreen.tscn")
		quit(1)
		return
	var home = home_scene.instantiate() as HomeScreen
	root.add_child(home)
	print("[PASS] HomeScreen instantiated successfully.")
	
	# 2. Test GameScreen instantiation
	var game_scene = load("res://scenes/GameScreen.tscn")
	if not game_scene:
		print("[FAIL] Could not load GameScreen.tscn")
		quit(1)
		return
	var game = game_scene.instantiate() as GameScreen
	root.add_child(game)
	print("[PASS] GameScreen instantiated successfully.")
	
	# 3. Test Level Loading for all 10 levels
	for lvl in range(10):
		game.load_level(lvl)
		if game.preview_texture.texture == null:
			print("[FAIL] Level %d image texture failed to load." % (lvl + 1))
			quit(1)
			return
		if game.puzzle_board.tile_nodes.size() != 14:
			print("[FAIL] Level %d does not have exactly 14 tiles." % (lvl + 1))
			quit(1)
			return
	print("[PASS] All 10 levels loaded with textures and 14 active tiles.")
	
	# 4. Test Player Interaction on GameScreen
	game.load_level(0) # Level 1
	var board = game.puzzle_board
	var empty_idx = board.logic.empty_index
	var legal_moves = board.logic.get_legal_moves()
	var test_tile_cell = legal_moves[0]
	var test_tile_id = board.logic.grid[test_tile_cell]
	
	# Simulate clicking that tile
	board._on_tile_clicked(test_tile_id)
	if board.logic.move_count == 1:
		print("[PASS] Tile click simulated successfully, move count incremented to 1.")
	else:
		print("[FAIL] Simulated tile click did not increment move count.")
		quit(1)
		return
		
	# 5. Clean up nodes
	home.queue_free()
	game.queue_free()
	
	print("\nALL GAMEPLAY FLOW INTEGRATION TESTS PASSED!")
	quit(0)
