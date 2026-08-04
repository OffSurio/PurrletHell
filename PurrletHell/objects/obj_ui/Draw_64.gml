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

//Desenhar numero da Wave atual.
if (instance_exists(obj_wave_controller)) {
    draw_set_font(-1);
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(gui_w - 20, 20, "Wave: " + string(obj_wave_controller.wave_number));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}