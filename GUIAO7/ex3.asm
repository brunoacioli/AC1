	.data
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv SIZE, 30
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"
str2:	.space 31
str3:	.asciiz "\n"
str4:	.asciiz "String too long: "
	
	.text
	.globl main
main:
	addi $sp, $sp, -4 # reserva espaço na stack
	sw $ra, 0($sp) # guarda os registos
	
	la $a0, str1 
	jal strlen # strlen(str1)
	move $t0, $v0 # $t0 = strlen(str1)

if:	bgt $t0, SIZE, else # if(strlen(str1) <= SIZE)
	la $a0, str2
	la $a1, str1
	jal strcpy
	
	move $a0, $v0
	li $v0, print_string
	syscall # print_string(str2)
	
	la $a0, str3
	li $v0, print_string
	syscall # print_string("\n")
	
	la $a0, str2
	jal strrev
	move $a0, $v0
	li $v0, print_string
	syscall # print_string(strrev(str2));
	li $v0, 0 # exit_value = 0
	j endif

else:
	la $a0, str4
	li $v0, print_string
	syscall # print_string(str4)
	
	la $a0, str1
	jal strlen # strlen(str1)
	move $a0, $v0
	li $v0, print_int10
	syscall # print_int10(strlen(str1))
	li $v0, -1

endif:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	
strcpy:
	li $t0, 0 # i = 0
do:	
	addu $t1, $a0, $t0 # $t1 = &dst[i]
	addu $t2, $a1, $t0 # $t2 = &src[i]
	lb $t2, 0($t2) # $t2 = src[i]
	sb $t2, 0($t1) # dst[i] = src[i]
	addiu $t0, $t0, 1 # i++
while:	bne $t2, '\0', do # while (src[i] != '\0')
	move $v0, $a0 # return dst
	jr $ra
	
strlen:	
	li $t1, 0 # len = 0
while1:	lb $t0, 0($a0) # while(*s++ != '\0')
	beq $t0, '\0', endw1 # 
	addiu $a0, $a0, 1 # 
	addi $t1, $t1, 1 # len++
	j while1

endw1:	move $v0, $t1 # return len
	jr $ra
	
strrev:	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	move $s0, $a0
	move $s1, $a0
	move $s2, $a0

while3: lb $t1, 0($s2)
	beq $t1, '\0', endw3
	addiu $s2, $s2, 1 #
	j while3
endw3:	addi $s2, $s2, -1 # p2--

while2:	bge $s1, $s2, endw2 	# while (p1 < p2)
	move $a0 ,$s1 
	move $a1, $s2
	jal exchange	# exchange(p1,p2)
	addi $s1, $s1, 1
	addi $s2, $s2, -1
	j while2

endw2:
	move $v0, $s0
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addiu $sp, $sp, 16
	jr $ra
	
exchange:
	lb $t0, 0($a0)
	lb $t1, 0($a1)
	sb $t0, 0($a1)
	sb $t1, 0($a0)
	jr $ra

