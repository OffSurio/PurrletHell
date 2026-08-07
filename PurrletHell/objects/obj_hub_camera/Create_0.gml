/// @description Insert description here
// You can write your code in this editor
cam_width  = 500;
cam_height = 280;

if (!global.window_initialized) {
    window_set_size(1440, 960);
    window_center();
    display_set_gui_size(1440, 960);
    global.window_initialized = true;
}

cam = camera_create();
camera_set_view_size(cam, cam_width, cam_height);
view_set_camera(0, cam);

cam_x = 0;
cam_y = 0;