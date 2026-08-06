// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_process_burn(){
    if (burn_active){
        burn_tick_timer--;
        if (burn_tick_timer <= 0){
            hp -= burn_damage_per_tick;
            burn_ticks_remaining--;
            burn_tick_timer = 40;

            if (burn_ticks_remaining <= 0){
                burn_active = false;
            }

            if (hp <= 0){
                if (random(1) <= global.coin_drop_chance){
                    var _amount = irandom_range(coin_value_min, coin_value_max);
                    var _coin = instance_create_layer(x, y, "Instances", obj_coin);
                    _coin.value = _amount;
                }
                instance_destroy();
            }
        }
    }
}