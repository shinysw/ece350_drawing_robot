.text
j main2
nop
nop
nop
nop
nop
nop
nop

square:
    nop
    nop
    nop
    nop
    nop
    addi $r19, $0, 1
    addi $r20, $0, 1
    addi $r21, $0, 21213
    addi $r22, $0, 21213
    stall 47140452
    addi $r19, $0, 1
    addi $r20, $0, 0
    addi $r21, $0, 21213
    addi $r22, $0, 21214
    stall 47140452
    addi $r19, $0, 0
    addi $r20, $0, 0
    addi $r21, $0, 21214
    addi $r22, $0, 21214
    stall 47140452
    addi $r19, $0, 0
    addi $r20, $0, 1
    addi $r21, $0, 21214
    addi $r22, $0, 21213
    stall 47140452
    addi $r21, $0, 0
    addi $r22, $0, 0

    # Reset the input
    addi $r8, $0, 0
    j		main2			# jump to main2
    
triangle:
    nop
    nop
    nop
    nop
    nop
    addi $r19, $0, 1
    addi $r20, $0, 1
    addi $r21, $0, 0
    addi $r22, $0, 0
    stall 0
    addi $r19, $0, 1
    addi $r20, $0, 1
    addi $r21, $0, 21213
    addi $r22, $0, 21213
    stall 47140452
    addi $r19, $0, 1
    addi $r20, $0, 0
    addi $r21, $0, 21213
    addi $r22, $0, 21214
    stall 47140452
    addi $r19, $0, 0
    addi $r20, $0, 1
    addi $r21, $0, 30000
    addi $r22, $0, 0
    stall 66666666
    addi $r21, $0, 0
    addi $r22, $0, 0

    addi $r9, $0, 0
    j main2

star: 
    nop
    nop
    nop
    nop
    nop
    addi $r10, $0, -1
    j main2

main2:
    nop
    nop
    nop
    nop
    nop
    bne $r8, $1, square
    bne $r9, $1, triangle
    bne $r10, $1, star
    j main2
