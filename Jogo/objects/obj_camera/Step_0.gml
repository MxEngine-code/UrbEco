var zoom_anterior = zoom;

global.camera_x1 = camera_x;
global.camera_y1 = camera_y;

if (mouse_wheel_up())
{
    zoom += zoom_velocidade;
}

if (mouse_wheel_down())
{
    zoom -= zoom_velocidade;
}


zoom = clamp(
    zoom,
    zoom_min,
    zoom_max
);



var nova_view_largura =
    view_original_largura / zoom;

var nova_view_altura = view_original_altura / zoom;

if (mouse_check_button_pressed(mb_right))
{
    arrastando = true;

    mouse_inicio_x = device_mouse_x_to_gui(0);
    mouse_inicio_y = device_mouse_y_to_gui(0);

    camera_inicio_x = camera_x;
    camera_inicio_y = camera_y;
}


if (arrastando)
{
    var mouse_atual_x = device_mouse_x_to_gui(0);
    var mouse_atual_y = device_mouse_y_to_gui(0);

    var diferenca_x = mouse_inicio_x - mouse_atual_x;
    var diferenca_y = mouse_inicio_y - mouse_atual_y;

    camera_x = camera_inicio_x + diferenca_x / zoom;
    camera_y = camera_inicio_y + diferenca_y / zoom;
}


if (mouse_check_button_released(mb_right))
{
    arrastando = false;
}


if (zoom != zoom_anterior)
{
    var mouse_percent_x =
        mouse_x / window_get_width();

    var mouse_percent_y =
        mouse_y / window_get_height();

    camera_x +=
        (view_original_largura / zoom_anterior -
         nova_view_largura)
         * mouse_percent_x;


    camera_y +=
        (view_original_altura / zoom_anterior -
         nova_view_altura)
         * mouse_percent_y;
}

camera_x = max(
    camera_x,
    0
);


camera_y = max(
    camera_y,
    0
);


if (camera_x + nova_view_largura > mundo_largura)
{
    camera_x =
        mundo_largura -
        nova_view_largura;
}


if (camera_y + nova_view_altura > mundo_altura)
{
    camera_y =
        mundo_altura -
        nova_view_altura;
}


if (nova_view_largura >= mundo_largura)
{
    camera_x =
        (mundo_largura - nova_view_largura) / 2;
}

if (nova_view_altura >= mundo_altura)
{
    camera_y =
        (mundo_altura - nova_view_altura) / 2;
}


camera_set_view_size(
    camera,
    nova_view_largura,
    nova_view_altura
);


camera_set_view_pos(
    camera,
    camera_x,
    camera_y
);