
module clk(clock_in,y);
input clock_in;
output reg y;
reg [19:0]z=20'd0;
parameter w=20'd1000000;

always@(negedge clock_in)
begin
z<=z+20'd1;
if(z>=(w-1))
z<=20'd0;
y<=(z<w/2)?1'b1:1'b0;
end
endmodule
