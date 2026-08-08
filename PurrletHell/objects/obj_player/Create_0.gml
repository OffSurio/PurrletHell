/// @description Insert description here
// You can write your code in this editor

// Estamina
stamina = global.stamina_max;
stamina_drain_sprint = 0.4;
stamina_dash_cost = 22;
stamina_exhausted = false;  // true quando zera só libera de novo ao encher 100%
stamina_visible_timer = 0;

// Movimento
move_speed_walk = 2.2;
move_speed_sprint = 4.2;
hsp = 0;
vsp = 0;

// Dash
is_dashing = false;
dash_timer = 0;
dash_duration = 20;
dash_speed = 11;
dash_damage = 15;
dash_direction = 0;
dash_trail_timer = 0;
dash_hit_ids = [];

//imunidade
invuln_timer = 0;
invuln_duration = 40; // imunidade após tomar dano