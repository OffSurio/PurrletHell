// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_ring_gauge(_x, _y, _radius, _thickness, _pct, _col, _alpha){
    if (_pct <= 0) return;

    var _steps = 32;
    var _n = max(1, ceil(_steps * _pct));

    draw_primitive_begin(pr_trianglestrip);
    for (var i = 0; i <= _n; i++) {
        var _frac = min(i / _steps, _pct);
        var _ang = 90 - (_frac * 360); // começa no topo e sobe no sentido horário

        var _ox = _x + lengthdir_x(_radius, _ang);
        var _oy = _y + lengthdir_y(_radius, _ang);
        var _ix = _x + lengthdir_x(_radius - _thickness, _ang);
        var _iy = _y + lengthdir_y(_radius - _thickness, _ang);

        draw_vertex_color(_ox, _oy, _col, _alpha);
        draw_vertex_color(_ix, _iy, _col, _alpha);
    }
    draw_primitive_end();
}