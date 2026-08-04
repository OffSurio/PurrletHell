/// @description Insert description here
// You can write your code in this editor
travel_timer++;
var _progress = clamp(travel_timer / travel_time, 0, 1);

// posição horizontal
x = lerp(start_x, target_x, _progress);
y = lerp(start_y, target_y, _progress);

// altura simulada (parábola)
var _height = 4 * peak_height * _progress * (1 - _progress);
draw_offset_y = -_height;

// escala leve enquanto sobe
image_xscale = 1 + (_height / peak_height) * 0.3;
image_yscale = image_xscale;

if (_progress >= 1) {
    instance_create_layer(target_x, target_y, "Instances", obj_tomato_puddle);
    instance_destroy();
}