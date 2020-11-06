.data
prompt:.asciiz "Enter an integer: "
between:.asciiz "Between 1 and 10"

.text

main:
	.macro printStr
	li	$v0, 4
	syscall
	.end_macro 
	.macro readInt
	li	$v0, 5
	syscall
	.end_macro
	
	li	$s1, 1
	li	$s2, 10
	
	la	$a0, prompt
	printStr
	readInt
	move	$t0, $v0
	
	bgt	$t0, $s2, endEqual
	blt 	$t0, $s1, endEqual	
	la	$a0, between
	printStr
		
endEqual:	
	
	
	li    $v0,    10    # Exit gracefully
    	syscall
	
	