class_name PuzzleLogic
extends RefCounted

const ROWS = 3
const COLS = 5
const TOTAL_CELLS = 15
const EMPTY_TILE = 14 # Index of the missing piece in 0-indexed grid (bottom-right)

# Array of size 15 holding tile IDs (0 to 14, where 14 is the empty cell)
var grid: Array[int] = []
var empty_index: int = EMPTY_TILE
var move_count: int = 0
var timer_started: bool = false
var elapsed_time: float = 0.0
var is_game_over: bool = false

func _init() -> void:
	reset_to_solved()

## Resets the grid to the solved state (0..14)
func reset_to_solved() -> void:
	grid.clear()
	for i in range(TOTAL_CELLS):
		grid.append(i)
	empty_index = EMPTY_TILE
	move_count = 0
	timer_started = false
	elapsed_time = 0.0
	is_game_over = false

## Returns whether a given grid index is adjacent to the empty cell (orthogonal only)
func is_move_legal(index: int) -> bool:
	if index < 0 or index >= TOTAL_CELLS:
		return false
	if index == empty_index:
		return false
	
	var r1 = index / COLS
	var c1 = index % COLS
	var r2 = empty_index / COLS
	var c2 = empty_index % COLS
	
	var r_diff = abs(r1 - r2)
	var c_diff = abs(c1 - c2)
	
	# Strict orthogonal adjacency (no diagonal)
	return (r_diff == 1 and c_diff == 0) or (r_diff == 0 and c_diff == 1)

## Returns an array of legal adjacent tile indices that can move into the empty space
func get_legal_moves() -> Array[int]:
	var moves: Array[int] = []
	var r = empty_index / COLS
	var c = empty_index % COLS
	
	# Up
	if r > 0:
		moves.append((r - 1) * COLS + c)
	# Down
	if r < ROWS - 1:
		moves.append((r + 1) * COLS + c)
	# Left
	if c > 0:
		moves.append(r * COLS + (c - 1))
	# Right
	if c < COLS - 1:
		moves.append(r * COLS + (c + 1))
	
	return moves

## Performs a player move if legal.
## Returns true if the move was successful, false if illegal.
func make_player_move(index: int) -> bool:
	if is_game_over:
		return false
	
	if not is_move_legal(index):
		return false
	
	# Execute swap
	_swap_with_empty(index)
	
	# Increment move count only for legal player moves
	move_count += 1
	
	# Timer starts on first valid move
	if not timer_started:
		timer_started = true
	
	# Check if victory condition met
	if is_solved():
		is_game_over = true
	
	return true

## Internal swap between a tile and the empty slot
func _swap_with_empty(index: int) -> void:
	grid[empty_index] = grid[index]
	grid[index] = EMPTY_TILE
	empty_index = index

## Shuffles the board using legal moves starting from the solved state.
## This guarantees 100% solvability without unsolvable permutations.
func shuffle(num_moves: int = 40) -> void:
	reset_to_solved()
	var last_moved_pos: int = -1
	
	for _step in range(num_moves):
		var legal = get_legal_moves()
		# Avoid immediately undoing the last move if other choices exist
		var candidates: Array[int] = []
		for move in legal:
			if move != last_moved_pos or legal.size() == 1:
				candidates.append(move)
		
		if candidates.is_empty():
			candidates = legal
		
		var chosen = candidates[randi() % candidates.size()]
		var prev_empty = empty_index
		_swap_with_empty(chosen)
		last_moved_pos = prev_empty
	
	# If by rare coincidence the puzzle ended up solved, make 2 extra moves
	if is_solved():
		var extra = get_legal_moves()
		_swap_with_empty(extra[0])
		var extra2 = get_legal_moves()
		_swap_with_empty(extra2[extra2.size() - 1])
	
	# Reset game counters for the new game
	move_count = 0
	timer_started = false
	elapsed_time = 0.0
	is_game_over = false

## Checks if every tile is in its target index (0..14)
func is_solved() -> bool:
	for i in range(TOTAL_CELLS):
		if grid[i] != i:
			return false
	return true

## Updates timer if started and not won
func update_timer(delta: float) -> void:
	if timer_started and not is_game_over:
		elapsed_time += delta
