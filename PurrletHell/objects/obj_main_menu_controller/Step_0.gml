/// @description Insert description here
// You can write your code in this editor
if (fade_alpha > 0) fade_alpha -= fade_speed;

if (confirm_new_game_open && keyboard_check_pressed(vk_escape)){
    confirm_new_game_open = false;
}

if (keyboard_check_pressed(vk_f5)){
    if (file_exists("purrlethell_save.dat")){
        file_delete("purrlethell_save.dat");
    }
    scr_global_var();
    has_save = false;
    show_debug_message("Save apagado");
}