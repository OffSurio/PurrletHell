// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_on_enemy_death(){
	scr_play_sound(snd_enemy_death, VOL_ENEMY_DEATH);
    // Moeda (com bônus de espólio)
    if (random(1) <= global.coin_drop_chance){
        var _amount = irandom_range(coin_value_min, coin_value_max) + global.coin_bonus_flat;
        var _coin = instance_create_layer(x, y, "Instances", obj_coin);
        _coin.value = _amount;
    }

    // Coração (espólio)
    if (variable_global_exists("skill_esp_heart") && global.skill_esp_heart){
        if (random(1) <= 0.08){
            instance_create_layer(x, y, "Instances", obj_heart_pickup);
        }
    }

    // Boost de cadência
    if (variable_global_exists("skill_atk_speed7") && global.skill_atk_speed7){
        global.kill_streak_count++;
        if (global.kill_streak_count >= 15){
            global.kill_streak_count = 0;
            var _duration = (variable_global_exists("skill_atk_speed10") && global.skill_atk_speed10) ? 10 : 7;
            global.fire_rate_boost_active = true;
            global.fire_rate_boost_timer = _duration * room_speed;
        }
    }

    // Explosão em cadeia
    if (global.skill_atk_explode){
    var _dirs = [45, 135, 225, 315]; // diagonais forma um X
    for (var i = 0; i < 4; i++){
        var _shard = instance_create_layer(x, y, "Instances", obj_explosion_shard);
        _shard.direction = _dirs[i];
        _shard.speed = 5;
        _shard.image_angle = _dirs[i];
    }
}

    instance_destroy();
}