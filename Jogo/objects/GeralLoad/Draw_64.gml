draw_set_font(Font2); 
draw_set_color(c_black);

draw_set_halign(fa_center); 
draw_set_valign(fa_middle); 

var _centro_x = display_get_gui_width() / 2;
var _centro_y = display_get_gui_height() / 2;

draw_text(_centro_x, _centro_y, "Carregando");
draw_set_font(Font1);
draw_set_color(c_gray);
if (estado == "Mundo") draw_text(_centro_x, _centro_y+75, $"{estado} {passo_diagonal}/{limite_maximo}");
if (estado == "Arvores") draw_text(_centro_x, _centro_y+75, $"{estado} {objetos_criados}/{total_objetos-15}");
if (estado == "Outros") draw_text(_centro_x, _centro_y+75, $"{estado} {objetos_criados-(total_objetos-15)}/{15}");