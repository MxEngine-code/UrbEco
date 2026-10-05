var _bg = hover ? btn_bg_hover : btn_bg_color;

draw_set_color(_bg);
draw_set_alpha(0.75);
draw_roundrect_ext(x, y, x + btn_w, y + btn_h, btn_radius, btn_radius, false);

if (sprite_exists(icon_sprite)) {
    var _sw = sprite_get_width(icon_sprite);
    var _sh = sprite_get_height(icon_sprite);
    
    var _ix = x + (btn_w - _sw) / 2;
    var _iy = y + (btn_h - _sh) / 2;
    
    if (_sw > btn_w || _sh > btn_h) {
        var _scale = min(btn_w / _sw, btn_h / _sh) * 0.8;
        draw_sprite_ext(icon_sprite, 0, x + btn_w/2, y + btn_h/2, _scale, _scale, 0, icon_color, 1);
    } else {
        draw_sprite(icon_sprite, 0, _ix, _iy);
    }
}

if (texto != "") {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x + btn_w/2, y + btn_h/2, texto);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (hover && tooltip_text!= "") {
    var _lines = string_split(tooltip_text, "\n");
    var _line_count = array_length(_lines);

    var _max_w = 0;
    for (var i = 0; i < _line_count; i++) {
        _max_w = max(_max_w, string_width(_lines[i]));
    }
    var _txt_h = string_height("Ag") * _line_count + (_line_count-1) * 4;

    var _box_w = _max_w + tooltip_padding*2;
    var _box_h = _txt_h + tooltip_padding*2;

    var _tx = x + btn_w + 5;
    var _ty = y - 75;

    if (_tx + _box_w > display_get_gui_width()) {
        _tx = x - _box_w - 12;
    }

    draw_set_color(make_color_rgb(60,60,60));
    draw_roundrect_ext(_tx, _ty, _tx + _box_w, _ty + _box_h, 8, 8, false);

    draw_set_color(make_color_rgb(100,100,100));
    draw_roundrect_ext(_tx, _ty, _tx + _box_w, _ty + _box_h, 8, 8, true);

    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
	draw_set_font(Font_ui);
    var _draw_y = _ty + tooltip_padding;
    for (var i = 0; i < _line_count; i++) {
        draw_text(_tx + tooltip_padding, _draw_y, _lines[i]);
        _draw_y += string_height(_lines[i]) + 4;
    }
}