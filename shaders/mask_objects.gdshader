shader_type spatial;

uniform vec3 color : source_color = vec3(0.0, 0.0, 0.0);
uniform float wire_width : hint_range(0.0, 1.0) = 0.1;
uniform float emission_strength : hint_range(0.0, 10.0) = 1.0;
uniform float transparency : hint_range(0.0, 1.0) = 1.0;
uniform sampler2D electricity_effect_texture;
uniform float electricity_length : hint_range(0.0, 10.0) = 0.2;
uniform float electricity_ray_duration : hint_range(0.0, 10.0) = 0.5;
uniform float electricity_delay_between_rays : hint_range(0.0, 10.0) = 1;

render_mode blend_mix, depth_draw_opaque;

void fragment() {
    ALBEDO = color.rgb;
}

	