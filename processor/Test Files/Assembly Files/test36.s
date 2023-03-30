nop 	# simple j test case
nop 
nop 
nop
nop
nop
addi    $r1, $r0, 4     # $r1 = 4
addi    $r2, $r0, 5     # $r2 = 5
nop
nop
sub     $r3, $r0, $r1   # $r3 = -4
sub     $r4, $r0, $r2   # $r4 = -5
nop
nop
nop 	
j 	j1		# Jump to j1
nop			# flushed instruction
nop			# flushed instruction
addi 	$r20, $r20, 1	# r20 += 1 (Incorrect)
addi 	$r20, $r20, 1	# r20 += 1 (Incorrect)
addi 	$r20, $r20, 1	# r20 += 1 (Incorrect)
j1: 
addi 	$r10, $r10, 1	# r10 += 1 (Correct)
nop			# Avoid add RAW hazard
nop			# Avoid add RAW hazard
nop
nop
# Final: $r10 should be 1, $r20 should be 0