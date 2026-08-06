/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
if (instance_exists(obj_player)) {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (_dist <= pickup_radius) {
        var _dir = point_direction(x, y, obj_player.x, obj_player.y);
        x += lengthdir_x(move_speed, _dir);
        y += lengthdir_y(move_speed, _dir);
    }

    if (_dist <= collect_radius) {
        global.coins += value;
        instance_destroy();
    }
}