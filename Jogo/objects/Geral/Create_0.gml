global.energia = 0;
global.agua = 0;
global.poluicao = 0;
global.populacao = 0;
global.money = 100000;
global.dia = true;

var _objs_lista = [];
var _tile_lista = [];
global.botoes_atuais = [];
global.objetos = [];
global.objs_construidos = [];
global.nuvensn = 0
objs_construidosant = [];

global.favela_ativa = false;
global.favela_desbloqueada = false;

global.tempo_jogo = 0;

global.tempo_area = 0;

global.area_atual_x = -1;
global.area_atual_y = -1;

global.tamanho_area_favela = 540;

global.favela_spawn_timer = 0;
global.favela_lucro_timer = 0;
global.favela_populacao_timer = 0;

global.polui_arvores_timer = 0;
global.polui_populacao_timer = 0;

global.lucro_poluicao_multiplicador = 1;

randomize();

var mapa_largura = 336;
var mapa_altura  = 184;

var tamanho_tile = 32;

var seed = irandom(999999);

var _flores = [];


var quantidade_grupos_flores = 5;


for (var f = 0; f < quantidade_grupos_flores; f++)
{
    var flor_x = irandom(mapa_largura - 1);
    var flor_y = irandom(mapa_altura - 1);

    array_push(
        _flores,
        new Vector3(
            flor_x,
            flor_y,
            0
        )
    );
}


for (var x1 = 0; x1 < mapa_largura; x1++)
{
    for (var y1 = 0; y1 < mapa_altura; y1++)
    {
        var nx = x1 / (mapa_largura - 1);
        var ny = y1 / (mapa_altura - 1);

        var dx = nx - 0.5;
        var dy = ny - 0.5;

        var distancia = sqrt(
            dx * dx +
            dy * dy
        );

        var n1 = sin((x1 + seed) * 0.075) * 0.5 + cos((y1 + seed) * 0.09) * 0.5;

        n1 = (n1 + 1.0) * 0.5;

        var n2 =
            sin((x1 + seed * 2) * 0.16) *
            cos((y1 + seed) * 0.13);

        n2 = (n2 + 1.0) * 0.5;

        var n3 =
            sin((x1 + seed) * 0.035) *
            cos((y1 + seed) * 0.045);

        n3 = (n3 + 1.0) * 0.5;

        var terreno =
            n1 * 0.45 +
            n2 * 0.25 +
            n3 * 0.30;


        var borda = min(
            min(nx, 1.0 - nx),
            min(ny, 1.0 - ny)
        );

        var continente =
            terreno +
            borda * 1.5;

        var lago =
            sin((x1 + seed * 3) * 0.11) *
            cos((y1 + seed * 4) * 0.095);

        lago = (lago + 1.0) * 0.5;

        var tile = 8;


        if (continente < 0.55)
        {
            tile = 8;
        }


        else
        {
            if (lago > 0.93 && terreno < 0.58)
            {
                tile = 8;
            }

            else
            {
                var chance = irandom(99);

                if (chance < 45)
                {
                    tile = 1;
                }
                else if (chance < 70)
                {
                    tile = 2;
                }
                else
                {
                    tile = 5;
                }

                var tem_flor = false;

                for (var f = 0; f < array_length(_flores); f++)
                {
                    var flor = _flores[f];

                    var fx = flor.x;
                    var fy = flor.y;


                    var distancia_flor =
                        point_distance(
                            x1,
                            y1,
                            fx,
                            fy
                        );


                    if (distancia_flor <= 4)
                    {
                        if (irandom(99) < 35)
                        {
                            tem_flor = true;
                            break;
                        }
                    }
                }

                if (tem_flor)
                {
                    tile = choose(
                        3,
                        6,
                        7
                    );
                }
            }
        }

        array_push(_tile_lista,new Vector3(x1 * tamanho_tile,y1 * tamanho_tile,tile)
);
    }
}

global.tile_lista = _tile_lista;

var _layer = layer_get_id("Tiles_1");

var _tilemap = layer_tilemap_get_id(_layer);


for (var i = 0; i < array_length(_tile_lista); i++)
{
    var _p = _tile_lista[i];


    tilemap_set(
        _tilemap,
        _p.z,
        _p.x div tamanho_tile,
        _p.y div tamanho_tile
    );
	
	if (_p.z == 1){
		r = irandom_range(1, 5);
		if (r <= 2){
			array_push(_objs_lista, new Vector3(_p.x,_p.y,1));
		}
		
		if (r == 3){
			array_push(_objs_lista, new Vector3(_p.x,_p.y,2));
		}
	}
}

for (var i = 0; i < array_length(_objs_lista); i++)
{
    var _p = _objs_lista[i];

    if (_p.z == 1) instance_create_layer(_p.x, _p.y, "Vegetacao", obj_Arv1);
	if (_p.z == 2) instance_create_layer(_p.x, _p.y, "Vegetacao", obj_pedra);
}

audio_pause_sound(Menu1)
audio_play_sound(jogo, 1, true);

drawopcoes1(100,675,80);

//residencia tipo = 1
array_push(global.objetos, {nome: "Casa pequena",sprite: spr_casa,id1: 1,unico1: "Capacidade: 1 pessoas", energia: -0.5, agua: -0.5, poluicaos: 0.2,preco: 8,gera: 1,tipo: 1});
array_push(global.objetos, {nome: "Casa2",sprite: spr_casa2,id1: 2,unico1: "Capacidade: 1 pessoas", energia: -0.4, agua: -0.4, poluicaos: 0.1,preco: 10,gera: 1,tipo: 1});
array_push(global.objetos, {nome: "Casa3",sprite: spr_casa3,id1: 3,unico1: "Capacidade: 2 pessoas", energia: -1, agua: -1, poluicaos: 0.2,preco: 12,gera: 2,tipo: 1});
array_push(global.objetos, {nome: "Casa4",sprite: spr_casa_4,id1: 4,unico1: "Capacidade: 2 pessoas", energia: -0.8, agua: -0.8, poluicaos: 0.1,preco: 14,gera: 2,tipo: 1});
array_push(global.objetos, {nome: "Casa5",sprite: spr_casa_5,id1: 5,unico1: "Capacidade: 3 pessoas", energia: -2, agua: -2, poluicaos: 0.3,preco: 16,gera: 3,tipo: 1});
array_push(global.objetos, {nome: "Casa6",sprite: spr_casa_6,id1: 6,unico1: "Capacidade: 2 pessoas", energia: -0.6, agua: -0.7, poluicaos: 0.1,preco: 18,gera: 2,tipo: 1});

array_push(global.objetos, {nome: "Casa7",sprite: spr_casa_7,id1: 7,unico1: "Capacidade: 4 pessoas", energia: -4, agua: -4, poluicaos: 1,preco: 20,gera: 4,tipo: 1});
array_push(global.objetos, {nome: "Casa8",sprite: spr_casa_8,id1: 8,unico1: "Capacidade: 3 pessoas", energia: -1.5, agua: -1.5, poluicaos: 0.2,preco: 22,gera: 3,tipo: 1});
array_push(global.objetos, {nome: "Casa9",sprite: spr_casa_9,id1: 9,unico1: "Capacidade: 5 pessoas", energia: -5, agua: -5, poluicaos: 1,preco: 24,gera: 5,tipo: 1});
array_push(global.objetos, {nome: "Casa10",sprite: spr_casa_10,id1: 10,unico1: "Capacidade: 4 pessoas", energia: -3, agua: -3, poluicaos: 0.8,preco: 26,gera: 4,tipo: 1});
array_push(global.objetos, {nome: "Casa11",sprite: spr_casa_11,id1: 11,unico1: "Capacidade: 2 pessoas", energia: -0.5, agua: -0.5, poluicaos: 0.9,preco: 28,gera: 2,tipo: 1});
array_push(global.objetos, {nome: "Casa12",sprite: spr_casa_12,id1: 12,unico1: "Capacidade: 4 pessoas", energia: -2, agua: -2, poluicaos: 0.7,preco: 30,gera: 4,tipo: 1});

array_push(global.objetos, {nome: "Mercado",sprite: spr_mercado_2,id1: 13,unico1: "Gera 2", energia: -4, agua: -3, poluicaos: 1,preco: 30,gera: 6,tipo: 2});

//array_push(global.objetos, {nome: "Predio pequeno",sprite: spr_predio_pequeno,id1: 2,unico1: "Capacidade: 20 pessoas", energia: -25, agua: -12, lucro: 0, puluicaos: 7,preco: 80,gera: 20,tipo: 1});
//array_push(global.objetos, {nome: "Predio",sprite: spr_predio,id1: 3,unico1: "Capacidade: 30 pessoas", energia: -30, agua: -20, lucro: 0, puluicaos: 8,preco: 120,gera: 30,tipo: 1});


alarm[0] = 60;