var _thickness = 32;
// Parede de cima
var _top = instance_create_layer(0, -_thickness, "Instances", obj_wall);
_top.image_xscale = room_width / sprite_get_width(obj_wall.sprite_index);
_top.image_yscale = _thickness / sprite_get_height(obj_wall.sprite_index);

// Parede de baixo
var _bottom = instance_create_layer(0, room_height, "Instances", obj_wall);
_bottom.image_xscale = room_width / sprite_get_width(obj_wall.sprite_index);
_bottom.image_yscale = _thickness / sprite_get_height(obj_wall.sprite_index);

// Parede da esquerda
var _left = instance_create_layer(-_thickness, 0, "Instances", obj_wall);
_left.image_xscale = _thickness / sprite_get_width(obj_wall.sprite_index);
_left.image_yscale = room_height / sprite_get_height(obj_wall.sprite_index);

// Parede da direita
var _right = instance_create_layer(room_width, 0, "Instances", obj_wall);
_right.image_xscale = _thickness / sprite_get_width(obj_wall.sprite_index);
_right.image_yscale = room_height / sprite_get_height(obj_wall.sprite_index);