# Mapa de registos
# str: $s0
# val: $s1
# O main é, neste caso, uma sub-rotina intermédia

	.text
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv MAX_STR_SIZE, 33
str:	.space 33
	.data
main:
	addiu $sp, $sp, -12 # reserva espaço na stack
	sw $ra, 0($sp) # guarda os registos
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	la $s0, str
	
do:	
	li $v0, read_int
	syscall 
	move $s1, $v0 # val = read_int()