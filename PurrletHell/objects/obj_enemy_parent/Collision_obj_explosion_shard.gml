/// @description Insert description here
// You can write your code in this editor
hp -= other.damage;
if (hp <= 0) {
    scr_on_enemy_death();
}
instance_destroy(other);