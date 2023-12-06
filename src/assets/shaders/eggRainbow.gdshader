shader_type canvas_item;

uniform vec4 white = vec4(1, 1, 1, 1);

void fragment() {
	vec4 curr_color = texture(TEXTURE,UV);
    if (curr_color == white)
	{
        COLOR = vec4(0.5 + 0.5 * cos(TIME+vec3(0,2,4)), 1.0);
    }
}