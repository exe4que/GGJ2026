shader_type spatial;

uniform vec3 color : source_color = vec3(0.0, 0.0, 0.0);
uniform sampler2D noise : source_color, repeat_enable;
uniform float speed_mutiplier = 1;
uniform float uv_multilplier = 0.1;
uniform float paralax_multiplier = 0.5;
uniform float emmission_multiplier = 0.5;

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

void fragment() 
{
	float time = TIME * speed_mutiplier;
	vec2 world_uv = vec2(frag_uv.x, frag_uv.y) * uv_multilplier;
	//vec2 uv1 = vec2(UV.x + time * 0.02634513, UV.y - time * 0.037152563);
	vec2 uv1 = vec2(world_uv.x + time * 0.02634513, world_uv.y - time * 0.037152563);
	vec2 uv2 = vec2(world_uv.x - time * 0.02956377, world_uv.y - time * 0.028462617);
	world_uv += frag_uv.zw * paralax_multiplier;
	vec2 uv3 = vec2(world_uv.x - time * 0.03175893, world_uv.y + time * 0.041982837);
	vec2 uv4 = vec2(world_uv.x + time * 0.02784382, world_uv.y + time * 0.031957362);
	vec4 noise1 = texture(noise, uv1);
	vec4 noise2 = texture(noise, uv2);
	vec4 noise3 = texture(noise, uv3);
	vec4 noise4 = texture(noise, uv4);
    ALBEDO = color.rgb;
	ALBEDO *= (noise1.r * noise3.g + noise2.b * noise4.a) + 0.1;
	ALPHA = ALBEDO.r + ALBEDO.g + ALBEDO.b;
	EMISSION = color.rgb * ALPHA * ALPHA * emmission_multiplier;
	ALPHA = ALPHA * ALPHA + 0.5;
	
}

	