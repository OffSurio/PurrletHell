// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_big_button(_text, _cx, _cy, _base_w, _base_h){
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _half_w = _base_w / 2;
    var _half_h = _base_h / 2;
    var _hover = (_mx >= _cx - _half_w && _mx <= _cx + _half_w &&
                  _my >= _cy - _half_h && _my <= _cy + _half_h);

    var _scale = _hover ? 1.08 : 1.0;
    var _w = _base_w * _scale;
    var _h = _base_h * _scale;

    draw_set_color(_hover ? make_color_rgb(255, 215, 0) : c_white);
    draw_roundrect_ext(_cx - _w/2, _cy - _h/2, _cx + _w/2, _cy + _h/2, 16, 16, false);
	
	draw_set_font(fnt_menu);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);
    draw_text_transformed(_cx, _cy, _text, _scale * 1.1, _scale * 1.1, 0);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
	draw_set_font(-1);

    return (_hover && mouse_check_button_pressed(mb_left));
}