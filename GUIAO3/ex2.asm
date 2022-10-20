# Mapa de registos:
#	$t0 - value
#	$t1 - bit
#	$t2 - i
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

for1:	bge $t2, 32, endfor1 # while (i < 32) {
	andi $t1, $t0, 0x80000000
if1:	beq $t1, $0, else # if (bit != 0)
	li $a0, '1'
	li $v0, print_char
	syscall # print_char('1')
	j endif1
else: 	li $a0, '0'
	li $v0, print_char
	syscall # print_char('0')

endif1: sll $t0, $t0, 1 # value = value << 1
	addi $t2, $t2, 1
	j for1
	
endfor1:
	jr $ra

	
