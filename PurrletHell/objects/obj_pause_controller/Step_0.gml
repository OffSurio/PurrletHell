/// @description Insert description here
// You can write your code in this editor
var _hub_panel_open = instance_exists(obj_hub_ui_controller) && obj_hub_ui_controller.current_panel != "none";

if (!global.game_paused && !_hub_panel_open && keyboard_check_pressed(vk_escape)){
    open_pause();
}
else if (global.game_paused && !pause_confirm_open && keyboard_check_pressed(vk_escape)){
    close_pause();
}