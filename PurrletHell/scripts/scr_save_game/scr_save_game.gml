// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_save_game(){
    var _data = {
        coins: global.coins,
        wave_record: global.wave_record,
        tutorial_seen: global.tutorial_dialogue_seen,

        weapon_pistol_unlocked: global.weapon_pistol_unlocked,
        weapon_laser_unlocked: global.weapon_laser_unlocked,
        weapon_claws_unlocked: global.weapon_claws_unlocked,
        weapon_pistol_true_form: global.weapon_pistol_true_form,
        weapon_laser_true_form: global.weapon_laser_true_form,
        weapon_claws_true_form: global.weapon_claws_true_form,

        skill_atk_explode: global.skill_atk_explode,
        skill_atk_speed7: global.skill_atk_speed7,
        skill_atk_dash_dmg: global.skill_atk_dash_dmg,
        skill_atk_speed10: global.skill_atk_speed10,
        skill_atk_dmg1: global.skill_atk_dmg1,
        skill_atk_dmg2: global.skill_atk_dmg2,
        skill_hp_1: global.skill_hp_1,
        skill_hp_2: global.skill_hp_2,
        skill_hp_3: global.skill_hp_3,
        skill_hp_4: global.skill_hp_4,
        skill_sau_stamina1: global.skill_sau_stamina1,
        skill_sau_regen: global.skill_sau_regen,
        skill_sau_time: global.skill_sau_time,
        skill_sau_stamina2: global.skill_sau_stamina2,
        skill_esp_heart: global.skill_esp_heart,
        skill_esp_coin1: global.skill_esp_coin1,
        skill_esp_extra_coins: global.skill_esp_extra_coins,
        skill_esp_coin2: global.skill_esp_coin2,
        skill_esp_range1: global.skill_esp_range1,
        skill_esp_range2: global.skill_esp_range2,

        vida_max: global.vida_max,
        stamina_max: global.stamina_max,
        stamina_regen_rate: global.stamina_regen_rate,
        wave_time_bonus: global.wave_time_bonus,
        coin_bonus_flat: global.coin_bonus_flat,
        coin_pickup_range_bonus: global.coin_pickup_range_bonus,
        coin_drop_chance: global.coin_drop_chance,

        equipped_weapon_key: scr_get_weapon_key(global.equipped_weapon)
    };

    var _json = json_stringify(_data);
    var _buffer = buffer_create(string_byte_length(_json) + 1, buffer_grow, 1);
    buffer_write(_buffer, buffer_text, _json);

    var _encoded = buffer_base64_encode(_buffer, 0, buffer_get_size(_buffer));
    buffer_delete(_buffer);

    var _file = file_text_open_write("purrlethell_save.dat");
    file_text_write_string(_file, _encoded);
    file_text_close(_file);
}