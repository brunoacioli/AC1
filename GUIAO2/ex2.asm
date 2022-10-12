	.data
	.text
	.globl main
main:	li $t0, 0x12345678 # instruçao virtual que cria uma constante de 32 bits
	sll $t2, $t0, 1
	srl $t3, $t0, 1
	sra $t4, $t0, 1
	jr $ra