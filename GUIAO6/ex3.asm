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

# i = $t0
# j = $t1
# array[i][j] = $t3

main:
	li $t0, 0 # i = 0
	
for:	bge $t0, SIZE, endfor
	li $v0, print_string
	la $a0, str4
	syscall 	# print_string(str4)
	li $v0, print_int10
	move $a0, $t0
	syscall # print_int10(i)
	li $v0, print_string
	la $a0, str5
	syscall # print_string(str5)
	
	li $t1, 0 # j = 0
	
	
while:		# while(array[i][j] != '\0')
	la $t3, array # $t3 = &array[0]
	sll $t2, $t0, 2 # 
	add $t3, $t3, $t2 # $t3 = &array[i]
	lw $t3, 0($t3) # $t3 = array[i] = &array[i][0]
	addu $t3, $t3, $t1 # $t3 = &array[i][j]
	lb $t3, 0($t3) # $t3 = array[i][j]
	beq $t3, '\0', endw 
	move $a0, $t3
	li $v0, print_char
	syscall 	# print_char(array[i][j])
	li $v0, print_char
	li $a0, '-'
	syscall # print_char('-')
	addiu $t1, $t1, 1 # j++
	j while
endw:
	addiu $t0, $t0, 1 # i++
	j for
endfor:
	jr $ra
