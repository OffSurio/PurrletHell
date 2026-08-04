/// @description Insert description here
// You can write your code in this editor
var _alpha;
var _blink_window = 60; // últimos frames entra no modo "piscando"

if (lifetime > _blink_window){
    _alpha = 1; // visível o tempo todo
}else{
    // pisca ligado/desligado nos últimos instantes
    _alpha = (lifetime div 8) % 2 == 0 ? 1 : 0.15;
}
draw_set_alpha(_alpha);
draw_sprite(spr_tomato_puddle,0,x,y);
draw_set_alpha(1);
draw_set_color(c_white);