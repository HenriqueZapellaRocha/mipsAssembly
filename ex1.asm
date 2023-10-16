.data

i: .word 4
j: .word 0
newline: .asciiz "\n"

.text 
	.globl main
main:

li $v0, 5
syscall 
move $t1, $v0
lw $t0, i

beq $t0, $t1, labe1

subi $t1,$t1,1

j label2


labe1:
addi $t0,$t0, 2

label2:
move $a0, $t0
li $v0, 1
syscall 

li $v0, 4         # Carregue o código do serviço de impressão de string em $v0
    la $a0, newline   # Carregue o endereço da string de nova linha em $a0
    syscall           # Chame o sistema para imprimir a string


move $a0, $t1
li $v0, 1
syscall 
