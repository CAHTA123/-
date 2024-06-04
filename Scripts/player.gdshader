shader_type canvas_item;

uniform sampler2D mask_texture;
uniform vec2 mask_position;
uniform sampler2D sprite_texture; 

void fragment() {
    vec2 mask_uv = UV - mask_position; 
    vec4 mask_color = texture(mask_texture, mask_uv).rgba;
    vec4 sprite_color = texture(sprite_texture, UV).rgba; 
	sprite_color.a *= mask_color.a;
    COLOR = sprite_color;
}
