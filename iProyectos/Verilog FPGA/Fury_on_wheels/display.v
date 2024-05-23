module display(clk,seg,on1,on2,on3,x);
input clk;
reg [2:0]selec;
output reg [6:0]seg;
input [6:0] on1,on2,on3;
output reg[2:0]x;

always@(posedge clk)
begin
if(selec==3'd0)
begin seg=on1;x=3'b110;end

else if(selec==3'd1)
begin seg=on2;x=3'b101;end

else if(selec==3'd2)
begin seg=on3;x=3'b011;end

selec=selec+1'b1;

end
endmodule