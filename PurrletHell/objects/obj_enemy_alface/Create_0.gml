/// @description Insert description here
// You can write your code in this editor
event_inherited(); // pega variaveis do parent
randomize();
hp_max = 30; // vida baixa
hp = hp_max;
move_speed = 1.4; // velocidade média

attack_range = 300; // distância pra parar e atirar
resume_chase_range = 320; // voltar a perseguir

state = "chase";

// Configuração da rajada
burst_shots_total = 0;
burst_shots_fired = 0;
burst_shot_delay = 20; // frames entre cada tiro da rajada
burst_cooldown = 60; // frames de espera depois da rajada acabar
burst_timer = 0;