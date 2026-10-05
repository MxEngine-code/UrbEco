if (arrastando){
	x = floor(mouse_x / 32) * 32;
	y = floor(mouse_y / 32) * 32;
	show_debug_message(x);
}


if (tipo != 13){
	var itemdados1 = array_filter(global.objetos, method({t: tipo}, function(item){
			return item.id1 == t;
		}));

	itemdados = itemdados1[0];
	sprite_index = itemdados.sprite;
}

if (tipo == 13) {
	sprite_index = C_construcao;
	tempo -= 0.01; // 100 = 1 -> 1 / 100
	if (tempo <= 0) {
		var newo = instance_create_layer(x, y, "Instances", obj_construivel);
		newo.tipo = tipocc;
		array_push(global.objs_construidos, itemdados);
		instance_destroy();
	}
}


image_index = 0;
