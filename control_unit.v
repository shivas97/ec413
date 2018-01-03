`timescale 1ns / 1ns
module Control_Unit(
    instruction,
	 sign_extend,
    ALU_Control,
    read_sel_a,
    read_sel_b,
    write_sel,
    write,
    MemRead,
    MemWrite,
    MemReg,
    ALUSrc,
    Branch
);

    // TODO This is an unfinished control unit. It serves just to get you going with phase I, so you will need to change it
    // as you go along.

    input [31:0] instruction, sign_extend;
    output [3:0] ALU_Control;
    output [4:0] read_sel_a, read_sel_b, write_sel;
    output write;
     output MemRead,MemWrite,MemReg,ALUSrc,Branch;
	  

	 wire [31:0] sign_extend;
	 assign sign_extend = {{16{instruction[15]}}, {instruction[15:0]}}; 
	
	 // TODO, this works for R-types and ADDI, LW, and SW. BEQ uses SUB!
	assign ALU_Control = (instruction[31:26] == 6'b000100) ? 4'b0110 : //beq
								(instruction[31:26] == 6'b000000 && instruction[5:0] == 6'b100100) ? 4'b0000 : //and
								(instruction[31:26] == 6'b000000 && instruction[5:0] == 6'b100101) ? 4'b0001 : //or
								(instruction[31:26] == 6'b000000 && instruction[5:0] == 6'b100010) ? 4'b0110 : //sub
								(instruction[31:26] == 6'b000000 && instruction[5:0] == 6'b101010) ? 4'b0111 : //slt
								4'b0010; // lw, sw, add
    assign read_sel_a  = instruction[25:21];
    assign read_sel_b  = instruction[20:16];
    assign write_sel   = (instruction[31:26] == 0) ? instruction[15:11] : instruction[20:16];
    assign write       = (instruction[31:26] == 6'b101011 | instruction[31:26] == 6'b000100) ? 0 : 1; // should be 1 only when not a SW
    assign MemRead =  (instruction[31:26] == 6'b100011) ? 1 : 0; //lw
    assign MemReg =  (instruction[31:26] == 6'b100011) ? 1 : 0; // memReg
    assign MemWrite = (instruction[31:26] == 6'b101011) ? 1 : 0; //sw

     // FIXME: add output
    assign ALUSrc = (instruction[31:26] == 6'b000000 | instruction[31:26] == 6'b000100) ? 0 : 1;
    assign Branch = (instruction[31:26] == 6'b000100) ? 1 : 0;

endmodule