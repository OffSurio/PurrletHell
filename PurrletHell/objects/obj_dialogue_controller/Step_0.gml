/// @description Insert description here
// You can write your code in this editor
if (!dialogue_active) exit;

rainbow_hue += 3;
if (rainbow_hue >= 255) rainbow_hue -= 255;

wave_timer++;

if (!line_finished){
    portrait_timer++;
    if (portrait_timer >= 8){
        portrait_timer = 0;
        portrait_frame = (portrait_frame + 1) % 3;
    }

    typewriter_timer++;
    if (typewriter_timer >= typewriter_speed){
        typewriter_timer = 0;
        char_index++;
        if (char_index >= array_length(parsed_line)){
            char_index = array_length(parsed_line);
            line_finished = true;
        }
    }
}else{
    portrait_frame = 0;
}

if (keyboard_check_pressed(vk_space)){
    if (!line_finished){
        char_index = array_length(parsed_line);
        line_finished = true;
    }else{
        current_line++;
        if (current_line >= array_length(dialogue_lines)){
            dialogue_active = false;
            global.tutorial_dialogue_seen = true;
        }else{
            parsed_line = scr_parse_dialogue_line(dialogue_lines[current_line]);
			draw_set_font(fnt_dialogue);
			line_breaks = scr_wrap_dialogue_line(parsed_line, text_max_width, icon_reserved_width);
			char_index = 0;
			line_finished = false;
        }
    }
}