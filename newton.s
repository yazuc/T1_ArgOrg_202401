# Function to calculate square root using Newton-Raphson method
sqrt_nr:
	lw		$a0, 8($sp)		# 	// $a0 = n
	lw		$a1, 4($sp)		# 	// $a1 = &vet[0]
	bne		$a0, 1, recurs	# 	if(n == 1)
	lw		$v0, 0($a1)		#		
	jr		$ra	