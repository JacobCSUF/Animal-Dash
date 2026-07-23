shader_type canvas_item;

uniform bool top_down_move = false;

uniform float uv_speed_x : hint_range(-10.0, 10.0) = 0.0;
uniform float uv_speed_y : hint_range(-10.0, 10.0) = 0.0;

void vertex() {
	

	// Apply movement
	if (top_down_move)
		UV.y += TIME * uv_speed_y;
	else
		UV.x += TIME * uv_speed_x;


}