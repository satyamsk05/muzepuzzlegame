class_name LoadingScreen
extends Control

@export var target_level_index: int = 0
@export var load_duration: float = 1.8

@onready var mascot: TextureRect = $Center/VBox/MascotWrapper/Mascot
@onready var tip_label: Label = $Center/VBox/TipLabel
@onready var dots_label: Label = $Center/VBox/LoadingTitle

var _time: float = 0.0
var _tips: Array[String] = [
	"Some things are impossible to count...\nLike stars. Or grains of sand.\nSo let's count apples instead.",
	"Did you know?\nPuzzles help sharpen spatial reasoning and memory!",
	"Every master was once a beginner.\nTake your time and plan each slide!",
	"Keep your eyes on the open space.\nIt is the key to unlocking the board!"
]

func _ready() -> void:
	# Pick a fun tip
	tip_label.text = _tips[randi() % _tips.size()]
	
	# Floating animation
	_animate_mascot()
	
	# Start transition timer
	var timer = get_tree().create_timer(load_duration)
	timer.timeout.connect(_on_loading_complete)

func _process(delta: float) -> void:
	_time += delta
	# Floating bob
	mascot.position.y = sin(_time * 3.0) * 14.0
	
	# Animate "LOADING..." dots
	var dot_count = int(_time * 3.0) % 4
	var dots = ""
	for i in range(dot_count):
		dots += "."
	dots_label.text = "LOADING" + dots

func _animate_mascot() -> void:
	var tw = create_tween().set_loops()
	tw.tween_property(mascot, "scale", Vector2(1.05, 0.95), 0.8).set_trans(Tween.TRANS_SINE)
	tw.tween_property(mascot, "scale", Vector2(0.96, 1.04), 0.8).set_trans(Tween.TRANS_SINE)

func _on_loading_complete() -> void:
	var game_scene = load("res://scenes/GameScreen.tscn").instantiate() as GameScreen
	game_scene.current_level_index = target_level_index
	get_tree().root.add_child(game_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = game_scene
