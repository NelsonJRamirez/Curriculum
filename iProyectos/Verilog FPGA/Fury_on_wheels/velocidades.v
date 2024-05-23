`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:46:55 04/15/2023 
// Design Name: 
// Module Name:    velocidades 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module velocidades(clk,contador,v,out);
input[8:0]contador;
input [2:0]v;
output reg out;
input clk;
always@(posedge clk)
if(contador>=350)
out<=v[2];
else if(contador>=250)
out<=v[1];
else
out<=v[0];

endmodule
