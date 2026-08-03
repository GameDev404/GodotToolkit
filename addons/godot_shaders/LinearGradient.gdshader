shader_type canvas_item;
 
uniform vec4 light_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 dark_color  : source_color = vec4(0.0, 0.0, 0.0, 1.0);
void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	COLOR = tex * light_color + (vec4(1.0) - tex) * dark_color;
	COLOR.a = tex.a;
}
