.data


.text

main:

	.macro printStr
	li	$v0, 4
	syscall
	.end_macro 
	.macro space
	li	$v0, 4
	la	$a0, space
	syscall
	.end_macro 
	.macro printInt
	li	$v0, 1
	syscall
	.end_macro
	.macro readInt
	li	$v0, 5
	syscall
	.end_macro
	.macro exit
	li    $v0,    10
    	syscall
    	.end_macro
    	
    	.macro 
	li	$v0, 4
	la	$a0, space
	syscall
	.end_macro 