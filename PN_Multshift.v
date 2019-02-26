`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: JPLathuile
// Engineer: Xynium
// 
// Create Date: 11.01.2019 12:56:15
// Design Name: 
// Module Name: SliceShift
// Scale for not loosing signal
// 
//////////////////////////////////////////////////////////////////////////////////


module PN_MultShift(
        input wire[3:0] GCtrl,
        input wire[InWdth-1:0] Din,
        output reg[OutWdth-1:0] DoutReg
    );
 parameter OutWdth = 24;
 parameter InWdth = 40;

  
 always@(Din)
    begin
        case (GCtrl)
            4'b0000:  DoutReg<=Din[InWdth-1:InWdth-OutWdth-1];
            4'b0001:  DoutReg<=Din[InWdth-2:InWdth-OutWdth-2];
            4'b0010:  DoutReg<=Din[InWdth-3:InWdth-OutWdth-3];
            4'b0011:  DoutReg<=Din[InWdth-4:InWdth-OutWdth-4];
            4'b0100:  DoutReg<=Din[InWdth-5:InWdth-OutWdth-5];
            4'b0101:  DoutReg<=Din[InWdth-6:InWdth-OutWdth-6];
            4'b0110:  DoutReg<=Din[InWdth-7:InWdth-OutWdth-7];
            4'b0111:  DoutReg<=Din[InWdth-8:InWdth-OutWdth-8];
            4'b1000:  DoutReg<=Din[InWdth-9:InWdth-OutWdth-9];
            4'b1001:  DoutReg<=Din[InWdth-10:InWdth-OutWdth-10];
            4'b1010:  DoutReg<=Din[InWdth-11:InWdth-OutWdth-11];
            4'b1011:  DoutReg<=Din[InWdth-12:InWdth-OutWdth-12];
            4'b1100:  DoutReg<=Din[InWdth-13:InWdth-OutWdth-13];
            4'b1101:  DoutReg<=Din[InWdth-14:InWdth-OutWdth-14];
            4'b1110:  DoutReg<=Din[InWdth-15:InWdth-OutWdth-15];
            4'b1111:  DoutReg<=Din[InWdth-16:InWdth-OutWdth-16];
        endcase
    end
  
   
endmodule
