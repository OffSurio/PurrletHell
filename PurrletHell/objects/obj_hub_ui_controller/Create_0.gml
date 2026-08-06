/// @description Insert description here
// You can write your code in this editor
current_panel = "none"; //
ignore_close_timer = 0;

function open_panel(_panel){
    current_panel = _panel;
    ignore_close_timer = 5;
}

function close_panel(){
    current_panel = "none";
}

function draw_close_button(_gui_w, _gui_h) {
    var _bx = _gui_w - 40;
    var _by = 40;
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    draw_sprite(spr_close_x, 0, _bx, _by);

    var _half_w = sprite_get_width(spr_close_x) / 2;
    var _half_h = sprite_get_height(spr_close_x) / 2;
    var _padding = 6;

    var _hover = (_mx >= _bx - _half_w - _padding && _mx <= _bx + _half_w + _padding &&
                  _my >= _by - _half_h - _padding && _my <= _by + _half_h + _padding);

    if (_hover && mouse_check_button_pressed(mb_left)) {
        close_panel();
    }
}