/// @description Insert description here
// You can write your code in this editor
cam_width = 780;
cam_height = 540;

cam = camera_create();
camera_set_view_size(cam, cam_width, cam_height);
view_set_camera(0,cam);

cam_x = 0;
cam_y = 0;