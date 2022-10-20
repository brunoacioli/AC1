# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i

	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binario e: "
 	.eqv print_string, 4
 	.eqv read_int, 5
 	.eqv print_char, 11
 	.text
 	.globl main
 main:	la $a0, str1
 	li $v0, print_string
 	syscall # print_string(str1)
 	li $v0, read_int
 	syscall # read_int()
 	or $t0, $v0, $0
 	la $a0, str2
 	li $v0, print_string
 	syscall	# print_string(str2)
 	
 	li $t2, 0
for1:	bge $t2, 32, endfor1 # for (i = 0; i < 32; i++) {
	rem $t3, $t2, 4 # $t3 = i % 4
 	andi $t1, $t0, 0x80000000
 	srl $t1, $t1, 31
 
	
 if1: 	bne $t3, $0, if2
 	li $a0, ' '
 	li $v0, print_char
 	syscall # print_char(' ')
 	
 if2:	addi $t4, $t1, 0x30
 	move $a0, $t4
 	li $v0, print_char
 	syscall	# print_char(0x30 + bit)
 	sll $t0, $t0, 1 # value = value << 1
	addi $t2, $t2, 1
	j for1
	
endfor1:
	jr $ra