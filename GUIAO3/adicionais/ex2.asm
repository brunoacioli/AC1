# Mapa de Registos
# $t0 - mdor
# $t1 - mdo
# $t2 - res
# $t3 - i
	
	.data
str1:	.asciiz "Introduza dois numeros: "
str2:	.asciiz "Resultado: "
	.eqv  print_string, 4
	.eqv read_int, 5
	.eqv print_int10, 1
	
	.text
	.globl main
main:	la $a0, str1
	li $v0, print_string
	syscall # print_string(str1)
	
	li $v0, read_int
	syscall # read_int()
	andi $t0, $v0, 0x0F # mdor = read_int() & 0x0F
	
	li $v0, read_int
	syscall # read_int()
	andi $t1, $v0, 0x0F # mdo = read_int() & 0x0F
	li $t3, 0 # i = 0

while:	beq $t0, 0, endw # while( (mdor != 0) && (i++ < 4) )
	bge $t3, 4, endw
	
	andi $t4, $t0, 0x00000001 # $t4 = mdor & 0x00000001
if1:	beq $t4, 0, endif1	# if ((mdor &  0x00000001) != 0)
	add $t2, $t2, $t1 	# res = res + mdo
	j endif1

endif1:	
	sll $t1, $t1, 1 # mdo = mdo << 1
	srl $t0, $t0, 1	# mdor = mdor >> 1
	j while

endw:	la $a0, str2
	li $v0, print_string
	syscall 	# print_string(str2)
	move $a0, $t2
	li $v0, print_int10
	syscall	# print_int10(res)
	jr $ra
