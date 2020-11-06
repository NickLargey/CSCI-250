	.include "macros.asm"
	.data
prompt:	.asciiz	"Enter the number of pennies ==> "
result: .asciiz	"The fewest number of coins is: \n"
quart:	.asciiz "\nQuarters: "
dime:	.asciiz	"\nDimes:    "
nick:	.asciiz	"\nNickels:  "
pen:	.asciiz	"\nPennies:  "	
total:	.asciiz "\n a total of "
coins:	.asciiz " coins."
	.text
main:	# start logic
	li	$s1,	0	# initialize coin count
	print_str_at_label(prompt)	# print label
	readInt    	        # read input
	move 	$s0,	$v0	# move it	
	print_str_at_label(result)	# print label	
	# do quarter calculations and output
	print_str_at_label(quart)		# print label
	div	$s0, 	$s0,	25 #do the division
	mflo 	$s0		# move quotient into $s0
	add	$s1, 	$s1,	$s0	# count the coins
	printInt($s0)		# print it
	mfhi	$s0		# move the remainder into $s0
	
	# do dimes claculations and output
	print_str_at_label(dime)	# print label
	div	$s0,	$s0,	10  #do the division
	mflo	$s0		# move quotient into $s0
	add	$s1, 	$s1,	$s0	# count the coins
	printInt($s0)		# print it
	mfhi	$s0		# move the remainder into $s0
	# do nickels
	print_str_at_label(nick)	# print label
	div	$s0,	$s0,	5  #do the division
	mflo	$s0		# move quotient into $s0
	add	$s1, 	$s1,	$s0	# count the coins
	printInt($s0)		# print it
	mfhi	$s0		# move the remainder into $s0
	add	$s1, 	$s1,	$s0	# count the coins
	#print pennies
	print_str_at_label(pen)	# print label
	printInt($s0)		# print value
	print_str_at_label(total)
	printInt($s1)
	print_str_at_label(coins)	
	halt