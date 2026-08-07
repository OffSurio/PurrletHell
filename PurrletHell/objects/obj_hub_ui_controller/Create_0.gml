/// @description Insert description here
// You can write your code in this editor
current_panel = "none"; //
ignore_close_timer = 0;

tooltip_name_y = 600;
tooltip_divider_y = 656;
tooltip_desc_y = 672;
tooltip_price_y = 780;

function open_panel(_panel){
    current_panel = _panel;
    ignore_close_timer = 5;
}

function close_panel(){
    current_panel = "none";
}

function draw_close_button(_gui_w, _gui_h){
    var _bx = _gui_w - 40;
    var _by = 40;
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    draw_sprite(spr_close_x, 0, _bx, _by);

    var _half_w = sprite_get_width(spr_close_x) / 2;
    var _half_h = sprite_get_height(spr_close_x) / 2;
    var _padding = 6;

    var _hover = (_mx >= _bx - _half_w - _padding && _mx <= _bx + _half_w + _padding &&
                  _my >= _by - _half_h - _padding && _my <= _by + _half_h + _padding);

    if (_hover && mouse_check_button_pressed(mb_left)){
        close_panel();
    }
}

shop_items = [
    { id: "pistol_base", name: "Pistola de Ração", description: "Ração a granel, é meio dura, então deve dar pra atirar.",
      price: 0, column: 0, row: 0, requires_var: "",
      unlocked_var: "weapon_pistol_unlocked", weapon_type: obj_weapon_pistol,
      icon_sprite: spr_icon_pistol, weapon_key: "pistol" },

    { id: "pistol_true", name: "Pistola de Ração Gourmet", description: "O apice do sabor arroz com frango!!!",
      price: 1000, column: 0, row: 1, requires_var: "weapon_pistol_unlocked",
      unlocked_var: "weapon_pistol_true_form", weapon_type: noone,
      icon_sprite: spr_icon_pistol_true, weapon_key: "pistol" },

    { id: "laser_base", name: "PointLaser", description: "O que... O que é isso???",
      price: 300, column: 1, row: 0, requires_var: "",
      unlocked_var: "weapon_laser_unlocked", weapon_type: obj_weapon_laser,
      icon_sprite: spr_icon_laser, weapon_key: "laser" },

    { id: "laser_true", name: "Caneta Laser Dupla", description: "AHA!! Te peguei!! Espera... TEM DOIS?!",
      price: 1000, column: 1, row: 1, requires_var: "weapon_laser_unlocked",
      unlocked_var: "weapon_laser_true_form", weapon_type: noone,
      icon_sprite: spr_icon_laser_true, weapon_key: "laser" },

    { id: "claws_base", name: "Afiador de Garras", description: "Isso ajuda de mais a... SOLTA MINHA UNHA, SOCORRO.",
      price: 450, column: 2, row: 0, requires_var: "",
      unlocked_var: "weapon_claws_unlocked", weapon_type: obj_weapon_claws,
      icon_sprite: spr_icon_claws, weapon_key: "claws" },

    { id: "claws_true", name: "Garras de Metal 3.0", description: "Lâminas de meawtitanio, cortam ate diamantes.",
      price: 1000, column: 2, row: 1, requires_var: "weapon_claws_unlocked",
      unlocked_var: "weapon_claws_true_form", weapon_type: noone,
      icon_sprite: spr_icon_claws_true, weapon_key: "claws" }
];

tree_box_size = 150;
tree_spacing_x = 280;
tree_base_y = 420;
tree_middle_offset = 60; //coluna do meio
tree_branch_height = 220;
shop_hovered_item = -1;

function get_shop_item_position(_item){
    var _gui_w = display_get_gui_width();
    var _center_x = _gui_w / 2;
    var _col_x = _center_x + (_item.column - 1) * tree_spacing_x;
    var _base_y = tree_base_y - ((_item.column == 1) ? tree_middle_offset : 0);
    var _y = _base_y - (_item.row * tree_branch_height);
    return { x: _col_x, y: _y };
}

function get_equipped_weapon_key(){
    if (global.equipped_weapon == obj_weapon_pistol) return "pistol";
    if (global.equipped_weapon == obj_weapon_laser) return "laser";
    if (global.equipped_weapon == obj_weapon_claws) return "claws";
    return "";
}

function get_shop_item_state(_item){
    var _owned = variable_global_get(_item.unlocked_var);
    if (_owned) {
        if (_item.weapon_key == get_equipped_weapon_key()) return "selected";
        return "owned";
    }

    var _prereq_met = (_item.requires_var == "") || variable_global_get(_item.requires_var);
    var _affordable = global.coins >= _item.price;
    return (_prereq_met && _affordable) ? "purchasable" : "locked";
}

function get_weapon_object_from_key(_key) {
    if (_key == "pistol") return obj_weapon_pistol;
    if (_key == "laser") return obj_weapon_laser;
    if (_key == "claws") return obj_weapon_claws;
    return noone;
}