`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:35:15 04/15/2023 
// Design Name: 
// Module Name:    relojjj 
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
module relojjj(clk, m);
input clk;
output reg m;

reg [31:0] z;
parameter y = 32'd15000000;

always @(posedge clk)
begin
z <= z + 1;
if (z == y)
begin 
z <=0;
m <= ~m;
end
end 

endmodule
