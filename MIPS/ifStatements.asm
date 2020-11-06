.data
.text

main:	
#	beq	$s0, $s1, endif
#	addi	$s0, $s0, -1
#endif:
	
#	bne	$s0, $s1, endif
	# else $s0 = $s0 -1
#	addi	$s0, $s0, -1
#endif:

#	beq	$s3, $s4, endif
#	add	$s0, $s1, $s2	# f = g + h
#endif:

#	ble	$s0, $s1, endif
#	# else $s0 = $s0 -1
#	addi	$s0, #s0, -1
#endif:

#	bge	#s0, $s1, endif
#	# else $s0 = $s0 - 1
#	addi $s0, $s0, -1
#endif:

#	blt	#s0, $s1, endif
#	# else $s0 = $s0 - 1
#	addi $s0, $s0, -1
#endif:

#	bgt	#s0, $s1, endif
#	# else $s0 = $s0 - 1
#	addi $s0, $s0, -1
#endif:
#	beqz	$s0, endif
#	# else $s0 = $s0 - 1
#	addi $s0, $s0, -1
#endif

	bne	$s0, $s1, endif
	addi	$s0, $s0,  1
	add	$s0, $s0, $s0
endif:

	bgt	$s0, $s1, endif
	addi	$s0, $s0, 1
endif:

	bge	$s0, $s1, endif
	addi	$s0, $s0, 1
endif:

	bgez	$s0, endif
	addi	$s0, $s0, 1
endif:

	bgtz	$s0, endif
	addi	$s0, $s0, 1
endif:
	
	bgez	$s0, endif
	ble	$s0, $s1, endif
	addi	$s0, $s0, 1
endif:
	

