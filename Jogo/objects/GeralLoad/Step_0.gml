 if (estado == "Mundo") {
    repeat(velocidade_grama) {
        if (passo_diagonal <= limite_maximo) {
            for (var _x = 0; _x <= 42; _x++) {
                var _y = passo_diagonal - _x;
                if (_y >= 0 && _y <= 23) {
                    instance_create_layer(_x * 32, _y * 32, "Gramas", obj_grama);
                }
            }
            passo_diagonal++;
        } else {
            estado = "Arvores";
            break;
        }
    }
}

if (estado == "Arvores") {
    if (objetos_criados < total_objetos - 13) {
        
        timer_arvore--;
        
        if (timer_arvore <= 0) {
            if (irandom_range(1, 5) < 4) {
                instance_create_layer(random_range(0, 1344), random_range(0, 736), "Anima", obj_Arv1);
            } else {
                instance_create_layer(random_range(0, 1344), random_range(0, 736), "Anima", obj_pedra);
            }
            
            objetos_criados++;
            timer_arvore = tempo_espera_arvore;
        }
    } else {
        estado = "Outros"; 
    }
}

if (estado == "Outros") {
    if (objetos_criados < total_objetos) {
        
        timer_casa--;
        
        if (timer_casa <= 0) {
            if (irandom_range(1, 5) <= 3) {
                var o = instance_create_layer(random_range(0, 1344), random_range(0, 736), "Anima", obj_Arv1);
				var r = irandom_range(1, 5);
				if (r == 1) o.sprite_index = spr_casa_13;
				if (r == 2) o.sprite_index = spr_casa_4;
				if (r == 3) o.sprite_index = spr_casa_10;
				if (r == 4) o.sprite_index = spr_casa_7;
				if (r == 5) o.sprite_index = spr_casa_8;
            }
            
            objetos_criados++;
            timer_casa = tempo_espera_casa;
        }
    } else {
        estado = "concluido"; 
		room_goto(Game);
		application_get_position();
    }
}