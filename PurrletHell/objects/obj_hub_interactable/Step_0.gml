/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
if (instance_exists(obj_hub_player) && instance_exists(obj_hub_ui_controller)){
    var _dist = point_distance(x, y, obj_hub_player.x, obj_hub_player.y);
    player_in_range = (_dist <= interact_range) && (obj_hub_ui_controller.current_panel == "none");

    if (player_in_range && keyboard_check_pressed(ord("E"))){
        obj_hub_ui_controller.open_panel(panel_to_open);
    }
}