/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;

var _base_fire_rate = global.weapon_laser_true_form ? fire_rate_true : 65;
fire_rate = global.fire_rate_boost_active ? round(_base_fire_rate * 0.5) : _base_fire_rate;

if (instance_exists(obj_player)){
    var _dir = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
    image_angle = _dir;

    x = obj_player.x + lengthdir_x(offset, _dir);
    y = obj_player.y + lengthdir_y(offset, _dir);

    fire_timer++;
    if (fire_timer >= fire_rate){
        fire_timer = 0;
        fire_laser(_dir);
    }
}

function fire_laser_beam(_dir, _dmg, _burn_dmg){
    var _end_x = obj_player.x + lengthdir_x(laser_length, _dir);
    var _end_y = obj_player.y + lengthdir_y(laser_length, _dir);

    var _list = ds_list_create();
    var _count = collision_line_list(obj_player.x, obj_player.y, _end_x, _end_y, obj_enemy_parent, true, true, _list, false);

    for (var i = 0; i < _count; i++){
        with (_list[| i]) {
            hp -= _dmg;
            burn_active = true;
            burn_ticks_remaining = other.burn_tick_count;
            burn_tick_timer = other.burn_tick_interval;
            burn_damage_per_tick = _burn_dmg;

            if (hp <= 0) {
				scr_on_enemy_death();
			}
        }
    }
    ds_list_destroy(_list);

    var _beam = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_laser_beam);
    _beam.end_x = _end_x;
    _beam.end_y = _end_y;
}

function fire_laser(_dir){
    var _true_form = global.weapon_laser_true_form;
    var _dmg = (_true_form ? laser_damage_true : laser_damage) * scr_get_damage_multiplier();
    var _burn_dmg = _true_form ? burn_damage_per_tick_true : burn_damage_per_tick;

    fire_laser_beam(_dir, _dmg, _burn_dmg);
    if (_true_form) fire_laser_beam(_dir + 180, _dmg, _burn_dmg); // segundo feixe pro lado oposto
}