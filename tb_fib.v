`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:37:51 12/10/2017
// Design Name:   CPU
// Module Name:   /ad/eng/users/s/h/shivas/Project_Phase1/tb_fib.v
// Project Name:  Project_Phase1
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

module tb_fib;

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

	always #1 clock = ~clock; 
	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 1;
		start = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here
		      uut.instruction_Memory.ram[0] = 32'b001000_01000_01001_00000_00000_011110;  //# addi t1, t0, 30      # looking for n-th Fibbonacci number
            uut.instruction_Memory.ram[1] = 32'b001000_01000_01010_00000_00000_000010;  //# addi t2, t0, 2      # Counter, we have the first and second number, so 2
            uut.instruction_Memory.ram[2] = 32'b001000_01000_01011_00000_00000_000001;  //# addi t3, t0, 1      # First number
            uut.instruction_Memory.ram[3] = 32'b001000_01000_01100_00000_00000_000001;  //# addi t4, t0, 1      # Second number
            uut.instruction_Memory.ram[4] = 32'b000100_01010_01001_00000_00000000101;   //# beq t2, t1, 5       # if the counter is equal to n, the requested number, then exit
            uut.instruction_Memory.ram[5] = 32'b001000_01010_01010_00000_00000_000001;  //# addi t2, t2, 1      # increment the counter
            uut.instruction_Memory.ram[6] = 32'b000000_01011_01100_01110_00000_100000;  //# add t6, t3, t4      # Add the two Fibbonacci numbers we have to get the next one
            uut.instruction_Memory.ram[7] = 32'b001000_01100_01011_00000_00000_000000;  //# addi t3, t4, 0      # Move the higher one the lower one
            uut.instruction_Memory.ram[8] = 32'b001000_01110_01100_00000_00000_000000;  //# addi t4, t6, 0      # Move the new one to the higher one
            uut.instruction_Memory.ram[9] = 32'b000100_01000_01000_11111_11111111010;   //# beq t0, t0, loop
            uut.instruction_Memory.ram[10] = 32'b000000_01000_01100_01101_00000_100000; //# add t5, t0, t4      # move the result into t5
            uut.instruction_Memory.ram[11] = 32'b000100_01000_01000_11111_11111111111;  //# beq t0, t0, forever # jump to the same instruction forever
  #10 reset = 0;
	end
      
endmodule

