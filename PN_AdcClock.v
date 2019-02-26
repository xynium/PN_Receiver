`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: jplathuile
// Engineer: xynium
// 
// Create Date: 24.02.2019 10:21:30
// Design Name: 
// Module Name: PN_AdcClock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Clock RedPitaya
// 
//////////////////////////////////////////////////////////////////////////////////


module PN_AdcClock(
    input AClkd,
    input AClki,
    output AClk
    );
    
    wire                      int_clk0;
    wire                      int_clk;
    
      IBUFGDS adc_clk_inst0 (.I(AClkd), .IB(AClki), .O(int_clk0));
      BUFG adc_clk_inst (.I(int_clk0), .O(int_clk));

  assign AClk = int_clk;

endmodule
