/// @description Insert description here
// You can write your code in this editor

portrait_reserved_width = 140; // largura reservada pro retrato — texto nunca passa disso
icon_reserved_width = 32;      // espaço reservado pro ícone do "Novelos de lã"
text_max_width = 900 - 80 - 140; // box_w - margens - espaço do retrato
line_breaks = [];

dialogue_lines = [
    "Ei novato! Na sua direita.",
    "Todos os outros estão lá fora enfrentando esses malditos vegetais.",
    "Pretende ir também?",
    "Só tome cuidado, utilize de *WASD* ou as *Setas* para se mover.",
    "Apertando *SHIFT* você corre, e desvie dos ataques com *SPACE*, se mostre forte!!",
	"Ganhe vantagens com o tempo excedente, ele se junta ao pouco tempo que tem...",
	"Criando uma verdadeira *REAÇÃO EM CADEIA!!!* que vai te ajudar muito no futuro.",
    "Pegue os *Novelos de lã* e os traga pra mim, terei o prazer de te vender umas armas legais.",
    "Você sabe...",
    "...a *erva de gato* não se compra sozinha..",
    "Se estiver se sentindo fraco descanse na nossa Cohab peluda de *ARRANHADORES*, poderá evoluir.",
	"Ela fica no canto esquerdo da sala, espero que não sofra com rinite alergica.",
    "Agora vá novato, não tenha medo se falhar, sempre caímos de pé não é mesmo?"
];

current_line = 0;
parsed_line = [];
char_index = 0;
typewriter_timer = 0;
typewriter_speed = 2; // frames por caractere
line_finished = false;
dialogue_active = false;

portrait_frame = 0;
portrait_timer = 0;
rainbow_hue = 0;
wave_timer = 0;

if (!global.tutorial_dialogue_seen){
    dialogue_active = true;
    parsed_line = scr_parse_dialogue_line(dialogue_lines[current_line]);
	draw_set_font(fnt_dialogue);
	line_breaks = scr_wrap_dialogue_line(parsed_line, text_max_width, icon_reserved_width);
}