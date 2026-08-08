/// @description Insert description here
// You can write your code in this editor
switch (fade_state){
    case "in":
        alpha += fade_speed;
        if (alpha >= 1) { alpha = 1; fade_state = "hold"; hold_timer = 0; }
        break;

    case "hold":
        hold_timer++;
        if (hold_timer >= hold_duration) fade_state = "out";
        break;

    case "out":
        alpha -= fade_speed;
        if (alpha <= 0){
            alpha = 0;
            current_image++;

            if (current_image >= array_length(splash_images)){
                room_goto(rm_menu_inicial);
            }else{
                fade_state = "in";
            }
        }
        break;
}