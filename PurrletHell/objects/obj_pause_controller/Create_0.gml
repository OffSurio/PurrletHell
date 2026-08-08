/// @description Insert description here
// You can write your code in this editor
pause_confirm_open = false;
pause_confirm_action = ""; // "base" ou "menu"

if (!variable_instance_exists(id, "context")) context = "garden";

function open_pause(){
    if (global.game_paused) exit;
    global.game_paused = true;
    pause_confirm_open = false;
}

function close_pause(){
    global.game_paused = false;
}

function go_to_main_menu(){
	scr_save_game();
    if (asset_get_index("rm_menu_inicial") != -1){
        room_goto(asset_get_index("rm_menu_inicial"));
    }else{
        show_debug_message("nao criei ainda xd");
    }
}