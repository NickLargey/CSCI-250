.data

.text

main:	
	.macro sleep
	li 	$v1, 32
	la	$a0, 5000
	syscall
	.end_macro
	
	li	$v0, 31
	la	$a0, 60
	la	$a1, 5000
	la	$a2, 33
	la	$a3, 80
	
	syscall
	sleep
	li	$v0, 31
	la	$a0, 63
	la	$a1, 5000
	la	$a2, 33
	la	$a3, 80
	
	syscall
	sleep
	li	$v0, 31
	la	$a0, 66
	la	$a1, 5000
	la	$a2, 33
	la	$a3, 80
	
	syscall
	sleep
	
	
	