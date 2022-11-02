# Mapa de Registos
# $t0 = p
# $t1 = *p
	
	.data
	.eqv read_string, 8
	.eqv print_string, 4
	.eqv SIZE, 20
str1:	.asciiz "Introduza uma string: "
str:	.space 21
	.text
	.globl main
main:	
	la $a0, str1
	li $v0, print_string
	syscall	# print_string(str1)
	la $a0, str
	li $a1, SIZE
	li $v0 , read_string
	syscall	# read_string()
	la $t0, str
while:
	lb $t1, 0($t0)
	beq $t1, '\0', endw
if1:	blt $t1, 'a', endif1
	bgt $t1, 'z' endif1
	sub $t1, $t1, 0x61 # *p = *p - 'a'
	addi $t1, $t1, 0x41 # *p = *p + 'A'
	sb $t1, 0($t0)
endif1:
	addi $t0, $t0, 1 # p++
	j while
endw:
	la $a0, str
	li $v0, print_string
	syscall	# print_string(str)
	jr $ra
	