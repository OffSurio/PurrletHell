/// @description Insert description here
wave_number = 0;
enemies_per_wave_base = 5;
enemies_alive = 0;
enemies_pending_spawn = 0;
wave_delay_timer = 90;
in_between_waves = true;
is_game_over = false;

// Timer da wave
wave_time_base = 1200; //20 segundo
wave_time_growth_per_step = 180; //+3s por degrau
wave_time_growth_step_waves = 10; //sobe um degrau a cada 5 waves
wave_time_growth_cap_at_step = 6; // para de crescer depois da wave 30
wave_time_current_base = 0; // valor base da wave atual
bonus_time = 0; // tempo excedente
bonus_flash_timer = 0; // controla o "+Bonus"
bonus_flash_amount = 0;
wave_timer = 0; // contagem regressiva atual, em frames

spawn_timer = 0;
spawn_interval = 1;
spawn_window_pct = 0.7; // espalha spawn 70% do tempo da wave

function get_available_enemy_types(){
    var _types = [obj_enemy_alface];
    if (wave_number >= 6)  array_push(_types, obj_enemy_tomate);
    if (wave_number >= 15) array_push(_types, obj_enemy_pepino);
    return _types;
}

function get_wave_enemy_count(){
    var _count = enemies_per_wave_base + floor((wave_number - 1) * 1.2);
    return min(_count, 25);
}

function get_wave_time_base(){
    var _steps = min(floor((wave_number - 1) / wave_time_growth_step_waves), wave_time_growth_cap_at_step);
    return wave_time_base + (_steps * wave_time_growth_per_step);
}

randomise();

function start_next_wave(){
    wave_number++;

    var _count = get_wave_enemy_count();
    enemies_pending_spawn = _count;
    in_between_waves = false;

    wave_time_current_base = get_wave_time_base();

    if (bonus_time > 0){
        bonus_flash_amount = bonus_time;
        bonus_flash_timer = 90;
    }

    wave_timer = wave_time_current_base + bonus_time;

    // Calcula o intervalo entre spawns, espalhando pelos primeiros 70% do tempo
    var _spawn_window = wave_timer * spawn_window_pct;
    spawn_interval = max(1, floor(_spawn_window / _count));
    spawn_timer = 0;

    spawn_enemy(); // spawna o primeiro instantaneo
}

function spawn_enemy(){
    var _margin = 60;
    var _posicao_valida = false;
    var _sx, _sy;
    var _tentativas = 0;

    while (!_posicao_valida && _tentativas < 50){
        var _side = irandom(3);
        switch (_side){
            case 0: _sx = irandom_range(_margin, room_width - _margin); _sy = _margin; break;
            case 1: _sx = irandom_range(_margin, room_width - _margin); _sy = room_height - _margin; break;
            case 2: _sx = _margin; _sy = irandom_range(_margin, room_height - _margin); break;
            case 3: _sx = room_width - _margin; _sy = irandom_range(_margin, room_height - _margin); break;
        }
        var _colidiu_parede = place_meeting(_sx, _sy, obj_wall);
        var _colidiu_inimigo = place_meeting(_sx, _sy, obj_enemy_parent);

        if (!_colidiu_parede && !_colidiu_inimigo){
            _posicao_valida = true;
        }
        _tentativas++;

        if (_posicao_valida){
            var _available = get_available_enemy_types();
            var _type = _available[irandom(array_length(_available) - 1)];
            instance_create_layer(_sx, _sy, "Instances", _type);
            enemies_alive++;
            enemies_pending_spawn--;
        }
    }
}

function reset_run(){
    // Salva recorde antes de zerar
    if (wave_number > global.wave_record){
        global.wave_record = wave_number;
    }

    // Destroi tudo que estiver em campo
    with (obj_enemy_parent)              instance_destroy();
    with (obj_projectile)                instance_destroy();
	with (obj_laser_beam)                instance_destroy();
    with (obj_enemy_projectile_alface)   instance_destroy();
    with (obj_tomato_grenade)            instance_destroy();
    with (obj_tomato_puddle)             instance_destroy();
    with (obj_tomato_puddle_projectile)  instance_destroy();
	with (obj_coin)                      instance_destroy();

    // Reseta o player
    global.vida = global.vida_max;
    obj_player.x = room_width / 2;
    obj_player.y = room_height / 2;
    global.stamina = global.stamina_max;
    obj_player.invuln_timer = 0;

    // Reseta wave/timer
    wave_number = 0;
    bonus_time = 0;
    bonus_flash_timer = 0;
    enemies_alive = 0;
    enemies_pending_spawn = 0;
    in_between_waves = true;
    wave_delay_timer = 90;
    is_game_over = false;
}

start_next_wave();