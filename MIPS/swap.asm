.data
.text
	# params = v ($a0), n ($a1)
	# iterators = i ($s0), j ($s1)

main:
swap:
	sll   $t1, $a1, 2     	# reg $t1 = k * 4
	add   $t1, $a0, $t1   	# reg $t1 = v + (k * 4)
			      	# reg $t1 has the address of v[k]			      
	lw	$t0, 0($t1)	# reg $t0 (temp) = v[k]
	lw	$t2, 4($t1)	# reg $t2 = v[k+1]
				# refers to next element of v
	sw	$t2, 0($t1)	# v[k] = reg $t2
	sw	$t0, 4($t1)	# v[k + 1] = reg $t0 (temp)
	
	jr	$ra		# return to calling routine
	
sort:	
	addi $sp, $sp, -20	# Make room on stack for 5 registers
	sw   $ra, 16($sp)	# Save $ra on stack
	sw   $s3, 12($sp)	# Save $s3 on stack
	sw   $s2, 8($sp)	# Save $s2 on stack
	sw   $s1, 4($sp)	# Save $s1 on stack
	sw   $s0, 0($sp)	# Save $s0 on stack
	
	# Move Params
	move $s2, $a0		# Copy Parameter $a0 into $s2 (save $a0)
	move $s3, $a1		# Copy Parameter $a1 into $s3 (save $a1)
	
	# Outer Loop
	move $s0, $zero		# i = 0
for1tst:
	slt $t0, $s0, $s3	# reg $t0 = 0 if $s0 >= $a1 (i >= n)
	beq $t0, $zero, exit1	# go to exit1 if $s0 >= $a1 (i >= n)
	
	# Inner Loop
	addi $s0, $s1, -1	# j = i - 1	
for2tst:
	slti $t0, $s1, 0	# reg $t0 = 1 if $s1 < 0 (j<0)
	bne $t0, $zero, exit2	# goto exit2 if $s1 < 0 (j<0)
	sll $t1, $s1, 2		# reg $t1 = j * 4
	add $t2, $s2, $t1	# reg $t2 = v + (j * 4)
	lw $t3, 0($t2)		# reg $t3 = v[j]
	lw $t4, 4($t2)		# reg $t4 = v[j + 1]
	slt $t0, $t4, $t3	# reg $t0 = 0 if $t4 >= $t3
	beq $t0, $zero, exit2	# go to exit2 if $t4 >= $t3
	
	# Pass Params and Call
	move $a0, $s2		# 1st param of swap is v (old $a0)
	move $a1, $s1 		# 2nd param of swap is j
	jal swap
	
	# Inner Loop
	addi $s1, $s1, -1	# j -= 1
	j for2tst		# jump to test of inner loop
	
	# Outer Loop
exit2:
	addi $s0, $s0, 1	# i += 1
	j for1tst		# jump to test of outer loop

exit1:	
	lw $s0, 0($sp)		# restore $s0 from stack
	lw $s1, 4($sp)		# restore $s1 from stack
	lw $s2, 8($sp)		# restore $s2 from stack
	lw $s3, 12($sp)		# restore $s3 from stack
	lw $ra, 16($sp)		# restore $ra from stack
	addi $sp, $sp, 20	# restore stack pointer
	
	jr $ra
	
	