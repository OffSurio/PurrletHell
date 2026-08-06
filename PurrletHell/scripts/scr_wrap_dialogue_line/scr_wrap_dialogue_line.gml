// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_wrap_dialogue_line(_parsed, _max_width, _icon_reserved_width) {
    var _line_starts = [0];
    var _line_width = 0;
    var _len = array_length(_parsed);
    var i = 0;

    while (i < _len) {
        var _word_end = i;
        var _word_width = 0;

        while (_word_end < _len && _parsed[_word_end].char != " ") {
            _word_width += string_width(_parsed[_word_end].char);
            _word_end++;
        }

        // Se essa palavra termina um trecho dourado, reserva espaço extra pro ícone
        if (_word_end > i && _parsed[_word_end - 1].gold) {
            var _next_is_gold = (_word_end < _len && _parsed[_word_end].gold);
            if (!_next_is_gold) _word_width += _icon_reserved_width;
        }

        var _space_width = (_word_end < _len && _parsed[_word_end].char == " ") ? string_width(" ") : 0;

        if (_line_width > 0 && _line_width + _word_width > _max_width) {
            array_push(_line_starts, i);
            _line_width = 0;
        }

        _line_width += _word_width + _space_width;
        i = _word_end + 1;
    }

    return _line_starts;
}