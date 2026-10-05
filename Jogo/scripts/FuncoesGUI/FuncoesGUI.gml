function drawopcoes1(xbuy1, ybuy1, dis){
	criarbuytxt(xbuy1+dis, ybuy1, false, 301, "MORADIA");
	criarbuytxt(xbuy1+dis*2, ybuy1, false, 303, "LUCRO");
}
function drawcontrucoes(xbuy1, ybuy1, dis, tipo1){
    var lista_atual = array_filter(global.objetos, method({t: tipo1}, function(item){
        return item.tipo == t;
    }));

    for (var i1 = 0; i1 < array_length(lista_atual); i1++){
        var dados = lista_atual[i1];
        criarbuy(xbuy1 + dis * i1, ybuy1, dados.sprite, dados.id1, $"Nome: {dados.nome}\n{dados.unico1}\nPreço: {dados.preco}");
    }

    criarbuytxt(xbuy1 + dis * array_length(lista_atual), ybuy1, false, 302, "VOLTAR");
}