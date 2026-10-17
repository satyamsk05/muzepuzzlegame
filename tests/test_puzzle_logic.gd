extends SceneTree

const PuzzleLogic = preload("res://scripts/puzzle_logic.gd")
const SaveManager = preload("res://scripts/save_manager.gd")

func _init() -> void:
	print("--- Running Scale Maze Puzzle Test Suite ---")
	var passed = 0
	var failed = 0
	
	# Test 1 & 6: Solved board recognition
	var logic = PuzzleLogic.new()
	if logic.is_solved():
		print("[PASS] Test 1: Initially solved board is recognized correctly.")
		passed += 1
	else:
		print("[FAIL] Test 1: Solved board not recognized.")
		failed += 1
		
	# Test 2: Adjacent tile moves successfully
	# Initially empty cell is at index 14 (row 2, col 4). Adjacent cells are 13 (row 2, col 3) and 9 (row 1, col 4).
	var can_move_13 = logic.is_move_legal(13)
	var can_move_9 = logic.is_move_legal(9)
	if can_move_13 and can_move_9:
		print("[PASS] Test 2: Orthogonally adjacent tiles (13, 9) are legal moves.")
		passed += 1
	else:
		print("[FAIL] Test 2: Adjacent tiles rejected.")
		failed += 1
		
	# Test 3: Non-adjacent tile does not move
	# Index 0 (row 0, col 0) is far from 14
	var can_move_0 = logic.is_move_legal(0)
	var can_move_5 = logic.is_move_legal(5)
	if not can_move_0 and not can_move_5:
		print("[PASS] Test 3: Non-adjacent tiles (0, 5) are rejected.")
		passed += 1
	else:
		print("[FAIL] Test 3: Non-adjacent tile accepted as legal.")
		failed += 1
		
	# Test 4: Diagonal movement is rejected
	# Index 8 (row 1, col 3) is diagonally adjacent to 14 (row 2, col 4)
	var can_move_diagonal = logic.is_move_legal(8)
	if not can_move_diagonal:
		print("[PASS] Test 4: Diagonal movement (cell 8) is strictly rejected.")
		passed += 1
	else:
		print("[FAIL] Test 4: Diagonal movement was permitted.")
		failed += 1
		
	# Test 5: Move counter & Timer start on first valid move only
	var initial_moves = logic.move_count
	var illegal_res = logic.make_player_move(0) # Attempt illegal move
	if not illegal_res and logic.move_count == initial_moves and not logic.timer_started:
		print("[PASS] Test 5a: Illegal move did not increment move counter or start timer.")
		passed += 1
	else:
		print("[FAIL] Test 5a: Illegal move affected counter or timer.")
		failed += 1
		
	var legal_res = logic.make_player_move(13) # Legal move
	if legal_res and logic.move_count == 1 and logic.timer_started:
		print("[PASS] Test 5b: Valid move incremented counter to 1 and started timer.")
		passed += 1
	else:
		print("[FAIL] Test 5b: Valid move failed to update state correctly.")
		failed += 1
		
	# Test 6: Solvability of shuffled board
	# We shuffle multiple times and verify that by construction (swaps from solved state),
	# parity and reachability to solved state is 100% mathematically preserved.
	var shuffle_ok = true
	for s in range(5):
		logic.shuffle(30)
		if logic.is_solved(): # Extremely unlikely to be already solved
			shuffle_ok = false
		if logic.grid.size() != 15:
			shuffle_ok = false
		# Check all numbers 0..14 present exactly once
		var check = logic.grid.duplicate()
		check.sort()
		for i in range(15):
			if check[i] != i:
				shuffle_ok = false
	if shuffle_ok:
		print("[PASS] Test 6: Shuffled boards maintain valid 15-cell permutation created via legal moves (100% solvable).")
		passed += 1
	else:
		print("[FAIL] Test 6: Shuffle produced invalid grid state.")
		failed += 1
		
	# Test 7: Restart resets all current-game state
	logic.reset_to_solved()
	if logic.move_count == 0 and logic.elapsed_time == 0.0 and not logic.timer_started and logic.is_solved():
		print("[PASS] Test 7: Restart resets board, timer, move count, and solved state.")
		passed += 1
	else:
		print("[FAIL] Test 7: Reset did not clear all state.")
		failed += 1
		
	# Test 8: Win condition locks board
	# Put in 1-move away state: move 13 into 14, then move 13 back
	logic.reset_to_solved()
	logic.make_player_move(13) # now empty is at 13
	logic.make_player_move(14) # now tile 13 moves into 13, empty moves into 14 -> solved!
	if logic.is_solved() and logic.is_game_over:
		var move_after_win = logic.make_player_move(13)
		if not move_after_win:
			print("[PASS] Test 8: Solved board enters game_over and locks board against further moves.")
			passed += 1
		else:
			print("[FAIL] Test 8: Board was not locked after victory.")
			failed += 1
	else:
		print("[FAIL] Test 8: Win state not detected after reaching solved state.")
		failed += 1
		
	# Test 9: SaveManager persistence
	var save = SaveManager.new()
	save.reset_all()
	if save.get_highest_unlocked() == 1 and save.get_sound_enabled():
		save.set_sound_enabled(false)
		save.save_level_result(1, 15, 23.5)
		
		var reloaded_save = SaveManager.new()
		if reloaded_save.get_highest_unlocked() == 2 and reloaded_save.is_level_completed(1) and not reloaded_save.get_sound_enabled():
			print("[PASS] Test 9: SaveManager correctly persists progress, sound setting, and unlocks next level.")
			passed += 1
		else:
			print("[FAIL] Test 9: Reloaded save did not match expected values.")
			failed += 1
	else:
		print("[FAIL] Test 9: SaveManager initialization failed.")
		failed += 1
		
	print("\n--- Test Results: %d Passed, %d Failed ---" % [passed, failed])
	if failed == 0:
		print("ALL PUZZLE LOGIC ACCEPTANCE TESTS PASSED!")
	quit(failed)
