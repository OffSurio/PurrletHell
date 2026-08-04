/// @description Insert description here
// You can write your code in this editor
if (!instance_exists(obj_player)) exit;

var _dist = point_distance(x, y, obj_player.x, obj_player.y);
var _dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);

var _outro = instance_place(x, y, obj_enemy_parent);
if (_outro != noone){
    if (!is_dashing && !_outro.is_dashing){
        var _dir = point_direction(_outro.x, _outro.y, x, y);

        // move para longe
        x += lengthdir_x(0.5, _dir);
        y += lengthdir_y(0.5, _dir);
    }
}

if (state == "dashing"){
    image_xscale = (lengthdir_x(1, dash_direction) < 0) ? -1 : 1;
}else if (state != "dash_charge"){
    image_xscale = (obj_player.x < x) ? -1 : 1;
}

if (state == "chase"){
    if (_dist <= melee_range){
		state = "melee_attack";
		melee_timer = 0;
		melee_has_hit = false;
		base_x = x;
		base_y = y;
	}else if (_dist <= dash_trigger_range){
        state = "dash_charge";
        dash_charge_timer = 0;
        dash_direction = _dir_to_player;
    }else{
        var _dx = lengthdir_x(move_speed, _dir_to_player);
        var _dy = lengthdir_y(move_speed, _dir_to_player);
        if (!place_meeting(x + _dx, y, obj_wall)) x += _dx;
        if (!place_meeting(x, y + _dy, obj_wall)) y += _dy;
    }
}else if (state == "melee_attack"){
    melee_timer++;

    if (melee_timer <= melee_windup){
 
        x = base_x + random_range(-melee_shake_amount, melee_shake_amount);
        y = base_y + random_range(-melee_shake_amount, melee_shake_amount);
    }else if (melee_timer <= melee_windup + spin_duration){
        // fase do giro
        x = base_x;
        y = base_y;

        if (!melee_has_hit && collision_circle(x, y, melee_hit_radius, obj_player, false, true)){
			scr_player_take_damage(melee_damage);
			melee_has_hit = true;
		}
    }else{
        state = "cooldown";
        attack_cooldown_timer = 0;
    }
}else if (state == "dash_charge"){
    dash_charge_timer++;
    if (dash_charge_timer >= dash_charge_grow + dash_charge_hold){
        state = "dashing";
        dash_timer = 0;
        dash_has_hit = false;
        is_dashing = true;
    }
}else if (state == "dashing"){
    dash_timer++;
    var _dx = lengthdir_x(dash_speed, dash_direction);
    var _dy = lengthdir_y(dash_speed, dash_direction);

    if (!place_meeting(x + _dx, y, obj_wall)) x += _dx;
    if (!place_meeting(x, y + _dy, obj_wall)) y += _dy;

    if (!dash_has_hit && place_meeting(x, y, obj_player)){
        scr_player_take_damage(dash_damage);
        dash_has_hit = true;
    }

    if (dash_timer >= dash_duration){
        is_dashing = false;
        attack_cooldown_timer = 0;
        if (dash_has_hit){
            state = "cooldown";
        }else{
            state = "stunned"; // errou o avanço
            stun_timer = 0;
        }
    }
}else if (state == "stunned"){
    stun_timer++;
    if (stun_timer >= stun_duration){
        state = "chase";
    }
}else if (state == "cooldown"){
    attack_cooldown_timer++;
    if (attack_cooldown_timer >= attack_cooldown_duration){
        state = "chase";
    }
}
show_debug_message("dist: " + string(_dist) + " | melee_range: " + string(melee_range));