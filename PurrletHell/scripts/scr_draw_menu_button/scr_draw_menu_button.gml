// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_menu_button(_text, _x, _y){
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _text_w = string_width(_text);
    var _text_h = string_height(_text);
    var _hover = (_mx >= _x - _text_w/2 - 10 && _mx <= _x + _text_w/2 + 10 &&
                  _my >= _y - _text_h/2 - 6  && _my <= _y + _text_h/2 + 6);

    var _scale = _hover ? 1.15 : 1.0;

	draw_set_font(fnt_pause);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(_hover ? make_color_rgb(255, 140, 0) : c_black);
    draw_text_transformed(_x, _y, _text, _scale, _scale, 0);
    draw_set_color(c_white);
	draw_set_font(-1);

    if (_hover && mouse_check_button_pressed(mb_left)) {
		scr_play_sound(snd_button, VOL_BUTTON, 1.3);
		return true;
	}
	return false;
}