.data
    
nomes:.asciiz	"Integrantes: <Henrique Zapella Rocha, Lucas Weiss>"
valores:.asciiz	"\n\nValores de (m,n): \n"
explicacao: .asciiz"\nDigite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execucao"
resultado: .asciiz"resultado: A("
virgula: .asciiz ","
resultadod: .asciiz ") = "

.text
	.globl main  	
main:


la $a0, nomes
la $v0, 4
syscall 
 
la $a0, explicacao
syscall 

li $a0, 1   #m = 1
li $a1, 2   # n = 0
li $t2, 0   #A(m, n)

#loop para insercao de m e n. finaliza caso a entrada de m seja m < 0
loop:

la $a0, valores
la $v0, 4
syscall 

li $v0, 5 #codigo para ler inteiro. M
syscall  #chama o sistema operacinal

#m < 0
bltz $v0, fechaPrograma # caso o numero de entrada seja negativo, vai para o trecho de codigo que fecha o programa

move $a0, $v0 # passa o valor de M do registrador v0 para a0
move $t3, $v0 # guarda o valor de M para escrever no terminal na parte de resultado

li $v0, 5 #codigo para ler inteiro. n
syscall  #chama o sistema operacinal

move $a1, $v0 # passa o valor de n do registrador v0 para a1
move $t4, $v0 # guarda o valor de N para escrever no terminal na parte de resultado

move $t0, $a0 # passa o valor de a0 para t0
move $t1, $a1 # passa o valor de a1 para t1
move $t2, $v0 # passa o valor de v0, registraador de retorno de funcao, para t2

jal ackermann # chama a funcao de ackermann

# imprime resultado: A("
la $a0, resultado
la $v0, 4
syscall 

#imprime o valor de M na tela
move $a0, $t3
la $v0, 1
syscall 

#imprime a virgula
la $a0, virgula
la $v0, 4
syscall 

#imprime o N na tela
move $a0, $t4
la $v0, 1
syscall 

#imprime ") = " na tela
la $a0, resultadod
la $v0, 4
syscall 

move $a0, $t2 #copia o resultado da funcao para o registrador $a0. Para imprimir
li $v0, 1     # codigo para impirmir um inteiro
syscall	      #chamada do sistema operacional	

jal loop #volta PARA O INCIOO DO LOOP	

#funcao que termina o programa
fechaPrograma:
li $v0, 10   #codigo para sair do programa
syscall      #chamada do sistema operacional

#funcao de ackermann
ackermann:

subi $sp, $sp,  16  # rserva na pilha
sw   $ra, 12($sp)   # reserva endereco de retorno
sw   $t0, 8($sp)    # reserva m
sw   $t1, 4($sp)    # reserva n
sw   $t2, 0($sp)    # reserva A(m,n)

move $t0, $a0  #move $a0 para $t0
move $t1, $a1  #move $a1 para $t1
move $t2, $v0  #move $v0 para $t2

#m > 0
bgtz $t0 testador
# m  = 0
beq $t0, $zero, primeirotipo

#be not equal bne
#be equal beq


#m = 0
primeirotipo:

# n + 1
addi $t2, $t1, 1 # armazena no registrador $t2 que possui o resultad, no caso A(M,N)
jal fim  #pula para o fim da funcao de ackeman

#verifica se temos no momneto o segun do ou terceiro caso, ou seja se n = 0 ou se n > 0
testador:
# n = 0
beq $t1, $zero, segundoCaso # pula para o caso A(M-1,1) se m > 0  e n = 0
# n > 0
bgtz $t0, terceiroCaso #pula para o terceiro caso A(m-1, A(M, N-1)) se M > 0 e n > 0

#A(m-1, 1)
segundoCaso: 

subi $a0, $t0, 1  #m-1
li $a1, 1 # n = 1
jal ackermann # volta para ackeman 
move $t2, $v0 #passa o resultado para o registrador que guarda o resultado da funcao 
jal fim       #pula para o fim da funcao de ackeman


terceiroCaso:
move $a0, $t0   #inseri o valor de M contido em t0 em a0
subi $a1, $t1, 1 # N-1
jal ackermann	# chama a funcao de ackeman pasando:  A(m, A(M, N-1))
move $a1, $v0   #pega o rsultado da chama e colocar em a1
subi $a0,$a0, 1 # M-1
jal ackermann	#chama a funcao de ackeman pasando: A(M - 1, resultado anterior)
move $t2, $v0   #passa o valor de retorno para o registrador que armazena o resultado da funcao ackeman


fim:

#move para o registrador que retorna os valores de funcao
move $v0, $t2

#carrega os registradores guardados na pilha
lw   $ra, 12($sp)
lw   $a0, 8($sp)
lw   $a1, 4($sp)
lw   $t0, 0($sp)

#limpa a pilha
addi $sp, $sp, 16  #limpa a pilha
#retrona para a main de onde a funcao foi chamada
jr $ra


