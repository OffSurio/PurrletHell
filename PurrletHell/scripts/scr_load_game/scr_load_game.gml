// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_load_game(){
    if (!file_exists("purrlethell_save.dat")) return false;

    var _file = file_text_open_read("purrlethell_save.dat");
    var _encoded = file_text_read_string(_file);
    file_text_close(_file);

    var _buffer = buffer_base64_decode(_encoded);
    var _json = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);

    var _data = json_parse(_json);

    global.coins = _data.coins;
    global.wave_record = _data.wave_record;
    global.tutorial_dialogue_seen = _data.tutorial_seen;

    global.weapon_pistol_unlocked = _data.weapon_pistol_unlocked;
    global.weapon_laser_unlocked = _data.weapon_laser_unlocked;
    global.weapon_claws_unlocked = _data.weapon_claws_unlocked;
    global.weapon_pistol_true_form = _data.weapon_pistol_true_form;
    global.weapon_laser_true_form = _data.weapon_laser_true_form;
    global.weapon_claws_true_form = _data.weapon_claws_true_form;

    global.skill_atk_explode = _data.skill_atk_explode;
    global.skill_atk_speed7 = _data.skill_atk_speed7;
    global.skill_atk_dash_dmg = _data.skill_atk_dash_dmg;
    global.skill_atk_speed10 = _data.skill_atk_speed10;
    global.skill_atk_dmg1 = _data.skill_atk_dmg1;
    global.skill_atk_dmg2 = _data.skill_atk_dmg2;
    global.skill_hp_1 = _data.skill_hp_1;
    global.skill_hp_2 = _data.skill_hp_2;
    global.skill_hp_3 = _data.skill_hp_3;
    global.skill_hp_4 = _data.skill_hp_4;
    global.skill_sau_stamina1 = _data.skill_sau_stamina1;
    global.skill_sau_regen = _data.skill_sau_regen;
    global.skill_sau_time = _data.skill_sau_time;
    global.skill_sau_stamina2 = _data.skill_sau_stamina2;
    global.skill_esp_heart = _data.skill_esp_heart;
    global.skill_esp_coin1 = _data.skill_esp_coin1;
    global.skill_esp_extra_coins = _data.skill_esp_extra_coins;
    global.skill_esp_coin2 = _data.skill_esp_coin2;
    global.skill_esp_range1 = _data.skill_esp_range1;
    global.skill_esp_range2 = _data.skill_esp_range2;

    global.vida_max = _data.vida_max;
    global.vida = global.vida_max;
    global.stamina_max = _data.stamina_max;
    global.stamina_regen_rate = _data.stamina_regen_rate;
    global.wave_time_bonus = _data.wave_time_bonus;
    global.coin_bonus_flat = _data.coin_bonus_flat;
    global.coin_pickup_range_bonus = _data.coin_pickup_range_bonus;
    global.coin_drop_chance = _data.coin_drop_chance;

    global.equipped_weapon = scr_weapon_key_to_object(_data.equipped_weapon_key);

    return true;
}

function scr_get_weapon_key(_obj){
    if (_obj == obj_weapon_laser) return "laser";
    if (_obj == obj_weapon_claws) return "claws";
    return "pistol";
}

function scr_weapon_key_to_object(_key){
    if (_key == "laser") return obj_weapon_laser;
    if (_key == "claws") return obj_weapon_claws;
    return obj_weapon_pistol;
}