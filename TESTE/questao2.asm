#	Mapa de registos
#	i: $t0
#	v: $t1
#	&val[0]: $t2
	.data
val:	.word 8,4,15,-1987,327,-9,27,16
str1:	.asciiz "Result is: \n"
	.eqv SIZE, 8
	.eqv print_int10, 1
	.eqv print_char, 11
	.eqv print_string, 4
	
	.text
	.globl main
	
main:	
	li $t0, 0 # i = 0
	la $t2, val # $t2 = val
	li $t3, SIZE # $t3 = SIZE
	div $t3, $t3, 2 # $t3 = size/2
	sll $t4, $t3, 2 # $t4 = SIZE/2 *4
	addu $t4, $t4, $t2 # $t4 = &val[SIZE/2]

do:	
	sll $t5, $t0, 2 # $t5 = i*4
	addu $t8, $t4, $t5 # $t4 = &val[SIZE/2 + i] 
	addu $t7, $t5, $t2 # $t5 = &val[i]
	lw $t1, 0($t7) # v = val[i]
	lw $t6, 0($t8) # $t6 = val[SIZE/2 +i]
	sw $t6, 0($t7) # val[i] = val[SIZE/2 +i]
	sw $t1, 0($t8) # val[SIZE/2 +i] = v
	
	
while:	addiu $t0, $t0, 1 # i++
	blt $t0, $t3, do # while i < SIZE/2
	
	
	la $a0, str1
	li $v0, print_string
	syscall # print_string(str1)
	li $t0, 0 # i= 0
	la $t2, val
do2:
	sll $t5, $t0, 2 # $t5 = i * 4
	addu $t5, $t5, $t2 # $t5 = &val[i]
	li $v0, print_int10
	lw $a0, 0($t5)
	syscall # print_int10(val[i++])
	addiu $t0, $t0, 1 # 
	li $v0, print_char
	li $a0, ','
	syscall # print_char(',')
while2:	blt $t0, SIZE, do2

	jr $ra
	

	