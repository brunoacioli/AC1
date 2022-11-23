	.data
str:	.asciiz "Arquitetura de Computadores I"
	.eqv print_int10, 1
	.text
	.globl main
	
main:	
	addiu $sp, $sp, -4 # fazer espaço na pilha
	sw $ra, 0($sp) # salva $ra na pilha
	la $a0, str # str = arg0 de strlen
	jal strlen # strlen(str)
	move $a0, $v0 # $a0 = $v0 = retorno de strlen
	li $v0, print_int10 
	syscall # print(strlen(str))
	li $v0, 0 # return 0
	lw $ra, 0($sp) # devolve o valor de $ra
	addiu $sp, $sp, 4 # repoe a stack
	jr $ra
	
strlen:	
	li $t1, 0 # len = 0
while:	lb $t0, 0($a0) # while(*s++ != '\0')
	beq $t0, '\0', endw # 
	addiu $a0, $a0, 1 # 
	addi $t1, $t1, 1 # len++
	j while

endw:	move $v0, $t1 # return len
	jr $ra