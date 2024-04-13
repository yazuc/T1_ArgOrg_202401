#include <stdio.h>
int sqrt_nr(int v, int i){
    if(i == 0)
        return 1;

    if(i > 0){
        return (sqrt_nr(v, i - 1 ) + (v/sqrt_nr(v, i - 1)))/2;
    }
}

void main(){
    int executando = 1;
    int valor, i;
    printf("Programa de Raiz Quadrada - Newton-Raphson /n");
    printf("Desenvolvedores: Leonardo T. Rubert /n");
    printf("Digite os parâmetros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execução /n");

    do{
        scanf("%d %d", &valor, &i);

        if(i < 0)
            executando = 0;

        int result = sqrt_nr(valor, i);
        printf("%f /n", result);

    }while(executando == 1);
}