/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_shop);

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_sprite_stretched(spr_menu_background, 0, 0, 0, _gui_w, _gui_h);

if (!confirm_new_game_open){
    if (has_save){
        if (scr_draw_big_button("Continuar", _gui_w/2, btn_continue_y, 320, 90)){
            room_goto(rm_hub);
        }
    }

    if (scr_draw_big_button("Novo Jogo", _gui_w/2, btn_new_game_y, 320, 90)){
		if (has_save){
			confirm_new_game_open = true;
		}else{
			scr_global_var();
			scr_save_game();
			room_goto(rm_hub);
		}
	}
	if (scr_draw_big_button("Sair do Jogo", _gui_w/2, btn_quit_y, 320, 90)){
		game_end();
	}
}else{
    var _panel_w = 840;
	var _panel_h = 560;
	var _panel_x = (_gui_w - _panel_w) / 2;
	var _panel_y = (_gui_h - _panel_h) / 2;

	draw_sprite_stretched(spr_panel_confirm_bg, 0, _panel_x, _panel_y, _panel_w, _panel_h);

	var _text_y = _panel_y + (_panel_h * PANEL_TEXT_Y_PCT);
	var _button_y = _panel_y + (_panel_h * PANEL_BUTTON_Y_PCT);

	draw_set_font(fnt_pause);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_black);
	draw_text_ext(_gui_w/2, _text_y, "Tem certeza que deseja iniciar um novo jogo?\nTodos os dados serão perdidos.", 45, _panel_w - 180);
	draw_set_color(c_white);
	draw_set_font(-1);

	if (scr_draw_menu_button("SIM", _gui_w/2 - 120, _button_y)){
	    scr_global_var();
	    scr_save_game();
	    room_goto(rm_hub);
	}
	if (scr_draw_menu_button("NÃO", _gui_w/2 + 120, _button_y)){
	    confirm_new_game_open = false;
	}

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

if (fade_alpha > 0){
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1);
}
draw_set_font(-1);