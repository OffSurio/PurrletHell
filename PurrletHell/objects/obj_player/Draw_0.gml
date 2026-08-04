/// @description Insert description here
// You can write your code in this editor
if (invuln_timer > 0 && (invuln_timer div 4) % 2 == 0){
    // pisca a cada 4 frames enquanto imune
}else{
    draw_self();
}

draw_self();

if (stamina_visible_timer > 0){
    var _pct = stamina / global.stamina_max;
    var _col = c_lime;
    if (_pct <= 0.15)      _col = c_red;
    else if (_pct <= 0.35) _col = c_yellow;

    var _ring_x = x - sprite_width/2 - 15;
    var _ring_y = y - 15;
    var _radius = 10;
    var _thickness = 6;

    scr_draw_ring_gauge(_ring_x, _ring_y, _radius, _thickness, 1, c_black, 0.4); // trilho de fundo
    scr_draw_ring_gauge(_ring_x, _ring_y, _radius, _thickness, _pct, _col, 1); // preenchimento
}