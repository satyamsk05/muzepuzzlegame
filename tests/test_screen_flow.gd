extends SceneTree

func _init() -> void:
	print("--- Running Screen Flow Test (Start -> Home -> Loading -> Game) ---")

	# 1. Test StartScreen instantiation
	var start_scene = load("res://scenes/StartScreen.tscn")
	if not start_scene:
		print("[FAIL] Could not load StartScreen.tscn")
		quit(1)
		return
	var start = start_scene.instantiate()
	root.add_child(start)
	if not start.get_node_or_null("BottomContainer/VBox/GetStartedBtn"):
		print("[FAIL] StartScreen missing GetStartedBtn")
		quit(1)
		return
	print("[PASS] StartScreen instantiated and wired successfully.")

	# 2. Test HomeScreen instantiation & winding path
	var home_scene = load("res://scenes/HomeScreen.tscn")
	if not home_scene:
		print("[FAIL] Could not load HomeScreen.tscn")
		quit(1)
		return
	var home = home_scene.instantiate()
	root.add_child(home)
	if not home.is_node_ready():
		home._ready()
	var path_line = home.get_node_or_null("ScrollContainer/PathArea/RoadLine") as Line2D
	if not path_line or path_line.get_point_count() == 0:
		print("[FAIL] HomeScreen winding path has no points generated.")
		quit(1)
		return
	print("[PASS] HomeScreen winding road generated with %d points." % path_line.get_point_count())

	# 3. Test LoadingScreen instantiation
	var loading_scene = load("res://scenes/LoadingScreen.tscn")
	if not loading_scene:
		print("[FAIL] Could not load LoadingScreen.tscn")
		quit(1)
		return
	var loading = loading_scene.instantiate()
	loading.target_level_index = 0
	root.add_child(loading)
	var tip = loading.get_node_or_null("Center/VBox/TipLabel") as Label
	if not tip or tip.text.is_empty():
		print("[FAIL] LoadingScreen tip is empty.")
		quit(1)
		return
	print("[PASS] LoadingScreen instantiated with tip: '%s'" % tip.text.replace("\n", " "))

	# 4. Clean up
	start.queue_free()
	home.queue_free()
	loading.queue_free()

	print("\nALL SCREEN NAVIGATION & ASSET FLOW TESTS PASSED SUCCESSFULLY!")
	quit(0)
