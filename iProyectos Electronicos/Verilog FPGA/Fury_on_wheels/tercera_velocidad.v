
module tercera_velocidad(clock_in,y);
input clock_in;
output reg y;
reg [22:0]z=23'd0;
parameter w=23'd333333;

always@(negedge clock_in)
begin
z<=z+23'd1;
if(z>=(w-1))
z<=23'd0;
y<=(z<w/2)?1'b1:1'b0;
end
endmodule
