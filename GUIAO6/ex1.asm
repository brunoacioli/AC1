	.data
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_char, 11
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"

array:	.word str1, str2, str3

	.text
	.globl main
# i = $t0
main:
	li $t0, 0
for:	bge $t0, SIZE, endfor # for i < SIZE: i++
	sll $t1, $t0, 2  # $t1 = i *4
	la $t2, array
	add $t1, $t2, $t1
	lw $a0, 0($t1)
	li $v0, print_string
	syscall # print_string(array[i])
	li $a0, '\n'
	li $v0, print_char
	syscall # print_char('\n')
	addi $t0, $t0, 1 # i++
	j for
endfor:
	jr $ra