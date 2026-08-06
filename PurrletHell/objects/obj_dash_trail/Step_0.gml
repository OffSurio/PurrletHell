/// @description Insert description here
// You can write your code in this editor
if (global.game_paused) exit;
image_alpha -= alpha_fade_speed;
if (image_alpha <= 0) instance_destroy();