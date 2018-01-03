`timescale 1ns / 1ns
/** @module : ALU
 *  @author : Albert Bitdiddle
 *  ALU Module Template 
 *  Adaptive and Secure Computing Systems (ASCS) Laboratory
 */
 
module ALU (
		ALU_Control, 
		operand_A, operand_B, 
		ALU_result, zero
); 
input [3:0]   ALU_Control; 
input [31:0]  operand_A ;
input [31:0]  operand_B ;
output zero; 
output [31:0] ALU_result;

//--------------Add your code here ------------------ 

// TODO: right now, ALU only ANDs the two operands. You have to implement the rest of the instructions.

assign ALU_result = (ALU_Control == 4'b0000) ? (operand_A & operand_B) :
						  (ALU_Control == 4'b0001) ? (operand_A | operand_B) :
						  (ALU_Control == 4'b0010) ? (operand_A + operand_B) :
						  (ALU_Control == 4'b0110) ? (operand_A - operand_B) :
						  (ALU_Control == 4'b0111) ? (operand_A < operand_B) ? 1: 0 :
						  (ALU_Control == 4'b1100) ? ~(operand_A | operand_B) : 
						  0;
						  
//operand_A & operand_B;
assign zero =(ALU_result == 0) ? 1 : 0;


//----------------------------------------------------

endmodule