/// @description Insert description here
// You can write your code in this editor
if (!variable_global_exists("equipped_weapon")){
    global.equipped_weapon = obj_weapon_pistol;
}
current_instance = noone;

function equip_weapon(_type){
    if (instance_exists(current_instance)){
        instance_destroy(current_instance);
    }
    current_instance = instance_create_layer(obj_player.x, obj_player.y, "Instances_weapon", _type);
    global.equipped_weapon = _type;
}

equip_weapon(global.equipped_weapon);