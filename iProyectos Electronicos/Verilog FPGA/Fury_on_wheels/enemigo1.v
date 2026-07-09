`timescale 1ns / 1ps
module enemigo1 (
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
			if (enemigo1[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= enemigo1[vcount- posy][hcount- posx][7:5];
				green <= enemigo1[vcount- posy][hcount- posx][4:2];
            blue 	<= enemigo1[vcount- posy][hcount- posx][1:0];
				data  <= 1'b1;
			end
			else
				data <= 0;
			end
		else
		data <= 0;
	end
end

parameter RESOLUCION_X = 60;
parameter RESOLUCION_Y = 60;
wire [8:0] enemigo1[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign enemigo1[10][24] = 9'b100101001;
assign enemigo1[10][25] = 9'b101001101;
assign enemigo1[10][26] = 9'b101001101;
assign enemigo1[10][27] = 9'b101001101;
assign enemigo1[10][28] = 9'b101001101;
assign enemigo1[10][29] = 9'b100101001;
assign enemigo1[11][23] = 9'b100101001;
assign enemigo1[11][24] = 9'b100101001;
assign enemigo1[11][25] = 9'b101001110;
assign enemigo1[11][26] = 9'b101010010;
assign enemigo1[11][27] = 9'b101010010;
assign enemigo1[11][28] = 9'b101001110;
assign enemigo1[11][29] = 9'b100101001;
assign enemigo1[11][30] = 9'b100101001;
assign enemigo1[12][22] = 9'b100101001;
assign enemigo1[12][23] = 9'b111111111;
assign enemigo1[12][24] = 9'b110010111;
assign enemigo1[12][25] = 9'b100101101;
assign enemigo1[12][26] = 9'b101001101;
assign enemigo1[12][27] = 9'b101001101;
assign enemigo1[12][28] = 9'b100101101;
assign enemigo1[12][29] = 9'b110010111;
assign enemigo1[12][30] = 9'b111111111;
assign enemigo1[12][31] = 9'b100101001;
assign enemigo1[13][22] = 9'b101001001;
assign enemigo1[13][23] = 9'b101101101;
assign enemigo1[13][24] = 9'b101001101;
assign enemigo1[13][25] = 9'b101001101;
assign enemigo1[13][26] = 9'b101001101;
assign enemigo1[13][27] = 9'b101001101;
assign enemigo1[13][28] = 9'b101001101;
assign enemigo1[13][29] = 9'b101001101;
assign enemigo1[13][30] = 9'b101101101;
assign enemigo1[13][31] = 9'b101001001;
assign enemigo1[14][21] = 9'b100101001;
assign enemigo1[14][22] = 9'b100101001;
assign enemigo1[14][23] = 9'b100101001;
assign enemigo1[14][24] = 9'b100101001;
assign enemigo1[14][25] = 9'b101001101;
assign enemigo1[14][26] = 9'b101001101;
assign enemigo1[14][27] = 9'b101001101;
assign enemigo1[14][28] = 9'b101001101;
assign enemigo1[14][29] = 9'b100101001;
assign enemigo1[14][30] = 9'b100101001;
assign enemigo1[14][31] = 9'b100101001;
assign enemigo1[14][32] = 9'b100101001;
assign enemigo1[15][21] = 9'b100101001;
assign enemigo1[15][22] = 9'b100101001;
assign enemigo1[15][23] = 9'b100101001;
assign enemigo1[15][24] = 9'b100101001;
assign enemigo1[15][25] = 9'b101001101;
assign enemigo1[15][26] = 9'b101001110;
assign enemigo1[15][27] = 9'b101001110;
assign enemigo1[15][28] = 9'b101001101;
assign enemigo1[15][29] = 9'b100101001;
assign enemigo1[15][30] = 9'b100101001;
assign enemigo1[15][31] = 9'b100101001;
assign enemigo1[15][32] = 9'b100101001;
assign enemigo1[16][21] = 9'b100101001;
assign enemigo1[16][22] = 9'b100101001;
assign enemigo1[16][23] = 9'b100101001;
assign enemigo1[16][24] = 9'b100101001;
assign enemigo1[16][25] = 9'b101001110;
assign enemigo1[16][26] = 9'b101001110;
assign enemigo1[16][27] = 9'b101001110;
assign enemigo1[16][28] = 9'b101001101;
assign enemigo1[16][29] = 9'b100101001;
assign enemigo1[16][30] = 9'b100101001;
assign enemigo1[16][31] = 9'b100101001;
assign enemigo1[16][32] = 9'b100101001;
assign enemigo1[17][22] = 9'b100101001;
assign enemigo1[17][23] = 9'b100101001;
assign enemigo1[17][24] = 9'b100101001;
assign enemigo1[17][25] = 9'b101001001;
assign enemigo1[17][26] = 9'b101001001;
assign enemigo1[17][27] = 9'b101001001;
assign enemigo1[17][28] = 9'b101001001;
assign enemigo1[17][29] = 9'b100101001;
assign enemigo1[17][30] = 9'b100101001;
assign enemigo1[17][31] = 9'b100101001;
assign enemigo1[18][22] = 9'b100101001;
assign enemigo1[18][23] = 9'b100101001;
assign enemigo1[18][24] = 9'b100101000;
assign enemigo1[18][25] = 9'b100100100;
assign enemigo1[18][26] = 9'b100100100;
assign enemigo1[18][27] = 9'b100100100;
assign enemigo1[18][28] = 9'b100100100;
assign enemigo1[18][29] = 9'b100101000;
assign enemigo1[18][30] = 9'b100101001;
assign enemigo1[18][31] = 9'b100101001;
assign enemigo1[19][22] = 9'b100101001;
assign enemigo1[19][23] = 9'b101001000;
assign enemigo1[19][24] = 9'b100101001;
assign enemigo1[19][25] = 9'b100101001;
assign enemigo1[19][26] = 9'b100101001;
assign enemigo1[19][27] = 9'b100101001;
assign enemigo1[19][28] = 9'b100101001;
assign enemigo1[19][29] = 9'b100101001;
assign enemigo1[19][30] = 9'b101001000;
assign enemigo1[19][31] = 9'b100101001;
assign enemigo1[20][22] = 9'b100101001;
assign enemigo1[20][23] = 9'b101001000;
assign enemigo1[20][24] = 9'b100101001;
assign enemigo1[20][25] = 9'b100101001;
assign enemigo1[20][26] = 9'b100101001;
assign enemigo1[20][27] = 9'b100101001;
assign enemigo1[20][28] = 9'b100101001;
assign enemigo1[20][29] = 9'b100101001;
assign enemigo1[20][30] = 9'b101001000;
assign enemigo1[20][31] = 9'b100101001;
assign enemigo1[21][22] = 9'b100101001;
assign enemigo1[21][23] = 9'b101001000;
assign enemigo1[21][24] = 9'b100101001;
assign enemigo1[21][25] = 9'b100101001;
assign enemigo1[21][26] = 9'b101101101;
assign enemigo1[21][27] = 9'b101101101;
assign enemigo1[21][28] = 9'b100101001;
assign enemigo1[21][29] = 9'b100101001;
assign enemigo1[21][30] = 9'b101001000;
assign enemigo1[21][31] = 9'b100101001;
assign enemigo1[22][22] = 9'b100101001;
assign enemigo1[22][23] = 9'b101001000;
assign enemigo1[22][24] = 9'b100101001;
assign enemigo1[22][25] = 9'b101001101;
assign enemigo1[22][26] = 9'b101110010;
assign enemigo1[22][27] = 9'b110010010;
assign enemigo1[22][28] = 9'b101001101;
assign enemigo1[22][29] = 9'b100101001;
assign enemigo1[22][30] = 9'b101001000;
assign enemigo1[22][31] = 9'b100101001;
assign enemigo1[23][22] = 9'b100101001;
assign enemigo1[23][23] = 9'b101001000;
assign enemigo1[23][24] = 9'b100101001;
assign enemigo1[23][25] = 9'b100101001;
assign enemigo1[23][26] = 9'b110010010;
assign enemigo1[23][27] = 9'b101110010;
assign enemigo1[23][28] = 9'b100101001;
assign enemigo1[23][29] = 9'b100101001;
assign enemigo1[23][30] = 9'b100101000;
assign enemigo1[23][31] = 9'b100101001;
assign enemigo1[24][22] = 9'b100101001;
assign enemigo1[24][23] = 9'b101001000;
assign enemigo1[24][24] = 9'b100101001;
assign enemigo1[24][25] = 9'b101001101;
assign enemigo1[24][26] = 9'b110010111;
assign enemigo1[24][27] = 9'b110010010;
assign enemigo1[24][28] = 9'b101001101;
assign enemigo1[24][29] = 9'b100101001;
assign enemigo1[24][30] = 9'b101001000;
assign enemigo1[24][31] = 9'b100101001;
assign enemigo1[25][22] = 9'b100101001;
assign enemigo1[25][23] = 9'b100101001;
assign enemigo1[25][24] = 9'b100101001;
assign enemigo1[25][25] = 9'b100101001;
assign enemigo1[25][26] = 9'b100101001;
assign enemigo1[25][27] = 9'b100101001;
assign enemigo1[25][28] = 9'b100101001;
assign enemigo1[25][29] = 9'b100101001;
assign enemigo1[25][30] = 9'b100101001;
assign enemigo1[25][31] = 9'b100101001;
assign enemigo1[26][22] = 9'b100101001;
assign enemigo1[26][23] = 9'b100101001;
assign enemigo1[26][24] = 9'b100101001;
assign enemigo1[26][25] = 9'b100101001;
assign enemigo1[26][26] = 9'b100101001;
assign enemigo1[26][27] = 9'b100101001;
assign enemigo1[26][28] = 9'b100101001;
assign enemigo1[26][29] = 9'b100101001;
assign enemigo1[26][30] = 9'b100101001;
assign enemigo1[26][31] = 9'b100101001;
assign enemigo1[27][22] = 9'b100101001;
assign enemigo1[27][23] = 9'b100101001;
assign enemigo1[27][24] = 9'b100101001;
assign enemigo1[27][25] = 9'b100101001;
assign enemigo1[27][26] = 9'b100101001;
assign enemigo1[27][27] = 9'b100101001;
assign enemigo1[27][28] = 9'b100101001;
assign enemigo1[27][29] = 9'b100101001;
assign enemigo1[27][30] = 9'b100101001;
assign enemigo1[27][31] = 9'b100101001;
assign enemigo1[28][21] = 9'b100101001;
assign enemigo1[28][22] = 9'b100101001;
assign enemigo1[28][23] = 9'b100101001;
assign enemigo1[28][24] = 9'b100100100;
assign enemigo1[28][25] = 9'b100100100;
assign enemigo1[28][26] = 9'b100100100;
assign enemigo1[28][27] = 9'b100100100;
assign enemigo1[28][28] = 9'b100100100;
assign enemigo1[28][29] = 9'b100100100;
assign enemigo1[28][30] = 9'b100101001;
assign enemigo1[28][31] = 9'b100101001;
assign enemigo1[28][32] = 9'b100101001;
assign enemigo1[29][21] = 9'b100101001;
assign enemigo1[29][22] = 9'b100101001;
assign enemigo1[29][23] = 9'b100101001;
assign enemigo1[29][24] = 9'b100101001;
assign enemigo1[29][25] = 9'b101001001;
assign enemigo1[29][26] = 9'b101001101;
assign enemigo1[29][27] = 9'b101001101;
assign enemigo1[29][28] = 9'b101001001;
assign enemigo1[29][29] = 9'b100101001;
assign enemigo1[29][30] = 9'b100101001;
assign enemigo1[29][31] = 9'b100101001;
assign enemigo1[29][32] = 9'b100101001;
assign enemigo1[30][21] = 9'b100101001;
assign enemigo1[30][22] = 9'b100101001;
assign enemigo1[30][23] = 9'b100101001;
assign enemigo1[30][24] = 9'b100101001;
assign enemigo1[30][25] = 9'b101001110;
assign enemigo1[30][26] = 9'b101001110;
assign enemigo1[30][27] = 9'b101001110;
assign enemigo1[30][28] = 9'b101001101;
assign enemigo1[30][29] = 9'b100101001;
assign enemigo1[30][30] = 9'b100101001;
assign enemigo1[30][31] = 9'b100101001;
assign enemigo1[30][32] = 9'b100101001;
assign enemigo1[31][21] = 9'b100101001;
assign enemigo1[31][22] = 9'b100101001;
assign enemigo1[31][23] = 9'b100101001;
assign enemigo1[31][24] = 9'b100101001;
assign enemigo1[31][25] = 9'b101001101;
assign enemigo1[31][26] = 9'b101001101;
assign enemigo1[31][27] = 9'b101001101;
assign enemigo1[31][28] = 9'b101001101;
assign enemigo1[31][29] = 9'b100101001;
assign enemigo1[31][30] = 9'b100101001;
assign enemigo1[31][31] = 9'b100101001;
assign enemigo1[31][32] = 9'b100101001;
assign enemigo1[32][22] = 9'b100101001;
assign enemigo1[32][23] = 9'b101001001;
assign enemigo1[32][24] = 9'b101001001;
assign enemigo1[32][25] = 9'b101001110;
assign enemigo1[32][26] = 9'b101010010;
assign enemigo1[32][27] = 9'b101010010;
assign enemigo1[32][28] = 9'b101001110;
assign enemigo1[32][29] = 9'b101001001;
assign enemigo1[32][30] = 9'b101001001;
assign enemigo1[32][31] = 9'b100101001;
assign enemigo1[33][23] = 9'b110000101;
assign enemigo1[33][24] = 9'b110000000;
assign enemigo1[33][25] = 9'b101001101;
assign enemigo1[33][26] = 9'b101001110;
assign enemigo1[33][27] = 9'b101001110;
assign enemigo1[33][28] = 9'b101001101;
assign enemigo1[33][29] = 9'b110000000;
assign enemigo1[33][30] = 9'b110000101;
//Total de Lineas = 246
endmodule

