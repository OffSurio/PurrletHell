/// @description Insert description here
// You can write your code in this editor
window_set_size(1440, 960);
window_center();
display_set_gui_size(1440, 960);
global.window_initialized = true;


splash_images = [spr_splash_name, spr_splash_jam];
current_image = 0;

entry_fade_alpha = 1;

fade_state = "in";
alpha = 0;
fade_speed = 0.1;
hold_duration = 60;
hold_timer = 0;