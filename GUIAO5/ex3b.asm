# Mapa de registos
# ...
# houve_troca: $t4
# i: $t5
# lista: $t6
# lista + i: $t7
# lista + i + 1: $t3
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
	li $t0, SIZE
	li $t5, 0 # i = 0
	la $t6, lista
	
for1:	bge $t5, $t0, do # for i < 5
	sll $t2, $t5, 2 # i = i * 4
	addu $t7, $t6, $t2 # $t7 = lista + i
	li $v0, read_int
	syscall # read_int
	sw $v0, 0($t7) # lista[i] = read_int
	addi $t5, $t5, 1 # i++
	j for1

do:
	li $t4, FALSE
	li $t5, 0

for2:	bge $t5, 9, while

if:	sll $t7, $t5, 2 # i = i * 4
	addu $t7, $t7, $t6 # $t7 = lista + i
	lw $t8, 0($t7) # $t8 = lista[i]
	lw $t9, 4($t7) # $t9 = lista[i+1]
	bleu $t8, $t9, endif # if lista[i] > lista[i+1]
	sw $t8, 4($t7) # lista[i+1] = $t8
	sw $t9, 0($t7) # lista[i] = $t9
	li $t4, TRUE # houveTroca = true

endif:	addiu $t5, $t5, 1 # i++
	j for2
while:	beq $t4, TRUE, do # while $t4 == TRUE

	li $t5, 0 # i = 0
for3:	bge $t5, $t0, endfor3 # for i < SIZE
	sll $t2, $t5, 2 # i = i * 4
	addu $t7, $t6, $t2 # $t7 = lista + i
	lw $a0, 0($t7)
	li $v0, print_int10
	syscall # print_int(lista[i]) ordenada
	la $a0, str1
	li $v0, print_string
	syscall # print_string("\n")
	addiu $t5, $t5, 1
	j for3

endfor3:
	jr $ra