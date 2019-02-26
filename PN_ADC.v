`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: jplathuile
// Engineer: xynium 
// 
// Create Date: 24.02.2019 10:15:14
// Design Name: 
// Module Name: PN_ADC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// ADC RedPitaya   reformat output assumed 14 bts IN 16 bts Out
// 
//////////////////////////////////////////////////////////////////////////////////


module PN_ADC(
    input AdcClk,
    input [13:0] InAdcA,
    input [13:0] InAdcB,
    output reg [DTAWDTH-1:0] OutAdcA,
    output reg [DTAWDTH-1:0] OutAdcB
    );
    
    parameter  DTAWDTH =16;  // Width of output    
    
   // reg  [DTAWDTH-1:0] rDtaA;
   // reg  [DTAWDTH-1:0] rDtaB;
     
   // assign OutAdcA = rDtaA;
   // assign OutAdcB = rDtaB;
    
    always @(posedge AdcClk)  begin
        OutAdcA <= {~InAdcA[13],InAdcA[12:0],2'b0};
        OutAdcB <= {~InAdcB[13],InAdcB[12:0],2'b0};
        end
    
endmodule
