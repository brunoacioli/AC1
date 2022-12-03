	.data
	.eqv read_int, 5
	.eqv print_double, 3
	.eqv SIZE, 10
array:	.space 80
	.text
	.globl main
main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $t0, array
	li $t1, 0
for1:	bge $t1, SIZE, endfor1 # for i = 0; i < SIZE; i++
	li $v0, read_int
	syscall # read_int()
	
	mtc1 $v0, $f0
	cvt.d.w $f0, $f0
	sll $t2, $t1, 3 # $t2 = i*8
	add $t3, $t2, $t0
	s.d $f0, 0($t3)
	
	addiu $t1, $t1, 1 # i++
	j for1
endfor1:
	la $a0, array
	li $a1, SIZE
	jal max
	
	mov.d $f12, $f0
	li $v0, print_double
	syscall # print_double(average(*array,SIZE)
	
	li $v0, 0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	
	
max:
	move $t0, $a0	# $t0 = p
	addi $t1, $a1, -1 # $t1 = n - 1
	sll $t1, $t1, 3 # $t1 = (n-1)*3
	add $t1, $t1, $t0 # $t1 = p+n-1
	
	l.d $f0, 0($t0) # max = *p
	addiu $t0, $t0, 8 # p++
for: 	bgt $t0, $t1, endfor # for(; p <= u; p++) {
	l.d $f2, 0($t0) # $f2 = *p
	
if:	c.le.d $f2, $f0 # if (*p > max) {
	bc1t endif
	mov.d $f0, $f2

endif:	
	addiu $t0, $t0, 8 # p++
	j for
endfor:
	jr $ra
	