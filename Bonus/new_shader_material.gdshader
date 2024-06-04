shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

void fragment() {
    vec2 uv = UV;
    vec4 blur_color = vec4(0.0);
    const int radius = 20; // уменьшен радиус для начала

    vec2 tex_size = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 pixel_size = vec2(1.0) / tex_size;

    for (int x = -radius; x <= radius; x++) {
        for (int y = -radius; y <= radius; y++) {
            vec2 offset = vec2(float(x), float(y)) * pixel_size;
            blur_color += texture(SCREEN_TEXTURE, uv + offset);
        }
    }

    blur_color /= float((radius * 2 + 1) * (radius * 2 + 1));
    COLOR = blur_color;
}
