.data
    prompt1: .asciiz "Programa de Raiz Quadrada  Newton-Raphson\n"
    prompt2: .asciiz "Desenvolvedores: Leonardo T. Rubert\n"
    prompt3: .asciiz "Terminou de rodar a recursao\n"
    prompt4: .asciiz "Insira um valor para x: "
    prompt5: .asciiz "Insira um valor para i: "
    prompt6: .asciiz "\n"
    result_prompt: .asciiz "%f\n"

.text
.globl main

main:
    # Print prompts
    li $v0, 4                    
    la $a0, prompt1              
    syscall                     # Printa o nome do programa

    li $v0, 4                    
    la $a0, prompt2              
    syscall                     # Printa o nome do desenvolvedor

input_loop:
    li $v0, 4                    
    la $a0, prompt4              # Printa o prompt para inserir o valor de x
    syscall

    # Lê o input do usuário para x
    li $v0, 5                   
    syscall                      # Lê o input do usuário para x
    move $t0, $v0                # Salva o valor de x em $t0
    
    # Verifica se x é negativo (-1)
    beq $t0, -1, end_program     # Se x for negativo, termina o programa
    
    li $v0, 4                    
    la $a0, prompt5              # Printa o prompt para inserir o valor de i
    syscall

    # Lê o input do usuário para i
    li $v0, 5                   
    syscall                      # Lê o input do usuário para i
    move $t1, $v0                # Salva o valor de i em $t1
    
    # Verifica se i é negativo (-1)
    beq $t1, -1, end_program     # Se i for negativo, termina o programa
    
    addi $sp, $sp, -12           # Aloca espaço na pilha para x, i e endereço de retorno
    
    # Passa os valores de entrada do usuário para a pilha
    sw $t0, 8($sp)               # Salva x na pilha
    sw $t1, 4($sp)               # Salva i na pilha
    sw $ra, 0($sp)               # Salva o endereço de retorno na pilha
    
    jal sqrt                     # Chama a função sqrt para iniciar a recursão
    
    lw $ra, 0($sp)               # Restaura o endereço de retorno
    addi $sp, $sp, 12            # Adiciona os 12 bytes de volta na pilha       
    
    # Printa o resultado
    move $a0, $v0                # Move o resultado para $a0 para imprimir
    li $v0, 1                    # Serviço de syscall para imprimir um inteiro
    syscall                      # Imprime o resultado        
    
    li $v0, 4                    
    la $a0, prompt6              # Printa linha em branco
    syscall                     # Imprime linha em branco
    
    j input_loop                 # Volta para o início do loop para continuar solicitando entradas

end_program:
    # Termina o programa
    li $v0, 10                   # Serviço de syscall para terminar o programa
    syscall                      # Termina o programa

sqrt:
    lw $a0, 8($sp)               # carrega o x da pilha
    lw $a1, 4($sp)               # carrega o i da pilha
    bgtz $a1, sqrt_nr            # checa se o i é maior ou igual a 0
    li $v0, 1                    # retorna 1 se i = 0
    jr $ra                       # retorna quem chamou a função

sqrt_nr:
    addi $a1, $a1, -1            # decrementa i por 1
    addi $sp, $sp, -12           # aloca espaço para x, i e sp
    sw $a0, 8($sp)               # salva o x na pilha
    sw $a1, 4($sp)               # salva o i na pilha
    sw $ra, 0($sp)            	 # salva o endereço de quem chamou na pilha
    jal sqrt                  	 # chamada recursiva para chegar no fim da recursão
    
    lw $ra, 0($sp)            	 # recupera o endereço
    lw $a1, 4($sp)               # recupera o i
    lw $a0, 8($sp)           	 # recupera o x
    addi $sp, $sp, 12        	 # libera o espaço da pilha
    
    div $a0, $a0, $v0         # calcula x / sqrt_nr(x, i - 1)
    add $a0, $a0, $v0         # adiciona o resultado da chamada recursiva
    srl $a0, $a0, 1           # usa shift right pra divisão por 2
    move $v0, $a0             # move o resultado pra v0
    jr $ra                    # retorna pra quem fezz a chamada
