/// @description Insert description here
// You can write your code in this editor
if (!instance_exists(obj_camera)) exit;

var _cam = obj_camera;
var _view_left   = _cam.cam_x + edge_margin;
var _view_top    = _cam.cam_y + edge_margin;
var _view_right  = _cam.cam_x + _cam.cam_width  - edge_margin;
var _view_bottom = _cam.cam_y + _cam.cam_height - edge_margin;

var _show = (blink_timer div 20) % 2 == 0; // liga/desliga o tracker

if (_show){
    with (obj_enemy_parent){
        if (_show){
    var _cam_cx = _cam.cam_x + (_cam.cam_width * 0.5);
    var _cam_cy = _cam.cam_y + (_cam.cam_height * 0.5);

    with (obj_enemy_parent){
        var _offscreen = (x < _view_left || x > _view_right || y < _view_top || y > _view_bottom);

        if (_offscreen){
            var _dist = point_distance(_cam_cx, _cam_cy, x, y);
            var _min_dist = 550;
            var _max_dist = 1400;
            var _amount = clamp((_dist - _min_dist) / (_max_dist - _min_dist), 0, 1);
            var _scale = lerp(1.0, 0.3, _amount);
            var _mx = clamp(x, _view_left, _view_right);
            var _my = clamp(y, _view_top, _view_bottom);
            draw_sprite_ext(spr_offscreen_alert, 0, _mx, _my, _scale, _scale, 0, c_yellow, 0.8);
			}
		}
	}
    }
}