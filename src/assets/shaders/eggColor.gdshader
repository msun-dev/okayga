shader_type canvas_item;

uniform vec4 color: source_color;
uniform vec4 white = vec4(1, 1, 1, 1);

void fragment() {
	vec4 curr_color = texture(TEXTURE,UV);
    if (curr_color == white)
	{
        COLOR = color;
    }
}
