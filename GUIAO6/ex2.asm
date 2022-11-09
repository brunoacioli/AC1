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

# $t1 = p
# $t2 = pultimo
main:	la $t1, array
	li $t2, SIZE
	sll $t2, $t2, 2 # $t2 = $t2 * 4
	add $t2, $t1, $t2 # $t2 = $t1 + $t2 = pultimo
for:	bge $t1, $t2, endfor
	lw $a0, 0($t1)
	li $v0, print_string
	syscall # print_string(*p)
	li $v0, print_char
	li $a0, '\n'
	syscall # print_char('\n')
	addiu $t1, $t1, 4 # p++
	j for
endfor:
	jr $ra
	