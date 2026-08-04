/// @description Insert description here
// You can write your code in this editor
hp -= other.damage;


var _forca_recuo = 10; // força do knockback

var _dir = point_direction(other.x, other.y, x, y);

x += lengthdir_x(_forca_recuo, _dir);
y += lengthdir_y(_forca_recuo, _dir);

instance_destroy(other); // destrói o projétil

if (hp <= 0){
    instance_destroy();
}