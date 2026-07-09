`timescale 1ns / 1ps
module enemigo2 (
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
			if (enemigo2[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= enemigo2[vcount- posy][hcount- posx][7:5];
				green <= enemigo2[vcount- posy][hcount- posx][4:2];
            blue 	<= enemigo2[vcount- posy][hcount- posx][1:0];
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
wire [8:0] enemigo2[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign enemigo2[10][24] = 9'b111100000;
assign enemigo2[10][25] = 9'b111100000;
assign enemigo2[10][26] = 9'b110100000;
assign enemigo2[10][27] = 9'b110100000;
assign enemigo2[10][28] = 9'b111100000;
assign enemigo2[10][29] = 9'b111100000;
assign enemigo2[11][23] = 9'b111100000;
assign enemigo2[11][24] = 9'b111100100;
assign enemigo2[11][25] = 9'b111100000;
assign enemigo2[11][26] = 9'b110100000;
assign enemigo2[11][27] = 9'b110100000;
assign enemigo2[11][28] = 9'b111100000;
assign enemigo2[11][29] = 9'b111100100;
assign enemigo2[11][30] = 9'b111100000;
assign enemigo2[12][22] = 9'b111100100;
assign enemigo2[12][23] = 9'b111111111;
assign enemigo2[12][24] = 9'b111110010;
assign enemigo2[12][25] = 9'b110100000;
assign enemigo2[12][26] = 9'b110100000;
assign enemigo2[12][27] = 9'b110100000;
assign enemigo2[12][28] = 9'b110100000;
assign enemigo2[12][29] = 9'b111110010;
assign enemigo2[12][30] = 9'b111111111;
assign enemigo2[12][31] = 9'b111100100;
assign enemigo2[13][22] = 9'b111100100;
assign enemigo2[13][23] = 9'b111101001;
assign enemigo2[13][24] = 9'b111100100;
assign enemigo2[13][25] = 9'b110100000;
assign enemigo2[13][26] = 9'b110100000;
assign enemigo2[13][27] = 9'b110100000;
assign enemigo2[13][28] = 9'b110100000;
assign enemigo2[13][29] = 9'b111100100;
assign enemigo2[13][30] = 9'b111101001;
assign enemigo2[13][31] = 9'b111100100;
assign enemigo2[14][21] = 9'b111100000;
assign enemigo2[14][22] = 9'b111100000;
assign enemigo2[14][23] = 9'b111100000;
assign enemigo2[14][24] = 9'b111100000;
assign enemigo2[14][25] = 9'b110100000;
assign enemigo2[14][26] = 9'b110100000;
assign enemigo2[14][27] = 9'b110100000;
assign enemigo2[14][28] = 9'b110100000;
assign enemigo2[14][29] = 9'b111100000;
assign enemigo2[14][30] = 9'b111100000;
assign enemigo2[14][31] = 9'b111100000;
assign enemigo2[14][32] = 9'b111100000;
assign enemigo2[15][21] = 9'b111100000;
assign enemigo2[15][22] = 9'b111100000;
assign enemigo2[15][23] = 9'b111100000;
assign enemigo2[15][24] = 9'b111100000;
assign enemigo2[15][25] = 9'b110100000;
assign enemigo2[15][26] = 9'b110100000;
assign enemigo2[15][27] = 9'b110100000;
assign enemigo2[15][28] = 9'b110100000;
assign enemigo2[15][29] = 9'b111100000;
assign enemigo2[15][30] = 9'b111100000;
assign enemigo2[15][31] = 9'b111100000;
assign enemigo2[15][32] = 9'b111100000;
assign enemigo2[16][21] = 9'b111100000;
assign enemigo2[16][22] = 9'b111100000;
assign enemigo2[16][23] = 9'b111100000;
assign enemigo2[16][24] = 9'b111100000;
assign enemigo2[16][25] = 9'b111100000;
assign enemigo2[16][26] = 9'b110100000;
assign enemigo2[16][27] = 9'b110100000;
assign enemigo2[16][28] = 9'b111100000;
assign enemigo2[16][29] = 9'b111100000;
assign enemigo2[16][30] = 9'b111100000;
assign enemigo2[16][31] = 9'b111100000;
assign enemigo2[16][32] = 9'b111100000;
assign enemigo2[17][22] = 9'b111100000;
assign enemigo2[17][23] = 9'b110100100;
assign enemigo2[17][24] = 9'b101100100;
assign enemigo2[17][25] = 9'b101100100;
assign enemigo2[17][26] = 9'b101100100;
assign enemigo2[17][27] = 9'b101100100;
assign enemigo2[17][28] = 9'b101100100;
assign enemigo2[17][29] = 9'b101100100;
assign enemigo2[17][30] = 9'b110100100;
assign enemigo2[17][31] = 9'b111100000;
assign enemigo2[18][22] = 9'b110100100;
assign enemigo2[18][23] = 9'b101100100;
assign enemigo2[18][24] = 9'b101000100;
assign enemigo2[18][25] = 9'b100101000;
assign enemigo2[18][26] = 9'b100101000;
assign enemigo2[18][27] = 9'b100101000;
assign enemigo2[18][28] = 9'b100101000;
assign enemigo2[18][29] = 9'b101000100;
assign enemigo2[18][30] = 9'b101100100;
assign enemigo2[18][31] = 9'b110100100;
assign enemigo2[19][22] = 9'b110100100;
assign enemigo2[19][23] = 9'b101000100;
assign enemigo2[19][24] = 9'b111100000;
assign enemigo2[19][25] = 9'b111100100;
assign enemigo2[19][26] = 9'b111100000;
assign enemigo2[19][27] = 9'b111100000;
assign enemigo2[19][28] = 9'b111100100;
assign enemigo2[19][29] = 9'b111100000;
assign enemigo2[19][30] = 9'b101000100;
assign enemigo2[19][31] = 9'b110100100;
assign enemigo2[20][22] = 9'b110100100;
assign enemigo2[20][23] = 9'b101000100;
assign enemigo2[20][24] = 9'b111100000;
assign enemigo2[20][25] = 9'b111100000;
assign enemigo2[20][26] = 9'b111100100;
assign enemigo2[20][27] = 9'b111100100;
assign enemigo2[20][28] = 9'b111100000;
assign enemigo2[20][29] = 9'b111100000;
assign enemigo2[20][30] = 9'b101000100;
assign enemigo2[20][31] = 9'b110100100;
assign enemigo2[21][22] = 9'b110100100;
assign enemigo2[21][23] = 9'b101000100;
assign enemigo2[21][24] = 9'b111100000;
assign enemigo2[21][25] = 9'b111100100;
assign enemigo2[21][26] = 9'b111110001;
assign enemigo2[21][27] = 9'b111101001;
assign enemigo2[21][28] = 9'b111100000;
assign enemigo2[21][29] = 9'b111100000;
assign enemigo2[21][30] = 9'b101000100;
assign enemigo2[21][31] = 9'b110100100;
assign enemigo2[22][22] = 9'b110100100;
assign enemigo2[22][23] = 9'b101000100;
assign enemigo2[22][24] = 9'b111100000;
assign enemigo2[22][25] = 9'b111101001;
assign enemigo2[22][26] = 9'b111110110;
assign enemigo2[22][27] = 9'b111101001;
assign enemigo2[22][28] = 9'b111100100;
assign enemigo2[22][29] = 9'b111100000;
assign enemigo2[22][30] = 9'b101000100;
assign enemigo2[22][31] = 9'b110100100;
assign enemigo2[23][22] = 9'b110100100;
assign enemigo2[23][23] = 9'b101000100;
assign enemigo2[23][24] = 9'b111100000;
assign enemigo2[23][25] = 9'b111100100;
assign enemigo2[23][26] = 9'b111101101;
assign enemigo2[23][27] = 9'b111110001;
assign enemigo2[23][28] = 9'b111100100;
assign enemigo2[23][29] = 9'b111100000;
assign enemigo2[23][30] = 9'b101000100;
assign enemigo2[23][31] = 9'b110100100;
assign enemigo2[24][22] = 9'b110100100;
assign enemigo2[24][23] = 9'b101000100;
assign enemigo2[24][24] = 9'b111100000;
assign enemigo2[24][25] = 9'b111100000;
assign enemigo2[24][26] = 9'b111100100;
assign enemigo2[24][27] = 9'b111100100;
assign enemigo2[24][28] = 9'b111100000;
assign enemigo2[24][29] = 9'b111100000;
assign enemigo2[24][30] = 9'b101000100;
assign enemigo2[24][31] = 9'b110100100;
assign enemigo2[25][22] = 9'b110100100;
assign enemigo2[25][23] = 9'b110000100;
assign enemigo2[25][24] = 9'b111100000;
assign enemigo2[25][25] = 9'b111100000;
assign enemigo2[25][26] = 9'b111100000;
assign enemigo2[25][27] = 9'b111100000;
assign enemigo2[25][28] = 9'b111100000;
assign enemigo2[25][29] = 9'b111100000;
assign enemigo2[25][30] = 9'b110000100;
assign enemigo2[25][31] = 9'b110100100;
assign enemigo2[26][22] = 9'b111100000;
assign enemigo2[26][23] = 9'b111100000;
assign enemigo2[26][24] = 9'b111100000;
assign enemigo2[26][25] = 9'b111100000;
assign enemigo2[26][26] = 9'b111100000;
assign enemigo2[26][27] = 9'b111100000;
assign enemigo2[26][28] = 9'b111100000;
assign enemigo2[26][29] = 9'b111100000;
assign enemigo2[26][30] = 9'b111100000;
assign enemigo2[26][31] = 9'b111100000;
assign enemigo2[27][22] = 9'b111100000;
assign enemigo2[27][23] = 9'b111100000;
assign enemigo2[27][24] = 9'b111100000;
assign enemigo2[27][25] = 9'b110000100;
assign enemigo2[27][26] = 9'b110000100;
assign enemigo2[27][27] = 9'b110000100;
assign enemigo2[27][28] = 9'b110000100;
assign enemigo2[27][29] = 9'b111100000;
assign enemigo2[27][30] = 9'b111100000;
assign enemigo2[27][31] = 9'b111100000;
assign enemigo2[28][21] = 9'b111100000;
assign enemigo2[28][22] = 9'b111100000;
assign enemigo2[28][23] = 9'b111100100;
assign enemigo2[28][24] = 9'b101000100;
assign enemigo2[28][25] = 9'b100101000;
assign enemigo2[28][26] = 9'b100101000;
assign enemigo2[28][27] = 9'b100101000;
assign enemigo2[28][28] = 9'b100101000;
assign enemigo2[28][29] = 9'b101000100;
assign enemigo2[28][30] = 9'b111100000;
assign enemigo2[28][31] = 9'b111100000;
assign enemigo2[28][32] = 9'b111100000;
assign enemigo2[29][21] = 9'b111100000;
assign enemigo2[29][22] = 9'b111100000;
assign enemigo2[29][23] = 9'b110100100;
assign enemigo2[29][24] = 9'b110000100;
assign enemigo2[29][25] = 9'b110000100;
assign enemigo2[29][26] = 9'b101100100;
assign enemigo2[29][27] = 9'b101100100;
assign enemigo2[29][28] = 9'b110000100;
assign enemigo2[29][29] = 9'b110000100;
assign enemigo2[29][30] = 9'b110100100;
assign enemigo2[29][31] = 9'b111100000;
assign enemigo2[29][32] = 9'b111100000;
assign enemigo2[30][21] = 9'b111100000;
assign enemigo2[30][22] = 9'b111100000;
assign enemigo2[30][23] = 9'b111100000;
assign enemigo2[30][24] = 9'b111100000;
assign enemigo2[30][25] = 9'b111100000;
assign enemigo2[30][26] = 9'b110100000;
assign enemigo2[30][27] = 9'b110100000;
assign enemigo2[30][28] = 9'b111100000;
assign enemigo2[30][29] = 9'b111100000;
assign enemigo2[30][30] = 9'b111100000;
assign enemigo2[30][31] = 9'b111100000;
assign enemigo2[30][32] = 9'b111100000;
assign enemigo2[31][21] = 9'b111100000;
assign enemigo2[31][22] = 9'b111100000;
assign enemigo2[31][23] = 9'b111100000;
assign enemigo2[31][24] = 9'b111100000;
assign enemigo2[31][25] = 9'b110100000;
assign enemigo2[31][26] = 9'b110100000;
assign enemigo2[31][27] = 9'b110100000;
assign enemigo2[31][28] = 9'b110100000;
assign enemigo2[31][29] = 9'b111100000;
assign enemigo2[31][30] = 9'b111100000;
assign enemigo2[31][31] = 9'b111100000;
assign enemigo2[31][32] = 9'b111100000;
assign enemigo2[32][22] = 9'b111100000;
assign enemigo2[32][23] = 9'b111100000;
assign enemigo2[32][24] = 9'b111100000;
assign enemigo2[32][25] = 9'b111100000;
assign enemigo2[32][26] = 9'b111100000;
assign enemigo2[32][27] = 9'b111100000;
assign enemigo2[32][28] = 9'b111100000;
assign enemigo2[32][29] = 9'b111100000;
assign enemigo2[32][30] = 9'b111100000;
assign enemigo2[32][31] = 9'b111100000;
assign enemigo2[33][23] = 9'b110100000;
assign enemigo2[33][24] = 9'b110000000;
assign enemigo2[33][25] = 9'b110000000;
assign enemigo2[33][26] = 9'b110100000;
assign enemigo2[33][27] = 9'b110100000;
assign enemigo2[33][28] = 9'b110000000;
assign enemigo2[33][29] = 9'b110000000;
assign enemigo2[33][30] = 9'b110100000;
//Total de Lineas = 246
endmodule

