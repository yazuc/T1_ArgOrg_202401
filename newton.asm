.data
    prompt1: .asciiz "Programa de Raiz Quadrada – Newton-Raphson\n"
    prompt2: .asciiz "Desenvolvedores: Leonardo T. Rubert\n"
    prompt3: .asciiz "Terminou de rodar a recursao\n"
    result_prompt: .asciiz "%f\n"
    x: .word 100
    i: .word 4

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
    
    addi	$sp, $sp, -12	 #  Aloca espaço na pilha para 3 palavras (12 bytes)

    # Calculate sqrt_nr(100, 2)
    lw $t0, x                    # coloca valor de x em t0
    sw $t0, 8($sp)		 # coloca x na pilha    
    
    lw $t1, i                    # coloca valor de i em t1
    sw $t1, 4($sp) 		 # coloca i na pilha   
    
    sw $ra, 0($sp)		 # Coloca $ra na pilha
    
    
    jal sqrt			 # chama a recursão
    
    lw $ra, 0($sp)		 # recupera $ra
    addi $sp, $sp, 12		 # adiciona os 16 bytes de volta na pilha           

    # Print result
    move	$a0, $v0	 # move resultado para v0 para imprimir
    li $v0, 1                    # syscall: print int
    syscall

    # Exit program
    li $v0, 10                   # syscall: exit
    syscall

sqrt:
    lw $a0, 8($sp)               # Load x from the stack
    lw $a1, 4($sp)               # Load i from the stack
    bgtz $a1, sqrt_nr            # Branch if i is greater than 0
    li $v0, 1                    # Return 1 if i is 0 or negative
    jr $ra                       # Return to the caller

sqrt_nr:
    addi $a1, $a1, -1            # Decrement i by 1
    addi $sp, $sp, -12           # Allocate stack space for x, i, and return address
    sw $a0, 8($sp)               # Save x on the stack
    sw $a1, 4($sp)               # Save i on the stack
    sw $ra, 0($sp)            	 # Save return address on the stack
    jal sqrt                  	 # Recursive call
    
    lw $ra, 0($sp)            	 # Restore return address
    lw $a1, 4($sp)               # Restore i
    lw $a0, 8($sp)           	 # Restore x
    addi $sp, $sp, 12        	 # Deallocate stack space
    
    div $a0, $a0, $v0         # Calculate x / sqrt_nr(x, i - 1)
    add $a0, $a0, $v0         # Add the result of the recursive call
    srl $a0, $a0, 1           # Divide by 2 (shift right logical)
    move $v0, $a0             # Move the result to $v0
    jr $ra                    # Return to the caller