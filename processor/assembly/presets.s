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
    addi $r21, $0, 1
    stall $0, $0, 10

    addi $r19, $0, 0
    addi $r21, $0, 0

    addi $r20, $0, 1
    addi $r22, $0, 1
    stall $0, $0, 10

    addi $r20, $0, 0
    addi $r22, $0, 0

    addi $r19, $0, -1
    addi $r21, $0, 1
    stall $0, $0, 10

    addi $r19, $0, 0
    addi $r21, $0, 0

    addi $r20, $0, -1
    addi $r22, $0, 1
    stall $0, $0, 10
    addi $r20, $0, 0
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
    # first diagonal
    addi $r19, $0, 1
    addi $r20, $0, 1
    addi $r21, $0, 1
    addi $r22, $0, 1

    stall $0, $0, 10
    # Turn off first diagonal
    addi $r19, $0, -1
    addi $r21, $0, -1
    addi $r20, $0, -1
    addi $r22, $0, -1

    #second diagonal


    addi $r9, $0, -1
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
