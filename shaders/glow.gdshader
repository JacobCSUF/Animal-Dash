shader_type canvas_item;

// Uniforms control parameters from the editor or script
uniform float flash_progress : hint_range(0.0, 1.0) = 0.0; // Controls flash intensity (0=none, 1=full flash)

void fragment() {
    // Get the original color of the texture
    vec4 original_color = texture(TEXTURE, UV);

    // Mix the original color with white based on flash_progress
    // vec3(1.0) is pure white (R, G, B)
    COLOR = vec4(mix(original_color.rgb, vec3(1.0), flash_progress), original_color.a);
}