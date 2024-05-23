`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:38:21 04/14/2023 
// Design Name: 
// Module Name:    relojenemigo3 
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
module relojenemigo3(clock_in,y);
input clock_in;
output reg y;
reg [26:0]z=27'd0;
parameter w=27'd666666;

always@(negedge clock_in)
begin
z<=z+27'd1;
if(z>=(w-1))
z<=27'd0;
y<=(z<w/2)?1'b1:1'b0;
end
endmodule