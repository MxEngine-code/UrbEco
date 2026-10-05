function Vector3(_x, _y, _z) constructor {
    x = _x;
    y = _y;
    z = _z;
}

function noise_2d(_x, _y)
{
    var n = sin(_x * 12.9898 + _y * 78.233) * 43758.5453;
	var c = sin(_y * 0.763463 - _x * 543783) - 82.7;
    return n - floor(n);
}

function existterrono(_x, _y)
{
    for (var i = 0; i < array_length(global.tile_lista); i++)
    {
        var _p = global.tile_lista[i];

        if (_p.x == _x && _p.y == _y)
        {
            if (_p.z == 8) return false;

            break;
        }
    }

    if (instance_place(_x, _y, obj_Arv1) != noone) return false;

    if (instance_place(_x, _y, obj_pedra) != noone) return false;

    return true;
}

function limparui(){
	for (var i = 0; i < array_length(global.botoes_atuais); i++) {
        if (instance_exists(global.botoes_atuais[i])) {
            instance_destroy(global.botoes_atuais[i]);
        }
    }
    global.botoes_atuais = [];
}

function clicar(tipoc){
	criou = false;
	show_debug_message($"tipoc: {tipoc}");
	if (tipoc < 300) {
		var itemdados = array_filter(global.objetos, function(item){
			return item.id1 == tipoc;
		});
		show_debug_message($"tamanho: {array_length(itemdados)}");
		if (array_length(itemdados)) {
			if (global.money >= itemdados[0].preco) {
				global.money -= itemdados[0].preco;
				criou = true;
			}
		}
	}
	
	if (criou){
		var	obj = instance_create_layer(32, 64, "Instances", obj_constructor);
		obj.tipo = tipoc;
		obj.image_alpha = 33;
	}
	
	if (tipoc == 300){
		limparui();
		drawopcoes1(100,675,80);
	}
	
	if (tipoc == 301){
		limparui();
		drawcontrucoes(100,675,80,1);
	}
	
	if (tipoc == 302){
		limparui();
		drawopcoes1(100,675,80);
	}
	
	if (tipoc == 303){
		limparui();
		drawcontrucoes(100,675,80,2);
	}
	
	if (tipoc == 304){
		limparui();
		drawcontrucoes(100,675,80,2);
	}
}

function criarbuy(xpos, ypos, spritei, tipoc, textotool){
	var b1 = instance_create_layer(xpos, ypos, "GUI", obj_buy);
	if (spritei != false) b1.icon_sprite = spritei;
	
	b1.texto = "";
	b1.tipoc = tipoc;
	b1.tooltip_text = textotool;
	array_push(global.botoes_atuais,b1);
}

function criarbuytxt(xpos, ypos, spritei, tipoc, textoi){
	var b1 = instance_create_layer(xpos, ypos, "GUI", obj_buy);
	if (spritei != false) b1.icon_sprite = spritei;
	
	b1.texto = textoi;
	b1.tipoc = tipoc;
	array_push(global.botoes_atuais,b1);
}

function criar_favela()
{
    var cam = view_camera[0];

    var cam_x = camera_get_view_x(cam);
    var cam_y = camera_get_view_y(cam);

    var cam_w = camera_get_view_width(cam);
    var cam_h = camera_get_view_height(cam);


    var tentativa = 0;
    var criado = false;


    while (tentativa < 100 && !criado)
    {
        tentativa++;


        // ====================================
        // ESCOLHE UMA POSIÇÃO ALEATÓRIA NO MUNDO
        // ====================================

        var px = irandom_range(0, 10751);
        var py = irandom_range(0, 5887);


        // Alinha ao grid
        px = floor(px / 16) * 16;
        py = floor(py / 16) * 16;


        // ====================================
        // NÃO PODE SER ONDE O JOGADOR ESTÁ
        // ====================================

        var dentro_camera =
            px >= cam_x - 128 &&
            px <= cam_x + cam_w + 128 &&
            py >= cam_y - 128 &&
            py <= cam_y + cam_h + 128;


        if (dentro_camera)
        {
            continue;
        }


        // ====================================
        // PRECISA SER TERRENO
        // ====================================

        if (!existterrono(px, py))
        {
            continue;
        }


        // ====================================
        // CRIA A CONSTRUÇÃO
        // ====================================

        var nova = instance_create_layer(
            px,
            py,
            "Instances",
			obj_favela
        );


        global.poluicao += 2;

        criado = true;


        show_debug_message(
            $"Favela criada em: {px}, {py}"
        );
    }


    if (!criado)
    {
        show_debug_message(
            "Não foi encontrado espaço para uma nova favela."
        );
    }
}