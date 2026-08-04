/// @description Insert description here
// You can write your code in this editor
lifetime = 240; // 4 segundos
radius = 32;

damage_per_tick = 1;
damage_interval = 15; // tempo para dar dano enquanto o player estiver dentro
damage_timer = 0;

// Cria os 4 projéteis  assim que a poça nasce
var _speed = 5;
var _dirs = [90, 270, 0, 180]; // cima, baixo, direita, esquerda

for (var i = 0; i < array_length(_dirs); i++){
    var _p = instance_create_layer(x, y, "inst_baixo", obj_tomato_puddle_projectile);
    _p.direction = _dirs[i];
    _p.speed = _speed;
    _p.image_angle = _dirs[i];
}