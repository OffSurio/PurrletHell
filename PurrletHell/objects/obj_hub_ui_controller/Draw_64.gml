/// @description Insert description here
// You can write your code in this editor
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (current_panel == "skill_tree"){ //ARVORE DE HABILIDADE
    draw_sprite_stretched(spr_panel_skill_tree_bg, 0, 0, 0, _gui_w, _gui_h);

    draw_sprite(spr_coin, 0, 70, 70);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(110, 70, string(global.coins), 1.4, 1.4, 0);

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    skill_hovered_item = -1;

    // Linhas em L
    for (var i = 0; i < array_length(skill_items); i++){
    var _item = skill_items[i];
    if (_item.requires != ""){
        var _parent = get_skill_item_by_id(_item.requires);
        if (_parent != noone){
            var _state = get_skill_item_state(_item);
            draw_set_color(get_state_color(_state));

            var _py = get_skill_item_y(_parent);
            var _iy = get_skill_item_y(_item);
            var _r = skill_box_radius;

            if (_parent.x == _item.x){
                // Conexão reta
                var _dir_y = sign(_iy - _py);
                var _start_y = _py + _r * _dir_y;
                var _end_y = _iy - _r * _dir_y;
                draw_line_width(_item.x, _start_y, _item.x, _end_y, 4);
            }else{
                // Conexão em L
                var _dir_x = sign(_item.x - _parent.x);
                var _start_x = _parent.x + _r * _dir_x;
                draw_line_width(_start_x, _py, _item.x, _py, 4);

                var _dir_y2 = sign(_iy - _py);
                var _end_y = _iy - _r * _dir_y2;
                draw_line_width(_item.x, _py, _item.x, _end_y, 4);
            }
        }
    }
}

    // Círculos
    for (var i = 0; i < array_length(skill_items); i++){
        var _item = skill_items[i];
        var _iy = get_skill_item_y(_item);
        var _state = get_skill_item_state(_item);

        var _hover = (point_distance(_mx, _my, _item.x, _iy) <= skill_box_radius);
        if (_hover) skill_hovered_item = i;

        var _icon_color = (_state == "locked") ? c_gray : c_white;
        var _icon_alpha = (_state == "locked") ? 0.5 : 1;

        draw_sprite_ext(_item.icon_sprite, _item.icon_index, _item.x, _iy,
            (skill_box_radius*2) / sprite_get_width(_item.icon_sprite),
            (skill_box_radius*2) / sprite_get_height(_item.icon_sprite),
            0, _icon_color, _icon_alpha);

        draw_set_color(get_state_color(_state));
        scr_draw_circle_border(_item.x, _iy, skill_box_radius, 4);

        if (_hover && mouse_check_button_pressed(mb_left) && _state == "purchasable"){
            global.coins -= _item.price;
            variable_global_set("skill_" + _item.id, true);
			scr_apply_skill_effect(_item.id);
        }
    }

    // Tooltip
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_line_width(_gui_w/2 - 300, tooltip_divider_y, _gui_w/2 + 300, tooltip_divider_y, 4);
    draw_set_alpha(1);

    if (skill_hovered_item != -1){
        var _item = skill_items[skill_hovered_item];
        var _state = get_skill_item_state(_item);
        var _center_x = _gui_w / 2;

        draw_set_font(fnt_shop);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_set_color(make_color_rgb(255, 140, 0));
		draw_text_transformed(_center_x, tooltip_name_y, _item.name, 1.3, 1.3, 0);

        draw_set_color(c_white);
        draw_text_ext(_center_x, tooltip_desc_y, _item.description, -1, 600);

        if (_state != "owned"){
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
}else if (current_panel == "shop"){ //SHOP
    draw_sprite_stretched(spr_panel_shop_bg, 0, 0, 0, _gui_w, _gui_h);

    draw_sprite(spr_coin, 0, 70, 70);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text_transformed(110, 70, string(global.coins), 1.4, 1.4, 0);

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    shop_hovered_item = -1;

    // Linhas conectando base -> true form
    for (var i = 0; i < array_length(shop_items); i++){
    var _item = shop_items[i];
    if (_item.requires_var != "") {
        for (var j = 0; j < array_length(shop_items); j++){
            if (shop_items[j].column == _item.column && shop_items[j].row == 0){
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
    for (var i = 0; i < array_length(shop_items); i++){
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
				scr_apply_skill_effect(_item.id);
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

if (shop_hovered_item != -1){
    var _item = shop_items[shop_hovered_item];
    var _state = get_shop_item_state(_item);
    var _center_x = _gui_w / 2;

    draw_set_font(fnt_shop);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);

    draw_set_color(make_color_rgb(255, 140, 0));
	draw_text_transformed(_center_x, tooltip_name_y, _item.name, 1.3, 1.3, 0);

    draw_set_color(c_white);
    draw_text_ext(_center_x, tooltip_desc_y, _item.description, -1, 600);

    if (_state == "purchasable" || _state == "locked"){
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
}else if (current_panel == "confirm_door"){ //PORTA
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
if (current_panel == "none"){
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    draw_sprite(spr_coin, 0, 50, 40);
    draw_text_transformed(80, 40, string(global.coins), 1.2, 1.2, 0);

    draw_sprite(spr_trophy, 0, 50, 100);
    draw_text_transformed(80, 100, "WAVE " + string(global.wave_record), 1.2, 1.2, 0);

    draw_set_color(c_white);
    draw_set_valign(fa_top);
}