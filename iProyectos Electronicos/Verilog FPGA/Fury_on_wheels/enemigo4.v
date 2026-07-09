`timescale 1ns / 1ps
module enemigo4 (
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
			if (enemigo4[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= enemigo4[vcount- posy][hcount- posx][7:5];
				green <= enemigo4[vcount- posy][hcount- posx][4:2];
            blue 	<= enemigo4[vcount- posy][hcount- posx][1:0];
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
wire [8:0] enemigo4[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign enemigo4[10][24] = 9'b111110100;
assign enemigo4[10][25] = 9'b111110000;
assign enemigo4[10][26] = 9'b111110000;
assign enemigo4[10][27] = 9'b111110000;
assign enemigo4[10][28] = 9'b111110000;
assign enemigo4[10][29] = 9'b111110100;
assign enemigo4[11][23] = 9'b111110100;
assign enemigo4[11][24] = 9'b111111100;
assign enemigo4[11][25] = 9'b111110000;
assign enemigo4[11][26] = 9'b111110000;
assign enemigo4[11][27] = 9'b111110000;
assign enemigo4[11][28] = 9'b111110000;
assign enemigo4[11][29] = 9'b111111100;
assign enemigo4[11][30] = 9'b111110100;
assign enemigo4[12][22] = 9'b111110100;
assign enemigo4[12][23] = 9'b111111111;
assign enemigo4[12][24] = 9'b111111101;
assign enemigo4[12][25] = 9'b111110000;
assign enemigo4[12][26] = 9'b111110000;
assign enemigo4[12][27] = 9'b111110000;
assign enemigo4[12][28] = 9'b111110000;
assign enemigo4[12][29] = 9'b111111101;
assign enemigo4[12][30] = 9'b111111111;
assign enemigo4[12][31] = 9'b111110100;
assign enemigo4[13][22] = 9'b111110100;
assign enemigo4[13][23] = 9'b111111100;
assign enemigo4[13][24] = 9'b111110100;
assign enemigo4[13][25] = 9'b111110000;
assign enemigo4[13][26] = 9'b111110000;
assign enemigo4[13][27] = 9'b111110000;
assign enemigo4[13][28] = 9'b111110000;
assign enemigo4[13][29] = 9'b111110100;
assign enemigo4[13][30] = 9'b111111100;
assign enemigo4[13][31] = 9'b111110100;
assign enemigo4[14][21] = 9'b111110100;
assign enemigo4[14][22] = 9'b111110100;
assign enemigo4[14][23] = 9'b111110000;
assign enemigo4[14][24] = 9'b111110100;
assign enemigo4[14][25] = 9'b111110000;
assign enemigo4[14][26] = 9'b111110000;
assign enemigo4[14][27] = 9'b111110000;
assign enemigo4[14][28] = 9'b111110000;
assign enemigo4[14][29] = 9'b111110100;
assign enemigo4[14][30] = 9'b111110000;
assign enemigo4[14][31] = 9'b111110100;
assign enemigo4[14][32] = 9'b111110000;
assign enemigo4[15][21] = 9'b111110100;
assign enemigo4[15][22] = 9'b111110100;
assign enemigo4[15][23] = 9'b111110100;
assign enemigo4[15][24] = 9'b111110100;
assign enemigo4[15][25] = 9'b111110000;
assign enemigo4[15][26] = 9'b111110000;
assign enemigo4[15][27] = 9'b111110000;
assign enemigo4[15][28] = 9'b111110000;
assign enemigo4[15][29] = 9'b111110100;
assign enemigo4[15][30] = 9'b111110100;
assign enemigo4[15][31] = 9'b111110100;
assign enemigo4[15][32] = 9'b111110100;
assign enemigo4[16][21] = 9'b111110000;
assign enemigo4[16][22] = 9'b111110100;
assign enemigo4[16][23] = 9'b111110100;
assign enemigo4[16][24] = 9'b111110100;
assign enemigo4[16][25] = 9'b111110000;
assign enemigo4[16][26] = 9'b111110000;
assign enemigo4[16][27] = 9'b111110000;
assign enemigo4[16][28] = 9'b111110000;
assign enemigo4[16][29] = 9'b111110100;
assign enemigo4[16][30] = 9'b111110100;
assign enemigo4[16][31] = 9'b111110100;
assign enemigo4[16][32] = 9'b111110000;
assign enemigo4[17][22] = 9'b111110100;
assign enemigo4[17][23] = 9'b111110000;
assign enemigo4[17][24] = 9'b101101100;
assign enemigo4[17][25] = 9'b101101000;
assign enemigo4[17][26] = 9'b101101000;
assign enemigo4[17][27] = 9'b101101000;
assign enemigo4[17][28] = 9'b101101000;
assign enemigo4[17][29] = 9'b101101100;
assign enemigo4[17][30] = 9'b111110000;
assign enemigo4[17][31] = 9'b111110100;
assign enemigo4[18][22] = 9'b110110000;
assign enemigo4[18][23] = 9'b101101100;
assign enemigo4[18][24] = 9'b101001000;
assign enemigo4[18][25] = 9'b100100100;
assign enemigo4[18][26] = 9'b100100100;
assign enemigo4[18][27] = 9'b100100100;
assign enemigo4[18][28] = 9'b100100100;
assign enemigo4[18][29] = 9'b101001000;
assign enemigo4[18][30] = 9'b101101100;
assign enemigo4[18][31] = 9'b110110000;
assign enemigo4[19][22] = 9'b110110000;
assign enemigo4[19][23] = 9'b101001000;
assign enemigo4[19][24] = 9'b111110000;
assign enemigo4[19][25] = 9'b111110000;
assign enemigo4[19][26] = 9'b111110000;
assign enemigo4[19][27] = 9'b111110000;
assign enemigo4[19][28] = 9'b111110000;
assign enemigo4[19][29] = 9'b111110000;
assign enemigo4[19][30] = 9'b101001000;
assign enemigo4[19][31] = 9'b110110000;
assign enemigo4[20][22] = 9'b110110000;
assign enemigo4[20][23] = 9'b101001000;
assign enemigo4[20][24] = 9'b111110000;
assign enemigo4[20][25] = 9'b111110100;
assign enemigo4[20][26] = 9'b111110100;
assign enemigo4[20][27] = 9'b111110100;
assign enemigo4[20][28] = 9'b111110100;
assign enemigo4[20][29] = 9'b111110000;
assign enemigo4[20][30] = 9'b101001000;
assign enemigo4[20][31] = 9'b110110000;
assign enemigo4[21][22] = 9'b110110000;
assign enemigo4[21][23] = 9'b101001000;
assign enemigo4[21][24] = 9'b111110000;
assign enemigo4[21][25] = 9'b111110100;
assign enemigo4[21][26] = 9'b111111101;
assign enemigo4[21][27] = 9'b111111101;
assign enemigo4[21][28] = 9'b111110100;
assign enemigo4[21][29] = 9'b111110000;
assign enemigo4[21][30] = 9'b101001000;
assign enemigo4[21][31] = 9'b110110000;
assign enemigo4[22][22] = 9'b110110000;
assign enemigo4[22][23] = 9'b101001000;
assign enemigo4[22][24] = 9'b111110000;
assign enemigo4[22][25] = 9'b111110100;
assign enemigo4[22][26] = 9'b111111101;
assign enemigo4[22][27] = 9'b111111101;
assign enemigo4[22][28] = 9'b111110100;
assign enemigo4[22][29] = 9'b111110000;
assign enemigo4[22][30] = 9'b101001000;
assign enemigo4[22][31] = 9'b110110000;
assign enemigo4[23][22] = 9'b110110000;
assign enemigo4[23][23] = 9'b101001000;
assign enemigo4[23][24] = 9'b111110000;
assign enemigo4[23][25] = 9'b111110100;
assign enemigo4[23][26] = 9'b111111101;
assign enemigo4[23][27] = 9'b111111101;
assign enemigo4[23][28] = 9'b111110100;
assign enemigo4[23][29] = 9'b111110000;
assign enemigo4[23][30] = 9'b101001000;
assign enemigo4[23][31] = 9'b110110000;
assign enemigo4[24][22] = 9'b110110000;
assign enemigo4[24][23] = 9'b101001000;
assign enemigo4[24][24] = 9'b111110000;
assign enemigo4[24][25] = 9'b111110100;
assign enemigo4[24][26] = 9'b111110100;
assign enemigo4[24][27] = 9'b111110100;
assign enemigo4[24][28] = 9'b111110100;
assign enemigo4[24][29] = 9'b111110000;
assign enemigo4[24][30] = 9'b101001000;
assign enemigo4[24][31] = 9'b110110000;
assign enemigo4[25][22] = 9'b111110000;
assign enemigo4[25][23] = 9'b110001100;
assign enemigo4[25][24] = 9'b111110100;
assign enemigo4[25][25] = 9'b111110100;
assign enemigo4[25][26] = 9'b111110000;
assign enemigo4[25][27] = 9'b111110000;
assign enemigo4[25][28] = 9'b111110100;
assign enemigo4[25][29] = 9'b111110100;
assign enemigo4[25][30] = 9'b110001100;
assign enemigo4[25][31] = 9'b111110000;
assign enemigo4[26][22] = 9'b111110100;
assign enemigo4[26][23] = 9'b111110100;
assign enemigo4[26][24] = 9'b111110100;
assign enemigo4[26][25] = 9'b111110100;
assign enemigo4[26][26] = 9'b111110100;
assign enemigo4[26][27] = 9'b111110100;
assign enemigo4[26][28] = 9'b111110100;
assign enemigo4[26][29] = 9'b111110100;
assign enemigo4[26][30] = 9'b111110100;
assign enemigo4[26][31] = 9'b111110100;
assign enemigo4[27][22] = 9'b111110000;
assign enemigo4[27][23] = 9'b111110100;
assign enemigo4[27][24] = 9'b111110000;
assign enemigo4[27][25] = 9'b110001100;
assign enemigo4[27][26] = 9'b110001100;
assign enemigo4[27][27] = 9'b110001100;
assign enemigo4[27][28] = 9'b110001100;
assign enemigo4[27][29] = 9'b111110000;
assign enemigo4[27][30] = 9'b111111100;
assign enemigo4[27][31] = 9'b111110000;
assign enemigo4[28][21] = 9'b111110100;
assign enemigo4[28][22] = 9'b111110100;
assign enemigo4[28][23] = 9'b111110000;
assign enemigo4[28][24] = 9'b101001000;
assign enemigo4[28][25] = 9'b100100101;
assign enemigo4[28][26] = 9'b100100100;
assign enemigo4[28][27] = 9'b100100100;
assign enemigo4[28][28] = 9'b100000100;
assign enemigo4[28][29] = 9'b101001000;
assign enemigo4[28][30] = 9'b111110000;
assign enemigo4[28][31] = 9'b111110100;
assign enemigo4[28][32] = 9'b111110100;
assign enemigo4[29][21] = 9'b111110100;
assign enemigo4[29][22] = 9'b111110100;
assign enemigo4[29][23] = 9'b111110000;
assign enemigo4[29][24] = 9'b110001100;
assign enemigo4[29][25] = 9'b110001100;
assign enemigo4[29][26] = 9'b110001100;
assign enemigo4[29][27] = 9'b110001100;
assign enemigo4[29][28] = 9'b110001100;
assign enemigo4[29][29] = 9'b110001100;
assign enemigo4[29][30] = 9'b111110000;
assign enemigo4[29][31] = 9'b111110100;
assign enemigo4[29][32] = 9'b111110000;
assign enemigo4[30][21] = 9'b111110100;
assign enemigo4[30][22] = 9'b111110100;
assign enemigo4[30][23] = 9'b111110100;
assign enemigo4[30][24] = 9'b111110100;
assign enemigo4[30][25] = 9'b111110000;
assign enemigo4[30][26] = 9'b111110000;
assign enemigo4[30][27] = 9'b111110000;
assign enemigo4[30][28] = 9'b111110000;
assign enemigo4[30][29] = 9'b111110100;
assign enemigo4[30][30] = 9'b111110100;
assign enemigo4[30][31] = 9'b111110100;
assign enemigo4[30][32] = 9'b111110000;
assign enemigo4[31][21] = 9'b111110100;
assign enemigo4[31][22] = 9'b111110100;
assign enemigo4[31][23] = 9'b111110100;
assign enemigo4[31][24] = 9'b111110100;
assign enemigo4[31][25] = 9'b111110000;
assign enemigo4[31][26] = 9'b111110000;
assign enemigo4[31][27] = 9'b111110000;
assign enemigo4[31][28] = 9'b111110000;
assign enemigo4[31][29] = 9'b111110100;
assign enemigo4[31][30] = 9'b111110100;
assign enemigo4[31][31] = 9'b111110100;
assign enemigo4[31][32] = 9'b111110000;
assign enemigo4[32][22] = 9'b111110100;
assign enemigo4[32][23] = 9'b111110100;
assign enemigo4[32][24] = 9'b111110000;
assign enemigo4[32][25] = 9'b111110000;
assign enemigo4[32][26] = 9'b111110000;
assign enemigo4[32][27] = 9'b111110000;
assign enemigo4[32][28] = 9'b111110000;
assign enemigo4[32][29] = 9'b111110000;
assign enemigo4[32][30] = 9'b111110100;
assign enemigo4[32][31] = 9'b111110100;
assign enemigo4[33][23] = 9'b111101000;
assign enemigo4[33][24] = 9'b111100000;
assign enemigo4[33][25] = 9'b111101100;
assign enemigo4[33][26] = 9'b111110000;
assign enemigo4[33][27] = 9'b111110000;
assign enemigo4[33][28] = 9'b111101100;
assign enemigo4[33][29] = 9'b111100000;
assign enemigo4[33][30] = 9'b111101000;
//Total de Lineas = 246
endmodule

