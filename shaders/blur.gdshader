shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_enable, filter_linear_mipmap;

void fragment() {
    COLOR.rgb = textureLod(screen_texture, SCREEN_UV, 4.0).rgb;
}