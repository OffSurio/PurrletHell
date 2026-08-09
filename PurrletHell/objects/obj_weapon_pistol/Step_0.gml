/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
if (instance_exists(obj_player)){
    var _dir = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
	image_angle = _dir;

	image_xscale = weapon_scale;
	image_yscale = (_dir > 90 && _dir < 270) ? -weapon_scale : weapon_scale;

	x = obj_player.x + lengthdir_x(offset, _dir);
	y = obj_player.y + lengthdir_y(offset, _dir);
    x = obj_player.x + lengthdir_x(offset, _dir);
    y = obj_player.y + lengthdir_y(offset, _dir);

    var _true_form = global.weapon_pistol_true_form;
    var _fire_rate = _true_form ? true_fire_rate : global.fire_rate;
	if (global.fire_rate_boost_active) _fire_rate = round(_fire_rate * 0.2);

    fire_timer++;
    if (fire_timer >= _fire_rate){
		fire_timer = 0;
		scr_play_sound(snd_player_gun, VOL_PLAYER_GUN);
		var _proj = instance_create_layer(x, y, "Instances", obj_projectile);
		_proj.direction = _dir;
		_proj.speed = 8.5;
		_proj.image_angle = _dir;
		_proj.damage = (_true_form ? true_damage : base_damage) * scr_get_damage_multiplier();
		_proj.max_bounces = _true_form ? 2 : 0;
		_proj.lifetime = _true_form ? proj_lifetime_true : proj_lifetime;
}
}