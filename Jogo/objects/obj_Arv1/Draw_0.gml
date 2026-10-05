draw_self();

if (destruindo) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_set_colour(c_red);
	
	draw_text(x, y, string(tempo));

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}