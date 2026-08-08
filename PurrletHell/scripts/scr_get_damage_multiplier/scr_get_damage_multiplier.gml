// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_get_damage_multiplier(){
    var _mult = 1;
    if (variable_global_exists("skill_atk_dmg1") && global.skill_atk_dmg1) _mult += 0.02;
    if (variable_global_exists("skill_atk_dmg2") && global.skill_atk_dmg2) _mult += 0.02;
    return _mult;
}