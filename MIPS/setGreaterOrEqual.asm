.data
.text

main:
	li	$s0, 2
	li	$s1, 1
	li	$s2, 3
	li	$s3, 0
	 
	sge	$s0, $s0, $s1
	sle	$s1, $s0, $s2
	or	$s0, $s0, $s1
	sgt	$s1, $s1, $s3
	and	$s0, $s0, $s1
	
	li	$v0, 4
	la	$a0, ($s0)
	syscall