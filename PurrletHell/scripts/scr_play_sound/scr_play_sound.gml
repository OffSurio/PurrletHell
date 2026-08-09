// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_play_sound(_sound, _volume, _pitch = 1, _pitch_variance = 0.08){
    var _inst = audio_play_sound(_sound, 1, false);
    audio_sound_gain(_inst, _volume, 0);
    audio_sound_pitch(_inst, _pitch + random_range(-_pitch_variance, _pitch_variance));
    return _inst;
}