# Mapa de registos
# $t0 - gray
# $t1 - mask
# $t2 - bin
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nValor em codigo Gray: "
str3:	.asciiz "\nValor em binario: "
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_int16, 34
	.text
	.globl main
	
main:	la $a0, str1
	li $v0, print_string
	syscall # print_string(str1)
	
	li $v0, read_int
	syscall # read_int()
	move $t0, $v0 # gray = read_int()
	srl $t1, $t0, 1 # mask = gray >> 1
	move $t2, $t0 	# bin = gray
	
while1:	beq $t1, 0, endwhile1 # while( mask != 0) {
	xor $t2, $t2, $t1 # bin = bin ^ mask
	srl $t1, $t1, 1 	# mask = mask >> 1
	j while1

endwhile1:
	la $a0, str2
	li $v0, print_string
	syscall # print_string(str2)
	
	move $a0, $t0
	li $v0, print_int16
	syscall # print_int16(gray)
	
	la $a0, str3
	li $v0, print_string
	syscall # print_string(str3)
	
	move $a0, $t2
	li $v0, print_int16
	syscall # print_int16(bin)

	