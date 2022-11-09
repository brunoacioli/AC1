# Mapa de registos
# ...
# houve_troca: $t4
# p: $t5
# pUltimo: $t6 

	.data
lista:	.space 40
str1:	.asciiz "\n"
	.eqv FALSE, 0
	.eqv TRUE, 1
	.eqv SIZE, 10
	.eqv read_int, 5
	.eqv print_int10, 1
	.eqv print_string, 4
	
	.text
	.globl main
main:
	li $t6, SIZE
	la $t5, lista # p = lista
	sub $t6, $t6, 1
	sll $t6, $t6, 2
	addu $t6, $t5, $t6 # pUltimo = lista + (SIZE-1)
	
for1:	bgt $t5, $t6, endfor1 # for p =< pUltimo
	li $v0, read_int
	syscall 	# read_int()
	sw $v0, 0($t5)
	addiu $t5, $t5, 4 # p++
	j for1

endfor1:
	la $t5, lista
	
do:
	li $t4, FALSE
	
	li $t6, SIZE
	la $t5, lista # p = lista
	sub $t6, $t6, 1
	sll $t6, $t6, 2
	addu $t6, $t5, $t6 # pUltimo = lista + (SIZE-1)
	
for2:	bge $t5, $t6, while # for p < pUltimo

	lw $t7, 0($t5) # $t7 = *p
	lw $t8, 4($t5) # $t8 = *(p+1)

if:	ble $t7, $t8, endif # if *p > *(p+1)
	sw $t8, 0($t5) # *p = $t8
	sw $t7, 4($t5) # *(p+1) = $t7
	li $t4, TRUE

endif:	
	addiu $t5, $t5, 4
	j for2

while:	beq $t4, TRUE, do

	li $t6, SIZE
	la $t5, lista # p = lista
	sub $t6, $t6, 1
	sll $t6, $t6, 2
	addu $t6, $t5, $t6 # p6 = lista + (SIZE-1)
	
for3:	bgt $t5, $t6, endfor3
	li $v0, print_int10
	lw $a0, 0($t5)
	syscall	# print_int10(*P)
	li $v0, print_string
	la $a0, str1
	syscall	# print_string("\n")
	addiu $t5, $t5, 4 # p++
	j for3
endfor3:
	jr $ra
	
