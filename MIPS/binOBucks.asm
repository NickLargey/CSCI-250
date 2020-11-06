# CSCI 250
# Nick Largey
# 10/17/2020
# I pledge that this work is my own
	   
	   
	   .data
greeting:  .asciiz "Greetings! I’m your robot bank teller.\nHow many power-of-two dollars do you want?\n"
binTag:    .asciiz "Here are your $"
binTag2:   .asciiz " Bin-O-Bucks:\n"
dollarTag: .asciiz " dollar bill\n"
space:	   .asciiz " "
word: 	   .word 0x00000400

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
	.macro end
	li    $v0,    10
    	syscall
    	.end_macro
	
	lw	$s0, word		# Load 1024 into register for future use
	la	$a0, greeting		# Read in user's int and print greeting
	printStr
	readInt
	
	move	$t0, $v0		# Store user's int
	
	la	$a0, binTag		# Format dispense tag with user int and print 
	printStr
	la	$a0, ($t0)
	printInt
	la	$a0, binTag2
	printStr
	
	
	
	# Steps repeat for each denomination of bill in loop
loop:   
	beqz	$s0, end_loop		# When divisor has reached zero the loop will branch to end
	div	$t0, $t0, $s0 		# Divide user int by 1024
	mfhi	$t0			# Move remainder to $t0 for future divisions
	mflo	$s1			# Move $lo register to print 
	la	$a0, ($s1)		# Load quotient to print 
	printInt			# Print total of times userInt was divisible by 1024
	space				# Print a space
	la	$a0, ($s0)		# Load divisor to print
	printInt			# Print divisor
	la	$a0, dollarTag		# Load dollarTag string
	printStr			# Print end of line
	srl	$s0, $s0, 1		# Shift Right Logical 1024 by 1 to get 512 	 
	b	loop
end_loop:
	end				# Exit Gracefully 
	
	