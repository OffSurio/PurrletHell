/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) {
    if (speed != 0) {
        saved_speed = speed;
        speed = 0;
    }
    exit;
}

if (saved_speed != 0) {
    speed = saved_speed;
    saved_speed = 0;
}
lifetime--;
if (lifetime <= 0) instance_destroy();

if (x < 0 || x > room_width || y < 0 || y > room_height) instance_destroy();