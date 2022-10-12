# Mapa de registos:
# $t0 - soma
# $t1 - value
# $t2 - i
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "Valor ignorado \n"
str3:	.asciiz "A soma dos positivos e: "
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_int10, 1
	
	.text
	.globl main
	
main:	li $t0, 0 # soma = 0
	li $t2, 0 # i = 0

for1:	bge $t2, 5, endfor # while (i < 5)
	la $a0, str1
	ori $v0, $0, print_string
	syscall # print_string(str1)
	ori $v0, $0, read_int
	syscall # read_int()
	ori $t1, $v0, $0 # t1 = value
	
if1:	ble $t1, $0, else1 # if (value > 0)
	add $t0, $t0, $t1 # soma += value
	j endif1

else1:	la $a0, str2
	ori $v0, $0, print_string
	syscall	# print_string(str2)
	 