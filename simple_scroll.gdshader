shader_type canvas_item;

uniform vec2 dir;
uniform float scale = 1;

void fragment() {
	COLOR = texture(TEXTURE, (UV + (dir * TIME)) * scale);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
