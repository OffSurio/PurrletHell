/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
lifetime--;
if (lifetime <= 0){
    instance_destroy();
    exit;
}

if (instance_exists(obj_player)){
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (_dist <= radius && !obj_player.is_dashing){
        damage_timer++;
        if (damage_timer >= damage_interval){
            damage_timer = 0;
			scr_player_take_damage(damage_per_tick);
        }
    }else{
        damage_timer = 0;
    }
}