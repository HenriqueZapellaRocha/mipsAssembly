.data 

vet: .word 0,1,2,3,4,5,6,7,8,9	#carrega o vetor na memoria

.text 
	.globl main
	
main:

la $a0, vet 		#armazena primeira posicao do vetor
la $a1, vet+36		#armazena ultima posicao do vetor
	
loop:			#while(p <= pfim)
bge $a1, $a0, fim  	#<=
jal swap

addi $a0, $a0, 4
subi $a1, $a1, 4

j loop
fim:

li $v0, 10
syscall 

swap:

lw $t0, 0($a0)		#aux = p
lw $t1	0($a1)		
sw $t1, 0($a0)
sw $t0, 0($a1)

jr $ra
