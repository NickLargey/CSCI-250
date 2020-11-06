	.data
Empty:  .space 32	# Allocate 32 bytes for Empty Array
	.text
	
main:


# Selection Sort Algorithm
#
# int i,j, min
#
# for(j=0; j < n; j++) 
#  min = j
#  for(i = j + 1; i < n; i++)
#	if(a[i] < a[min])
#  	  min = i;
#	if(min != j)
#	  swap(a[j], a[min])
###################################
# Filling an Array using a Loop
	la	$a0, Empty	# Value to fill each element
	li	$v0, 0		# count of elements to init
	li	$t0, 4

Loop:
	sw	$c0, 0($a0)	# Increment array pointer by element size, May omit offset of 0
	addi	$a0, $a0, 4
	addi	$t0, $t0, -1
	bgtz	$t0, Loop


# void swap(int v[], int k)
# {
#    int temp;
#    temp = v[k];
#    v[k] = v[k+1];
#    v[k+1] = temp;
# }
###################################
	sll $t1, $a1, 2		# reg $t1 = k * 4
	add $t1, $a0, $t1	# reg $t1 = v + (k * 4)
				# reg $t1 has the address of v[k]
				
				
				
	lw $t0, 0($t1)		# reg #t0 (temp) = v[k]
	lw $t2, 4($t1)		# reg $t2 = v[k + 1]
				# refers to next element of v			