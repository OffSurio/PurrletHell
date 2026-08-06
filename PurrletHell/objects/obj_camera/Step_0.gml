/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
if (instance_exists(obj_player)){
    var _target_x = obj_player.x - cam_width / 2;
    var _target_y = obj_player.y - cam_height / 2;

    // Suaviza o movimento da câmera
    cam_x = lerp(cam_x, _target_x, 0.1);
    cam_y = lerp(cam_y, _target_y, 0.1);

    // Trava a câmera dentro dos limites da room
    cam_x = clamp(cam_x, 0, room_width  - cam_width);
    cam_y = clamp(cam_y, 0, room_height - cam_height);

    camera_set_view_pos(cam, cam_x, cam_y);
}