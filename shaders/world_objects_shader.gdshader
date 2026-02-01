shader_type spatial;

uniform vec3 wire_color : source_color = vec3(0.0, 0.0, 0.0);
uniform float wire_width : hint_range(0.0, 1.0) = 0.1;
uniform float emission_strength : hint_range(0.0, 10.0) = 1.0;
uniform float transparency : hint_range(0.0, 1.0) = 1.0;
uniform sampler2D electricity_effect_texture;
uniform float electricity_length : hint_range(0.0, 10.0) = 0.2;
uniform float electricity_ray_duration : hint_range(0.0, 10.0) = 0.5;
uniform float electricity_delay_between_rays : hint_range(0.0, 10.0) = 1;

render_mode blend_mix, depth_draw_opaque;

varying vec4 frag_uv;

void vertex()
{
	vec3 world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	vec3 cam_to_frag = normalize(world_pos - CAMERA_POSITION_WORLD);
	vec3 uv_camera_off = cam_to_frag - dot(NORMAL, cam_to_frag) * NORMAL;
	frag_uv.xy = world_pos.xy * NORMAL.z + world_pos.xz * NORMAL.y + world_pos.yz * NORMAL.x;
	frag_uv.zw = uv_camera_off.xy * NORMAL.z + uv_camera_off.xz * NORMAL.y + uv_camera_off.yz * NORMAL.x;
}


float peak(float x, float start, float len) {
	    float t = (x - start) / len;   // normaliza a 0–1
	    t = clamp(t, 0.0, 1.0);
	    return 1.0 - abs(t * 2.0 - 1.0);
	}
	
void fragment() {
    vec2 uv = UV;
	
	//edges//
	vec3 scale;
	scale.x = length(MODEL_MATRIX[0].xyz);
	scale.y = length(MODEL_MATRIX[1].xyz);
	scale.z = length(MODEL_MATRIX[2].xyz);
	
	float avg_scale = (scale.x + scale.y + scale.z) / 3.0;
	float corrected_width = wire_width / avg_scale;
	
	float edge2 = uv.x > 1.0 - corrected_width ? 1.0 : 0.0;
	float edge3 = uv.y < corrected_width ? 1.0 : 0.0;
	float edge1 = uv.x < corrected_width ? 1.0 : 0.0;
	float edge4 = uv.y > 1.0 - wire_width ? 1.0 : 0.0;
	float edge = clamp(edge1 + edge2 + edge3 + edge4, 0, 1);
	//end edges//
	
	vec3 electricity_texture = texture(electricity_effect_texture, UV).rgb;
	float max_time = electricity_ray_duration * 3.0 + electricity_delay_between_rays * 3.0;
	float world_pos = NODE_POSITION_WORLD.x + NODE_POSITION_WORLD.x + NODE_POSITION_WORLD.z;
	float looped_time = mod(world_pos + TIME, max_time);
	
	float true_r = electricity_texture.r > 0.0 ? electricity_texture.r * electricity_ray_duration : -1.0;
	float true_g = electricity_texture.g > 0.0 ? electricity_ray_duration + electricity_delay_between_rays + electricity_texture.g * electricity_ray_duration : -1.0;
	float true_b = electricity_texture.b > 0.0 ? electricity_ray_duration * 2.0 + electricity_delay_between_rays * 2.0 + electricity_texture.b * electricity_ray_duration : -1.0;

	float looped_start_time = looped_time - electricity_length * 0.5;
	float ray_r = peak(true_r, looped_start_time, electricity_length);
	float ray_g = peak(true_g, looped_start_time, electricity_length);
	float ray_b = peak(true_b, looped_start_time, electricity_length);
	float ray = ray_r + ray_g + ray_b;

    ALBEDO = wire_color * edge + wire_color * ray;
	//ALBEDO = vec3(uv.x, uv.y, 0.0);
	EMISSION = wire_color * edge * emission_strength + wire_color * ray;
	ALPHA = edge > 0.0 ? 1.0 : transparency;
}

	