// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_apply_skill_effect(_id){
    switch (_id){
        case "hp_1": case "hp_2": case "hp_3": case "hp_4":
            global.vida_max += 1;
            global.vida += 1;
            break;
        case "sau_stamina1": case "sau_stamina2":
            global.stamina_max += 25;
            break;
        case "sau_regen":
            global.stamina_regen_rate += 1;
            break;
        case "sau_time":
            global.wave_time_bonus += 300; // +5s
            break;
        case "esp_coin1": case "esp_coin2":
            global.coin_drop_chance += 0.02;
            break;
        case "esp_extra_coins":
            global.coin_bonus_flat += 2;
            break;
        case "esp_range1": case "esp_range2":
            global.coin_pickup_range_bonus += 2;
            break;
    }
}