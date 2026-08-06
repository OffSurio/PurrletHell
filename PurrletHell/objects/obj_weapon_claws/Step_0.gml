/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_player)){
    var _dir = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
    image_angle = _dir;

    x = obj_player.x + lengthdir_x(offset, _dir);
    y = obj_player.y + lengthdir_y(offset, _dir);

    fire_timer++;
    if (fire_timer >= fire_rate){
        fire_timer = 0;

        var _wave = instance_create_layer(x, y, "Instances", obj_claw_wave);
        _wave.direction = _dir;
        _wave.speed = claw_speed;
        _wave.image_angle = _dir;
        _wave.damage = claw_damage;
        _wave.knockback_force = claw_knockback;
        _wave.lifetime = claw_lifetime;
    }
}