`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:51 11/13/2017 
// Design Name: 
// Module Name:    CPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//module CPU(
//    );


//endmodule

`timescale 1ns / 1ns
/** @module : CPU
 *  @author : Albert Bitdiddle
 *  CPU Module Template 
 *  Adaptive and Secure Computing Systems (ASCS) Laboratory
 */

module CPU (
  clock, 
  reset, 
  start
//  program_counter
); 
	 reg [31:0] PC;
    input clock, reset, start; 
//    input [31:0]  program_counter; 
     
    wire [31:0] ALU_operand_A, ALU_operand_B, ALU_result, ReadData, sign_extend;//read_the_data
    wire ALU_zero, PCSrc, ALUSrc, MemReg;

    // TODO: the instruction is currently a register, so we can control it from the testbench.
    // Later, we will want to turn it into a wire and drive it from instruction memory.
    wire [31:0] instruction;
	 wire MemRead, MemWrite;

    // Control signals from the control unit.
    wire [3:0] ALU_Control;
    wire [4:0] regfile_read_sel1, regfile_read_sel2, regfile_write_sel;
    wire regfile_write,  the_branch; //memory_read, memory_write;

    // TODO Instructions: We have connected the phase I modules - the ALU, register file, but not memory. 
    // For phase I, you shouldn't touch this file. You first need to:
    //    1) Complete refisterFile.v and test it 
    //    2) Complete ALU.v and test it
    //    3) Test both ALU and register file together, for which we have provided some simple benchmarks in tb_CPU.v
    //    4) Complete memory.v and test it
    //    5) Connect memory.v here and test all 3 modules together
    //
    // In phase II, you will have to add the rest of the modules.

//MAKE EDITS TO THIS
    Memory instruction_Memory (
         .clock(clock),
			.Address(PC),
			.MemRead(1'b1),
			.ReadData(instruction),
			.MemWrite(),
			.writeData()
    ); 

    Control_Unit control (
        .instruction(instruction      ),
		  .sign_extend(sign_extend),
        .ALU_Control(ALU_Control      ),
        .read_sel_a (regfile_read_sel1),
        .read_sel_b (regfile_read_sel2),
        .write_sel  (regfile_write_sel),
        .write      (regfile_write    ),
		  .MemRead(MemRead     ),
		  .MemWrite(MemWrite   ),
		  .MemReg(MemReg	),
		  .ALUSrc(ALUSrc),
		  .Branch(the_branch)
    );

    registerFile registers (
        .clock     (clock            ),
        .reset     (reset            ),
        .read_sel1 (regfile_read_sel1),
        .read_sel2 (regfile_read_sel2),
        .write     (regfile_write    ),
        .write_data(MUX_3      ),
        .write_sel (regfile_write_sel),
        .read_data1(ALU_operand_A    ),
        .read_data2(ALU_operand_B    )
		  //.ReadData (MUX_3)
    ); 
	 
	 
	 wire [31:0] MUX_2; 
	 assign MUX_2 = (ALUSrc == 0 )? ALU_operand_B : sign_extend;

	wire [31:0] MUX_3;
	assign MUX_3 = (MemReg == 1) ? ReadData : ALU_result; 
	
    ALU ALU_unit(
        .ALU_Control(ALU_Control  ),
        .operand_A  (ALU_operand_A),
        .operand_B  (MUX_2),
        .zero       (ALU_zero     ),
        .ALU_result (ALU_result   )
    ); 
      

    Memory data_Memory(
            // Add code 
			.clock(clock            	),
			.Address(ALU_result[31:0]  	),
			.MemRead(MemRead     	),
			.ReadData(ReadData		),
			.MemWrite(MemWrite),
			.writeData(ALU_operand_B   )
    );
	 
	assign PCSrc = ALU_zero & the_branch;
	always @(posedge clock) begin
		if (reset) begin
			PC <= 0;
		end
		else begin
			PC <= (the_branch & ALU_zero) ? PC + 1 + sign_extend : PC + 1; 
		end
	end
	
endmodule
