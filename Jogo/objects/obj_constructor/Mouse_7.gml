arrastando = false;
tipocc = tipo;
tipo = 13;
if (!existterrono(x,y))
{
	var itemdados1 = array_filter(global.objetos, method({t: tipocc}, function(item){
			return item.id1 == t;
		}));

	global.money += itemdados1[0].preco;
	instance_destroy();
}