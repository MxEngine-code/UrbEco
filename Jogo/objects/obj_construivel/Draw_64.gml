if (tool_aberto)
{
    draw_set_color(c_black);
    draw_set_alpha(0.9);

    draw_rectangle(tool_x,tool_y,tool_x + tool_largura,tool_y + tool_altura,false);
	
	draw_set_font(Font_ui);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(tool_x + 15,tool_y + 15,itemdados[0].nome);
    draw_text(tool_x + 15,tool_y + 45,itemdados[0].unico1);
    draw_text(tool_x + tool_largura - 25,tool_y + 10,"X");
    draw_set_color(c_white);
    draw_rectangle(tool_x + 15,tool_y + tool_altura - 40,tool_x + 140,tool_y + tool_altura - 15,false);
    draw_set_color(c_black);
    draw_text(tool_x + 35,tool_y + tool_altura - 37,$"Destruir (+{itemdados[0].preco})");
}