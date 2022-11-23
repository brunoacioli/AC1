# Mapa de registos:
# str: $a0 -> $s0 (argumento é passado em $a0)
# p1: $s1 (registo callee-saved)
# p2: $s2 (registo callee-saved)
#
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