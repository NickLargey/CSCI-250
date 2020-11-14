# Selection Sort Algorithm
#
# int i,j, min
# for(j=0; j < n-1; j++)
#    min = j
#    for(i = j+1; i < n; i++)
#      if(a[i] < a[min])
#        min = i;
#      if(min != j)
#        swap(a[j], a[min]
#
###################################

.data
	spaceChar: .asciiz " "
	elemPrompt: .asciiz "Please enter how many integers you would like to sort (1 to 20): "
	intPrompt: .asciiz "Please enter integer #"
	printArr: .asciiz "Sorted Array is ===> "
	
.text

main:
	.macro printStr
	li	$v0, 4
	syscall
	.end_macro 
	.macro spaceChar
	li	$v0, 4
	la	$a0, spaceChar
	syscall
	.end_macro 
	.macro printInt
	li	$v0, 1
	syscall
	.end_macro
	.macro ptNewline
	li	$v0, 4
	la	$a0, newline
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
    	
    	la	$a0, elemPrompt	# Read in user's int and print prompt
	printStr
	readInt
    	
    	move	$s2, $v0	# move amount of elements to reg $s2
    	sll	$s0, $v0, 2	# $s0 = array size * 4
    	sub	$sp, $sp, $s0	# subtract the arraysize in bytes from the stack pointer
    	addi	$t1, $zero, 0	# init counter to fill array
    	
    		
fillArr: 
	beq	$s2, $t1, exit_get	# break out of loop when counter == user's int
	la	$a0, intPrompt  # print prompt for user to enter int
	printStr
	la 	$a0, ($t1)	# add index counter to print statement 
	printInt
	spaceChar
	readInt			#  Read in one element of the array
	
	sll	$t2, $s1, 2		# $t2=i*4
	add	$t3, $t2, $sp		# $t3=$sp+i*4

	sw	$v0, ($t3)		# The element is stored
					# at the address $t3
	
	addi	$t1, $t1, 1	# incriment index counter by one
	b	fillArr		# jump back to beginning of loop
sort:
    	exit
    	jal	swap
    	
exit_get:	move	$a0, $sp		# $a0=base address af the array
		move	$a1, $s2		# $a1=size of the array
		jal	isort			# isort(a,n)
						# In this moment the array has been 
						# sorted and is in the stack frame 
		la	$a0, printArr		# Print of str3
		printStr

		move	$s1, $zero		# i=0
for_print:	bge	$s1, $s2, exit_print	# if i>=n go to exit_print
		sll	$t0, $s1, 2		# $t0=i*4
		add	$t1, $sp, $t0		# $t1=address of a[i]
		lw	$a0, 0($t1)		#
		li	$v0, 1			# print of the element a[i]
		syscall				#

		#la	$a0, str5
		#li	$v0, 4
		#syscall
		addi	$s1, $s1, 1		# i=i+1
		j	for_print
exit_print:	add	$sp, $sp, $s0		# elimination of the stack frame 
              
		li	$v0, 10			# EXIT
		syscall			#
		
		
# selection_sort
isort:		addi	$sp, $sp, -20		# save values on stack
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		sw	$s2, 12($sp)
		sw	$s3, 16($sp)

		move 	$s0, $a0		# base address of the array
		move	$s1, $zero		# i=0

		subi	$s2, $a1, 1		# lenght -1
isort_for:	bge 	$s1, $s2, isort_exit	# if i >= length-1 -> exit loop
		
		move	$a0, $s0		# base address
		move	$a1, $s1		# i
		move	$a2, $s2		# length - 1
		
		jal	mini
		move	$s3, $v0		# return value of mini
		
		move	$a0, $s0		# array
		move	$a1, $s1		# i
		move	$a2, $s3		# mini
		
		jal	swap

		addi	$s1, $s1, 1		# i += 1
		j	isort_for		# go back to the beginning of the loop
		
isort_exit:	lw	$ra, 0($sp)		# restore values from stack
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		lw	$s2, 12($sp)
		lw	$s3, 16($sp)
		addi	$sp, $sp, 20		# restore stack pointer
		jr	$ra			# return


# index_minimum routine
mini:		move	$t0, $a0		# base of the array
		move	$t1, $a1		# mini = first = i
		move	$t2, $a2		# last
		
		sll	$t3, $t1, 2		# first * 4
		add	$t3, $t3, $t0		# index = base array + first * 4		
		lw	$t4, 0($t3)		# min = v[first]
		
		addi	$t5, $t1, 1		# i = 0
mini_for:	bgt	$t5, $t2, mini_end	# go to min_end

		sll	$t6, $t5, 2		# i * 4
		add	$t6, $t6, $t0		# index = base array + i * 4		
		lw	$t7, 0($t6)		# v[index]

		bge	$t7, $t4, mini_if_exit	# skip the if when v[i] >= min
		
		move	$t1, $t5		# mini = i
		move	$t4, $t7		# min = v[i]

mini_if_exit:	addi	$t5, $t5, 1		# i += 1
		j	mini_for

mini_end:	move 	$v0, $t1		# return mini
		jr	$ra
swap:
	sll	$t1, $a1, 2	# reg $t1 = k * 4
	add	$t1, $a0, $t1	# reg $t1 = v + (k * 4)
				# reg $t1 has the address of v[k]
	lw	$t0, 0($t1)	# reg $t0 (temp) = v[k]
	lw	$t2, 4($t1)	# reg #t2 = v[k+1]
				# refers to next element of v
	sw	$t2, 0($t1)	# v[k] = reg $t2
	sw	$t0, 4($t1)	# v[k+1] = reg $t0 (temp)
	jr	$ra