// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

// R2 will hold the final product.
@R2
M=0

(LOOP)
    // If (R0 == 0), goto END.
    @R0
    D=M
    @END
    D;JEQ

    // Otherwise, R0 -= 1.
    @R0
    M=M-1

    // Add R1 to sum.
    @R1
    D=M
    @R2
    M=D+M

    // Return to top of the loop.
    @LOOP
    0;JMP

(END)
    @END
    0;JMP

