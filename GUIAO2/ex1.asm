	.data
	.text
	.globl main
main:	ori $t0, $0, 0x1234 # recebendo 0x1234 em t0
	ori $t1, $0, 0x000F # recebendo 0x000F em t1
	and $t2, $t0, $t1 # t2 = t0 & t1
	or $t3,  $t0, $t1 # t3 = t0 | t1
	nor $t4, $t0, $t1 # t4 = t0 nor t1
	xor $t5, $t0, $t1 # t5 = t0 xor t1
	jr $ra
