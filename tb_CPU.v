`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:29:11 11/13/2017
// Design Name:   CPU
// Module Name:   /ad/eng/users/c/h/chauhank/Documents/ec413/PROJECT/tb_CPU.v
// Project Name:  PROJECT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_CPU;

	// Inputs
	reg clock;
	reg reset;
	reg start;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clock(clock), 
		.reset(reset), 
		.start(start)
	);

	// Clock generator
	always #1 clock = ~clock;

	initial begin

		// Initialize Inputs
	   clock = 0;
	   reset = 1;
	   start = 1;
	   
	   // everything has been set, start writing
	   #10 reset = 0;
	   
	   uut.instruction_Memory.ram[0] = 32'b00100000001000010000000000001001;  //addi r1, r1 9
	   uut.instruction_Memory.ram[1] = 32'b00100000010000100000000000001111;  //addi r2, r2, 15
	   uut.instruction_Memory.ram[2] = 32'b00100000011000110000000000011001;  //addi r3, r3, 25
	   uut.instruction_Memory.ram[3] = 32'b00100000100001000000000000011101;  //addi r4, r4, 29
	   uut.instruction_Memory.ram[4] = 32'b10101100100000110000000000001001;  //sw r3, 9(r4)
	   uut.instruction_Memory.ram[5] = 32'b00000000001000100010100000100000;  //add r5, r1, r2
	   uut.instruction_Memory.ram[6] = 32'b00000000010001000011000000100100;  //and r6, r2, r4
	   uut.instruction_Memory.ram[7] = 32'b00010000110000010000000000001010;  //beq r6, r1, 10   (shouldn't jump)
	   uut.instruction_Memory.ram[8] = 32'b00000000001000100011100000100101;  //or r7, r1, r2
	   uut.instruction_Memory.ram[9] = 32'b00000000011001000100000000101010;  //slt r8, r3, r4
	   uut.instruction_Memory.ram[10] = 32'b10001100011010010000000000001101; //lw r9, 13(r3)
	   uut.instruction_Memory.ram[11] = 32'b00010000011010010000000000001010; //beq r3, r9, 10
	   uut.instruction_Memory.ram[18] = 32'b00100001101011010000000001100100; //addi r13, r13, 100 (shouldn't execute)
	   uut.instruction_Memory.ram[21] = 32'b00100001010010100000000001100100; //addi r10, r10, 100 (shouldn't execute)
	   uut.instruction_Memory.ram[22] = 32'b00100001011010110000000001100100; //addi r11, r11, 100 (branch to here)
	   uut.instruction_Memory.ram[23] = 32'b00100001100011000000000001100100; //addi r12, r12, 100
	end

  /* final results should be
     r1=9
     r2=15
     r3=25
     r4=29
     r5=24
     r6=13
     r7=15
     r8=1
     r9=25
     r10=0
     r11=100
     r12=100
     r13=0

     mem[38]=25*/
endmodule
