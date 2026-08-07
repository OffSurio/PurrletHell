/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
if (instance_exists(obj_player)){
    var _dir = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
    image_angle = _dir;

    x = obj_player.x + lengthdir_x(offset, _dir);
    y = obj_player.y + lengthdir_y(offset, _dir);

    var _true_form = global.weapon_pistol_true_form;
    var _fire_rate = _true_form ? true_fire_rate : global.fire_rate;

    fire_timer++;
    if (fire_timer >= _fire_rate){
        fire_timer = 0;
        var _proj = instance_create_layer(x, y, "Instances", obj_projectile);
        _proj.direction = _dir;
        _proj.speed = 8.5;
        _proj.image_angle = _dir;
        _proj.damage = _true_form ? true_damage : base_damage;
        _proj.max_bounces = _true_form ? 2 : 0;
    }
}