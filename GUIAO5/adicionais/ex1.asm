# Mapa de Registos
# $t0: i
# $t1: j
# $t2: lista
# $t3: &lista[i]
# $t4: &lista[j]

	.data
lista:	.space 40
str1:	.asciiz "\n"
	.eqv SIZE, 10
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv read_int, 5
	.text
	.globl main

main:
	li $t0, 0 # i=0
	la $t2, lista

for1:	bge $t0, SIZE, endfor1 # for i < SIZE
	sll $t3, $t0, 2 # $t5 = i*4
	addu $t3, $t3, $t2 # $t3 = &lista[i]
	li $v0, read_int
	syscall # read_int()
	sw $v0, 0($t3) # lista[i] = read_int()
	addiu $t0, $t0, 1 # i++
	j for1

endfor1:
	la $t2, lista 
	li $t0, 0 # i = 0
	li $t9, SIZE
	sub $t9, $t9, 1 # $t9 = size - 1

for2:	bge $t0, $t9, endfor2 # for i < SIZE-1
	sll $t3, $t0, 2 # i = i*4
	addu $t3, $t3, $t2 # $t3 = &lista[i]
	addi $t1, $t0, 1 # $t3: j = i + 1

for3:	bge $t1, SIZE, endfor3
	sll $t4, $t1, 2 # j = j*4
	addu $t4, $t4, $t2 # $t4 = &lista[j]
	lw $t5, 0($t3) # $t5 = lista[i}
	lw $t6, 0($t4) # $t6 = lista[j]

if: 	ble $t5, $t6, endif # if lista[i] > lista[j]
	sw $t6, 0($t3) # lista[i] = lista[j]
	sw $t5, 0($t4) # lista[j] = lista[i]
	
endif:
	addiu $t1, $t1, 1 # j++
	j for3

endfor3:
	addiu $t0, $t0, 1 # i++
	j for2

endfor2:
	li $t0, 0 # i=0
	la $t2, lista

for4:	bge $t0, SIZE, endfor4 # for i < SIZE
	sll $t3, $t0, 2 # $t5 = i*4
	addu $t3, $t3, $t2 # $t3 = &lista[i]
	li $v0, print_int10
	lw $a0, 0($t3)
	syscall # print_int10()
	li $v0, print_string
	la $a0, str1
	syscall	# print_string("\n")
	addiu $t0, $t0, 1 # i++
	j for4
	
endfor4:
	jr $ra