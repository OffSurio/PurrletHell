/// @description Insert description here
// You can write your code in this editor
draw_self();

if (state == "dash_charge"){
    var _length, _col;

    if (dash_charge_timer <= dash_charge_grow){
        var _pct = dash_charge_timer / dash_charge_grow;
        _length = lerp(20, dash_visual_length, _pct);

        if (_pct < 0.5) {
            _col = merge_color(c_white, c_orange, _pct * 2);
        }else{
            _col = merge_color(c_orange, c_red, (_pct - 0.5) * 2);
        }
    }else{
        _length = dash_visual_length; // segura no máximo durante o "hold" vermelho
        _col = c_red;
    }

    var _end_x = x + lengthdir_x(_length, dash_direction);
    var _end_y = y + lengthdir_y(_length, dash_direction);

    draw_set_alpha(0.7);
    draw_set_color(_col);
    draw_line_width(x, y, _end_x, _end_y, 6);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
if (state == "melee_attack" && melee_timer > melee_windup){
    var _spin_progress = (melee_timer - melee_windup) / spin_duration;
    var _sweep_angle = _spin_progress * 360;
	
	//area preenchida
	draw_set_alpha(0.15);
	draw_set_colour(c_red);
	
	var _fill_segments = 40;
	draw_primitive_begin(pr_trianglefan);
	draw_vertex(x,y);
	for (var i = 0; i <= _fill_segments; i++){
		var _ang = (i / _fill_segments) * _sweep_angle;
		draw_vertex(x + lengthdir_x(melee_hit_radius, _ang), y + lengthdir_y(melee_hit_radius, _ang));
	}
	draw_primitive_end();
	
	//configuração do ring
    draw_set_alpha(0.6);
    draw_set_color(c_red);
    
	var _thickness = 10;
	var _inner_r = melee_hit_radius - (_thickness / 2);
	var _outer_r = melee_hit_radius + (_thickness / 2);
	
	var _segments = 40;
	var _start_angle = 0;
	
	//desenhando o arco
	draw_primitive_begin(pr_trianglestrip);
	for (var i = 0; i <= _segments; i++){
		var _ang = _start_angle + (i / _segments) * _sweep_angle;
		
		draw_vertex(x + lengthdir_x(_inner_r, _ang), y + lengthdir_y(_inner_r, _ang));
		draw_vertex(x + lengthdir_x(_outer_r, _ang), y + lengthdir_y(_outer_r, _ang));
	}
	draw_primitive_end();
	
	//ponteiro
	draw_set_alpha(0.9);
	
	var _end_x = x + lengthdir_x(melee_hit_radius, _sweep_angle);
	var _end_y = y + lengthdir_y(melee_hit_radius, _sweep_angle);
	draw_line_width(x,y, _end_x, _end_y, 4);

    draw_set_alpha(1);
    draw_set_color(c_white);
}
scr_draw_burn_overlay();