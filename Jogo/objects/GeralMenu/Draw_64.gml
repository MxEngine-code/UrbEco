draw_set_font(Font2); 
draw_set_color(c_black);

draw_set_halign(fa_center); 
draw_set_valign(fa_middle); 

var _centro_x = display_get_gui_width() / 2;
var _centro_y = display_get_gui_height() / 2;

//draw_text(_centro_x, _centro_y, texto_atual);
draw_set_font(Font1);
draw_set_color(c_gray);
draw_text(_centro_x, _centro_y+75, "Aperte ENTER para comecar!");
draw_set_font(Font3);
draw_set_color(c_black);
draw_text(1314, 748, $"Versão {GM_version}");
draw_text(100, 748, "Desenvolvido por: Equipe 3410");
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_sprite(logo, logo, _centro_x - 120, _centro_y  - 145);