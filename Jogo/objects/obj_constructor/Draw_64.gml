if (tipo == 13) {
	draw_set_font(Font2); 
	draw_set_color(c_black);

	draw_set_halign(fa_center); 
	draw_set_valign(fa_middle); 

	var _centro_x = x;
	var _centro_y = y;

	draw_set_font(Font3);
	draw_set_colour(c_blue);
	draw_text(_centro_x + 16, _centro_y + 15, round(tempo));

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}