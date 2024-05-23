module clk_hz1(clock_in,y);
input clock_in;
output reg y;
reg [26:0]z=27'd0;
parameter w=27'd100000000;

always@(negedge clock_in)
begin
z<=z+27'd1;
if(z>=(w-1))
z<=27'd0;
y<=(z<w/2)?1'b1:1'b0;
end
endmodule
