// (c) Copyright 1995-2019 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: pavel-demin:user:axis_fifo:1.0
// IP Revision: 1

(* X_CORE_INFO = "axis_fifo,Vivado 2017.2" *)
(* CHECK_LICENSE_TYPE = "system_fifo_1_0,axis_fifo,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_fifo_1_0 (
  aclk,
  s_axis_tready,
  s_axis_tdata,
  s_axis_tvalid,
  m_axis_tready,
  m_axis_tdata,
  m_axis_tvalid,
  fifo_write_full,
  fifo_write_data,
  fifo_write_wren,
  fifo_read_empty,
  fifo_read_data,
  fifo_read_rden
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
input wire aclk;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TREADY" *)
output wire s_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *)
input wire [63 : 0] s_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *)
input wire s_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *)
input wire m_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *)
output wire [31 : 0] m_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *)
output wire m_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *)
input wire fifo_write_full;
(* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *)
output wire [63 : 0] fifo_write_data;
(* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *)
output wire fifo_write_wren;
(* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *)
input wire fifo_read_empty;
(* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *)
input wire [31 : 0] fifo_read_data;
(* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *)
output wire fifo_read_rden;

  axis_fifo #(
    .S_AXIS_TDATA_WIDTH(64),
    .M_AXIS_TDATA_WIDTH(32)
  ) inst (
    .aclk(aclk),
    .s_axis_tready(s_axis_tready),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tvalid(s_axis_tvalid),
    .m_axis_tready(m_axis_tready),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tvalid(m_axis_tvalid),
    .fifo_write_full(fifo_write_full),
    .fifo_write_data(fifo_write_data),
    .fifo_write_wren(fifo_write_wren),
    .fifo_read_empty(fifo_read_empty),
    .fifo_read_data(fifo_read_data),
    .fifo_read_rden(fifo_read_rden)
  );
endmodule


module axis_fifo #
(
  parameter integer S_AXIS_TDATA_WIDTH = 32,
  parameter integer M_AXIS_TDATA_WIDTH = 32
)
(
  // System signals
  input  wire                          aclk,

  // Slave side
  output wire                          s_axis_tready,
  input  wire [S_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input  wire                          s_axis_tvalid,

  // Master side
  input  wire                          m_axis_tready,
  output wire [M_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire                          m_axis_tvalid,

  // FIFO_WRITE port
  input  wire                          fifo_write_full,
  output wire [S_AXIS_TDATA_WIDTH-1:0] fifo_write_data,
  output wire                          fifo_write_wren,

  // FIFO_READ port
  input  wire                          fifo_read_empty,
  input  wire [M_AXIS_TDATA_WIDTH-1:0] fifo_read_data,
  output wire                          fifo_read_rden
);

  assign m_axis_tdata = fifo_read_empty ? {(M_AXIS_TDATA_WIDTH){1'b0}} : fifo_read_data;
  assign m_axis_tvalid = 1'b1;

  assign s_axis_tready = 1'b1;

  assign fifo_read_rden = m_axis_tready;

  assign fifo_write_data = s_axis_tdata;
  assign fifo_write_wren = s_axis_tvalid;

endmodule
