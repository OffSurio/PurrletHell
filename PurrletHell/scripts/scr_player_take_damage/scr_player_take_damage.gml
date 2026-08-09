// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_take_damage(_amount){
    if (obj_player.invuln_timer > 0) return; // ainda imune, ignora
	
	scr_play_sound(snd_dmg_hit, VOL_DMG_HIT);
	
    global.vida -= _amount;
    if (global.vida < 0) global.vida = 0;

    obj_player.invuln_timer = obj_player.invuln_duration;
}