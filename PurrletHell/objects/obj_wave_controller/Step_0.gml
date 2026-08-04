/// @description Insert description here
// You can write your code in this editor
if (in_between_waves){
    wave_delay_timer--;
    if (wave_delay_timer <= 0){
        start_next_wave();
    }
}else{
    enemies_alive = instance_number(obj_enemy_parent);

    if (enemies_alive <= 0 && enemies_pending_spawn <= 0){
        in_between_waves = true;
        wave_delay_timer = 90; // 1.5s de respiro entre waves
    }
}