`timescale 1ns / 1ps
module enemigo5 (
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
			if (enemigo5[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= enemigo5[vcount- posy][hcount- posx][7:5];
				green <= enemigo5[vcount- posy][hcount- posx][4:2];
            blue 	<= enemigo5[vcount- posy][hcount- posx][1:0];
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
wire [8:0] enemigo5[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign enemigo5[10][24] = 9'b110011100;
assign enemigo5[10][25] = 9'b110111101;
assign enemigo5[10][26] = 9'b110111101;
assign enemigo5[10][27] = 9'b110111101;
assign enemigo5[10][28] = 9'b110111101;
assign enemigo5[10][29] = 9'b110011100;
assign enemigo5[11][23] = 9'b110011100;
assign enemigo5[11][24] = 9'b110111100;
assign enemigo5[11][25] = 9'b111111101;
assign enemigo5[11][26] = 9'b111111101;
assign enemigo5[11][27] = 9'b111111101;
assign enemigo5[11][28] = 9'b111111101;
assign enemigo5[11][29] = 9'b110111100;
assign enemigo5[11][30] = 9'b110011100;
assign enemigo5[12][22] = 9'b110011100;
assign enemigo5[12][23] = 9'b111111111;
assign enemigo5[12][24] = 9'b111111101;
assign enemigo5[12][25] = 9'b110111100;
assign enemigo5[12][26] = 9'b110111101;
assign enemigo5[12][27] = 9'b110111101;
assign enemigo5[12][28] = 9'b110111100;
assign enemigo5[12][29] = 9'b111111101;
assign enemigo5[12][30] = 9'b111111111;
assign enemigo5[12][31] = 9'b110011100;
assign enemigo5[13][22] = 9'b110011100;
assign enemigo5[13][23] = 9'b110111101;
assign enemigo5[13][24] = 9'b110011100;
assign enemigo5[13][25] = 9'b110111101;
assign enemigo5[13][26] = 9'b110111101;
assign enemigo5[13][27] = 9'b110111101;
assign enemigo5[13][28] = 9'b110111101;
assign enemigo5[13][29] = 9'b110011100;
assign enemigo5[13][30] = 9'b110111101;
assign enemigo5[13][31] = 9'b110011100;
assign enemigo5[14][21] = 9'b110011100;
assign enemigo5[14][22] = 9'b110011100;
assign enemigo5[14][23] = 9'b110011100;
assign enemigo5[14][24] = 9'b110011100;
assign enemigo5[14][25] = 9'b110111101;
assign enemigo5[14][26] = 9'b110111101;
assign enemigo5[14][27] = 9'b110111101;
assign enemigo5[14][28] = 9'b110111101;
assign enemigo5[14][29] = 9'b110011100;
assign enemigo5[14][30] = 9'b110011100;
assign enemigo5[14][31] = 9'b110011100;
assign enemigo5[14][32] = 9'b110011100;
assign enemigo5[15][21] = 9'b110011100;
assign enemigo5[15][22] = 9'b110011100;
assign enemigo5[15][23] = 9'b110011100;
assign enemigo5[15][24] = 9'b110011100;
assign enemigo5[15][25] = 9'b110111101;
assign enemigo5[15][26] = 9'b110111101;
assign enemigo5[15][27] = 9'b110111101;
assign enemigo5[15][28] = 9'b110111101;
assign enemigo5[15][29] = 9'b110011100;
assign enemigo5[15][30] = 9'b110011100;
assign enemigo5[15][31] = 9'b110011100;
assign enemigo5[15][32] = 9'b110011100;
assign enemigo5[16][21] = 9'b110011100;
assign enemigo5[16][22] = 9'b110011100;
assign enemigo5[16][23] = 9'b110011100;
assign enemigo5[16][24] = 9'b110011100;
assign enemigo5[16][25] = 9'b111111101;
assign enemigo5[16][26] = 9'b111111101;
assign enemigo5[16][27] = 9'b111111101;
assign enemigo5[16][28] = 9'b111111101;
assign enemigo5[16][29] = 9'b110011100;
assign enemigo5[16][30] = 9'b110011100;
assign enemigo5[16][31] = 9'b110011100;
assign enemigo5[16][32] = 9'b110011100;
assign enemigo5[17][22] = 9'b110011100;
assign enemigo5[17][23] = 9'b101110100;
assign enemigo5[17][24] = 9'b101001100;
assign enemigo5[17][25] = 9'b101101100;
assign enemigo5[17][26] = 9'b101101101;
assign enemigo5[17][27] = 9'b101101101;
assign enemigo5[17][28] = 9'b101101100;
assign enemigo5[17][29] = 9'b101001100;
assign enemigo5[17][30] = 9'b101110100;
assign enemigo5[17][31] = 9'b110011100;
assign enemigo5[18][22] = 9'b101110000;
assign enemigo5[18][23] = 9'b101001100;
assign enemigo5[18][24] = 9'b101001000;
assign enemigo5[18][25] = 9'b100100100;
assign enemigo5[18][26] = 9'b100100100;
assign enemigo5[18][27] = 9'b100100100;
assign enemigo5[18][28] = 9'b100100100;
assign enemigo5[18][29] = 9'b101001000;
assign enemigo5[18][30] = 9'b101001100;
assign enemigo5[18][31] = 9'b101110000;
assign enemigo5[19][22] = 9'b101110000;
assign enemigo5[19][23] = 9'b101001000;
assign enemigo5[19][24] = 9'b110011100;
assign enemigo5[19][25] = 9'b110010100;
assign enemigo5[19][26] = 9'b110010100;
assign enemigo5[19][27] = 9'b110010100;
assign enemigo5[19][28] = 9'b110010100;
assign enemigo5[19][29] = 9'b110011100;
assign enemigo5[19][30] = 9'b101001000;
assign enemigo5[19][31] = 9'b101110000;
assign enemigo5[20][22] = 9'b101110000;
assign enemigo5[20][23] = 9'b101001000;
assign enemigo5[20][24] = 9'b110011100;
assign enemigo5[20][25] = 9'b110011100;
assign enemigo5[20][26] = 9'b110011100;
assign enemigo5[20][27] = 9'b110011100;
assign enemigo5[20][28] = 9'b110011100;
assign enemigo5[20][29] = 9'b110011100;
assign enemigo5[20][30] = 9'b101001000;
assign enemigo5[20][31] = 9'b101110000;
assign enemigo5[21][22] = 9'b101110000;
assign enemigo5[21][23] = 9'b101001000;
assign enemigo5[21][24] = 9'b110011100;
assign enemigo5[21][25] = 9'b110011100;
assign enemigo5[21][26] = 9'b110011100;
assign enemigo5[21][27] = 9'b110111100;
assign enemigo5[21][28] = 9'b110011100;
assign enemigo5[21][29] = 9'b110011100;
assign enemigo5[21][30] = 9'b101001000;
assign enemigo5[21][31] = 9'b101110000;
assign enemigo5[22][22] = 9'b101110000;
assign enemigo5[22][23] = 9'b101001000;
assign enemigo5[22][24] = 9'b110011100;
assign enemigo5[22][25] = 9'b110011100;
assign enemigo5[22][26] = 9'b111111101;
assign enemigo5[22][27] = 9'b111111101;
assign enemigo5[22][28] = 9'b110011100;
assign enemigo5[22][29] = 9'b110011100;
assign enemigo5[22][30] = 9'b101001000;
assign enemigo5[22][31] = 9'b101110000;
assign enemigo5[23][22] = 9'b101110000;
assign enemigo5[23][23] = 9'b101001000;
assign enemigo5[23][24] = 9'b110011100;
assign enemigo5[23][25] = 9'b110111100;
assign enemigo5[23][26] = 9'b111111111;
assign enemigo5[23][27] = 9'b111111111;
assign enemigo5[23][28] = 9'b110011100;
assign enemigo5[23][29] = 9'b110011100;
assign enemigo5[23][30] = 9'b101001000;
assign enemigo5[23][31] = 9'b101110000;
assign enemigo5[24][22] = 9'b101110000;
assign enemigo5[24][23] = 9'b101001000;
assign enemigo5[24][24] = 9'b110011100;
assign enemigo5[24][25] = 9'b110011100;
assign enemigo5[24][26] = 9'b110111100;
assign enemigo5[24][27] = 9'b111111101;
assign enemigo5[24][28] = 9'b110011100;
assign enemigo5[24][29] = 9'b110011100;
assign enemigo5[24][30] = 9'b101001000;
assign enemigo5[24][31] = 9'b101110000;
assign enemigo5[25][22] = 9'b101110100;
assign enemigo5[25][23] = 9'b101110000;
assign enemigo5[25][24] = 9'b110011100;
assign enemigo5[25][25] = 9'b110011100;
assign enemigo5[25][26] = 9'b110011100;
assign enemigo5[25][27] = 9'b110011100;
assign enemigo5[25][28] = 9'b110011100;
assign enemigo5[25][29] = 9'b110011100;
assign enemigo5[25][30] = 9'b101110000;
assign enemigo5[25][31] = 9'b101110100;
assign enemigo5[26][22] = 9'b110011100;
assign enemigo5[26][23] = 9'b110011100;
assign enemigo5[26][24] = 9'b110011100;
assign enemigo5[26][25] = 9'b110011100;
assign enemigo5[26][26] = 9'b110011100;
assign enemigo5[26][27] = 9'b110011100;
assign enemigo5[26][28] = 9'b110011100;
assign enemigo5[26][29] = 9'b110011100;
assign enemigo5[26][30] = 9'b110011100;
assign enemigo5[26][31] = 9'b110011100;
assign enemigo5[27][22] = 9'b110011100;
assign enemigo5[27][23] = 9'b110111100;
assign enemigo5[27][24] = 9'b110011100;
assign enemigo5[27][25] = 9'b101110000;
assign enemigo5[27][26] = 9'b101110000;
assign enemigo5[27][27] = 9'b101110000;
assign enemigo5[27][28] = 9'b101110000;
assign enemigo5[27][29] = 9'b110011100;
assign enemigo5[27][30] = 9'b110111100;
assign enemigo5[27][31] = 9'b110011100;
assign enemigo5[28][21] = 9'b110011100;
assign enemigo5[28][22] = 9'b110011100;
assign enemigo5[28][23] = 9'b110011100;
assign enemigo5[28][24] = 9'b101001000;
assign enemigo5[28][25] = 9'b100100100;
assign enemigo5[28][26] = 9'b100100100;
assign enemigo5[28][27] = 9'b100100100;
assign enemigo5[28][28] = 9'b100100100;
assign enemigo5[28][29] = 9'b101001000;
assign enemigo5[28][30] = 9'b110011100;
assign enemigo5[28][31] = 9'b110011100;
assign enemigo5[28][32] = 9'b110011100;
assign enemigo5[29][21] = 9'b110011100;
assign enemigo5[29][22] = 9'b110011100;
assign enemigo5[29][23] = 9'b101110100;
assign enemigo5[29][24] = 9'b101110000;
assign enemigo5[29][25] = 9'b101110001;
assign enemigo5[29][26] = 9'b110010001;
assign enemigo5[29][27] = 9'b110010001;
assign enemigo5[29][28] = 9'b101110001;
assign enemigo5[29][29] = 9'b101110000;
assign enemigo5[29][30] = 9'b101110100;
assign enemigo5[29][31] = 9'b110011100;
assign enemigo5[29][32] = 9'b110011100;
assign enemigo5[30][21] = 9'b110011100;
assign enemigo5[30][22] = 9'b110011100;
assign enemigo5[30][23] = 9'b110011100;
assign enemigo5[30][24] = 9'b110011100;
assign enemigo5[30][25] = 9'b111111101;
assign enemigo5[30][26] = 9'b111111101;
assign enemigo5[30][27] = 9'b111111101;
assign enemigo5[30][28] = 9'b111111101;
assign enemigo5[30][29] = 9'b110011100;
assign enemigo5[30][30] = 9'b110011100;
assign enemigo5[30][31] = 9'b110011100;
assign enemigo5[30][32] = 9'b110011100;
assign enemigo5[31][21] = 9'b110011100;
assign enemigo5[31][22] = 9'b110011100;
assign enemigo5[31][23] = 9'b110011100;
assign enemigo5[31][24] = 9'b110011100;
assign enemigo5[31][25] = 9'b110111101;
assign enemigo5[31][26] = 9'b110111101;
assign enemigo5[31][27] = 9'b110111101;
assign enemigo5[31][28] = 9'b110111101;
assign enemigo5[31][29] = 9'b110011100;
assign enemigo5[31][30] = 9'b110011100;
assign enemigo5[31][31] = 9'b110011100;
assign enemigo5[31][32] = 9'b110011100;
assign enemigo5[32][22] = 9'b110011100;
assign enemigo5[32][23] = 9'b110111100;
assign enemigo5[32][24] = 9'b110011100;
assign enemigo5[32][25] = 9'b111111101;
assign enemigo5[32][26] = 9'b111111101;
assign enemigo5[32][27] = 9'b111111101;
assign enemigo5[32][28] = 9'b111111101;
assign enemigo5[32][29] = 9'b110011100;
assign enemigo5[32][30] = 9'b110111100;
assign enemigo5[32][31] = 9'b110011100;
assign enemigo5[33][23] = 9'b111101100;
assign enemigo5[33][24] = 9'b110000000;
assign enemigo5[33][25] = 9'b110110101;
assign enemigo5[33][26] = 9'b110111101;
assign enemigo5[33][27] = 9'b110111101;
assign enemigo5[33][28] = 9'b110110101;
assign enemigo5[33][29] = 9'b110000000;
assign enemigo5[33][30] = 9'b111101100;
//Total de Lineas = 246
endmodule

