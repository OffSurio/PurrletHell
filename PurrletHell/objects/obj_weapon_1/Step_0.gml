/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_player)){
    var _dir = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
    image_angle = _dir;

    // Posiciona a arma grudada no player, deslocada na direção da mira
    x = obj_player.x + lengthdir_x(offset, _dir);
    y = obj_player.y + lengthdir_y(offset, _dir);

    // Cadência automática
    fire_timer++;
    if (fire_timer >= global.fire_rate){
        fire_timer = 0;
        var _proj = instance_create_layer(x, y, "Instances", obj_projectile);
        _proj.direction = _dir;
        _proj.speed = 8;
        _proj.image_angle = _dir;
    }
}