.text


addi $1, $0, 1
j main2

square:

    addi $x, $0, 1
    addi $xspeed, $0, 1
    stall $0, $0, 10

    addi $x, $0, -1
    addi $xspeed, $0, -1

    addi $y, $0, 1
    addi $yspeed, $0, 1
    stall $0, $0, 10

    addi $y, $0, -1
    addi $yspeed, $0, -1

    addi $x, $0, -1
    addi $xspeed, $0, 1
    stall $0, $0, 10

    addi $x, $0, 1
    addi $xspeed, $0, -1

    addi $y, $0, -1
    addi $yspeed, $0, 1
    stall $0, $0, 10
    addi $y, $0, 1
    addi $yspeed, $0, -1

    # Reset the input
    addi $square, $0, -1
    j		main2			# jump to main2
    
triangle:
    # first diagonal
    addi $x, $0, 1
    addi $y, $0, 1
    addi $xspeed, $0, 1
    addi $yspeed, $0, 1

    stall $0, $0, 10
    # Turn off first diagonal
    addi $x, $0, -1
    addi $xspeed, $0, -1
    addi $y, $0, -1
    addi $yspeed, $0, -1

    #second diagonal


    addi $triangle, $0, -1
    j main2

star: 


    addi $star, $0, -1
    j main2


main2:
    bne $square, $1, square
    bne $triangle, $1, triangle
    bne $star, $1, star
    j main2
