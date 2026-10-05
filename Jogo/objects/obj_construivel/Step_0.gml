itemdados = array_filter(global.objs_construidos, method({t: tipo}, function(item){
		return item.id1 == t;
	}));

sprite_index = itemdados[0].sprite;

if (mouse_check_button_pressed(mb_right))
{
    if (position_meeting(mouse_x, mouse_y, id))
    {
        tool_aberto = true;

        var gui_x = camera_get_view_x(view_camera[0]);
        var gui_y = camera_get_view_y(view_camera[0]);

        tool_x = x - gui_x + sprite_width / 2 + 10;
        tool_y = y - gui_y - tool_altura / 2;
    }
}

if (tool_aberto && mouse_check_button_pressed(mb_left))
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    if (point_in_rectangle(mx,my,tool_x + tool_largura - 35,tool_y + 5,tool_x + tool_largura,tool_y + 40))
    {
        tool_aberto = false;
    }

    else if (point_in_rectangle(mx,my,tool_x + 15,tool_y + tool_altura - 40,tool_x + 110,tool_y + tool_altura - 15))
    {
        if (global.money >= 2){
			global.money -= 2;
			instance_destroy();
		}

    }

    else if (!point_in_rectangle(mx,my,tool_x,tool_y,tool_x + tool_largura,tool_y + tool_altura))
    {
        tool_aberto = false;
    }
}