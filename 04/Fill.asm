// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(LOOP)

    // Assume no key is pressed. In this case, 
    // all pixels will be set to 0.
    D=0

    // Check the keyboard for input.
    @KBD
    D=M

    // If D is still 0 at this moment, no
    // key was pressed down, so we
    // should proceed to set all the
    // pixels to 0 by skipping forward to DISPLAY.
    @DISPLAY
    D;JEQ

    // Alternatively, if D != 0 above, then a key
    // is being pressed down. Set D to -1 to set
    // the full register to 1111_1111 = 16 black pixels.
    D=-1

(DISPLAY)
    
    // In this inner loop, we render the pixels to the screen
    // with the D chosen above from {0, -1}.
    //
    // The height of the screen is 256 pixels and the width
    // is 512 pixels. The screen is memory mapped to a region
    // of RAM beginning at @SCREEN. The HACK computer has a
    // 16-bit architecture, so the register size = RAM width
    // is 16 bits. 
    //
    // The RENDER loop will operate at the level of the
    // register size = RAM width = 16 bits. Thus we see
    // that there will be 512 / 16 = 32 registers per row
    // and 256 rows, which means the RENDER loop will pass
    // over 256 * 32 = 8192 RAM registers / addresses.

    // Store the color, currently held in D.
    @color
    M=D

    // Store n = 8192.
    @8192
    D=A
    @n
    M=D

    // i is our loop counter.
    @i
    M=0

    @SCREEN
    D=A
    @address
    M=D

(RENDER)

    // If i > n, rendering is complete.
    @i
    D=M
    @n
    D=D-M
    @LOOP
    D;JGT

    // Set the current RAM register to the selected color.
    @color
    D=M
    @address
    A=M
    M=D

    // Proceed to the next address.
    @i
    M=M+1
    D=M
    @address
    M=D+M

    // Continue rendering.
    @RENDER
    0;JMP

// This should not be reachable. We include it for good
// practice: If execution does arrive here somehow, 
// it would be a security risk for an assembly
// program to continue to run endlessly.
(END)
    @END
    0;JMP
