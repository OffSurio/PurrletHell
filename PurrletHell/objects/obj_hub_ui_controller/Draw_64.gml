/// @description Insert description here
// You can write your code in this editor
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (current_panel == "skill_tree"){
    draw_sprite_stretched(spr_panel_skill_tree_bg, 0, 0, 0, _gui_w, _gui_h);
    draw_close_button(_gui_w, _gui_h);
}else if (current_panel == "shop"){
    draw_sprite_stretched(spr_panel_shop_bg, 0, 0, 0, _gui_w, _gui_h);
    draw_close_button(_gui_w, _gui_h);
}else if (current_panel == "confirm_door"){
    var _panel_w = 400;
    var _panel_h = 250;
    var _panel_x = (_gui_w - _panel_w) / 2;
    var _panel_y = (_gui_h - _panel_h) / 2;

    draw_sprite_stretched(spr_panel_confirm_bg, 0, _panel_x, _panel_y, _panel_w, _panel_h);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_gui_w/2, _panel_y + 60, "Voce esta pronto pra ir?");

    var _sim_x = _gui_w/2 - 60;
    var _nao_x = _gui_w/2 + 60;
    var _opt_y = _panel_y + 150;

    draw_text(_sim_x, _opt_y, "SIM");
    draw_text(_nao_x, _opt_y, "NAO");

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    if (mouse_check_button_pressed(mb_left)){
        if (point_distance(_mx, _my, _sim_x, _opt_y) <= 30){
            room_goto(Garden);
        }else if (point_distance(_mx, _my, _nao_x, _opt_y) <= 30){
            close_panel();
        }
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
//desenhando record e moeda.
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(20, 20, "Moedas: " + string(global.coins));
draw_text(20, 44, "Recorde: Wave " + string(global.wave_record));
draw_set_color(c_white);