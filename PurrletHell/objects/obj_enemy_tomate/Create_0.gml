/// @description Insert description here
// You can write your code in this editor
event_inherited();
coin_value_min = 8;
coin_value_max = 14;
hp_max = 40; //vida média
hp = hp_max;
move_speed = 0.9; //lenta

attack_range = 240; // distância pra parar e começar a carregar
resume_chase_range = 280;

state = "chase"; 

// Carregamento
charge_duration = 70;
charge_timer = 0;
shake_amount = 3;
base_x = x;
base_y = y;

target_x = 0;
target_y = 0;

// Cooldown depois de lançar
attack_cooldown_duration = 100; // cadencia de tiro
attack_cooldown_timer = 0;