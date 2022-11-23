# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1 
# Sub-rotina terminal: não devem ser usados registos $sx
	.data
	.eqv print_int10, 1
str1:	.asciiz "101101"
	.text
	.globl main
main:
	addiu $sp, $sp , -4
	sw $ra, 0($sp)
	la $a0, str1
	jal atoi  # atoi(str)
	move $a0, $v0
	li $v0, print_int10
	syscall # print_int10(atoi(str))
	li $v0, 0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

atoi:	li $v0, 0 # res = 0
while:	lb $t0, 0($a0)
	blt $t0, '0', endw # while ((*s >= '0') && (*s <= '9'))
	bgt $t0, '1', endw
	sub $t1, $t0, '0'
	addiu $a0, $a0, 1
	mul $v0, $v0, 2
	add $v0, $v0, $t1
	j while
endw:
	jr $ra