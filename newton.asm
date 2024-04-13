.data
    prompt1: .asciiz "Programa de Raiz Quadrada  Newton-Raphson\n"
    prompt2: .asciiz "Desenvolvedores: Leonardo T. Rubert\n"
    prompt3: .asciiz "Terminou de rodar a recursao\n"
    prompt4: .asciiz "Insira um valor para x:"
    prompt5: .asciiz "Insira um valor para i:"
    result_prompt: .asciiz "%f\n"
.text
.globl main
main:
    # Print prompts
    li $v0, 4                    
    la $a0, prompt1              
    syscall			 # printa nome programa

    li $v0, 4                    
    la $a0, prompt2              # printa desenvolvedor
    syscall
    
    li $v0, 4                    
    la $a0, prompt4              # printa prompt para usuário inserir x
    syscall
    
    # Lê o input do usuário para x
    li $v0, 5                   # faz o setup para ler input
    syscall                     # lê o input do usuário para x
    move $t0, $v0               # guarda o input do usuário em t0
    
    li $v0, 4                    
    la $a0, prompt5              # printa prompt para usuário inserir i
    syscall
    
    # Lê o input do usuário para i
    li $v0, 5                   # faz o setup para ler input
    syscall                     # lê o input do usuário para i
    move $t1, $v0               # Store the input value of i in $t1
    
    addi $sp, $sp, -12          # aloca espaço no sp para os dois valores e a pilha
    
    # manda os valores inseridos pelo usuário para a pilha
    sw $t0, 8($sp)              # aloca o x na pilha
    sw $t1, 4($sp)              # aloca o i na pilha
    
    sw $ra, 0($sp)              # aloca o ra na pilha
    
    jal sqrt                    # chama a funcao para comecar a recursão
    
    lw $ra, 0($sp)		 # recupera $ra
    addi $sp, $sp, 12		 # adiciona os 12 bytes de volta na pilha           

    # Print resultado
    move	$a0, $v0	 # move resultado para v0 para imprimir
    li $v0, 1                    # syscall: print int
    syscall

    # Termina o programa
    li $v0, 10                   # syscall: exit
    syscall

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
    jr $ra                    # retorna pra quem fez a chamada