// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_parse_dialogue_line(_line){
    var _result = [];
    var _in_special = false;
    var _special_start_index = 0;
    var _special_buffer = "";
    var _len = string_length(_line);

    for (var i = 1; i <= _len; i++){
        var _c = string_char_at(_line, i);

        if (_c == "*"){
            if (!_in_special){
                _in_special = true;
                _special_buffer = "";
                _special_start_index = array_length(_result);
            }else{
				_in_special = false;
				var _is_gold = (_special_buffer == "Novelos de lã");
				var _is_green = (_special_buffer == "erva de gato");
				for (var j = _special_start_index; j < array_length(_result); j++){
					_result[j].gold = _is_gold;
					_result[j].green = _is_green;
					_result[j].special = !_is_gold && !_is_green;
				}
		}
            continue;
        }

        if (_in_special) _special_buffer += _c;
        array_push(_result, { char: _c, special: false, gold: false, green: false });
    }

    return _result;
}