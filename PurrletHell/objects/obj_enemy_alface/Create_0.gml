/// @description Insert description here
// You can write your code in this editor
event_inherited(); // pega variaveis do parent
randomize();
coin_value_min = 3;
coin_value_max = 8;
hp_max = 30; // vida baixa
hp = hp_max;
move_speed = 1.3; // velocidade média

attack_range = 280; // distância pra parar e atirar
resume_chase_range = 320; // voltar a perseguir

state = "chase";

// Configuração da rajada
burst_shots_total = 0;
burst_shots_fired = 0;
burst_shot_delay = 22; // frames entre cada tiro da rajada
burst_cooldown = 65; // frames de espera depois da rajada acabar
burst_timer = 0;