/// @description Insert description here
// You can write your code in this editor
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (current_panel == "skill_tree"){
    draw_sprite_stretched(spr_panel_skill_tree_bg, 0, 0, 0, _gui_w, _gui_h);
    draw_close_button(_gui_w, _gui_h);
}else if (current_panel == "shop") {
    draw_sprite_stretched(spr_panel_shop_bg, 0, 0, 0, _gui_w, _gui_h);

    draw_sprite(spr_coin, 0, 70, 70);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text(110, 70, string(global.coins)); // ~40px de respiro entre o ícone e o número

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    shop_hovered_item = -1;

    // Linhas conectando base -> true form
    for (var i = 0; i < array_length(shop_items); i++) {
    var _item = shop_items[i];
    if (_item.requires_var != "") {
        for (var j = 0; j < array_length(shop_items); j++) {
            if (shop_items[j].column == _item.column && shop_items[j].row == 0) {
                var _pos_a = get_shop_item_position(shop_items[j]); // base (embaixo)
                var _pos_b = get_shop_item_position(_item); // true form (em cima)
                var _half = tree_box_size / 2;

                draw_set_color(c_black);
                draw_line_width(_pos_a.x, _pos_a.y - _half, _pos_b.x, _pos_b.y + _half, 3);
                break;
            }
        }
    }
}

    // Quadrados
    for (var i = 0; i < array_length(shop_items); i++) {
        var _item = shop_items[i];
        var _pos = get_shop_item_position(_item);
        var _state = get_shop_item_state(_item);
        var _half = tree_box_size / 2;

        var _hover = (_mx >= _pos.x - _half && _mx <= _pos.x + _half &&
                      _my >= _pos.y - _half && _my <= _pos.y + _half);
        if (_hover) shop_hovered_item = i;

        var _icon_color = c_white;
        var _icon_alpha = 1;
        if (_state == "locked") { _icon_color = c_gray; _icon_alpha = 0.5; }

        draw_sprite_ext(_item.icon_sprite, 0, _pos.x, _pos.y,
            tree_box_size / sprite_get_width(_item.icon_sprite),
            tree_box_size / sprite_get_height(_item.icon_sprite),
            0, _icon_color, _icon_alpha);

        var _border_color = c_gray; // padrão pros bloqueados
		if (_state == "selected")         _border_color = c_lime;
		else if (_state == "purchasable") _border_color = make_color_rgb(255, 215, 0);
		else if (_state == "owned")       _border_color = c_white;

		draw_set_color(_border_color);
		scr_draw_rect_border(_pos.x - _half, _pos.y - _half, _pos.x + _half, _pos.y + _half, 4);

        if (_hover && mouse_check_button_pressed(mb_left)){
			if (_state == "purchasable" && global.coins >= _item.price){
				global.coins -= _item.price;
				variable_global_set(_item.unlocked_var, true);
				global.equipped_weapon = (get_weapon_object_from_key(_item.weapon_key));
			}else if (_state == "owned"){
        global.equipped_weapon = (get_weapon_object_from_key(_item.weapon_key));
		}
	}
}

    // Tooltip
    draw_set_color(c_black);
	draw_set_alpha(0.6);
	draw_line_width(_gui_w/2 - 300, tooltip_divider_y, _gui_w/2 + 300, tooltip_divider_y, 3.5);
	draw_set_alpha(1);

if (shop_hovered_item != -1) {
    var _item = shop_items[shop_hovered_item];
    var _state = get_shop_item_state(_item);
    var _center_x = _gui_w / 2;

    draw_set_font(fnt_shop);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);

    draw_set_color(make_color_rgb(255, 140, 0));
    draw_text(_center_x, tooltip_name_y, _item.name);

    draw_set_color(c_white);
    draw_text_ext(_center_x, tooltip_desc_y, _item.description, -1, 600);

    if (_state == "purchasable" || _state == "locked") {
        var _price_text = string(_item.price);
        var _text_w = string_width(_price_text);
        var _total_w = 40 + 10 + _text_w;
        var _start_x = _center_x - _total_w/2;

        draw_sprite(spr_coin, 0, _start_x + 20, tooltip_price_y);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_color(c_yellow);
        draw_text(_start_x + 50, tooltip_price_y, _price_text);
    }

    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
}

    draw_close_button(_gui_w, _gui_h);
}else if (current_panel == "confirm_door"){
    var _panel_w = 400;
    var _panel_h = 250;
    var _panel_x = (_gui_w - _panel_w) / 2;
    var _panel_y = (_gui_h - _panel_h) / 2;

    draw_sprite_stretched(spr_panel_confirm_bg, 0, _panel_x, _panel_y, _panel_w, _panel_h);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_gui_w/2, _panel_y + 60, "Voce esta pronto pra ir?");

    var _sim_x = _gui_w/2 - 60;
    var _nao_x = _gui_w/2 + 60;
    var _opt_y = _panel_y + 150;

    if (scr_draw_menu_button("SIM", _sim_x, _opt_y)){
		room_goto(Garden);
	}
	if (scr_draw_menu_button("NÃO", _nao_x, _opt_y)){
		close_panel();
	}
    

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
if (current_panel == "none") {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(20, 20, "Moedas: " + string(global.coins));
    draw_text(20, 44, "Recorde: Wave " + string(global.wave_record));
    draw_set_color(c_white);
}