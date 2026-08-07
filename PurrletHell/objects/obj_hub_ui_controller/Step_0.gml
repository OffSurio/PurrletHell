/// @description Insert description here
// You can write your code in this editor
if (ignore_close_timer > 0) ignore_close_timer--;

if (ignore_close_timer <= 0){
    if ((current_panel == "skill_tree" || current_panel == "shop") && keyboard_check_pressed(ord("E"))){
        close_panel();
    }
}