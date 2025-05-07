shader_type spatial;


// WARNING:
// if the following render_mode line is removed or altered
// the script progress_bar_3d.gd will no longer be able to
// create new versions of this shader.  See function
// progress_bar_3d.gd:_update_shader()
render_mode unshaded, shadows_disabled, depth_test_disabled;


uniform vec4 background_color : source_color = vec4(.0,.0,.0,1.);
uniform vec4 progress_color : source_color = vec4(.0,1.,.0,1.);
uniform float progress_value : hint_range(0.0, 1.0, 0.01) = .5;
uniform int billboard_mode = 1;


void vertex() {
	//enabled
	if(billboard_mode == 1) {
		MODELVIEW_MATRIX = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
		MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
	//fixed y
	} else if(billboard_mode == 2) {
		MODELVIEW_MATRIX = VIEW_MATRIX * mat4(vec4(normalize(cross(vec3(0.0, 1.0, 0.0), INV_VIEW_MATRIX[2].xyz)), 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0), MODEL_MATRIX[3]);
		MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
	}
}


void fragment() {
	vec2 border = vec2(0.01, 0.1);

	vec2 mask2 = step(border, UV) * step(UV, 1.0-border);
    float mask = mask2.x*mask2.y;

    float blend = ((UV.x - progress_value) <= 0.0 ? 1.0 : 0.0) * mask;
    vec4 fragColor = progress_color*blend + background_color*(1.0-blend);
	ALBEDO = fragColor.rgb;
}
