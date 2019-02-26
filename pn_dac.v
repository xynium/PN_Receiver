`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: jplathuile
// Engineer:  Xynium FM4PN
// 
// Create Date: 06.01.2019 08:09:42
// Design Name:
// Module Name: pn_dac
// Project Name: 
// Target Devices: Zynq
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


module PN_Dac #(
  parameter integer DAC_DATA_WIDTH = 14,
  parameter integer IN_DATA_WIDTH = 16
 )
(

  input  wire                        clk,
  input  wire                        ddr_clk,
  input  wire                        locked,

  // DAC signals
  (* X_INTERFACE_PARAMETER = "FREQ_HZ 250000000" *)
  output wire                        dac_clk,
  output wire                        dac_rst,
  output wire                        dac_sel,
  output wire                        dac_wrt,
  output wire [DAC_DATA_WIDTH-1:0]   dac_dat,
 
  input  wire [IN_DATA_WIDTH-1:0]   Idata,
  input  wire [IN_DATA_WIDTH-1:0]   Qdata
);

  reg [DAC_DATA_WIDTH-1:0] rIdat;
  reg [DAC_DATA_WIDTH-1:0] rQdat;
  //reg int_rst_reg;

  wire [DAC_DATA_WIDTH-2:0] IdtaBts;
  wire [DAC_DATA_WIDTH-2:0] QdtaBts;

  assign IdtaBts =Idata[IN_DATA_WIDTH-2:2];
  assign QdtaBts =Qdata[IN_DATA_WIDTH-2:2];

  genvar j;

  always @(posedge clk)
  begin
    if(~locked)
    begin
      rIdat <= {(DAC_DATA_WIDTH){1'b0}};
      rQdat <= {(DAC_DATA_WIDTH){1'b0}};
    end
    else
    begin
      rIdat <=  {Idata[IN_DATA_WIDTH-1], ~IdtaBts};
      rQdat <=  {Qdata[IN_DATA_WIDTH-1], ~QdtaBts};
    end
    //int_rst_reg <= ~locked ;
  end

  //ODDR ODDR_rst(.Q(dac_rst), .D1(int_rst_reg), .D2(int_rst_reg), .C(clk), .CE(1'b1), .R(1'b0), .S(1'b0));
  assign dac_rst = 1'b0;
  
  ODDR ODDR_sel(.Q(dac_sel), .D1(1'b0), .D2(1'b1), .C(clk), .CE(1'b1), .R(1'b0), .S(1'b0));
  ODDR ODDR_wrt(.Q(dac_wrt), .D1(1'b0), .D2(1'b1), .C(ddr_clk), .CE(1'b1), .R(1'b0), .S(1'b0));
  ODDR ODDR_clk(.Q(dac_clk), .D1(1'b0), .D2(1'b1), .C(ddr_clk), .CE(1'b1), .R(1'b0), .S(1'b0));

  generate
    for(j = 0; j < DAC_DATA_WIDTH; j = j + 1)
    begin : DAC_DAT
      ODDR ODDR_inst(
        .Q(dac_dat[j]),
        .D1(rIdat[j]),
        .D2(rQdat[j]),
        .C(clk),
        .CE(1'b1),
        .R(1'b0),
        .S(1'b0)
      );
    end
  endgenerate

endmodule
