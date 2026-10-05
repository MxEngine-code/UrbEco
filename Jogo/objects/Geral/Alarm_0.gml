var itemdados = array_filter(global.objs_construidos,function(item)
{
    return item.tipo == 2;
});

for (var i = 0; i < array_length(global.objs_construidos); i++)
{
    var obj = global.objs_construidos[i];

    global.energia += obj.energia;
    global.agua += obj.agua;
    global.poluicao += obj.poluicaos;
}

for (var i = 0; i < array_length(itemdados); i++)
{
    var lucro_atual = global.populacao * itemdados[i].gera;

    if (global.poluicao >= 100)
    {
        var maior_poluicao = -1;

        for (var j = 0; j < array_length(global.objs_construidos); j++)
        {
            var construida = global.objs_construidos[j];

            if (construida.tipo == 2)
            {
                for (var k = 0; k < array_length(global.objetos); k++)
                {
                    var dados_construcao = global.objetos[k];

                    if (is_struct(dados_construcao) && dados_construcao.id1 == construida.id1)
                    {
                        maior_poluicao = max(maior_poluicao,dados_construcao.poluicaos);
                        break;
                    }
                }
            }
        }

        var minha_poluicao = 0;

        for (var k = 0; k < array_length(global.objetos); k++)
        {
            var meus_dados = global.objetos[k];

            if (is_struct(meus_dados) && meus_dados.id1 == itemdados[i].id1)
            {
                minha_poluicao = meus_dados.poluicaos;
                break;
            }
        }

        if (minha_poluicao >= maior_poluicao)
        {
            lucro_atual *= 0.5;
        }
    }

    global.money += lucro_atual;
}

alarm[0] = 60;