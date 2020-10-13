#HELLO WORLD
	.data 
# Symbolic label Hello: data type ASCII string
Hello: .asciiz "Hello World\n"

	.text   # Text segment is unused for now.
	
main:   #Start of code section
	# Load register $v0 with code 4 for OS print
	li $v0, 4
	
	# Load address $a0 with address of string.
	# Label names are case sensitive.
	la $a0, Hello
	
	# call operating system to perform print operation
	syscall
	
# END OF PROGRAM - MUST LEAVE ONE BLANK LINE AT THE END.