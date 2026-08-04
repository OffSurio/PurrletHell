/// @description Insert description here
// You can write your code in this editor
if (!instance_exists(obj_player)) exit;

var _dist = point_distance(x, y, obj_player.x, obj_player.y);
var _dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);

if (obj_player.x < x) { image_xscale = -1; } else { image_xscale = 1; } // muda o lado da sprite

burst_shots_total = irandom_range(1,3);

//Se estiver colidindo com outro inimigo
var _outro = instance_place(x,y,obj_enemy_parent);
if (_outro != noone){
	var _dir = point_direction(_outro.x, _outro.y, x, y);
	
	//move para longe
	x += lengthdir_x(0.5,_dir);
	y += lengthdir_y(0.5, _dir);
}

if (state == "chase"){
    if (_dist <= attack_range){
        state = "attack";
        burst_shots_fired = 0;
        burst_timer = 0;
    }else{
        var _dx = lengthdir_x(move_speed, _dir_to_player);
        var _dy = lengthdir_y(move_speed, _dir_to_player);

        if (!place_meeting(x + _dx, y, obj_wall)) x += _dx;
        if (!place_meeting(x, y + _dy, obj_wall)) y += _dy;
    }
}else if (state == "attack"){
    if (_dist > resume_chase_range){
        state = "chase";
    }else{
        burst_timer++;

        if (burst_shots_fired < burst_shots_total){
            if (burst_timer >= burst_shot_delay){
                burst_timer = 0;
                burst_shots_fired++;

                var _proj = instance_create_layer(x, y, "Instances", obj_enemy_projectile_alface);
                _proj.direction = _dir_to_player;
                _proj.speed = 3;
                _proj.image_angle = _dir_to_player;
            }
        }else if (burst_timer >= burst_cooldown){
            burst_timer = 0;
            burst_shots_fired = 0; // começa nova rajada
        }
    }
}