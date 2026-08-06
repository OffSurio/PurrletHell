/// @description Insert description here
// You can write your code in this editor
scr_process_burn();
if (!instance_exists(obj_player)) exit;

var _dist = point_distance(x, y, obj_player.x, obj_player.y);
var _dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);

var _outro = instance_place(x,y,obj_enemy_parent);
if (_outro != noone){
	var _dir = point_direction(_outro.x, _outro.y, x, y);
	
	//move para longe
	x += lengthdir_x(0.5,_dir);
	y += lengthdir_y(0.5, _dir);
}

if (state != "charge") {
    if (obj_player.x < x) { image_xscale = -1; } else { image_xscale = 1; } // muda a direçao do sprite
}

if (state == "chase"){
    if (_dist <= attack_range){
        state = "charge";
        charge_timer = 0;
        base_x = x;
        base_y = y;
        target_x = obj_player.x; // lê a posição do player no momento em que começa a carregar
        target_y = obj_player.y;
    }else{
        var _dx = lengthdir_x(move_speed, _dir_to_player);
        var _dy = lengthdir_y(move_speed, _dir_to_player);

        if (!place_meeting(x + _dx, y, obj_wall)) x += _dx;
        if (!place_meeting(x, y + _dy, obj_wall)) y += _dy;
    }
}else if (state == "charge"){
    charge_timer++;

    // shake visual em volta da posição base
    x = base_x + random_range(-shake_amount, shake_amount);
    y = base_y + random_range(-shake_amount, shake_amount);

    if (charge_timer >= charge_duration){
        x = base_x;
        y = base_y;

        var _grenade = instance_create_layer(x, y, "Instances", obj_tomato_grenade);
        _grenade.start_x = x;
        _grenade.start_y = y;
        _grenade.target_x = target_x;
        _grenade.target_y = target_y;

        state = "cooldown";
        attack_cooldown_timer = 0;
    }
}else if (state == "cooldown"){
    attack_cooldown_timer++;
    if (attack_cooldown_timer >= attack_cooldown_duration){
        if (_dist > resume_chase_range){
            state = "chase";
        }else{
            state = "charge";
            charge_timer = 0;
            base_x = x;
            base_y = y;
            target_x = obj_player.x;
            target_y = obj_player.y;
        }
    }
}