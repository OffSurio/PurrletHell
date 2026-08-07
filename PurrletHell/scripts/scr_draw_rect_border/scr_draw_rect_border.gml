// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_rect_border(_x1, _y1, _x2, _y2, _thickness){
    draw_line_width(_x1, _y1, _x2, _y1, _thickness); // topo
    draw_line_width(_x1, _y2, _x2, _y2, _thickness); // baixo
    draw_line_width(_x1, _y1, _x1, _y2, _thickness); // esquerda
    draw_line_width(_x2, _y1, _x2, _y2, _thickness); // direita
}