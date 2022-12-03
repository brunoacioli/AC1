	.data
	.eqv read_int, 5
	.eqv print_double, 3
	.eqv SIZE, 10	
k1:	.double 0.0
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
	jal average
	
	mov.d $f12, $f0
	li $v0, print_double
	syscall # print_double(average(*array,SIZE)
	
	li $v0, 0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	
average:
	la $t0, k1
	l.d $f0, 0($t0) # sum = 0.0
	
	move $t0, $a1 # $t0 = n
for:	ble $t0, 0, endfor # for i = n; i >0; i--
	addi $t0, $t0, -1 # i--
	sll $t1, $t0, 3
	addu $t1, $a0, $t1
	l.d $f2, 0($t1)
	add.d $f0, $f0, $f2 # sum += array[i-1]
	
	j for

endfor:
	mtc1.d $a1, $f2
	cvt.d.w $f2, $f2
	div.d $f0, $f0, $f2
	jr $ra	
	
