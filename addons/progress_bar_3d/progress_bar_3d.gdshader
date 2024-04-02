shader_type spatial;

render_mode unshaded, shadows_disabled, depth_test_disabled;

uniform vec4 background_color : source_color = vec4(.0,.0,.0,1.);
uniform vec4 progress_color : source_color = vec4(.0,1.,.0,1.);
uniform float progress_value : hint_range(0.0, 1.0, 0.01) = .5;


void vertex() {
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
	vec2 border = vec2(0.01, 0.1);

	vec2 mask2 = step(border, UV) * step(UV, 1.0-border);
    float mask = mask2.x*mask2.y;

    float blend = ((UV.x - progress_value) <= 0.0 ? 1.0 : 0.0) * mask;
    vec4 fragColor = progress_color*blend + background_color*(1.0-blend);
	ALBEDO = fragColor.rgb;
}

