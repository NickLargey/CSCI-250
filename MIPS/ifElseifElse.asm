.data
.text	

main:
	.macro printInt
	li	$v0, 1
	syscall
	.end_macro 
	li	$s0, 4
	
	li	$s1, 1
	
	beqz	$s0, if
	beq	$s0, $s1, elseIf
	bne 	$s0, $s1, else
	bnez	$s0, else

if:
	addi	$s0, $s0, 3
	b	end
	
	
elseIf:
	addi 	$s0, $s0, 2
	b	end
	
else:
	addi	$s0, $s0, 1
	b 	end

end:	
	la	$a0, ($s0)
	printInt
	li    $v0,    10    # Exit gracefully
    	syscall
	