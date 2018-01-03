`timescale 1ns / 1ns
/** @module : Memory Module
 *  @author : Albert Bitdiddle
 *  Simple Memory Design Template
 *  Adaptive and Secure Computing Systems (ASCS) Laboratory
 */
 
 module Memory (
		clock,
    	Address,
   		MemRead, ReadData,
    	MemWrite,writeData
); 

input clock; 
input [31:0]   Address;
input MemRead;
output [31:0]  ReadData;
input MemWrite;
input [31:0]   writeData;
 
localparam MEM_DEPTH = 1 << 8;
reg [31:0]     ram [0:MEM_DEPTH-1];
 
//--------------Add your code here ------------------ 
always @ (posedge clock) begin
	if (MemWrite) 
		begin
		ram[Address] <= writeData;
		end
end
//----------------------------------------------------

assign ReadData = ram[Address];

endmodule