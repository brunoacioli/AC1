# Mapa de registos
# str: $s0
# val: $s1
# O main é, neste caso, uma sub-rotina intermédia

	.data
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv MAX_STR_SIZE, 33
str:	.space 33
	.text
	.globl main
main:
	addiu $sp, $sp, -12 # reserva espaço na stack
	sw $ra, 0($sp) # guarda os registos
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	la $s0, str
	
do3:	
	li $v0, read_int
	syscall 
	move $s1, $v0 # val = read_int()
	
	move $a0, $s1
	li $a1, 2
	la $a2, str
	jal itoa # itoa(val, 2, str)
	
	move $a0, $v0
	li $v0, print_string 
	syscall	# print_string(itoa(val, 2, str))
	
	move $a0, $s1
	li $a1, 8
	la $a2, str
	jal itoa # itoa(val, 8, str)
	
	move $a0, $v0
	li $v0, print_string
	syscall # print_string(itoa(val, 8, str))
	
	move $a0, $s1
	li $a1, 16
	la $a2, str
	jal itoa # itoa(val, 16, str)
	
	move $a0, $v0
	li $v0, print_string
	syscall # print_string(itoa(val, 16, str))
	
while3:	bne $s1, 0, do3
	
	li $v0, 0 # return 0
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addiu $sp, $sp, 12
	jr $ra
	
itoa:
	addiu $sp, $sp, -20 # reserva espaço na stack
	sw $ra, 0($sp) # guarda os registos na stack
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a2 # p = s

do:
	rem $t0, $s0, $s1 # digit = n % b
	div $s0, $s0, $s1 # n = n / b
	move $a0, $t0
	jal toascii # toascii(digit)
	sb $v0, 0($s3) # *p = s
	addiu $s3, $s3, 1 # s++
while:	bgt $s0, 0, do
	li $t1, '\0'
	sb $t1, 0($s3)
	move $a0, $s2
	jal strrev # strrev(s)
	#move $v0, $s2
	
	lw $ra, 0($sp) # devolve os registos guardados na stack
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addiu $sp, $sp, 20
	jr $ra
	
toascii:
	addi $a0, $a0, '0' # v += '0'
if:	ble $a0, '9', endif # if (v > '9')
	addiu $a0, $a0, 7 
endif:
	move $v0, $a0
	jr $ra
	
strrev:	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	move $s0, $a0
	move $s1, $a0
	move $s2, $a0

while1: lb $t1, 0($s2)
	beq $t1, '\0', endw1
	addiu $s2, $s2, 1 #
	j while1
endw1:	addi $s2, $s2, -1 # p2--

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


		
