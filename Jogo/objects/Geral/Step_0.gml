if (global.nuvensn < 50) {
    global.nuvensn++;
    instance_create_layer(random_range(-2113, -880), random_range(0, 3040), "Nuvens", obj_Nuvem);
	
    alarm[0] = game_get_speed(gamespeed_fps) * 5; 
}

if (array_length(global.objs_construidos) > array_length(objs_construidosant))
{
	var novo = global.objs_construidos[array_length(global.objs_construidos)-1];
	array_push(objs_construidosant,novo);
	if (novo.tipo == 1) {
		global.populacao += novo.gera;
	}
}

var vjogo = game_get_speed(gamespeed_fps);

global.tempo_jogo += 1 / vjogo;

if (!global.favela_desbloqueada && global.tempo_jogo >= 20) //3600 = 1h
{
    global.favela_desbloqueada = true;
}

if (global.favela_desbloqueada)
{
    var cam = view_camera[0];

    var cam_x = camera_get_view_x(cam);
    var cam_y = camera_get_view_y(cam);

    var centro_x = cam_x + camera_get_view_width(cam) / 2;
    var centro_y = cam_y + camera_get_view_height(cam) / 2;


    var area_x = floor(centro_x / global.tamanho_area_favela);
    var area_y = floor(centro_y / global.tamanho_area_favela);


    if (area_x != global.area_atual_x || area_y != global.area_atual_y) {
        global.area_atual_x = area_x;
        global.area_atual_y = area_y;

        global.tempo_area = 0;

        global.favela_ativa = false;

        global.favela_spawn_timer = 0;
        global.favela_lucro_timer = 0;
        global.favela_populacao_timer = 0;
    } else {
        global.tempo_area += 1 / vjogo;
    }

    if (global.tempo_area >= 30) {
        global.favela_ativa = true;
    }

    if (global.favela_ativa) {
        global.favela_spawn_timer += 1 / vjogo;
        global.favela_lucro_timer += 1 / vjogo;
        global.favela_populacao_timer += 1 / vjogo;

        if (global.favela_spawn_timer >= 10) {
            global.favela_spawn_timer = 0;

            criar_favela();
        }

        if (global.favela_lucro_timer >= 10) {
            global.favela_lucro_timer = 0;

            global.money -= 4;
        }

        if (global.favela_populacao_timer >= 60) {
            global.favela_populacao_timer = 0;

            global.populacao = max(0, global.populacao - 1);
        }
    }
}

var velocidade_jogo_pol = game_get_speed(gamespeed_fps);

if (global.poluicao >= 50) {
    global.polui_arvores_timer += 1 / velocidade_jogo_pol;

    if (global.polui_arvores_timer >= 30) {
        global.polui_arvores_timer = 0;

        var arvores = instance_number(obj_Arv1);

        if (arvores > 0) {
            var arvore = instance_find(obj_Arv1, irandom(arvores - 1));

            if (instance_exists(arvore)) {
                with (arvore) {
                    instance_destroy();
                }
            }
        }
    }
} else {
    global.polui_arvores_timer = 0;
}

if (global.poluicao >= 80) {
    global.polui_populacao_timer += 1 / velocidade_jogo_pol;

    if (global.poluicao >= 100) {
        if (global.polui_populacao_timer >= 60) {
            global.polui_populacao_timer = 0;

            global.populacao = max(0,global.populacao - 2);
        }
    } else {
        if (global.polui_populacao_timer >= 120) {
            global.polui_populacao_timer = 0;

            global.populacao = max(0,global.populacao - 1);
        }
    }
} else {
    global.polui_populacao_timer = 0;
}

if (global.poluicao >= 100) {
    global.lucro_poluicao_multiplicador = 0.5;
} else {
    global.lucro_poluicao_multiplicador = 1;
}