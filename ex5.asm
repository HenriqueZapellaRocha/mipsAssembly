.data 

vetA: .word 0,  3,  6,  9, -2, -5, -4, 5, 1, -6
vetB: .word 6, -9, -6, -3, -2,  4, -3, 2, 2, -1
vetC: .space 40

.text 
	.globl main
	
main: 

la $s0, vetA 		# pA = vetA[0]
la $s1, vetB 		# pB = vetB[0]
la $s2, vetC 		# pC = vetC[0]
la $s3, vetC+40		#pCFim = &vetC[10];

loop:

bge $s2, $s3, end

lw $t0, 0($s0)		#t0 = pa
lw $t1, 0($s1)		#t1 = pb
add $t3, $t0,$t1	# $t0 + $t1
sw $t3, 0($s2)		#s2 = $t0 + $t1

addi $s0, $s0, 4	#pa++
addi $s1, $s1, 4	#pb++
addi $s2, $s2, 4	#pc++

j loop

end: 

li $v0, 10
syscall
