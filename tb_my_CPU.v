`timescale 1ns / 1ns
/** @module : CPU
 *  @author : Albert Bitdiddle
 *  CPU Module Testbed 
 *  Adaptive and Secure Computing Systems (ASCS) Laboratory
 */


`timescale 1ns / 1ns
/** @module : CPU
 *  @author : Albert Bitdiddle
 *  CPU Module Testbed 
 *  Adaptive and Secure Computing Systems (ASCS) Laboratory
 */


module tb_CPU (); 
reg clock, reset, start; 
//reg [31:0] program_counter;  
//reg MemRead, MemWrite;


CPU cpu (
    .clock(clock), 
    .reset(reset), 
    .start(start)
//    .program_counter(program_counter)
);     

    // In phase I, we are not implementing the instruction memory. Therefore, we manually the instruction, the register
    // in the CPU.v It is implemented as a register right now, but you will eventually want to change it to a wire and 
    // drive it from instruction memory.

    // Clock generator
    always #1 clock = ~clock;

    initial begin
        clock = 0;
        reset = 1;
        start = 0;
		  //program_counter = 0;

        // Right now the regfile is empty. You can manually set the values in the regfile with something like:
        // cpu.registerFile.memory[10] = 100;
        // This will allow you to test your ALU and register file before the processor is complete. 
		  
		  /*cpu.instruction_Memory.ram[0] = 32'b000000_00011_00001_00010_00000000000; // AND regs 3 and 1, put result in 2
        cpu.instruction_Memory.ram[1] = 32'b000000_00100_00001_00011_00000000001; // OR regs 1 and 4, put result in 3 
        cpu.instruction_Memory.ram[2] = 32'b000000_00101_00001_00100_00000000001; // ADD regs 5 and 1, put result in 4
		  cpu.instruction_Memory.ram[3] = 32'b000100_00011_00010_00000_00000000000; // BEQ regs 3 and 2
		  cpu.instruction_Memory.ram[4] = 32'b000000_00100_00011_10000_00000101010; //SLT regs 8 and 3
		  cpu.instruction_Memory.ram[5] = 32'b001000_00010_00110_00000_00000001001;; //ADDI regs 2 and 6
		  cpu.instruction_Memory.ram[6] = 32'b100011_00011_00100_00000_00000001000; // lw reg 3 and 4
		  cpu.instruction_Memory.ram[7] = 32'b101011_00011_00001_00000_00000001000; // sw reg 3 and 1
		  cpu.instruction_Memory.ram[8] = 32'b000000_00101_00001_00100_00000000001; //sub reg 5 and 1*/
		
		  
        #10 reset = 0;
            start = 1;
/*		  cpu.registers.memory[1] = 5;
		  cpu.registers.memory[2] = 10;
		  cpu.registers.memory[3] = 15;
		  cpu.MemRead = 0;
		  cpu.MemWrite = 1;*/

        // After 10 nanoseconds, lets set the regfile_read_sel_1 to 1, regfile_read_sel_2 to 2, AND those values,
        // and write the result to register 3.



        // If you set the values of those  registers 1 and 2 to something other than 0, you should see some result in
        // register 3.

     end
     
endmodule