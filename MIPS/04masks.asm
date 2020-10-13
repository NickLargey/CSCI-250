	.data
fvalue: 0xc4fa0000
mask: 0x80000000
posValue: 0xffffffc9	
	.text

main:
	lw	$s0, fvalue
	lw	$s1, mask
	
	and	$s2, $s0, $s1
	xor	$s3, $s2, $s0
	
	li	$v0, 34
	la	$a0, ($s3)
	
	syscall	

	li	$v0, 10
	la	$a0, ($v0)
	syscall
