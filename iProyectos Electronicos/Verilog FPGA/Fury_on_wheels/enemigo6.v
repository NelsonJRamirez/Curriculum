`timescale 1ns / 1ps
module enemigo6 (
input enable,
input clock,
input [9:0] posx, posy,
input [9:0] hcount,
input [9:0] vcount,
output reg[2:0] red,
output reg[2:0] green,
output reg[1:0] blue,
output reg data);

always @(posedge clock)
begin
	if(enable)
	begin
		if(hcount >= posx & hcount < posx + RESOLUCION_X & vcount >= posy & vcount < posy + RESOLUCION_Y)
		begin
			if (enemigo6[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= enemigo6[vcount- posy][hcount- posx][7:5];
				green <= enemigo6[vcount- posy][hcount- posx][4:2];
            blue 	<= enemigo6[vcount- posy][hcount- posx][1:0];
				data  <= 1'b1;
			end
			else
				data <= 0;
			end
		else
		data <= 0;
	end
end

parameter RESOLUCION_X = 50;
parameter RESOLUCION_Y = 60;
wire [8:0] enemigo6[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign enemigo6[18][22] = 9'b111101100;
assign enemigo6[18][23] = 9'b110001101;
assign enemigo6[18][24] = 9'b101001001;
assign enemigo6[18][25] = 9'b111110000;
assign enemigo6[18][26] = 9'b111101100;
assign enemigo6[19][21] = 9'b111101100;
assign enemigo6[19][22] = 9'b111101100;
assign enemigo6[19][23] = 9'b110001101;
assign enemigo6[19][24] = 9'b101001001;
assign enemigo6[19][25] = 9'b111110000;
assign enemigo6[19][26] = 9'b111101100;
assign enemigo6[19][27] = 9'b111101100;
assign enemigo6[20][20] = 9'b111101100;
assign enemigo6[20][21] = 9'b111111110;
assign enemigo6[20][22] = 9'b111110000;
assign enemigo6[20][23] = 9'b110001101;
assign enemigo6[20][24] = 9'b101001001;
assign enemigo6[20][25] = 9'b111101100;
assign enemigo6[20][26] = 9'b111111101;
assign enemigo6[20][27] = 9'b111110001;
assign enemigo6[21][20] = 9'b111101100;
assign enemigo6[21][21] = 9'b111110101;
assign enemigo6[21][22] = 9'b111110000;
assign enemigo6[21][23] = 9'b110001101;
assign enemigo6[21][24] = 9'b101001001;
assign enemigo6[21][25] = 9'b111101100;
assign enemigo6[21][26] = 9'b111110001;
assign enemigo6[21][27] = 9'b111110101;
assign enemigo6[22][19] = 9'b111101100;
assign enemigo6[22][20] = 9'b111101100;
assign enemigo6[22][21] = 9'b111101100;
assign enemigo6[22][22] = 9'b111101100;
assign enemigo6[22][23] = 9'b110001101;
assign enemigo6[22][24] = 9'b101001001;
assign enemigo6[22][25] = 9'b111110000;
assign enemigo6[22][26] = 9'b111101100;
assign enemigo6[22][27] = 9'b111101100;
assign enemigo6[22][28] = 9'b111101100;
assign enemigo6[23][19] = 9'b111101100;
assign enemigo6[23][20] = 9'b111101100;
assign enemigo6[23][21] = 9'b111101100;
assign enemigo6[23][22] = 9'b111101100;
assign enemigo6[23][23] = 9'b110001101;
assign enemigo6[23][24] = 9'b101001001;
assign enemigo6[23][25] = 9'b111101100;
assign enemigo6[23][26] = 9'b111101100;
assign enemigo6[23][27] = 9'b111101100;
assign enemigo6[23][28] = 9'b111101100;
assign enemigo6[24][19] = 9'b111101100;
assign enemigo6[24][20] = 9'b111101100;
assign enemigo6[24][21] = 9'b111101100;
assign enemigo6[24][22] = 9'b111101100;
assign enemigo6[24][23] = 9'b110001101;
assign enemigo6[24][24] = 9'b101001001;
assign enemigo6[24][25] = 9'b111110000;
assign enemigo6[24][26] = 9'b111101100;
assign enemigo6[24][27] = 9'b111101100;
assign enemigo6[24][28] = 9'b111101100;
assign enemigo6[25][20] = 9'b111101100;
assign enemigo6[25][21] = 9'b110101000;
assign enemigo6[25][22] = 9'b110001000;
assign enemigo6[25][23] = 9'b101001000;
assign enemigo6[25][24] = 9'b100100100;
assign enemigo6[25][25] = 9'b110001000;
assign enemigo6[25][26] = 9'b110001000;
assign enemigo6[25][27] = 9'b111101100;
assign enemigo6[25][28] = 9'b111101100;
assign enemigo6[26][20] = 9'b110101000;
assign enemigo6[26][21] = 9'b101000100;
assign enemigo6[26][22] = 9'b100000000;
assign enemigo6[26][23] = 9'b100000000;
assign enemigo6[26][24] = 9'b100000000;
assign enemigo6[26][25] = 9'b100000000;
assign enemigo6[26][26] = 9'b100000000;
assign enemigo6[26][27] = 9'b110001000;
assign enemigo6[27][20] = 9'b101100100;
assign enemigo6[27][21] = 9'b101000100;
assign enemigo6[27][22] = 9'b110001000;
assign enemigo6[27][23] = 9'b101001000;
assign enemigo6[27][24] = 9'b100100100;
assign enemigo6[27][25] = 9'b101101000;
assign enemigo6[27][26] = 9'b110001000;
assign enemigo6[27][27] = 9'b100100000;
assign enemigo6[28][20] = 9'b101100100;
assign enemigo6[28][21] = 9'b100100000;
assign enemigo6[28][22] = 9'b111101100;
assign enemigo6[28][23] = 9'b110001101;
assign enemigo6[28][24] = 9'b101001001;
assign enemigo6[28][25] = 9'b111110000;
assign enemigo6[28][26] = 9'b110101000;
assign enemigo6[28][27] = 9'b100100000;
assign enemigo6[29][20] = 9'b101100100;
assign enemigo6[29][21] = 9'b100100000;
assign enemigo6[29][22] = 9'b111101100;
assign enemigo6[29][23] = 9'b110001101;
assign enemigo6[29][24] = 9'b101001001;
assign enemigo6[29][25] = 9'b111110000;
assign enemigo6[29][26] = 9'b110001000;
assign enemigo6[29][27] = 9'b100100000;
assign enemigo6[30][20] = 9'b101100100;
assign enemigo6[30][21] = 9'b100100000;
assign enemigo6[30][22] = 9'b111101100;
assign enemigo6[30][23] = 9'b110001101;
assign enemigo6[30][24] = 9'b101001001;
assign enemigo6[30][25] = 9'b111110000;
assign enemigo6[30][26] = 9'b110001000;
assign enemigo6[30][27] = 9'b100100000;
assign enemigo6[31][20] = 9'b101100100;
assign enemigo6[31][21] = 9'b100100000;
assign enemigo6[31][22] = 9'b111101100;
assign enemigo6[31][23] = 9'b110001101;
assign enemigo6[31][24] = 9'b101001001;
assign enemigo6[31][25] = 9'b111110000;
assign enemigo6[31][26] = 9'b110001000;
assign enemigo6[31][27] = 9'b100100000;
assign enemigo6[32][20] = 9'b101100100;
assign enemigo6[32][21] = 9'b100100000;
assign enemigo6[32][22] = 9'b111101100;
assign enemigo6[32][23] = 9'b110001101;
assign enemigo6[32][24] = 9'b101001001;
assign enemigo6[32][25] = 9'b111110000;
assign enemigo6[32][26] = 9'b110001000;
assign enemigo6[32][27] = 9'b100100000;
assign enemigo6[33][20] = 9'b110001000;
assign enemigo6[33][21] = 9'b101100100;
assign enemigo6[33][22] = 9'b111101100;
assign enemigo6[33][23] = 9'b110001101;
assign enemigo6[33][24] = 9'b101001001;
assign enemigo6[33][25] = 9'b111110000;
assign enemigo6[33][26] = 9'b111101000;
assign enemigo6[33][27] = 9'b101100100;
assign enemigo6[34][20] = 9'b111101100;
assign enemigo6[34][21] = 9'b111101100;
assign enemigo6[34][22] = 9'b111101100;
assign enemigo6[34][23] = 9'b110001101;
assign enemigo6[34][24] = 9'b101001001;
assign enemigo6[34][25] = 9'b111110000;
assign enemigo6[34][26] = 9'b111101100;
assign enemigo6[34][27] = 9'b111101100;
assign enemigo6[35][20] = 9'b111101100;
assign enemigo6[35][21] = 9'b111101100;
assign enemigo6[35][22] = 9'b111101100;
assign enemigo6[35][23] = 9'b101101000;
assign enemigo6[35][24] = 9'b100101001;
assign enemigo6[35][25] = 9'b110101100;
assign enemigo6[35][26] = 9'b111101100;
assign enemigo6[35][27] = 9'b111101100;
assign enemigo6[36][20] = 9'b111101100;
assign enemigo6[36][21] = 9'b111101000;
assign enemigo6[36][22] = 9'b100000000;
assign enemigo6[36][23] = 9'b100000000;
assign enemigo6[36][24] = 9'b100000000;
assign enemigo6[36][25] = 9'b100000000;
assign enemigo6[36][26] = 9'b101000100;
assign enemigo6[36][27] = 9'b111101100;
assign enemigo6[36][28] = 9'b111101100;
assign enemigo6[37][19] = 9'b111101100;
assign enemigo6[37][20] = 9'b111101100;
assign enemigo6[37][21] = 9'b101100100;
assign enemigo6[37][22] = 9'b101000100;
assign enemigo6[37][23] = 9'b100100100;
assign enemigo6[37][24] = 9'b100000000;
assign enemigo6[37][25] = 9'b101000100;
assign enemigo6[37][26] = 9'b101000100;
assign enemigo6[37][27] = 9'b111101100;
assign enemigo6[37][28] = 9'b111101100;
assign enemigo6[38][19] = 9'b111101100;
assign enemigo6[38][20] = 9'b111101100;
assign enemigo6[38][21] = 9'b111101100;
assign enemigo6[38][22] = 9'b111101100;
assign enemigo6[38][23] = 9'b110001101;
assign enemigo6[38][24] = 9'b101001001;
assign enemigo6[38][25] = 9'b111110000;
assign enemigo6[38][26] = 9'b111101100;
assign enemigo6[38][27] = 9'b111101100;
assign enemigo6[38][28] = 9'b111101100;
assign enemigo6[39][19] = 9'b111101100;
assign enemigo6[39][20] = 9'b111101100;
assign enemigo6[39][21] = 9'b111101100;
assign enemigo6[39][22] = 9'b111101100;
assign enemigo6[39][23] = 9'b110001101;
assign enemigo6[39][24] = 9'b101001001;
assign enemigo6[39][25] = 9'b111110000;
assign enemigo6[39][26] = 9'b111101100;
assign enemigo6[39][27] = 9'b111101100;
assign enemigo6[39][28] = 9'b111101100;
assign enemigo6[40][20] = 9'b111101100;
assign enemigo6[40][21] = 9'b111101100;
assign enemigo6[40][22] = 9'b111101100;
assign enemigo6[40][23] = 9'b110001101;
assign enemigo6[40][24] = 9'b101001001;
assign enemigo6[40][25] = 9'b111110000;
assign enemigo6[40][26] = 9'b111101100;
assign enemigo6[40][27] = 9'b111101100;
assign enemigo6[41][21] = 9'b111100100;
assign enemigo6[41][22] = 9'b110100100;
assign enemigo6[41][23] = 9'b111101100;
assign enemigo6[41][24] = 9'b111101100;
assign enemigo6[41][25] = 9'b111101000;
assign enemigo6[41][26] = 9'b111100100;
assign enemigo6[41][27] = 9'b111101000;
//Total de Lineas = 201
endmodule

