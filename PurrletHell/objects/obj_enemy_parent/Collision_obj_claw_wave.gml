/// @description Insert description here
// You can write your code in this editor
if (ds_list_find_index(other.hit_list, id) == -1){
    ds_list_add(other.hit_list, id); // marca esse inimigo como já atingido por essa onda

    hp -= other.damage;

    var _dir = point_direction(other.x, other.y, x, y);
	var _new_x = x + lengthdir_x(other.knockback_force, _dir);
	var _new_y = y + lengthdir_y(other.knockback_force, _dir);

	if (!place_meeting(_new_x, y, obj_wall)) x = _new_x;
	if (!place_meeting(x, _new_y, obj_wall)) y = _new_y;;

    if (hp <= 0){
        if (random(1) <= global.coin_drop_chance){
            var _amount = irandom_range(coin_value_min, coin_value_max);
            var _coin = instance_create_layer(x, y, "Instances", obj_coin);
            _coin.value = _amount;
        }
        instance_destroy();
    }
}