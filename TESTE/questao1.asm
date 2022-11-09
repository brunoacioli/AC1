# Mapa de registos
# val: $t0
# n : $t1
# min: $t2
# max: $t3
	.data
str1:	.asciiz "\nDigite ate 20 inteiros(zero para terminar): "
str2:	.asciiz "\nMaximo/Minimo sao: "
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv print_char, 11
	
	.text
	.globl main
main:
	li $t1, 0 # n = 0
	li $t2, 0x7FFFFFFF # min = 0x7FFFFFFF
	li $t3, 0x80000000 # max = 0x80000000
	
	la $a0, str1
	li $v0, print_string
	syscall # print_string(str1)
	
do:
	li $v0, read_int
	syscall	# read_int
	move $t0, $v0
	
if:	beq $t0, 0, endif
if2:	ble $t0, $t3, if3 # if val > max
	move $t3, $t0 # max = val
	
if3:	bge $t0, $t2, endif # if val < min
	move $t2, $t0 # min = val
	
endif:
	addiu $t1, $t1, 1 # n++
	
while: 	bge $t1, 20, endw # while n < 20 && val != 0
	bne $t0, 0, do

endw:
	la $a0, str2
	li $v0, print_string
	syscall # print_string(str2)
	
	li $v0, print_int10
	move $a0, $t3
	syscall # print_int10(max)
	
	li $v0, print_char
	li $a0, ':'
	syscall	# print_char(":")
	
	li $v0, print_int10
	move $a0, $t2
	syscall # Print_int10(min)
	
	jr $ra