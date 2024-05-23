`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:39:39 04/15/2023 
// Design Name: 
// Module Name:    frecuenciaDisplay 
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
module frecuenciaDisplay(clock_in,y);
input clock_in;
output reg y;
reg [17:0]z=18'd0;
parameter w=18'd250000;

always@(posedge clock_in)
begin
z<=z+18'd1;
if(z>=(w-1))
z<=18'd0;
y<=(z<w/2)?1'b1:1'b0;
end

endmodule
