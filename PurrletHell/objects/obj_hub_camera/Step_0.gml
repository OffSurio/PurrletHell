/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_hub_player)){
    var _target_x = obj_hub_player.x - cam_width / 2;
    var _target_y = obj_hub_player.y - cam_height / 2;

    cam_x = lerp(cam_x, _target_x, 0.1);
    cam_y = lerp(cam_y, _target_y, 0.1);

    cam_x = clamp(cam_x, 0, max(0, room_width  - cam_width));
    cam_y = clamp(cam_y, 0, max(0, room_height - cam_height));

    camera_set_view_pos(cam, cam_x, cam_y);
}