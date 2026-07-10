shader_type canvas_item;

uniform bool top_down_move = false;

uniform float uv_speed_x : hint_range(-10.0, 10.0) = 0.0;
uniform float uv_speed_y : hint_range(-10.0, 10.0) = 0.0;

void fragment() {
	vec2 uv = UV;

	// Apply movement
	if (top_down_move)
		uv.y += TIME * uv_speed_y;
	else
		uv.x += TIME * uv_speed_x;

	vec4 col = texture(TEXTURE, uv);

	// Mask: only draw where original texture has alpha
	float mask = texture(TEXTURE, UV).a;

	COLOR = vec4(col.rgb, col.a * mask);
}