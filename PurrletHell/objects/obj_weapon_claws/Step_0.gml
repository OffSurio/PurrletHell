/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
if (instance_exists(obj_player)){
    var _dir = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
    image_angle = _dir;

    x = obj_player.x + lengthdir_x(offset, _dir);
    y = obj_player.y + lengthdir_y(offset, _dir);

    fire_timer++;
    if (fire_timer >= fire_rate){
		fire_timer = 0;
		var _true_form = global.weapon_claws_true_form;
		var _dmg = _true_form ? claw_damage_true : claw_damage;
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