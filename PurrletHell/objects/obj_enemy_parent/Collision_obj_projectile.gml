/// @description Insert description here
// You can write your code in this editor
var _already_hit = false;
for (var i = 0; i < array_length(other.hit_ids); i++){
    if (other.hit_ids[i] == id) { _already_hit = true; break; }
}
if (_already_hit) exit;

	array_push(other.hit_ids, id);

	hp -= other.damage;

if (!is_dashing) {
    var _dir = point_direction(other.x, other.y, x, y);
    var _new_x = x + lengthdir_x(10, _dir);
    var _new_y = y + lengthdir_y(10, _dir);
    if (!place_meeting(_new_x, y, obj_wall)) x = _new_x;
    if (!place_meeting(x, _new_y, obj_wall)) y = _new_y;
}

if (hp <= 0){
    scr_on_enemy_death();
}

if (other.max_bounces > 0 && array_length(other.hit_ids) <= other.max_bounces){
    var _target = scr_find_ricochet_target(other.x, other.y, other.hit_ids, other.ricochet_range);
    if (_target != noone) {
        other.direction = point_direction(other.x, other.y, _target.x, _target.y);
        other.image_angle = other.direction;
        exit; // não destrói segue ricocheteando
    }
}

instance_destroy(other);