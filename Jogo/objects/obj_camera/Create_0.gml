camera = view_camera[0];

mundo_largura = 170 * 32;
mundo_altura  = 96 * 32;

view_original_largura = camera_get_view_width(camera);
view_original_altura  = camera_get_view_height(camera);


zoom = 1.0;

zoom_min = 0.5;
zoom_max = 2.0;

zoom_velocidade = 0.10;

camera_x = camera_get_view_x(camera);
camera_y = camera_get_view_y(camera);

arrastando = false;

mouse_inicio_x = 0;
mouse_inicio_y = 0;

camera_inicio_x = 0;
camera_inicio_y = 0;