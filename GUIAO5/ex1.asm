# i: $t0
# lista: $t1
# lista + i: $t2
	.data
	.eqv SIZE, 5
str:	.asciiz "\nIntroduza um numero: "
	.align 2
lista:	.space 20
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_int10, 1
	.text
	.globl main

main:	li $t0, 0 # i = 0
while1:	bge $t0, SIZE, endw
	la $a0, str
	li $v0, print_string
	syscall	# print_string(str)
	li $v0, read_int
	syscall	# read_int()
	la $t1, lista # $t1 = &lista[0]
	sll $t2, $t0, 2 # i = i *4
	addu $t2, $t2, $t1
	sw $v0, 0($t2)
	addi $t0, $t0, 1 # i++
	j while1
	
#endw:	li $t0, 0
#while2: bge $t0, SIZE, endw2
#	sll $t3, $t0, 2
#	addu $t3, $t3, $t1
#	lw $t4, 0($t3)
#	move $a0, $t4
#	li $v0, print_int10
#	syscall
#	addi $t0, $t0, 1
#	j while2
	
endw:
	jr $ra 	# termina o programa