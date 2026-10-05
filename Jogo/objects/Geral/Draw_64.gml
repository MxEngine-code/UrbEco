var gui_w = display_get_gui_width();
var pw = 850;
var ph = 72;
var px = (gui_w - pw) / 2;
var py = 15;

draw_set_alpha(0.35);
draw_set_color(c_black);
draw_roundrect(px + 5,py + 6,px + pw + 5,py + ph + 6,false);

draw_set_alpha(0.78);
draw_set_color(make_color_rgb(25,25,30));
draw_roundrect(px,py,px + pw,py + ph,false);

draw_set_alpha(1);
draw_set_color(make_color_rgb(90,90,100));
draw_roundrect(px,py,px + pw,py + ph,true);

var margem = 10;
var espacamento = 4;
var tab_w = (pw - margem * 2 - espacamento * 4) / 5;
var tab_h = 52;
var tab_y = py + 10;
var tab_x = px + margem;

draw_set_alpha(0.65);
draw_set_color(make_color_rgb(40,40,48));
draw_roundrect(tab_x,tab_y,tab_x + tab_w,tab_y + tab_h,false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(Font_ui);
draw_text(tab_x + 12,tab_y + 7,"DINHEIRO");
draw_set_color(make_color_rgb(180,180,190));
draw_text(tab_x + 12,tab_y + 28,"$" + string(global.money));

tab_x += tab_w + espacamento;
draw_set_alpha(0.65);
draw_set_color(make_color_rgb(40,40,48));
draw_roundrect(tab_x,tab_y,tab_x + tab_w,tab_y + tab_h,false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_text(tab_x + 12,tab_y + 7,"POPULAÇÃO");
draw_set_color(make_color_rgb(180,180,190));
draw_text(tab_x + 12,tab_y + 28,string(global.populacao));

tab_x += tab_w + espacamento;
draw_set_alpha(0.65);
draw_set_color(make_color_rgb(40,40,48));
draw_roundrect(tab_x,tab_y,tab_x + tab_w,tab_y + tab_h,false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_text(tab_x + 12,tab_y + 7,"ENERGIA");
draw_set_color(make_color_rgb(180,180,190));
draw_text(tab_x + 12,tab_y + 28,string(global.energia));

tab_x += tab_w + espacamento;
draw_set_alpha(0.65);
draw_set_color(make_color_rgb(40,40,48));
draw_roundrect(tab_x,tab_y,tab_x + tab_w,tab_y + tab_h,false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_text(tab_x + 12,tab_y + 7,"ÁGUA");
draw_set_color(make_color_rgb(180,180,190));
draw_text(tab_x + 12,tab_y + 28,string(global.agua));

tab_x += tab_w + espacamento;
draw_set_alpha(0.65);
draw_set_color(make_color_rgb(40,40,48));
draw_roundrect(tab_x,tab_y,tab_x + tab_w,tab_y + tab_h,false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_text(tab_x + 12,tab_y + 7,"POLUIÇÃO");
draw_set_color(make_color_rgb(180,180,190));
draw_text(tab_x + 12,tab_y + 28,string(global.poluicao));

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(Font_ui);

draw_set_alpha(1);
draw_set_font(Font_ui);

var px = 64;
var py = 640;
var pw = 1238;
var ph = 110;

draw_set_color(c_black);
draw_set_alpha(0.35);

draw_roundrect(px + 5,py + 6,px + pw + 5,py + ph + 6,false);

draw_set_alpha(0.72);
draw_set_color(make_color_rgb(25,25,30));

draw_roundrect(px,py,px + pw,py + ph,false);

draw_set_alpha(1);
draw_set_color(make_color_rgb(90,90,100));

draw_roundrect(px,py,px + pw,py + ph,true);

draw_set_color(make_color_rgb(120,120,130));

draw_rectangle(px + 15,py + 30,px + pw - 15,py + 32,false);

draw_set_color(c_white);
draw_set_font(Font_ui);

draw_text(px + 20,py + 7,"CONSTRUÇÕES");