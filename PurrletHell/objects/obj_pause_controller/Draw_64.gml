/// @description Insert description here
// You can write your code in this editor
if (!global.game_paused) exit;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// Fundo escurecido 
draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, _gui_w, _gui_h, false);
draw_set_alpha(1);

var _box_w = 600;
var _box_h = (context == "garden") ? 480 : 380;
var _box_x = (_gui_w - _box_w) / 2;
var _box_y = (_gui_h - _box_h) / 2;

draw_sprite_stretched(spr_panel_confirm_bg, 0, _box_x, _box_y, _box_w, _box_h);

if (!pause_confirm_open){
    var _title_y = _box_y + (_box_h * 0.20);

    draw_set_font(fnt_pause);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(_gui_w/2, _title_y, "PAUSADO", 1.2, 1.2, 0);
    draw_set_color(c_white);

    var _btn_start_y = _box_y + (_box_h * 0.42);
    var _btn_spacing = _box_h * 0.20;

    if (scr_draw_menu_button("Continuar", _gui_w/2, _btn_start_y)){
        close_pause();
    }

    if (context == "garden"){
        if (scr_draw_menu_button("Base", _gui_w/2, _btn_start_y + _btn_spacing)){
            pause_confirm_action = "base";
            pause_confirm_open = true;
        }
        if (scr_draw_menu_button("Menu Inicial", _gui_w/2, _btn_start_y + _btn_spacing * 2)){
            pause_confirm_action = "menu";
            pause_confirm_open = true;
        }
    }else{
        if (scr_draw_menu_button("Menu Inicial", _gui_w/2, _btn_start_y + _btn_spacing)){
            pause_confirm_action = "menu";
            pause_confirm_open = true;
        }
    }
}else{
    var _msg = (pause_confirm_action == "base")
        ? "Tem certeza que deseja voltar para a base?"
        : "Tem certeza que deseja ir para o menu?";

    var _text_y = _box_y + (_box_h * PANEL_TEXT_Y_PCT);
    var _button_y = _box_y + (_box_h * PANEL_BUTTON_Y_PCT);

    draw_set_font(fnt_pause);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_black);
    draw_text_ext(_gui_w/2, _text_y, _msg, 40, _box_w - 40);
    draw_set_color(c_white);
    draw_set_font(-1);

    if (scr_draw_menu_button("SIM", _gui_w/2 - 70, _button_y)) {
        if (pause_confirm_action == "base") {
            var _wave_num = instance_exists(obj_wave_controller) ? obj_wave_controller.wave_number : 0;
            if (_wave_num > global.wave_record) global.wave_record = _wave_num;
            close_pause();
            room_goto(rm_hub);
        } else {
            close_pause();
            go_to_main_menu();
        }
    }
    if (scr_draw_menu_button("NÃO", _gui_w/2 + 70, _button_y)) {
        pause_confirm_open = false;
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);