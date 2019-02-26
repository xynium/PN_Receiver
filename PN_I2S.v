`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design : Xynium JPLathuile
// Module Name: axis_i2s2
// Description: 
//     Transmet 16bts 8khz
//    BClk 128KHz =ax_clk / 128 = 16.384MHz/16= 2*16bts*8khz
//    si tx_axis_s_ready a 1 on peut presenter des data no real use
//    si tx_axis_s_valid est à 1 on latche les data no real use
// exp_p_tri_io,    les 16bits haut sont le canal droit les 16 bas le gauche
//////////////////////////////////////////////////////////////////////////////////

module PN_I2S(
    input  wire        ax_clk, // require: 16.384MHz
    input  wire [31:0] tx_ax_s_data,
    input  wire        tx_ax_s_valid,
    output reg         tx_ax_s_ready = 1'b0,
      
    // Tx OUT a connecter a IN sur le TLV
    output wire tx_Mclk, 
    output wire tx_LRCOUT, 
    output wire tx_Bclk, 
    output reg  tx_DOUT 
   
);
   reg[6:0] PreDiv=0;
   reg[5:0] MainClk=0;
   reg[15:0] tx_data_shift = 16'b0;
   integer tmp =0;
   
   assign tx_LRCOUT = MainClk[4];
   assign tx_Bclk = PreDiv[6];
   assign tx_Mclk = ax_clk;
             
   always@(posedge ax_clk) begin
       PreDiv <= PreDiv+1;
       if (PreDiv==7'h00)
            MainClk<= MainClk+1;
   end
   
   always@(posedge MainClk[0]or negedge MainClk[0]) begin 
        tx_DOUT <= tx_data_shift[15];
        tx_data_shift <= {tx_data_shift[14:0], 1'b0};
        tmp<=tmp+1;
        if (tmp==14)
            tx_ax_s_ready <= 1'b1;
   end
      
   always@(posedge MainClk[4])begin //load rigth data
        tx_data_shift <= tx_ax_s_data[31:16];
        tx_ax_s_ready <= 1'b0;
        tmp<=0;
   end
    
   always@(negedge MainClk[4]) begin //Load left data
        tx_data_shift <= tx_ax_s_data[15:0];
        tx_ax_s_ready <= 1'b0;
        tmp<=0;
   end
         
endmodule
