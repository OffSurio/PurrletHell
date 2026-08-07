/// @description Insert description here
// You can write your code in this editor
if (keyboard_check_pressed(vk_escape)) {
    var _hub_panel_open = instance_exists(obj_hub_ui_controller) && obj_hub_ui_controller.current_panel != "none";
    var _dialogue_open = instance_exists(obj_dialogue_controller) && obj_dialogue_controller.dialogue_active;

    if (_hub_panel_open){
        obj_hub_ui_controller.close_panel();
    }
    else if (_dialogue_open){
	//faz nada nao
    }
    else if (global.game_paused){
        if (!pause_confirm_open) close_pause();
    }
    else {
        open_pause();
    }
}