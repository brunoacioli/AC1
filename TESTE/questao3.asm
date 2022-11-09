#	Mapa de registos
#	$t0 -> n_even
#	$t1 -> n_odd
#	$t2 -> p1
#	$t3 -> p2

	.data
	.eqv	print_int10, 1
	.eqv	read_int, 5
	.eqv 	N, 5
a:	.space 20
be:	.space 20

	.text
	.globl main
main:
	li $t0, 0 # n_even = 0
	li $t1, 0 # n_odd = 0
	la $t2, a # p1 = a
	li $t4, N # $t4 = N
	sll $t4, $t4, 2 # $t4 = N*4
	addu $t4, $t4, $t2 # $t4 = a + N

for1:	bge $t2, $t4, endfor1 # for p1 = a; p1<(a+N); p1++
	li $v0, read_int
	syscall # read_int()
	sw $v0, 0($t2)
	addiu $t2, $t2, 4 # p++
	j for1

endfor1:
	la $t2, a # 
	la $t3, be # $t3 = b

for2:	bge $t2, $t4, endfor2 # for p1=a; p2=b; p1 <(a+N); p1++
	lw $t5, 0($t2) # $t5 = *p1
	rem $t6, $t5, 2 # $t6 = *p1%2

if1:	beq $t6, 0, else # if *p1%2 != 0
	sw $t5, 0($t3) # *p2++ = *p1
	addiu $t3, $t3, 4 # p2++
	addiu $t1, $t1, 1 # n_odd++
	j endif
else:	
	addiu $t0, $t0, 1 # n_even++
endif:	
	addiu $t2, $t2, 4 # p1++
	j for2
endfor2:
	la $t3, be
	move $t4, $t1
	sll $t4, $t4, 2 # $t4 = n_odd * 4
	addu $t4, $t4, $t3 # $t4 = b + n_odd

for3:	bge $t3, $t4, endfor3
	li $v0, print_int10
	lw $a0, 0($t3)
	syscall 	# print_int10(*p2)
	addiu $t3, $t3, 4 # p2++
	j for3
endfor3:
	jr $ra

	 
	