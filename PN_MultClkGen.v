`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: JPLathuile
// Engineer: xynium
// 
// Create Date: 08.02.2019 08:04:40
// Design Name: 
// Module Name: PN_MultClkGen
// Lengthen clock pulse and combine them for Adder
// 
//////////////////////////////////////////////////////////////////////////////////


module PN_MultClkGen(
    input Clk1,
    input Clk2,
    input Clk,
    output ClkOut
    );
    parameter PulsLeng = 4000;
  
    wire rClk1,rClk2;
    integer Cpt;
    reg One=1'b1;
    reg CLR;
       
    assign ClkOut = rClk1 & rClk2;
    
    initial begin
        Cpt=0;
        end
         
     FDCE #(
        .INIT(1'b0) // Initial value of register (1'b0 or 1'b1)
        ) FClk1 (
        .Q(rClk1), // 1-bit Data output
        .C(Clk1), // 1-bit Clock input
        .CE(One), // 1-bit Clock enable input
        .CLR(CLR), // 1-bit Asynchronous clear input
        .D(One) // 1-bit Data input
        );
     
     FDCE #(
        .INIT(1'b0) // Initial value of register (1'b0 or 1'b1)
        ) FClk2 (
        .Q(rClk2), // 1-bit Data output
        .C(Clk2), // 1-bit Clock input
        .CE(One), // 1-bit Clock enable input
        .CLR(CLR), // 1-bit Asynchronous clear input
        .D(One) // 1-bit Data input
        );
             
    always@(posedge Clk) begin 
       if (rClk1 || rClk2)
           Cpt = Cpt + 1;
       if (Cpt > PulsLeng) begin
          CLR<=1'b1;
          Cpt=0;
          end
       else   
           CLR<=1'b0;
       end   
    
endmodule
