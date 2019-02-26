`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2019 14:31:08
// Design Name: 
// Module Name: PN_CAG
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PN_CAG(
     input Clk,
    input [23:0] Din,
    output reg [15:0] Dout
    );
 
 reg [39:0] TmpReg;
 
 initial begin
     TmpReg = 0;
     end
 
 always@(posedge Clk) begin
     if (Din[23]==1'b1) TmpReg <= (TmpReg*255 - Din*256)/256;
     else TmpReg <= (TmpReg*255 + Din*256)/256;
    // TmpReg = TmpReg/256;
     //Dout = 16'h0x7FFF - TmpReg[23:8];
    // Dout =  TmpReg[23:8];
     end  
     
 always@( TmpReg)    
    Dout <= 16'h0x7FFF - TmpReg[23:8];
     
      
        
endmodule
