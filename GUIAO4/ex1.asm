# Mapa de registos
# num: $t0
# i: $t1
# str: $t2
# str+i: $t3
# str[i]: $t4 
	.data
	.eqv	SIZE, 20
	.eqv	read_string, 8
	.eqv 	print_int10, 1
str:	.space	21
	.text
	.globl main
main:	la $a0, str	# $a0 = &str[0]
	li $a1, SIZE
	li $v0, read_string
	syscall	# read_string(str, SIZE)
	li $t0, 0 # num = 0
	li $t1, 0 # i = 0
	lb $t4, 0($a0)
	
while1:
	la $t2, str
	addu $t3, $t2, $t1 # $t3 = str + i
	lb $t4, 0($t3)
	beq $t4, '\0', endw1
	
if1:	blt $t4, '0', endif1
	bgt $t4, '9', endif1
	
	addi $t0, $t0, 1	# num++

endif1:
	addi $t1, $t1, 1 # i++
	j while1

endw1:	li $v0, print_int10
	move $a0, $t0
	syscall # print_int10(num)
	jr $ra