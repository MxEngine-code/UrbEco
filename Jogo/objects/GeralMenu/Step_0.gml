if (caracteres_exibidos < string_length(texto_completo)) {
    caracteres_exibidos += velocidade_escrita;
    texto_atual = string_copy(texto_completo, 1, floor(caracteres_exibidos));
}

repeat(velocidade_transicao) {
    if (passo_diagonal <= limite_maximo) {
        for (var _x = 0; _x <= 42; _x++) {
            var _y = passo_diagonal - _x;
            if (_y >= 0 && _y <= 23) {
                instance_create_layer(_x * 32, _y * 32, "Gramas", obj_grama);
            }
        }
        passo_diagonal++;
    }
}
