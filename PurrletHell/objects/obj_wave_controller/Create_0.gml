/// @description Insert description here
// You can write your code in this editor
wave_number = 0;
enemies_per_wave_base = 3;
enemies_alive = 0;
enemies_pending_spawn = 0;

wave_delay_timer = 90; //pequeno intervalo antes da 1ª wave
in_between_waves = true;

// Lista de tipos de inimigo disponíveis pra sortear no spawn.
enemy_types = [obj_enemy_alface, obj_enemy_tomate];
randomise();

function start_next_wave(){
    wave_number++;
    var _count = enemies_per_wave_base + (wave_number - 1) * 2; // cresce 2x por wave

    enemies_pending_spawn = _count;
    in_between_waves = false;

    for (var i = 0; i < _count; i++){
        spawn_enemy();
    }
}

function spawn_enemy(){
    var _margin = 60;
	var _posicao_valida = false;
    var _sx, _sy;
	var _tentativas = 0;

while (!_posicao_valida && _tentativas < 50){
	var _side = irandom(3);
    switch (_side){
        case 0: _sx = irandom_range(_margin, room_width - _margin);_sy = _margin; break; // topo
        case 1: _sx = irandom_range(_margin, room_width - _margin); _sy = room_height - _margin; break; // baixo
        case 2: _sx = _margin; _sy = irandom_range(_margin, room_height - _margin); break; // esquerda
        case 3: _sx = room_width - _margin; _sy = irandom_range(_margin, room_height - _margin); break; // direita
    }
	var _colidiu_parede = place_meeting(_sx, _sy, obj_wall);
	var _colidiu_inimigo = place_meeting(_sx, _sy, obj_enemy_parent);
	
	if (!_colidiu_parede && !_colidiu_inimigo){
		_posicao_valida = true;
	}
	_tentativas++;
	
	if (_posicao_valida){
    var _type = enemy_types[irandom(array_length(enemy_types) - 1)];
    instance_create_layer(_sx, _sy, "Instances", _type);

    enemies_alive++;
    enemies_pending_spawn--;
		}
	}
}

start_next_wave();