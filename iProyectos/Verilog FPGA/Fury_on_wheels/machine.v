`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:38:17 04/15/2023 
// Design Name: 
// Module Name:    machine 
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
module machine(clk,botones,estados,gameover);
input gameover;
input clk;
input[2:0]botones;
output reg [1:0]estados;

//botones[0]=start
//botones[1]= pausa
//botones[2]=reset  
//gameover perdi	 
always@(posedge clk)

if(botones[0]==0)///start
estados<=2'd1;
else if(botones[1]==0&&estados==1) // pausa
estados<=2'd2;
else if(botones[2]==0&&(estados==2||estados==3))//reset
estados<=2'd0;
else if(gameover==1)//perder
estados<=2'd3;
endmodule
