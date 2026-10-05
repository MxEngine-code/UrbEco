var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

hover = point_in_rectangle(mx, my, x, y, x + btn_w, y + btn_h);

if (hover && mouse_check_button_pressed(mb_left)) {
    acao();
}