shader_type canvas_item;

uniform float threshold : hint_range(0.0, 0.5) = 0.06;
uniform float softness : hint_range(0.0, 0.5) = 0.12;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	float max_c = max(col.r, max(col.g, col.b));
	float alpha = smoothstep(threshold, threshold + softness, max_c);
	COLOR = vec4(col.rgb, col.a * alpha);
}
