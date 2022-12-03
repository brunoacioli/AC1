	.data
	.eqv read_int,5
	.eqv print_float, 2
k1:	.float 2.59375
k2:	.float 0.0
	.text
	.globl main
#res: $f0
#val: $t0
main:
do:	li $v0, read_int
	syscall
	move $t0, $v0 # val = read_int
	
	la $t1, k1
	l.s $f0, 0($t1) # f0 = 2.59375
	
	mtc1 $t0, $f2 # pass $t0 to $f2 
	cvt.s.w $f2, $f2 # $f2 = (float)val
	
	mul.s $f0, $f2, $f0 # res=(float)val * 2.59375
	li $v0, print_float
	mov.s $f12, $f0
	syscall
	
	la $t1, k2
	l.s $f2, 0($t1) # $f2 = 0.0
	
	c.eq.s $f0, $f2
	bc1f do
	
	jr $ra
	