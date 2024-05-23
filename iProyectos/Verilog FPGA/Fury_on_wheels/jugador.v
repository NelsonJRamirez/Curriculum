`timescale 1ns / 1ps
module jugador (
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
			if (jugador[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= jugador[vcount- posy][hcount- posx][7:5];
				green <= jugador[vcount- posy][hcount- posx][4:2];
            blue 	<= jugador[vcount- posy][hcount- posx][1:0];
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
wire [8:0] jugador[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign jugador[10][24] = 9'b101101100;
assign jugador[10][25] = 9'b101110000;
assign jugador[10][26] = 9'b101110000;
assign jugador[10][27] = 9'b101110000;
assign jugador[10][28] = 9'b101110000;
assign jugador[10][29] = 9'b101101100;
assign jugador[11][23] = 9'b101101100;
assign jugador[11][24] = 9'b110001100;
assign jugador[11][25] = 9'b110010000;
assign jugador[11][26] = 9'b110010000;
assign jugador[11][27] = 9'b110010000;
assign jugador[11][28] = 9'b110010000;
assign jugador[11][29] = 9'b110001100;
assign jugador[11][30] = 9'b101101100;
assign jugador[12][22] = 9'b101101100;
assign jugador[12][23] = 9'b111111111;
assign jugador[12][24] = 9'b111111101;
assign jugador[12][25] = 9'b101110000;
assign jugador[12][26] = 9'b101110000;
assign jugador[12][27] = 9'b101110000;
assign jugador[12][28] = 9'b101110000;
assign jugador[12][29] = 9'b111111101;
assign jugador[12][30] = 9'b111111111;
assign jugador[12][31] = 9'b101101100;
assign jugador[13][22] = 9'b101101100;
assign jugador[13][23] = 9'b110010000;
assign jugador[13][24] = 9'b110001100;
assign jugador[13][25] = 9'b101110000;
assign jugador[13][26] = 9'b101110000;
assign jugador[13][27] = 9'b101110000;
assign jugador[13][28] = 9'b101110000;
assign jugador[13][29] = 9'b110001100;
assign jugador[13][30] = 9'b110010000;
assign jugador[13][31] = 9'b101101100;
assign jugador[14][21] = 9'b101101100;
assign jugador[14][22] = 9'b101101100;
assign jugador[14][23] = 9'b101101100;
assign jugador[14][24] = 9'b101101100;
assign jugador[14][25] = 9'b101110000;
assign jugador[14][26] = 9'b101110000;
assign jugador[14][27] = 9'b101110000;
assign jugador[14][28] = 9'b101110000;
assign jugador[14][29] = 9'b101101100;
assign jugador[14][30] = 9'b101101100;
assign jugador[14][31] = 9'b101101100;
assign jugador[14][32] = 9'b101101100;
assign jugador[15][21] = 9'b101101100;
assign jugador[15][22] = 9'b101101100;
assign jugador[15][23] = 9'b101101100;
assign jugador[15][24] = 9'b101101100;
assign jugador[15][25] = 9'b101110000;
assign jugador[15][26] = 9'b101110000;
assign jugador[15][27] = 9'b101110000;
assign jugador[15][28] = 9'b101110000;
assign jugador[15][29] = 9'b101101100;
assign jugador[15][30] = 9'b101101100;
assign jugador[15][31] = 9'b101101100;
assign jugador[15][32] = 9'b101101100;
assign jugador[16][21] = 9'b101101100;
assign jugador[16][22] = 9'b101101100;
assign jugador[16][23] = 9'b101101100;
assign jugador[16][24] = 9'b101101100;
assign jugador[16][25] = 9'b110010000;
assign jugador[16][26] = 9'b110010000;
assign jugador[16][27] = 9'b110010000;
assign jugador[16][28] = 9'b110010000;
assign jugador[16][29] = 9'b101101100;
assign jugador[16][30] = 9'b101101100;
assign jugador[16][31] = 9'b101101100;
assign jugador[16][32] = 9'b101101100;
assign jugador[17][22] = 9'b101101100;
assign jugador[17][23] = 9'b101101100;
assign jugador[17][24] = 9'b101001000;
assign jugador[17][25] = 9'b101001000;
assign jugador[17][26] = 9'b101001000;
assign jugador[17][27] = 9'b101001000;
assign jugador[17][28] = 9'b101001000;
assign jugador[17][29] = 9'b101001000;
assign jugador[17][30] = 9'b101101100;
assign jugador[17][31] = 9'b101101100;
assign jugador[18][22] = 9'b101101100;
assign jugador[18][23] = 9'b101001000;
assign jugador[18][24] = 9'b101001000;
assign jugador[18][25] = 9'b100100100;
assign jugador[18][26] = 9'b100100100;
assign jugador[18][27] = 9'b100100100;
assign jugador[18][28] = 9'b100100100;
assign jugador[18][29] = 9'b101001000;
assign jugador[18][30] = 9'b101001000;
assign jugador[18][31] = 9'b101101100;
assign jugador[19][22] = 9'b101101100;
assign jugador[19][23] = 9'b101001000;
assign jugador[19][24] = 9'b101101100;
assign jugador[19][25] = 9'b101101100;
assign jugador[19][26] = 9'b101001100;
assign jugador[19][27] = 9'b101101100;
assign jugador[19][28] = 9'b101101100;
assign jugador[19][29] = 9'b101101100;
assign jugador[19][30] = 9'b101001000;
assign jugador[19][31] = 9'b101101100;
assign jugador[20][22] = 9'b101101100;
assign jugador[20][23] = 9'b101001000;
assign jugador[20][24] = 9'b101101100;
assign jugador[20][25] = 9'b110010000;
assign jugador[20][26] = 9'b110110101;
assign jugador[20][27] = 9'b110110101;
assign jugador[20][28] = 9'b110010000;
assign jugador[20][29] = 9'b101101100;
assign jugador[20][30] = 9'b101001000;
assign jugador[20][31] = 9'b101101100;
assign jugador[21][22] = 9'b101101100;
assign jugador[21][23] = 9'b101001000;
assign jugador[21][24] = 9'b101101100;
assign jugador[21][25] = 9'b110010000;
assign jugador[21][26] = 9'b111111110;
assign jugador[21][27] = 9'b110010001;
assign jugador[21][28] = 9'b101101100;
assign jugador[21][29] = 9'b101101100;
assign jugador[21][30] = 9'b101001000;
assign jugador[21][31] = 9'b101101100;
assign jugador[22][22] = 9'b101101100;
assign jugador[22][23] = 9'b101001000;
assign jugador[22][24] = 9'b101101100;
assign jugador[22][25] = 9'b101101100;
assign jugador[22][26] = 9'b110110101;
assign jugador[22][27] = 9'b111111101;
assign jugador[22][28] = 9'b110010000;
assign jugador[22][29] = 9'b101101100;
assign jugador[22][30] = 9'b101001000;
assign jugador[22][31] = 9'b101101100;
assign jugador[23][22] = 9'b101101100;
assign jugador[23][23] = 9'b101001000;
assign jugador[23][24] = 9'b101101100;
assign jugador[23][25] = 9'b101101100;
assign jugador[23][26] = 9'b110010001;
assign jugador[23][27] = 9'b110010000;
assign jugador[23][28] = 9'b101101100;
assign jugador[23][29] = 9'b101101100;
assign jugador[23][30] = 9'b101001000;
assign jugador[23][31] = 9'b101101100;
assign jugador[24][22] = 9'b101101100;
assign jugador[24][23] = 9'b101001000;
assign jugador[24][24] = 9'b101101100;
assign jugador[24][25] = 9'b101101100;
assign jugador[24][26] = 9'b101101100;
assign jugador[24][27] = 9'b101101100;
assign jugador[24][28] = 9'b101101100;
assign jugador[24][29] = 9'b101101100;
assign jugador[24][30] = 9'b101001000;
assign jugador[24][31] = 9'b101001000;
assign jugador[25][22] = 9'b101101100;
assign jugador[25][23] = 9'b101101100;
assign jugador[25][24] = 9'b101101100;
assign jugador[25][25] = 9'b101101100;
assign jugador[25][26] = 9'b101101100;
assign jugador[25][27] = 9'b101101100;
assign jugador[25][28] = 9'b101101100;
assign jugador[25][29] = 9'b101101100;
assign jugador[25][30] = 9'b101101100;
assign jugador[25][31] = 9'b101101100;
assign jugador[26][22] = 9'b101101100;
assign jugador[26][23] = 9'b101101100;
assign jugador[26][24] = 9'b101101100;
assign jugador[26][25] = 9'b101101100;
assign jugador[26][26] = 9'b101101100;
assign jugador[26][27] = 9'b101101100;
assign jugador[26][28] = 9'b101101100;
assign jugador[26][29] = 9'b101101100;
assign jugador[26][30] = 9'b101101100;
assign jugador[26][31] = 9'b101101100;
assign jugador[27][22] = 9'b101101100;
assign jugador[27][23] = 9'b101101100;
assign jugador[27][24] = 9'b101101100;
assign jugador[27][25] = 9'b101001000;
assign jugador[27][26] = 9'b101001000;
assign jugador[27][27] = 9'b101001000;
assign jugador[27][28] = 9'b101001000;
assign jugador[27][29] = 9'b101101100;
assign jugador[27][30] = 9'b101101100;
assign jugador[27][31] = 9'b101101100;
assign jugador[28][21] = 9'b101101100;
assign jugador[28][22] = 9'b101101100;
assign jugador[28][23] = 9'b101101100;
assign jugador[28][24] = 9'b100101000;
assign jugador[28][25] = 9'b100100100;
assign jugador[28][26] = 9'b100100100;
assign jugador[28][27] = 9'b100100100;
assign jugador[28][28] = 9'b100100100;
assign jugador[28][29] = 9'b101001000;
assign jugador[28][30] = 9'b101101100;
assign jugador[28][31] = 9'b101101100;
assign jugador[28][32] = 9'b101101100;
assign jugador[29][21] = 9'b101101100;
assign jugador[29][22] = 9'b101101100;
assign jugador[29][23] = 9'b101101100;
assign jugador[29][24] = 9'b101001000;
assign jugador[29][25] = 9'b101101100;
assign jugador[29][26] = 9'b101101100;
assign jugador[29][27] = 9'b101101100;
assign jugador[29][28] = 9'b101101100;
assign jugador[29][29] = 9'b101001000;
assign jugador[29][30] = 9'b101101100;
assign jugador[29][31] = 9'b101101100;
assign jugador[29][32] = 9'b101101100;
assign jugador[30][21] = 9'b101101100;
assign jugador[30][22] = 9'b101101100;
assign jugador[30][23] = 9'b101101100;
assign jugador[30][24] = 9'b101101100;
assign jugador[30][25] = 9'b110010000;
assign jugador[30][26] = 9'b110010000;
assign jugador[30][27] = 9'b110010000;
assign jugador[30][28] = 9'b110010000;
assign jugador[30][29] = 9'b101101100;
assign jugador[30][30] = 9'b101101100;
assign jugador[30][31] = 9'b101101100;
assign jugador[30][32] = 9'b101101100;
assign jugador[31][21] = 9'b101101100;
assign jugador[31][22] = 9'b101101100;
assign jugador[31][23] = 9'b101101100;
assign jugador[31][24] = 9'b101101100;
assign jugador[31][25] = 9'b101110000;
assign jugador[31][26] = 9'b101110000;
assign jugador[31][27] = 9'b101110000;
assign jugador[31][28] = 9'b101110000;
assign jugador[31][29] = 9'b101101100;
assign jugador[31][30] = 9'b101101100;
assign jugador[31][31] = 9'b101101100;
assign jugador[31][32] = 9'b101101100;
assign jugador[32][22] = 9'b101101100;
assign jugador[32][23] = 9'b110001100;
assign jugador[32][24] = 9'b101101100;
assign jugador[32][25] = 9'b110010000;
assign jugador[32][26] = 9'b110010000;
assign jugador[32][27] = 9'b110010000;
assign jugador[32][28] = 9'b110010000;
assign jugador[32][29] = 9'b101101100;
assign jugador[32][30] = 9'b110001100;
assign jugador[32][31] = 9'b101101100;
assign jugador[33][23] = 9'b110101000;
assign jugador[33][24] = 9'b110000000;
assign jugador[33][25] = 9'b101101100;
assign jugador[33][26] = 9'b101110000;
assign jugador[33][27] = 9'b101110000;
assign jugador[33][28] = 9'b101101100;
assign jugador[33][29] = 9'b110000000;
assign jugador[33][30] = 9'b110101000;
//Total de Lineas = 246
endmodule

