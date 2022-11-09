	.data
X1:	.asciiz "TEST1"	 
	.align 2
X2:	.space 20
X3:	
	.text
	.globl main
main:	la $t4, X2 # 1
	ori $t5, $0, 4 # 2 
	xor $t0, $t0, $t0 # 3
	xor $t1, $t1, $t1 # 4
L1:	beq $t0, $t5, L2 # 5
	add $t2, $t0, $t0 # 6
	add $t3, $t2, $t2 # 7
	addu $t3, $t3, $t4 # 8
	sw $t2, 0($t3) # 9
	add $t1, $t1, $t2 # 10
	addi $t0, $t0, 1 # 11
	j L1 # 12
L2:	sw $t1, 4($t3) # 13
	jr $ra
