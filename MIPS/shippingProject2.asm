		.data
newline: 	.asciiz "\n"		
greeting:	.asciiz "Welcome to Largey shipping\n"				
sizePrompt: 	.asciiz "Please enter the package size in cubic inches (1 - 8000): \n"
weightPrompt: 	.asciiz "Please enter the weight of the package (1 - 100): \n"
shipPrompt0: 	.asciiz "1) Ground 5-10 business days\n"
shipPrompt1: 	.asciiz "2) Super saver air 2-4 business days\n"
shipPrompt2: 	.asciiz "3) Next day air\n"
shipPrompt3: 	.asciiz "Please select your shipping speed. Enter 1, 2, or 3: \n"

invoice0:	.asciiz "Shipping Invoice\n"
invoice1:	.asciiz "Package volume in cubic inches: "
invoice2:	.asciiz "Package weight in pounds: "
invoice3:	.asciiz "Ship via: "
shipMethod0:	.asciiz "Ground"
shipMethod1:	.asciiz "Super Saver"
shipMethod2:	.asciiz "Next Day Air"
invoice4:	.asciiz "Cost: $"
shipAgain:	.asciiz "Do you want to ship another package? Enter 1 for Yes or 0 for No: "

farewell:	.asciiz "Bye, Thanks for stopping by..."
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
	 	
    	la	$a0, greeting		# Print greeting
	printStr	
	li	$a1, 1			# Set WHILE_TRUE to true

WHILE_TRUE:
	beqz 	$a1, END_WHILE_TRUE	# Stop program
	
sizeLoop:				# If user enters size < 1 or > 8000 repeat prompt	
	la	$a0, sizePrompt		# Read in user's int and print prompt
	printStr
	readInt
	
	move	$t0, $v0		# Load size to $t0	
	
	bltu 	$t0, 1, sizeLoop	# If n < 1 jump back to sizeLoop
	bgtu	$t0, 8000, sizeLoop	# If n > 8000 jump back to sizeLoop
	b	weightLoop		# Jump to Weight
		
weightLoop:    				# If user enters weight < 1 or > 100 repeat prompt 	
	la	$a0, weightPrompt	# Read in user's int and print prompt
	printStr
	readInt
	
	move	$t1, $v0		# Load weight to $t1	
	
	bltu	$t1, 1, weightLoop	# If n < 1 jump back to weightLoop
	bgtu	$t1, 100, weightLoop	# If n > 1000 jump back to weightLoop
	b	shippingLoop		# Jump to Shipping Method  		

shippingLoop:				# If user input is < 1 or > 3 repeat prompt
	la	$a0, shipPrompt0	#Print prompt for shipping method
	printStr
	la	$a0, shipPrompt1		
	printStr
	la	$a0, shipPrompt2		
	printStr
	la	$a0, shipPrompt3	# Read in user's int and print shipping prompt
	printStr
	readInt
	
	move	$t2, $v0		# Load Shipping Method to $t2
	
	bltu	$t2, 1, shippingLoop	# If n < 1 jump back to shippingLoop
	bgtu	$t2, 3, shippingLoop	# If n > 3 jump back to shippingLoop
	b 	groundCalc		# Jump to calculation
	 
groundCalc:
	# Ground Shipping	1
	bne	$t2, 1, superSaverCalc	# Continue if shipment method wasn't 1
	bgtu	$t0, 1000, price12 	# if > 1000 cubic in.	set price to $12 		
	b	price8			# set price to $8
superSaverCalc:
	# Super Saver Air 	2
	bne	$t2, 2, nextDayCalc	# Continue if shipment method wasn't 2
	bgtu	$t0, 1000, price16 	# if > 1000 cubic in.	set price to $16 		
	b	price12			# set price to $12
nextDayCalc:
	# Next Day Air		3
	bgtu	$t0, 1000, price25 	# if > 1000 cubic in.	set price to $25 		
	b	price15			# set price to $15
price8:	
	li	$s0, 8			# set cost to $8
	b 	continue
price12:	
	li	$s0, 12			# Set cost to $12
	b 	continue
price15:	
	li	$s0, 15			# Set cost to $15
	b 	continue
price16:	
	li	$s0, 16			# Set cost to $16
	b 	continue
price25:	
	li	$s0, 25			# Set cost to $25
	b 	continue
		
continue:
	
	la	$a0, invoice0
	printStr
	la	$a0, invoice1
	printStr
	la	$a0, ($t0)
	printInt
	ptNewline
	la	$a0, invoice2
	printStr
	la	$a0, ($t1)
	printInt
	ptNewline
	la	$a0, invoice3
	printStr
	la	$a0, ($t2)
	printInt
	ptNewline
	la	$a0, invoice4
	printStr
	la	$a0, ($s0)
	printInt
	ptNewline
	
	la	$a0, shipAgain		# get if user wants to ship again
	printStr
	readInt
	move	$a1, $v0
	b WHILE_TRUE	

END_WHILE_TRUE:
	la	$a0, farewell		# Print goodbye
	printStr
	exit
