	.data
	.eqv print_string, 4
str1:	.asciiz "Arquitetura de "
str2:	.space 50
str3:	.asciiz "\n"
str4:	.asciiz "Computadores I"
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str2
	la $a1, str1
	jal strcpy
	la $a0, str2
	li $v0, print_string
	syscall # print_String(str2)
	
	la $a0, str3
	li $v0, print_string
	syscall # print_string("\n")
	
	la $a0, str2
	la $a1, str4
	jal strcat # strcat(str2, "Computadores I" )
	
	move $a0, $v0
	li $v0, print_string
	syscall # print_string(strcat(str2, "Computadores I" ))
	
	li $v0, 0
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8 # devolve espaço na stack
	jr $ra
	
strcat:
	addiu $sp, $sp, -8 # guarda espaço na stack
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	move $s0, $a0 # $s0 = p
	move $t1, $a1
	
while1:	lb $t0, 0($a0) # $t0 = *p
	beq $t0, '\0', endw1
	addiu $a0, $a0, 1 # p++
	j while1
endw1:
	jal strcpy
	move $v0, $s0
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
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