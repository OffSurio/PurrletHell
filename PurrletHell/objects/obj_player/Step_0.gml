/// @description Insert description here
// You can write your code in this editor
// input (WASD ou setas)
var _left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

var _input_h = _right - _left;
var _input_v = _down - _up;
var _len = point_distance(0, 0, _input_h, _input_v);

var _moving = (_len > 0);
var _norm_h = 0, _norm_v = 0;
if (_moving){
    _norm_h = _input_h / _len;
    _norm_v = _input_v / _len;
}

//Dash
if (!is_dashing && keyboard_check_pressed(vk_space) && stamina >= stamina_dash_cost && !stamina_exhausted){
    is_dashing = true;
    dash_timer = 0;
    stamina -= stamina_dash_cost;
    if (stamina <= 0) { stamina = 0; stamina_exhausted = true;}

    dash_direction = _moving ? point_direction(0, 0, _norm_h, _norm_v) : image_angle;
}

if (is_dashing){
    dash_timer++;
    var _dx = lengthdir_x(dash_speed, dash_direction);
    var _dy = lengthdir_y(dash_speed, dash_direction);

    if (!place_meeting(x + _dx, y, obj_wall)) x += _dx;
    if (!place_meeting(x, y + _dy, obj_wall)) y += _dy;

    dash_trail_timer++;
    if (dash_trail_timer >= 2){
        dash_trail_timer = 0;
        var _trail = instance_create_layer(x, y, "Instances", obj_dash_trail);
        _trail.sprite_index = sprite_index;
        _trail.image_index  = image_index;
        _trail.image_angle  = image_angle;
        _trail.image_xscale = image_xscale;
        _trail.image_yscale = image_yscale;
        _trail.depth = depth + 1; // desenha atrás do player
    }

    if (dash_timer >= dash_duration) is_dashing = false;

}else{
    //Movimento normal/sprint
    var _sprinting = keyboard_check(vk_shift) && _moving && stamina > 0 && !stamina_exhausted;
    var _speed = _sprinting ? move_speed_sprint : move_speed_walk;

    hsp = _norm_h * _speed;
    vsp = _norm_v * _speed;
	
	//colisao no eixo X
    if (!place_meeting(x + hsp, y, obj_wall)){
        x += hsp;
    }else{
        while (!place_meeting(x + sign(hsp), y, obj_wall)) x += sign(hsp);
    } //colisao no eixo y
    if (!place_meeting(x, y + vsp, obj_wall)){
        y += vsp;
    }else{
        while (!place_meeting(x, y + sign(vsp), obj_wall)) y += sign(vsp);
    }

    if (_sprinting){
        stamina -= stamina_drain_sprint;
        if (stamina <= 0) { stamina = 0; stamina_exhausted = true;}
    }
}

//Regeneração
var _using_stamina = is_dashing || (keyboard_check(vk_shift) && _moving && !stamina_exhausted && stamina > 0);

if (!_using_stamina && stamina < stamina_max) {
    stamina += stamina_regen_rate;
    if (stamina >= stamina_max) {
        stamina = stamina_max;
        stamina_exhausted = false; //libera de novo ao encher 100%
    }
}

//Visibilidade do anel
if (_using_stamina || stamina < stamina_max){
    stamina_visible_timer = 30; // fica visível meio segundo depois de soltar
}else if (stamina_visible_timer > 0){
    stamina_visible_timer--;
}
