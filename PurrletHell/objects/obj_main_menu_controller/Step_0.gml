/// @description Insert description here
// You can write your code in this editor
if (fade_alpha > 0) fade_alpha -= fade_speed;

if (confirm_new_game_open && keyboard_check_pressed(vk_escape)){
    confirm_new_game_open = false;
}