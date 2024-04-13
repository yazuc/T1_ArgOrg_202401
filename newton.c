#include <stdio.h>

//No exemplo dado em PDF sqrt_nr(100, 3) = 26, na verdade está mostrando o resultado de sqrt_nr(100, 2)
//O resultado de sqrt_nr(100, 3) = 15

float sqrt_nr(int v, int i){
    if(i == 0)
        return 1;

    if(i > 0){
        float parte1 = sqrt_nr(v, i - 1 );
        float parte2 = v/sqrt_nr(v, i - 1);
        float parte3 = (parte1 + parte2)/2;
        
        return (float) parte3;
    }
}

void main(){
    int executando = 1;
    int valor, i;
    printf("Programa de Raiz Quadrada - Newton-Raphson \n");
    printf("Desenvolvedores: Leonardo T. Rubert \n");

    do{
        printf("Digite os parâmetros x e i em ordem para calcular sqrt_nr (x, i) ou -1 para abortar a execução \n");
        scanf("%d %d", &valor, &i);

        if(i < 0)
            executando = 0;

        float result = sqrt_nr(valor, i);
        printf("%f \n", result);

    }while(executando == 1);
}