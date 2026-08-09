/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
if (instance_exists(obj_player)){
    var _dir = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);

image_angle = 0;
if (mouse_x < obj_player.x){
    image_xscale = -1;
    x = obj_player.x - offset;
}else{
    image_xscale = 1;
    x = obj_player.x + offset;
}
y = obj_player.y;

    var _fire_rate = fire_rate;
	if (global.fire_rate_boost_active) _fire_rate = round(_fire_rate * 0.5);

	fire_timer++;
	if (fire_timer >= _fire_rate){
		fire_timer = 0;
		var _true_form = global.weapon_claws_true_form;
		var _dmg = (_true_form ? claw_damage_true : claw_damage) * scr_get_damage_multiplier();
		var _kb = _true_form ? claw_knockback_true : claw_knockback;
		var _life = _true_form ? claw_lifetime_true : claw_lifetime;

    if (_true_form){
		create_claw_wave(_dir, _dmg, _kb, _life);
		create_claw_wave(_dir - claw_cone_spread, _dmg, _kb, _life);
		create_claw_wave(_dir + claw_cone_spread, _dmg, _kb, _life);
	}else{
		create_claw_wave(_dir, _dmg, _kb, _life);
		}
	}

function create_claw_wave(_wave_dir, _dmg, _kb, _life){
    var _wave = instance_create_layer(x, y, "Instances", obj_claw_wave);
    _wave.direction = _wave_dir;
    _wave.speed = claw_speed;
    _wave.image_angle = _wave_dir;
    _wave.damage = _dmg;
    _wave.knockback_force = _kb;
    _wave.lifetime = _life;
	}
}