/// @description Insert description here
// You can write your code in this editor
scr_global_var();
has_save = scr_load_game();

if (!global.window_initialized){
    window_set_size(1440, 960);
    window_center();
    display_set_gui_size(1440, 960);
    global.window_initialized = true;
}

fade_alpha = 1;
fade_speed = 0.03;

confirm_new_game_open = false;

btn_continue_y = 480;
btn_new_game_y = has_save ? 620 : 480;
btn_quit_y = has_save ? 760 : 620;