# Commodore-64-Matrix-Grid-Runner-Disassembly
Disassembly of this game to enable modifications such as infinite lives
Matrix

matrix.asm is the disassembled matrix.prg code. I used ChatGPT, Claud.ai and
also the disassembler JC64dis to disassemble the code.

The game was available as a tape cassette and as a cartridge. The code in the
game file matrix.prg (inside of the matrix.d64 disk image) shows how the tape
version works.

The program is loaded in at the normal start of BASIC $801. There is a basic 
stub 10 SYS(2080):REM MATRIX. This runs code at $820. This code then
copies all code from $900 onwards to $8000 and then jumps (JMP $8000).

The code at $8000 is the usual cartridge code:
2 bytes for warm start ($8009)
2 bytes for cold start
5 bytes containing characters CBM80
The game starts at $8009

The game was disassembled using ChatGPT 5.2, JC64dis (a Windows Commodore 64 disassembler),
dasm (a Windows assembler for 8 bit machines https://dasm-assembler.github.io/).

Once I had assembly code I could reassemble without errors and ran on the VICE emulator I
had to work out how the code works. I have commented some parts of the assembly code.

To use you will need to compile using dasm. Use LOAD "*",8,1 and type
SYS 32777
