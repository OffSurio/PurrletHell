/// @description Insert description here
// You can write your code in this editor
draw_self();

if (state == "charge"){
    var _pct = charge_timer / charge_duration;
    var _radius = 28;

    draw_set_alpha(0.5);
    draw_set_color(c_red);
    draw_circle(target_x, target_y, _radius * _pct, false); // cresce conforme carrega
}
draw_set_alpha(1);
draw_set_colour(c_white);