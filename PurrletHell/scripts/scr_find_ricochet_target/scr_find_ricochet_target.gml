// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_find_ricochet_target(_x, _y, _hit_ids, _range){
    var _best = noone;
    var _best_dist = infinity;

    with (obj_enemy_parent){
        var _already_hit = false;
        for (var i = 0; i < array_length(_hit_ids); i++){
            if (_hit_ids[i] == id) { _already_hit = true; break; }
        }
        if (!_already_hit){
            var _d = point_distance(_x, _y, x, y);
            if (_d <= _range && _d < _best_dist) { _best_dist = _d; _best = id; }
        }
    }
    return _best;
}