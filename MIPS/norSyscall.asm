.data
firstNorVal: 0x000000ff
secondNorVal: 0x0000ffff
firstXorVal: 0x00ff00ff
secondXorVal: 0x00ffff00	

.text

main:	
	
			
	lw	$s0,	firstNorVal
	lw	$s1,	secondNorVal
	
	nor	$s2,	$s0,	$s1
	
	li	$v0,	34
	la	$a0,	($s2)
	
	syscall
	
	li    $a0,    10    # Print a newline
    	li    $v0,    11
   	syscall
   	#li    $v0,    10    # Exit gracefully
    	#syscall
    	
	lw	$s0,	firstXorVal
	lw,	$s1,	secondXorVal
	
	xor	$s2,	$s0,	$s1
	
	li	$v0,	34
	la	$a0,	($s2)
	
	syscall
	