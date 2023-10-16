.macro power (%base, %expoente)

	li $v0, 1

loop:	ble %expoente, $zero, retorno

	mul $v0, $v0, %base

	subi %expoente, %expoente, 1

	j loop

retorno:

.end_macro

.text

  	.globl main

main:	lw $t0, a

	lw $t1, b

	power($t0, $t1)		# |

	sw $v0, res1		# +-> #   res1 = power(a, b);

	lw $t0, a

	lw $t1, b

	power($t1, $t0)		# |

	sw $v0, res2		# +-> #   res2 = power(b, a);
	
	lw $a0, res1
	li $v0,1
	syscall 
	
	lw $a0, res2
	li $v0,1
	syscall 

	li $v0, 10		# | $v0=10 encerra programa

	syscall			# +-> chamada ao SO }

	

.data

a: .word 2

b: .word 3

res1: .space 4

res2: .space 4

