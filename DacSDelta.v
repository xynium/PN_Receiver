`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design : Xynium JPLathuile
// Module Name: PN_DacSigDta
// Description: 
//     convertis le données entrées en analogique
//     DAC sigma delta 1 bits 
//     BClk 128KHz = ax_clk / 128 = 16.384MHz/16 = 2*16bts*8khz
//  
//////////////////////////////////////////////////////////////////////////////////
module PN_DacSigDta(DACout, DACin, Clk);
    parameter MSBI = 16;  // nombre de bits
    output DACout; // This is the average output that feeds low pass filter
    reg DACout; // for optimum performance, ensure that this ff is in IOB
    input[MSBI-1:0] DACin; // DAC input (excess 2**MSBI)
    input Clk;
       
    reg[MSBI+1:0] DeltaAdder; // Output of Delta adder
    reg[MSBI+1:0] SigmaAdder; // Output of Sigma adder
    reg[MSBI+1:0] SigmaLatch=MSBI+1'b0; // Latches output of Sigma adder
    reg[MSBI+1:0] DeltaB; // B input of Delta adder
    
    always @(SigmaLatch)
         DeltaB = {SigmaLatch[MSBI+1], SigmaLatch[MSBI+1]} << (MSBI);
    
    always @(DACin or DeltaB) begin
    if (DACin[MSBI-1]==1'b0)
         DeltaAdder <= (DACin + DeltaB) | {1'b1,{(MSBI-1){1'b0}}};
    else
         DeltaAdder <= (DeltaB +  DACin) & ~{1'b1,{(MSBI-1){1'b0}}};
    end
    
    always @(DeltaAdder or SigmaLatch) SigmaAdder = DeltaAdder + SigmaLatch;
    
    always @(posedge Clk )    begin
            SigmaLatch <=  SigmaAdder;
            DACout <=  SigmaLatch[MSBI+1];
            end
        
endmodule
