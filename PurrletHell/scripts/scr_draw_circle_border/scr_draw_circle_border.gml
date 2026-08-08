// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_circle_border(_x, _y, _radius, _thickness) {
    for (var i = 0; i < _thickness; i++) {
        draw_circle(_x, _y, _radius - i, true);
    }
}