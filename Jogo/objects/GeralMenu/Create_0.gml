passo_diagonal = 0;
limite_maximo = 42 + 23;
velocidade_transicao = 2;

repeat(random_range(75,90)){
    if (irandom_range(1, 5) < 4){
		instance_create_layer(random_range(0,1344), random_range(0,736), "Vegeta", obj_Arv1);
	} else {
		instance_create_layer(random_range(0,1344), random_range(0,736), "Vegeta", obj_pedra);
	}
}

texto_completo = "URB ECO";
texto_atual = "";
caracteres_exibidos = 0;
velocidade_escrita = 0.2;
audio_play_sound(Menu1, 1, true);