	.data
	.eqv print_string, 4
	.eqv print_int10, 1
str1:	.asciiz "Nr de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
	
	.text
	.globl main
# $t0 = i
main:	li $t0, 0 # i = 0
	move $t2, $a0 # $t2 = argc
	la $a0, str1
	li $v0, print_string
	syscall # print_string(str1)
	li $v0, print_int10
	move $a0, $t2
	syscall # print_int10(argc)
	
for:	bge $t0, $t2, endfor # for i = 0; i < argc; i++
	la $a0, str2
	li $v0, print_string
	syscall 	# print_string(str2)
	li $v0, print_int10
	move $a0, $t0
	syscall #print_int10(i)
	la $a0, str3
	li $v0, print_string
	syscall # print_string(": ")
	sll $t1, $t0, 2 
	add $t1, $t1, $a1 # $t1 = &argv[i]
	lw $a0, 0($t1) # $a0 = argv[i]
	li $v0, print_string
	syscall # print_string(argv[i])
	addiu $t0, $t0, 1 # i++
	j for
endfor:
	jr $ra
	
	
	
	
