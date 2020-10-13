	.data
	
	.text

main:
	
	li $s0, 9
	addi $s0, $s0, 16
	
	li $s1, 3
	addi $s1, $s1, 22
	
	sub $s0, $s0, $s1
	syscall
