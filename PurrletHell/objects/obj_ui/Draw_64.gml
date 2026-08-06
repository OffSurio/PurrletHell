/// @description Insert description here
// You can write your code in this editor
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var espacamento = 95;
var largura_total = global.vida_max * espacamento;

var cor_x_inicial = (gui_w - largura_total) / 2;
var cor_y = gui_h - 180;

for (var i = 0; i < global.vida_max; i++){
    var x_imagem = cor_x_inicial + (i * espacamento);

    draw_sprite_ext(spr_heart, 0, x_imagem, cor_y,1.5,1.5,1,-1,0.5);

    if (i < global.vida){
       draw_sprite_ext(spr_heart, 0, x_imagem, cor_y,1.5,1.5,1,-1,1);
    }
}

//Desenhar numero da Wave atual + recorde + moedas
if (instance_exists(obj_wave_controller)){
    draw_set_font(-1);
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(gui_w - 20, 20, "Wave: " + string(obj_wave_controller.wave_number));
    draw_text(gui_w - 20, 44, "Record: " + string(global.wave_record));
	draw_text(gui_w - 20, 68, "Coins: " + string(global.coins));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

//timer
if (instance_exists(obj_wave_controller)){
    var _wc = obj_wave_controller;
    var _total_seconds = max(0, ceil(_wc.wave_timer / room_speed));
    var _minutes = _total_seconds div 60;
    var _seconds = _total_seconds mod 60;
    var _time_str = string(_minutes) + ":" + string_format(_seconds, 2, 0);

    var _col;
    if (_wc.wave_timer <= (10 * room_speed)){
        _col = c_red; // últimos 10 segundos
    }else if (_wc.wave_timer > _wc.wave_time_current_base){
        _col = c_aqua; // cor do tempo com bonus
    }else{
        _col = c_white; // normal
    }

    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(_col);
    draw_text(gui_w / 2, 20, _time_str);

    // "+Tempo" piscando em azul
    if (_wc.bonus_flash_timer > 0 && (_wc.bonus_flash_timer div 6) % 2 == 0){
        var _bonus_seconds = ceil(_wc.bonus_flash_amount / room_speed);
        draw_set_color(c_aqua);
        draw_text(gui_w / 2 + 55, 20, "+" + string(_bonus_seconds) + "s");
    }

    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}