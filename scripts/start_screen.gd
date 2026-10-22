class_name StartScreen
extends Control

@onready var mascot: TextureRect = $CenterContainer/VBox/MascotWrapper/Mascot
@onready var bubble: Control = $CenterContainer/VBox/MascotWrapper/Bubble
@onready var get_started_btn: Button = $BottomContainer/VBox/GetStartedBtn
@onready var play_btn: Button = $BottomContainer/VBox/PlayBtn

var _mascot_base_y: float = 0.0
var _time: float = 0.0

func _ready() -> void:
	_mascot_base_y = mascot.position.y
	_apply_theme_styles()
	_start_mascot_float()
	get_started_btn.pressed.connect(_on_get_started_pressed)
	play_btn.pressed.connect(_on_get_started_pressed)

func _apply_theme_styles() -> void:
	UIStyles.apply_gradient_3d_button(get_started_btn, 24)
	UIStyles.apply_subtle_text_button(play_btn)

func _process(delta: float) -> void:
	_time += delta * 2.5
	# Smooth floating bobbing animation
	mascot.position.y = _mascot_base_y + sin(_time) * 12.0
	bubble.position.y = sin(_time * 1.2) * 6.0

func _start_mascot_float() -> void:
	# Subtle scale pulse on the flame
	var tw = create_tween().set_loops()
	tw.tween_property(mascot, "scale", Vector2(1.02, 0.98), 1.2).set_trans(Tween.TRANS_SINE)
	tw.tween_property(mascot, "scale", Vector2(0.98, 1.02), 1.2).set_trans(Tween.TRANS_SINE)

func _on_get_started_pressed() -> void:
	# Click sound or press scale punch
	var tw = create_tween()
	tw.tween_property(get_started_btn, "scale", Vector2(0.95, 0.95), 0.08)
	tw.tween_property(get_started_btn, "scale", Vector2(1.0, 1.0), 0.08)
	tw.tween_callback(func():
		var home_scene = load("res://scenes/HomeScreen.tscn").instantiate()
		get_tree().root.add_child(home_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = home_scene
	)
