shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D noise;

float wave(vec2 position){
  position += texture(noise, position / 10.0).x * 2.0 - 1.0;
  vec2 wv = 1.0 - abs(sin(position+TIME));
  return pow(1.0 - pow(wv.x * wv.y, 0.65), 4.0);
}

void fragment() {
    vec4 c = textureLod(screen_texture, SCREEN_UV, 0.0);
	if (c.rgb==vec3(60,80,110)){
		COLOR = vec4(1);
	}else COLOR = c;
}