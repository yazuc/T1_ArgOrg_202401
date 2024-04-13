.data
    prompt1: .asciiz "Programa de Raiz Quadrada – Newton-Raphson\n"
    prompt2: .asciiz "Desenvolvedores: Leonardo T. Rubert\n"
    prompt3: .asciiz "Digite os parâmetros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execução\n"
    result_prompt: .asciiz "%d\n"
    neg_one: .word -1
.text
.globl main

sqrt_nr:
    # Prologue
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a1, 0($sp)

    # Function Body
    beq $a1, $zero, return_one   # if(i == 0) return 1

    slti $t0, $a1, 0             # if(i < 0)
    bne $t0, $zero, return_zero  # return 0

    addi $sp, $sp, -8            # allocate stack space
    jal sqrt_nr                  # recursive call sqrt_nr(v, i - 1)
    lw $t0, 0($sp)               # retrieve result
    addi $sp, $sp, 8             # deallocate stack space

    div $a0, $a0, $t0            # v / sqrt_nr(v, i - 1)
    add $a0, $a0, $t0            # sqrt_nr(v, i - 1) + (v / sqrt_nr(v, i - 1))
    srl $a0, $a0, 1              # (sqrt_nr(v, i - 1) + (v / sqrt_nr(v, i - 1))) / 2

return_zero:
    move $v0, $a0                # store result
    lw $a1, 0($sp)               # restore $a1
    lw $ra, 4($sp)               # restore $ra
    addi $sp, $sp, 8             # deallocate stack space
    jr $ra                       # return

return_one:
    li $v0, 1                    # return 1
    jr $ra                       # return

main:
    li $v0, 4                    # syscall: print string
    la $a0, prompt1              # address of prompt1
    syscall

    li $v0, 4                    # syscall: print string
    la $a0, prompt2              # address of prompt2
    syscall

    li $v0, 4                    # syscall: print string
    la $a0, prompt3              # address of prompt3
    syscall

read_input:
    li $a0, 100                  # Set x as 100
    li $a1, 2                    # Set i as 2

    jal sqrt_nr                  # call sqrt_nr
    move $a0, $v0                # move return value to $a0

    li $v0, 1                    # syscall: print integer
    syscall

    j read_input                 # loop back to read_input

end_program:
    li $v0, 10                   # syscall: exit
    syscall
