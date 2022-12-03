	.data
k1:	.double 5.0
k2:	.double 9.0
k3:	.double 32.0
	.eqv print_double, 3
	.eqv read_double, 7
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	li $v0, read_double
	syscall
	mov.d $f12, $f0
	jal f2c
	mov.d $f12, $f0
	li $v0, print_double
	syscall
	
	li $v0, 0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4	
	jr $ra

f2c:	
	la $t0, k1
	l.d $f0, 0($t0)
	
	la $t0, k2
	l.d $f2, 0($t0)
	
	la $t0, k3
	l.d $f4, 0($t0)
	
	div.d $f0, $f0, $f2 # $f0 = 5.0/9.0
	sub.d $f2, $f12, $f4 # f2 = ft-32.0
	mul.d $f0, $f0, $f2 # return 5/9*(ft-32)
	
	jr $ra