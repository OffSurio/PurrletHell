/// @description Insert description here
// You can write your code in this editor
current_panel = "none"; //
ignore_close_timer = 0;

tooltip_name_y = 700;
tooltip_divider_y = 766;
tooltip_desc_y = 782;
tooltip_price_y = 890;
tree_y_offset = -250; // valor negativo sobe a árvore

function get_skill_item_y(_item){
    return _item.y + tree_y_offset;
}

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
tree_middle_offset = 60;
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

function get_weapon_object_from_key(_key){
    if (_key == "pistol") return obj_weapon_pistol;
    if (_key == "laser") return obj_weapon_laser;
    if (_key == "claws") return obj_weapon_claws;
    return noone;
}

skill_box_radius = 45;
skill_hovered_item = -1;

skill_items = [
    //ATAQUE
    { id: "atk_explode", name: "Explosão Zumbi", description: "Inimigos explodem ao morrer e lançam projeteis",
      price: 50, tree: "ataque", x: 288, y: 820, requires: "",
      icon_sprite: spr_skill_icon_atk, icon_index: 0 },

    { id: "atk_speed7", name: "Fúria de Caça", description: "Ao matar 15 inimigos garante velocidade de ataque por 7 segundos!!",
      price: 150, tree: "ataque", x: 288, y: 690, requires: "atk_explode",
      icon_sprite: spr_skill_icon_atk, icon_index: 1 },

    { id: "atk_dash_dmg", name: "Investida Afiada", description: "Arranha inimigos durante o Dash.",
      price: 250, tree: "ataque", x: 198, y: 560, requires: "atk_speed7",
      icon_sprite: spr_skill_icon_atk, icon_index: 2 },

    { id: "atk_speed10", name: "Fúria Prolongada", description: "Seu bonus de FÚRIA DA CAÇA é aumentado para 10 segundos",
      price: 250, tree: "ataque", x: 378, y: 560, requires: "atk_speed7",
      icon_sprite: spr_skill_icon_atk, icon_index: 3 },

    { id: "atk_dmg1", name: "Munição Reforçada", description: "Todas suas armas ganham dano adicional.",
      price: 380, tree: "ataque", x: 198, y: 430, requires: "atk_dash_dmg",
      icon_sprite: spr_skill_icon_atk, icon_index: 4 },

    { id: "atk_dmg2", name: "Munição Reforçada II", description: "Todas suas armas ganham dano adicional.",
      price: 380, tree: "ataque", x: 378, y: 430, requires: "atk_speed10",
      icon_sprite: spr_skill_icon_atk, icon_index: 4 },

    // SAÚDE
    { id: "hp_1", name: "Vida Extra", description: "Garante +1 Coração.",
      price: 50, tree: "saude", x: 720, y: 820, requires: "",
      icon_sprite: spr_skill_icon_hp, icon_index: 0 },

    { id: "hp_2", name: "Vida Extra II", description: "Garante +1 Coração de novo.",
      price: 150, tree: "saude", x: 720, y: 690, requires: "hp_1",
      icon_sprite: spr_skill_icon_hp, icon_index: 0 },

    { id: "sau_time", name: "Efeito Borboleta.", description: "Garante mais tempo no timer.",
      price: 250, tree: "saude", x: 590, y: 560, requires: "hp_2",
      icon_sprite: spr_skill_icon_time, icon_index: 0 },

    { id: "hp_3", name: "Vida Extra III", description: "Acho que o programador estava com preguiça... Miau.",
      price: 250, tree: "saude", x: 720, y: 560, requires: "hp_2",
      icon_sprite: spr_skill_icon_hp, icon_index: 0 },

    { id: "hp_4", name: "Vida Extra IV", description: "Que gato é esse que não tinha 7 vidas?",
      price: 380, tree: "saude", x: 720, y: 430, requires: "hp_3",
      icon_sprite: spr_skill_icon_hp, icon_index: 0 },

    { id: "sau_stamina1", name: "Fôlego Felino", description: "Aumento na sua quantidade maxima de estamina.",
      price: 150, tree: "saude", x: 850, y: 690, requires: "hp_1",
      icon_sprite: spr_skill_icon_stamina, icon_index: 0 },

    { id: "sau_regen", name: "Recuperação Rápida", description: "Sua estamina recarrega mais rapido.",
      price: 250, tree: "saude", x: 850, y: 560, requires: "sau_stamina1",
      icon_sprite: spr_skill_icon_regen, icon_index: 0 },

    { id: "sau_stamina2", name: "Fôlego Felino II", description: "Aumenta ainda mais sua quantidade maxima de estamina",
      price: 380, tree: "saude", x: 850, y: 430, requires: "sau_regen",
      icon_sprite: spr_skill_icon_stamina, icon_index: 0 },

    // ESPÓLIO
    { id: "esp_heart", name: "Sorte do Gato", description: "Inimigos agora podem deixar cair corações.",
      price: 50, tree: "espolio", x: 1152, y: 820, requires: "",
      icon_sprite: spr_skill_icon_esp, icon_index: 0 },

    { id: "esp_coin1", name: "Faro pra Novelo", description: "Aumenta a chance de inimigos abatidos concederem Novelos",
      price: 150, tree: "espolio", x: 1152, y: 690, requires: "esp_heart",
      icon_sprite: spr_skill_icon_esp, icon_index: 1 },

    { id: "esp_extra_coins", name: "Bônus de Caça", description: "Inimigos deixam cair MAIS Novelos.",
      price: 250, tree: "espolio", x: 1152, y: 560, requires: "esp_coin1",
      icon_sprite: spr_skill_icon_esp, icon_index: 2 },

    { id: "esp_coin2", name: "Faro pra Novelo II", description: "Aumenta a chance de inimigos abatidos concederem Novelos - parte 2.",
      price: 380, tree: "espolio", x: 1152, y: 430, requires: "esp_extra_coins",
      icon_sprite: spr_skill_icon_esp, icon_index: 1 },

    { id: "esp_range1", name: "Braços Longos", description: "O range para coleta aumentou um pouco.",
      price: 250, tree: "espolio", x: 1282, y: 560, requires: "esp_coin1",
      icon_sprite: spr_skill_icon_esp, icon_index: 3 },

    { id: "esp_range2", name: "Braços Longos II", description: "O range para coleta aumentou consideravelmente.",
      price: 380, tree: "espolio", x: 1022, y: 430, requires: "esp_extra_coins",
      icon_sprite: spr_skill_icon_esp, icon_index: 3 }
];

function get_skill_item_by_id(_id){
    for (var i = 0; i < array_length(skill_items); i++){
        if (skill_items[i].id == _id) return skill_items[i];
    }
    return noone;
}

function get_skill_item_state(_item){
    var _owned = variable_global_get("skill_" + _item.id);
    if (_owned) return "owned";

    var _prereq_met = (_item.requires == "") || variable_global_get("skill_" + _item.requires);
    var _affordable = global.coins >= _item.price;
    return (_prereq_met && _affordable) ? "purchasable" : "locked";
}

function get_state_color(_state){
    if (_state == "owned") return c_lime;
    if (_state == "purchasable") return make_color_rgb(255, 215, 0);
    return c_gray;
}