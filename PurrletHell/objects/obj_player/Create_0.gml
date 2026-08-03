/// @description Insert description here
// You can write your code in this editor

// Estamina
stamina_max = 100;
stamina = stamina_max;
stamina_regen_rate = 0.4;
stamina_drain_sprint = 0.5;
stamina_dash_cost = 25;
stamina_exhausted = false;   // true quando zera; só libera de novo ao encher 100%
stamina_visible_timer = 0;

// Movimento
move_speed_walk = 3;
move_speed_sprint = 5;
hsp = 0;
vsp = 0;

// Dash
is_dashing = false;
dash_timer = 0;
dash_duration = 12;
dash_speed = 10;
dash_direction = 0;
dash_trail_timer = 0;

