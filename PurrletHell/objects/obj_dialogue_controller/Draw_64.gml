/// @description Insert description here
// You can write your code in this editor
if (!dialogue_active) exit;

draw_set_font(fnt_dialogue);
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

var _box_w = 900;
var _box_h = 180;
var _box_x = (_gui_w - _box_w) / 2;
var _box_y = _gui_h - _box_h - 40;

draw_sprite_stretched(spr_dialogue_box, 0, _box_x, _box_y, _box_w, _box_h);

// Retrato sobrepondo a caixa, no canto direito
draw_sprite(spr_merchant_portrait, portrait_frame, _box_x + _box_w - 40, _box_y);

draw_set_font(fnt_dialogue);

var _text_x = _box_x + 40;
var _text_y = _box_y + 40;
var _cursor_x = _text_x;
var _cur_y = _text_y;
var _line_height = 38; // ajusta conforme o tamanho da fonte escolhida
var _break_ptr = 1;

for (var i = 0; i < char_index; i++){
    if (_break_ptr < array_length(line_breaks) && i == line_breaks[_break_ptr]) {
        _cursor_x = _text_x;
        _cur_y += _line_height;
        _break_ptr++;
    }

    var _entry = parsed_line[i];
    var _draw_y = _cur_y;

    if (_entry.special || _entry.gold || _entry.green){
		_draw_y += sin((wave_timer * 0.2) + (i * 0.5)) * 2;
	}

    if (_entry.special){
		draw_set_color(make_color_hsv((rainbow_hue + i * 8) mod 255, 255, 255));
	}else if (_entry.gold){
		draw_set_color(make_color_rgb(255, 215, 0));
	}else if (_entry.green){
		draw_set_color(c_lime);
	}else{
		draw_set_color(c_white);
	}

    draw_text(_cursor_x, _draw_y, _entry.char);
    _cursor_x += string_width(_entry.char);

    var _char_h = string_height("A"); // altura de referência da fonte atual

	var _is_last_gold_char = _entry.gold && (i == char_index - 1 || !parsed_line[i+1].gold);
	if (_is_last_gold_char){
		draw_sprite_ext(spr_coin, 0, _cursor_x + icon_reserved_width/2, _draw_y + (_char_h / 2), 0.6, 0.6, 0, c_white, 1);
		_cursor_x += icon_reserved_width;
	}
}

draw_set_color(c_white);

if (line_finished){
    draw_set_halign(fa_left);
    draw_set_color(c_gray);
    draw_text_transformed(_box_x + 20, _box_y + _box_h - 42, "SPACE para continuar", 0.75, 0.75, 0);
    draw_set_color(c_white);
}

draw_set_font(-1);