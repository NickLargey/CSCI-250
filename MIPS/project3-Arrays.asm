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
	arr:	.space 80
	elemPrompt: .asciiz "Please enter how many integers you would like to sort (1 to 20): "
	intPrompt: .asciiz "Please enter integer #"
	
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
    	
    	move	$t0, $v0	# move amount of elements to reg $v0
    	addi	$t1, $zero, 0	# init counter to fill array
    		
fillArr: 
	beq	$t0, $t1, sort	# break out of loop when counter == user's int
	la	$a0, intPrompt  # print prompt for user to enter int
	printStr
	la 	$a0, ($t1)	# add index counter to print statement 
	printInt
	spaceChar
	readInt
	
	######### Insert read int's into registers ##########
	#						    #
	#						    #	
	#						    #
	#####################################################
	
	
	addi	$t1, $t1, 1	# incriment index counter by one
	b	fillArr		# jump back to beginning of loop
sort:
    	exit
    	jal	swap
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
