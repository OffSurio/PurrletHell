/// @description Insert description here
// You can write your code in this editor
event_inherited();
coin_value_min = 5;
coin_value_max = 15;
hp_max = 60; // vida alta
hp = hp_max;
move_speed = 1.6;

melee_range = 110;  // distância pro ataque giratório
dash_trigger_range = 260; // distância pra carregar o avanço
melee_hit_radius = 85;
melee_damage = 1;

state = "chase"; // chase

// Ataque giratório (curto alcance)
melee_windup = 20;
spin_duration = 24;  // duração do giro
melee_shake_amount = 2;
base_x = x;
base_y = y;

// Carregamento do dash
dash_charge_grow = 40; // frames crescendo
dash_charge_hold = 10; // frames parado
dash_charge_timer = 0;
dash_visual_length = 280;
dash_direction = 0;

// Dash
dash_duration = 28;
dash_speed = 10;
dash_timer = 0;
dash_has_hit = false;
dash_damage = 1;
is_dashing = false; // ignorar colisão com outros inimigos

// Punição de erro
stun_duration = 78;
stun_timer = 0;

// Cadência entre ataques
attack_cooldown_duration = 50;
attack_cooldown_timer = 0;