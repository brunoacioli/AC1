	.data
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv print_int10, 1
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4: 	.asciiz "\nString #"
str5:	.asciiz ": "


array:	.word str1, str2, str3

	.text
	.globl main
# p = $t1
# pultimo = $t2
# **p2 = $t3
# i = $t4
# **pultimo2 = $t5
main:
	la $t1, array
	li $t2, SIZE
	sll $t2, $t2, 2
	addu $t2, $t2, $t1 # $t2 = pultimo
	li $t4, 0 # i = 0
for:	bge $t1, $t2, endfor # for p < pultimo; p++
	li $v0, print_string # 
	la $a0, str4
	syscall # print_string(str4)
	li $v0, print_int10
	move $a0, $t4
	syscall # Print_int10(i)
	li $v0, print_string
	la $a0, str5
	syscall # Print_string(str5)
	lw $t6, 0($t1) #
while: 
	lb $a0, 0($t6)
	beq $a0, '\0', endw # 
	li $v0, print_char
	syscall # 
	li $v0, print_char
	li $a0, '-'
	syscall # 
	addiu $t6, $t6, 1
	j while
endw:
	addiu $t1, $t1, 4
	j for
endfor:
	jr $ra
	