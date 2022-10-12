	.data # Data sagment
	.text # Code segment
	.globl main

main:	ori $t0, $0, 3 # $t0 = 3
	ori $t2, $0, 8 # $t2 = 8
	add $t1, $t0, $t0 #  $t1 = $t0 + $t0 = $t1 + 3 + 3
	add $t1, $t1, $t2 # $t1 = $t1 + $t2  = $t2
	jr $ra # fim do programa