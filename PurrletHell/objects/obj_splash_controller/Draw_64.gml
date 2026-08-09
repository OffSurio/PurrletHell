/// @description Insert description here
// You can write your code in this editor
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_set_color(c_black);
draw_rectangle(0, 0, _gui_w, _gui_h, false);

if (current_image < array_length(splash_images)){
    draw_set_alpha(alpha);
    draw_sprite_ext(splash_images[current_image], 0, _gui_w/2, _gui_h/2, 1, 1, 0, c_white, 1);
    draw_set_alpha(1);
}

if (entry_fade_alpha > 0){
    draw_set_alpha(entry_fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1);
}