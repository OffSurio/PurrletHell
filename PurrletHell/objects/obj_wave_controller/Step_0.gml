/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
if (!is_game_over && global.vida <= 0){
    is_game_over = true;
    go_to_hub();
    exit;
}

if (wave_announce_active){
    wave_announce_elapsed++;
    if (wave_announce_elapsed >= wave_announce_fade_in + wave_announce_hold + wave_announce_fade_out){
        wave_announce_active = false;
    }
}

if (bonus_flash_timer > 0) bonus_flash_timer--;

if (in_between_waves){
    wave_delay_timer--;
    if (wave_delay_timer <= 0){
        start_next_wave();
    }
}else{
    wave_timer--;

    if (enemies_pending_spawn > 0){
        spawn_timer--;
        if (spawn_timer <= 0){
            spawn_enemy();
            spawn_timer = spawn_interval;
        }
    }

    enemies_alive = instance_number(obj_enemy_parent);

    if (enemies_alive <= 0 && enemies_pending_spawn <= 0){
        bonus_time = max(wave_timer, 0);
        in_between_waves = true;
        wave_delay_timer = 90;
    }else if (wave_timer <= 0){
        bonus_time = 0;
        is_game_over = true;
        go_to_hub();
    }
}