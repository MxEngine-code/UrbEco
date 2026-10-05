if (tool_aberto)
{
    draw_set_color(c_black);
    draw_set_alpha(0.9);

    draw_rectangle(tool_x,tool_y,tool_x + tool_largura,tool_y + tool_altura,false);


    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_font(Font_ui);


    draw_text(tool_x + 15,tool_y + 15,"Moradia irregular");


    draw_text(tool_x + 15,tool_y + 45,"Impacto ambiental: +2");


    draw_text(tool_x + 15,tool_y + 65,"Custo social: -1 hab/min");
    draw_text(tool_x + 15,tool_y + 85,"Prejuízo: -4$ / 10s");
    draw_text(tool_x + tool_largura - 25,tool_y + 10,"X");
}