class_name UIStyles
extends RefCounted

## Creates a soft rounded card StyleBoxFlat
static func make_card_style(bg_color: Color = Color(1.0, 1.0, 1.0, 0.98), radius: int = 24, shadow_opacity: float = 0.08) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = bg_color
	style.set_corner_radius_all(radius)
	style.border_color = Color(0.9, 0.94, 0.98, 0.8)
	style.set_border_width_all(1)
	if shadow_opacity > 0.0:
		style.shadow_color = Color(0.1, 0.18, 0.35, shadow_opacity)
		style.shadow_size = 12
		style.shadow_offset = Vector2(0, 6)
	style.content_margin_left = 18
	style.content_margin_right = 18
	style.content_margin_top = 14
	style.content_margin_bottom = 14
	return style

## Creates a vibrant 3D tactile button style
static func make_btn_style(bg_color: Color, border_bottom_color: Color = Color.TRANSPARENT, radius: int = 20, shadow_opacity: float = 0.25) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = bg_color
	style.set_corner_radius_all(radius)
	if border_bottom_color != Color.TRANSPARENT:
		style.border_width_bottom = 4
		style.border_color = border_bottom_color
	if shadow_opacity > 0.0:
		style.shadow_color = Color(bg_color.r * 0.4, bg_color.g * 0.4, bg_color.b * 0.4, shadow_opacity)
		style.shadow_size = 8
		style.shadow_offset = Vector2(0, 4)
	style.content_margin_left = 20
	style.content_margin_right = 20
	style.content_margin_top = 12
	style.content_margin_bottom = 12
	return style

## Applies primary button styling (vibrant blue with 3D bottom bevel)
static func apply_primary_button(btn: Button, text_size: int = 22) -> void:
	var normal = make_btn_style(Color("#2563EB"), Color("#1D4ED8"), 22, 0.3)
	var hover = make_btn_style(Color("#3B82F6"), Color("#1D4ED8"), 22, 0.35)
	var pressed = make_btn_style(Color("#1D4ED8"), Color.TRANSPARENT, 22, 0.1)
	pressed.content_margin_top = 14 # Slight tactile press-down
	
	btn.add_theme_stylebox_override("normal", normal)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_stylebox_override("pressed", pressed)
	btn.add_theme_stylebox_override("focus", normal)
	btn.add_theme_color_override("font_color", Color.WHITE)
	btn.add_theme_color_override("font_hover_color", Color.WHITE)
	btn.add_theme_color_override("font_pressed_color", Color(0.9, 0.95, 1.0))
	btn.add_theme_font_size_override("font_size", text_size)

## Applies secondary white card button styling
static func apply_secondary_button(btn: Button, text_size: int = 18) -> void:
	var normal = StyleBoxFlat.new()
	normal.bg_color = Color.WHITE
	normal.set_corner_radius_all(18)
	normal.border_color = Color("#CBD5E1")
	normal.set_border_width_all(2)
	normal.shadow_color = Color(0.1, 0.2, 0.4, 0.06)
	normal.shadow_size = 6
	normal.shadow_offset = Vector2(0, 3)
	normal.content_margin_left = 18
	normal.content_margin_right = 18
	normal.content_margin_top = 10
	normal.content_margin_bottom = 10
	
	var hover = normal.duplicate() as StyleBoxFlat
	hover.bg_color = Color("#F8FAFC")
	hover.border_color = Color("#94A3B8")
	
	var pressed = normal.duplicate() as StyleBoxFlat
	pressed.bg_color = Color("#F1F5F9")
	pressed.shadow_size = 2
	
	btn.add_theme_stylebox_override("normal", normal)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_stylebox_override("pressed", pressed)
	btn.add_theme_stylebox_override("focus", normal)
	btn.add_theme_color_override("font_color", Color("#334155"))
	btn.add_theme_color_override("font_hover_color", Color("#1E293B"))
	btn.add_theme_color_override("font_pressed_color", Color("#0F172A"))
	btn.add_theme_font_size_override("font_size", text_size)

## Applies pill badge button styling (e.g. for Sound or Menu button)
static func apply_pill_button(btn: Button, text_size: int = 15) -> void:
	var normal = StyleBoxFlat.new()
	normal.bg_color = Color(1.0, 1.0, 1.0, 0.95)
	normal.set_corner_radius_all(24)
	normal.border_color = Color("#E2E8F0")
	normal.set_border_width_all(1)
	normal.shadow_color = Color(0.1, 0.2, 0.4, 0.08)
	normal.shadow_size = 6
	normal.shadow_offset = Vector2(0, 2)
	normal.content_margin_left = 14
	normal.content_margin_right = 14
	normal.content_margin_top = 8
	normal.content_margin_bottom = 8
	
	var hover = normal.duplicate() as StyleBoxFlat
	hover.bg_color = Color("#F1F5F9")
	
	var pressed = normal.duplicate() as StyleBoxFlat
	pressed.bg_color = Color("#E2E8F0")
	
	btn.add_theme_stylebox_override("normal", normal)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_stylebox_override("pressed", pressed)
	btn.add_theme_stylebox_override("focus", normal)
	btn.add_theme_color_override("font_color", Color("#1E293B"))
	btn.add_theme_font_size_override("font_size", text_size)

## Creates button style for level selection buttons
static func apply_level_button(btn: Button, is_current: bool, is_completed: bool, is_unlocked: bool) -> void:
	var style = StyleBoxFlat.new()
	style.set_corner_radius_all(14)
	style.content_margin_left = 6
	style.content_margin_right = 6
	style.content_margin_top = 8
	style.content_margin_bottom = 8
	
	if not is_unlocked:
		# Locked: soft muted grey with subtle border
		style.bg_color = Color("#F1F5F9")
		style.border_color = Color("#E2E8F0")
		style.set_border_width_all(1)
		btn.add_theme_color_override("font_disabled_color", Color("#94A3B8"))
	elif is_current:
		# Current unlocked level: vibrant glowing blue
		style.bg_color = Color("#2563EB")
		style.border_color = Color("#1D4ED8")
		style.border_width_bottom = 3
		style.shadow_color = Color(0.14, 0.38, 0.92, 0.35)
		style.shadow_size = 6
		style.shadow_offset = Vector2(0, 3)
		btn.add_theme_color_override("font_color", Color.WHITE)
		btn.add_theme_color_override("font_hover_color", Color.WHITE)
	elif is_completed:
		# Completed: fresh emerald green tint
		style.bg_color = Color("#ECFDF5")
		style.border_color = Color("#10B981")
		style.set_border_width_all(2)
		style.shadow_color = Color(0.06, 0.72, 0.5, 0.15)
		style.shadow_size = 4
		style.shadow_offset = Vector2(0, 2)
		btn.add_theme_color_override("font_color", Color("#047857"))
		btn.add_theme_color_override("font_hover_color", Color("#065F46"))
	else:
		# Unlocked but not current: clean white with border
		style.bg_color = Color.WHITE
		style.border_color = Color("#CBD5E1")
		style.set_border_width_all(1)
		btn.add_theme_color_override("font_color", Color("#334155"))
		
	btn.add_theme_stylebox_override("normal", style)
	var pressed = style.duplicate() as StyleBoxFlat
	pressed.bg_color = pressed.bg_color.darkened(0.1)
	btn.add_theme_stylebox_override("pressed", pressed)
	btn.add_theme_stylebox_override("hover", style)
	btn.add_theme_stylebox_override("focus", style)
	btn.add_theme_stylebox_override("disabled", style)
	btn.add_theme_font_size_override("font_size", 16)

## Applies a vibrant 3D gradient pill button (Reference Image 1 "Get Started")
static func apply_gradient_3d_button(btn: Button, text_size: int = 24) -> void:
	var normal = StyleBoxFlat.new()
	normal.bg_color = Color("#4F46E5") # Vibrant indigo/blue
	normal.set_corner_radius_all(28)
	normal.border_width_bottom = 5
	normal.border_color = Color("#3730A3")
	normal.shadow_color = Color(0.31, 0.27, 0.9, 0.45)
	normal.shadow_size = 14
	normal.shadow_offset = Vector2(0, 6)
	normal.content_margin_left = 28
	normal.content_margin_right = 28
	normal.content_margin_top = 16
	normal.content_margin_bottom = 16

	var hover = normal.duplicate() as StyleBoxFlat
	hover.bg_color = Color("#6366F1")
	hover.shadow_size = 18

	var pressed = normal.duplicate() as StyleBoxFlat
	pressed.bg_color = Color("#3730A3")
	pressed.border_width_bottom = 2
	pressed.content_margin_top = 19
	pressed.shadow_size = 4
	pressed.shadow_offset = Vector2(0, 2)

	btn.add_theme_stylebox_override("normal", normal)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_stylebox_override("pressed", pressed)
	btn.add_theme_stylebox_override("focus", normal)
	btn.add_theme_color_override("font_color", Color.WHITE)
	btn.add_theme_color_override("font_hover_color", Color.WHITE)
	btn.add_theme_font_size_override("font_size", text_size)

## Subtle text button for sign in / secondary links
static func apply_subtle_text_button(btn: Button, text_size: int = 15) -> void:
	var empty = StyleBoxEmpty.new()
	btn.add_theme_stylebox_override("normal", empty)
	btn.add_theme_stylebox_override("hover", empty)
	btn.add_theme_stylebox_override("pressed", empty)
	btn.add_theme_stylebox_override("focus", empty)
	btn.add_theme_color_override("font_color", Color("#94A3B8"))
	btn.add_theme_color_override("font_hover_color", Color("#60A5FA"))
	btn.add_theme_font_size_override("font_size", text_size)

## Dark space glassmorphism card
static func apply_dark_glass_card(panel: Control, radius: int = 24) -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.08, 0.08, 0.16, 0.85)
	style.set_corner_radius_all(radius)
	style.border_color = Color(0.25, 0.28, 0.48, 0.4)
	style.set_border_width_all(1)
	style.shadow_color = Color(0.0, 0.0, 0.0, 0.35)
	style.shadow_size = 10
	style.shadow_offset = Vector2(0, 4)
	style.content_margin_left = 18
	style.content_margin_right = 18
	style.content_margin_top = 14
	style.content_margin_bottom = 14
	panel.add_theme_stylebox_override("panel", style)

