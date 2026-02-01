shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

uniform vec2 global_position;
uniform vec2 screen_size;
uniform float force;
uniform float size;
uniform float thickness;

void fragment() {
	vec2 center = global_position;

	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	
	center.x = center.x / screen_size.x;
	center.x = (center.x - 0.5) / ratio + 0.5;
	center.y = (screen_size.y - center.y) / screen_size.y;
	
	vec2 scaled_uv = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
	
	float dist = length(scaled_uv - center);
	
	float mask =
		(1.0 - smoothstep(size - 0.1, size, dist)) *
		smoothstep(size - thickness - 0.1, size - thickness, dist);
	
	vec2 dir = SCREEN_UV - center;
	float len = length(dir);
	vec2 disp = (len > 0.0001 ? dir / len : vec2(0.0)) * force * mask;
	
	COLOR = texture(screen_texture, SCREEN_UV - disp);
}
