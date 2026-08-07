// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_burn_overlay(){
    if (burn_active){
        draw_sprite_ext(spr_fire, 0, x, y, 1, 1, 0, c_orange, 0.5);
    }
}