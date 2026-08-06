/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
// Trava o player se algum painel estiver aberto
if (instance_exists(obj_dialogue_controller) && obj_dialogue_controller.dialogue_active) exit;
if (instance_exists(obj_hub_ui_controller) && obj_hub_ui_controller.current_panel != "none") exit;

var _left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _input_h = _right - _left;

// Horizontal
var _hspd = _input_h * move_speed;
if (!place_meeting(x + _hspd, y, obj_wall)){
    x += _hspd;
} else {
    while (!place_meeting(x + sign(_hspd), y, obj_wall)) x += sign(_hspd);
}

if (_input_h != 0) facing = sign(_input_h);
image_xscale = facing;

// Gravidade
vspd += gravity_force;

// Pulo
if (on_ground && (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W")))){
    vspd = jump_force;
    on_ground = false;
}

// Vertical + colisão com chão
if (!place_meeting(x, y + vspd, obj_wall)){
    y += vspd;
    on_ground = false;
}else{
    while (!place_meeting(x, y + sign(vspd), obj_wall)) y += sign(vspd);
    if (vspd > 0) on_ground = true;
    vspd = 0;
}

// Estado
if (!on_ground){
    state = (vspd < 0) ? "jump" : "fall";
}else if (_input_h != 0){
    state = "walk";
}else{
    state = "idle";
}

// Troca o sprite conforme o estado
switch (state){
    case "idle": sprite_index = spr_hub_player_idle; break;
    case "walk": sprite_index = spr_hub_player_walk; break;
    case "jump": sprite_index = spr_hub_player_jump; break;
    case "fall": sprite_index = spr_hub_player_fall; break;
}