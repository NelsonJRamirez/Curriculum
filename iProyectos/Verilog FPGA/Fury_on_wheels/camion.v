`timescale 1ns / 1ps
module camion (
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
			if (camion[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= camion[vcount- posy][hcount- posx][7:5];
				green <= camion[vcount- posy][hcount- posx][4:2];
            blue 	<= camion[vcount- posy][hcount- posx][1:0];
				data  <= 1'b1;
			end
			else
				data <= 0;
			end
		else
		data <= 0;
	end
end

parameter RESOLUCION_X = 25;
parameter RESOLUCION_Y = 45;
wire [8:0] camion[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign camion[2][5] = 9'b111110000;
assign camion[2][6] = 9'b111110000;
assign camion[2][7] = 9'b111110000;
assign camion[2][8] = 9'b111110000;
assign camion[2][9] = 9'b111110000;
assign camion[2][10] = 9'b111110000;
assign camion[2][11] = 9'b111110000;
assign camion[2][12] = 9'b111110000;
assign camion[2][13] = 9'b111110000;
assign camion[2][14] = 9'b111110000;
assign camion[2][15] = 9'b111110000;
assign camion[2][16] = 9'b111110000;
assign camion[2][17] = 9'b111110000;
assign camion[2][18] = 9'b111110000;
assign camion[2][19] = 9'b111110100;
assign camion[3][5] = 9'b111101100;
assign camion[3][6] = 9'b111101100;
assign camion[3][7] = 9'b110101100;
assign camion[3][8] = 9'b110101100;
assign camion[3][9] = 9'b110101100;
assign camion[3][10] = 9'b110101100;
assign camion[3][11] = 9'b110101100;
assign camion[3][12] = 9'b110101100;
assign camion[3][13] = 9'b110101100;
assign camion[3][14] = 9'b110101100;
assign camion[3][15] = 9'b110101100;
assign camion[3][16] = 9'b110101100;
assign camion[3][17] = 9'b110101100;
assign camion[3][18] = 9'b110101100;
assign camion[3][19] = 9'b111110000;
assign camion[4][5] = 9'b110001100;
assign camion[4][6] = 9'b110101100;
assign camion[4][7] = 9'b110001100;
assign camion[4][8] = 9'b110001100;
assign camion[4][9] = 9'b110001100;
assign camion[4][10] = 9'b110001100;
assign camion[4][11] = 9'b110001100;
assign camion[4][12] = 9'b110001100;
assign camion[4][13] = 9'b110001100;
assign camion[4][14] = 9'b110001100;
assign camion[4][15] = 9'b110001100;
assign camion[4][16] = 9'b110001100;
assign camion[4][17] = 9'b110001100;
assign camion[4][18] = 9'b110001100;
assign camion[4][19] = 9'b110101100;
assign camion[4][20] = 9'b100100100;
assign camion[5][4] = 9'b100100100;
assign camion[5][5] = 9'b110101100;
assign camion[5][6] = 9'b110001100;
assign camion[5][7] = 9'b110101100;
assign camion[5][8] = 9'b111101100;
assign camion[5][9] = 9'b111101100;
assign camion[5][10] = 9'b111101100;
assign camion[5][11] = 9'b111101100;
assign camion[5][12] = 9'b111101100;
assign camion[5][13] = 9'b111101100;
assign camion[5][14] = 9'b111101100;
assign camion[5][15] = 9'b111101100;
assign camion[5][16] = 9'b111101100;
assign camion[5][17] = 9'b111101100;
assign camion[5][18] = 9'b110001100;
assign camion[5][19] = 9'b110101100;
assign camion[5][20] = 9'b101000100;
assign camion[6][5] = 9'b110101100;
assign camion[6][6] = 9'b110001100;
assign camion[6][7] = 9'b111101100;
assign camion[6][8] = 9'b111101100;
assign camion[6][9] = 9'b111101100;
assign camion[6][10] = 9'b111101100;
assign camion[6][11] = 9'b111101100;
assign camion[6][12] = 9'b111101100;
assign camion[6][13] = 9'b111101100;
assign camion[6][14] = 9'b111101100;
assign camion[6][15] = 9'b111101100;
assign camion[6][16] = 9'b111101100;
assign camion[6][17] = 9'b111101100;
assign camion[6][18] = 9'b110001100;
assign camion[6][19] = 9'b111110000;
assign camion[6][20] = 9'b101101100;
assign camion[7][4] = 9'b101101101;
assign camion[7][5] = 9'b111101100;
assign camion[7][6] = 9'b110001100;
assign camion[7][7] = 9'b111101100;
assign camion[7][8] = 9'b111101100;
assign camion[7][9] = 9'b111101100;
assign camion[7][10] = 9'b111101100;
assign camion[7][11] = 9'b111101100;
assign camion[7][12] = 9'b111101100;
assign camion[7][13] = 9'b111101100;
assign camion[7][14] = 9'b111101100;
assign camion[7][15] = 9'b111101100;
assign camion[7][16] = 9'b111101100;
assign camion[7][17] = 9'b111101100;
assign camion[7][18] = 9'b110001100;
assign camion[7][19] = 9'b111110000;
assign camion[7][20] = 9'b101101101;
assign camion[8][5] = 9'b110101100;
assign camion[8][6] = 9'b110001100;
assign camion[8][7] = 9'b110101100;
assign camion[8][8] = 9'b111101100;
assign camion[8][9] = 9'b111101100;
assign camion[8][10] = 9'b111101100;
assign camion[8][11] = 9'b111101100;
assign camion[8][12] = 9'b111101100;
assign camion[8][13] = 9'b111101100;
assign camion[8][14] = 9'b111101100;
assign camion[8][15] = 9'b111101100;
assign camion[8][16] = 9'b111101100;
assign camion[8][17] = 9'b111101100;
assign camion[8][18] = 9'b110001100;
assign camion[8][19] = 9'b111110000;
assign camion[8][20] = 9'b101001000;
assign camion[9][5] = 9'b111101100;
assign camion[9][6] = 9'b110101100;
assign camion[9][7] = 9'b110101100;
assign camion[9][8] = 9'b111101100;
assign camion[9][9] = 9'b111101100;
assign camion[9][10] = 9'b111101100;
assign camion[9][11] = 9'b111101100;
assign camion[9][12] = 9'b111101100;
assign camion[9][13] = 9'b111101100;
assign camion[9][14] = 9'b111101100;
assign camion[9][15] = 9'b111101100;
assign camion[9][16] = 9'b111101100;
assign camion[9][17] = 9'b111101100;
assign camion[9][18] = 9'b110001100;
assign camion[9][19] = 9'b111101100;
assign camion[10][5] = 9'b111101100;
assign camion[10][6] = 9'b110101100;
assign camion[10][7] = 9'b110101100;
assign camion[10][8] = 9'b111101100;
assign camion[10][9] = 9'b111101100;
assign camion[10][10] = 9'b111101100;
assign camion[10][11] = 9'b111101100;
assign camion[10][12] = 9'b111101100;
assign camion[10][13] = 9'b111101100;
assign camion[10][14] = 9'b111101100;
assign camion[10][15] = 9'b111101100;
assign camion[10][16] = 9'b111101100;
assign camion[10][17] = 9'b111101100;
assign camion[10][18] = 9'b110001100;
assign camion[10][19] = 9'b111101100;
assign camion[11][5] = 9'b110101100;
assign camion[11][6] = 9'b110101100;
assign camion[11][7] = 9'b111101100;
assign camion[11][8] = 9'b111101100;
assign camion[11][9] = 9'b111101100;
assign camion[11][10] = 9'b111101100;
assign camion[11][11] = 9'b111101100;
assign camion[11][12] = 9'b111101100;
assign camion[11][13] = 9'b111101100;
assign camion[11][14] = 9'b111101100;
assign camion[11][15] = 9'b111101100;
assign camion[11][16] = 9'b111101100;
assign camion[11][17] = 9'b111101100;
assign camion[11][18] = 9'b110001100;
assign camion[11][19] = 9'b110101100;
assign camion[11][20] = 9'b101001000;
assign camion[12][4] = 9'b100100100;
assign camion[12][5] = 9'b110101100;
assign camion[12][6] = 9'b110001100;
assign camion[12][7] = 9'b111101100;
assign camion[12][8] = 9'b111101100;
assign camion[12][9] = 9'b111101100;
assign camion[12][10] = 9'b111101100;
assign camion[12][11] = 9'b111101100;
assign camion[12][12] = 9'b111101100;
assign camion[12][13] = 9'b111101100;
assign camion[12][14] = 9'b111101100;
assign camion[12][15] = 9'b111101100;
assign camion[12][16] = 9'b111101100;
assign camion[12][17] = 9'b111101100;
assign camion[12][18] = 9'b110001100;
assign camion[12][19] = 9'b110101100;
assign camion[12][20] = 9'b100100100;
assign camion[13][5] = 9'b110101100;
assign camion[13][6] = 9'b110001100;
assign camion[13][7] = 9'b111101100;
assign camion[13][8] = 9'b111101100;
assign camion[13][9] = 9'b111101100;
assign camion[13][10] = 9'b111101100;
assign camion[13][11] = 9'b111101100;
assign camion[13][12] = 9'b111101100;
assign camion[13][13] = 9'b111101100;
assign camion[13][14] = 9'b111101100;
assign camion[13][15] = 9'b111101100;
assign camion[13][16] = 9'b111101100;
assign camion[13][17] = 9'b111101100;
assign camion[13][18] = 9'b110001100;
assign camion[13][19] = 9'b110101100;
assign camion[13][20] = 9'b101001000;
assign camion[14][5] = 9'b110101100;
assign camion[14][6] = 9'b110001100;
assign camion[14][7] = 9'b111101100;
assign camion[14][8] = 9'b111101100;
assign camion[14][9] = 9'b111101100;
assign camion[14][10] = 9'b111101100;
assign camion[14][11] = 9'b111101100;
assign camion[14][12] = 9'b111101100;
assign camion[14][13] = 9'b111101100;
assign camion[14][14] = 9'b111101100;
assign camion[14][15] = 9'b111101100;
assign camion[14][16] = 9'b111101100;
assign camion[14][17] = 9'b111101100;
assign camion[14][18] = 9'b110001100;
assign camion[14][19] = 9'b111110000;
assign camion[14][20] = 9'b101101101;
assign camion[15][4] = 9'b101101001;
assign camion[15][5] = 9'b110101100;
assign camion[15][6] = 9'b110001100;
assign camion[15][7] = 9'b111101100;
assign camion[15][8] = 9'b111101100;
assign camion[15][9] = 9'b111101100;
assign camion[15][10] = 9'b111101100;
assign camion[15][11] = 9'b111101100;
assign camion[15][12] = 9'b111101100;
assign camion[15][13] = 9'b111101100;
assign camion[15][14] = 9'b111101100;
assign camion[15][15] = 9'b111101100;
assign camion[15][16] = 9'b111101100;
assign camion[15][17] = 9'b111101100;
assign camion[15][18] = 9'b110001100;
assign camion[15][19] = 9'b111110000;
assign camion[15][20] = 9'b101101000;
assign camion[16][5] = 9'b110101100;
assign camion[16][6] = 9'b110101100;
assign camion[16][7] = 9'b111101100;
assign camion[16][8] = 9'b111101100;
assign camion[16][9] = 9'b111101100;
assign camion[16][10] = 9'b111101100;
assign camion[16][11] = 9'b111101100;
assign camion[16][12] = 9'b111101100;
assign camion[16][13] = 9'b111101100;
assign camion[16][14] = 9'b111101100;
assign camion[16][15] = 9'b111101100;
assign camion[16][16] = 9'b111101100;
assign camion[16][17] = 9'b111101100;
assign camion[16][18] = 9'b110101100;
assign camion[16][19] = 9'b110101100;
assign camion[17][5] = 9'b111101100;
assign camion[17][6] = 9'b110101100;
assign camion[17][7] = 9'b111101100;
assign camion[17][8] = 9'b111101100;
assign camion[17][9] = 9'b111101100;
assign camion[17][10] = 9'b111101100;
assign camion[17][11] = 9'b111101100;
assign camion[17][12] = 9'b111101100;
assign camion[17][13] = 9'b111101100;
assign camion[17][14] = 9'b111101100;
assign camion[17][15] = 9'b111101100;
assign camion[17][16] = 9'b111101100;
assign camion[17][17] = 9'b111101100;
assign camion[17][18] = 9'b110101100;
assign camion[17][19] = 9'b111101100;
assign camion[18][5] = 9'b111101100;
assign camion[18][6] = 9'b110101100;
assign camion[18][7] = 9'b111101100;
assign camion[18][8] = 9'b111101100;
assign camion[18][9] = 9'b111101100;
assign camion[18][10] = 9'b111101100;
assign camion[18][11] = 9'b111101100;
assign camion[18][12] = 9'b111101100;
assign camion[18][13] = 9'b111101100;
assign camion[18][14] = 9'b111101100;
assign camion[18][15] = 9'b111101100;
assign camion[18][16] = 9'b111101100;
assign camion[18][17] = 9'b111101100;
assign camion[18][18] = 9'b110101100;
assign camion[18][19] = 9'b111101100;
assign camion[19][5] = 9'b111101100;
assign camion[19][6] = 9'b110101100;
assign camion[19][7] = 9'b111101100;
assign camion[19][8] = 9'b111101100;
assign camion[19][9] = 9'b111101100;
assign camion[19][10] = 9'b111101100;
assign camion[19][11] = 9'b111101100;
assign camion[19][12] = 9'b111101100;
assign camion[19][13] = 9'b111101100;
assign camion[19][14] = 9'b111101100;
assign camion[19][15] = 9'b111101100;
assign camion[19][16] = 9'b111101100;
assign camion[19][17] = 9'b111101100;
assign camion[19][18] = 9'b110101100;
assign camion[19][19] = 9'b111101100;
assign camion[20][5] = 9'b111101100;
assign camion[20][6] = 9'b110101100;
assign camion[20][7] = 9'b111101100;
assign camion[20][8] = 9'b111101100;
assign camion[20][9] = 9'b111101100;
assign camion[20][10] = 9'b111101100;
assign camion[20][11] = 9'b111101100;
assign camion[20][12] = 9'b111101100;
assign camion[20][13] = 9'b111101100;
assign camion[20][14] = 9'b111101100;
assign camion[20][15] = 9'b111101100;
assign camion[20][16] = 9'b111101100;
assign camion[20][17] = 9'b111101100;
assign camion[20][18] = 9'b110101100;
assign camion[20][19] = 9'b111101100;
assign camion[21][5] = 9'b111101100;
assign camion[21][6] = 9'b110101100;
assign camion[21][7] = 9'b110101100;
assign camion[21][8] = 9'b110101100;
assign camion[21][9] = 9'b110101100;
assign camion[21][10] = 9'b110101100;
assign camion[21][11] = 9'b110101100;
assign camion[21][12] = 9'b110101100;
assign camion[21][13] = 9'b110101100;
assign camion[21][14] = 9'b110101100;
assign camion[21][15] = 9'b110101100;
assign camion[21][16] = 9'b110101100;
assign camion[21][17] = 9'b110101100;
assign camion[21][18] = 9'b110101100;
assign camion[21][19] = 9'b111101100;
assign camion[22][5] = 9'b111101100;
assign camion[22][6] = 9'b110101100;
assign camion[22][7] = 9'b110101100;
assign camion[22][8] = 9'b110101100;
assign camion[22][9] = 9'b110101100;
assign camion[22][10] = 9'b110101100;
assign camion[22][11] = 9'b110101100;
assign camion[22][12] = 9'b110101100;
assign camion[22][13] = 9'b110101100;
assign camion[22][14] = 9'b110101100;
assign camion[22][15] = 9'b110101100;
assign camion[22][16] = 9'b110101100;
assign camion[22][17] = 9'b110101100;
assign camion[22][18] = 9'b110001100;
assign camion[22][19] = 9'b110101100;
assign camion[23][5] = 9'b110101100;
assign camion[23][6] = 9'b111101100;
assign camion[23][7] = 9'b111101100;
assign camion[23][8] = 9'b111101100;
assign camion[23][9] = 9'b111101100;
assign camion[23][10] = 9'b111101100;
assign camion[23][11] = 9'b111101100;
assign camion[23][12] = 9'b111101100;
assign camion[23][13] = 9'b111101100;
assign camion[23][14] = 9'b111101100;
assign camion[23][15] = 9'b111101100;
assign camion[23][16] = 9'b111101100;
assign camion[23][17] = 9'b111101100;
assign camion[23][18] = 9'b111101100;
assign camion[23][19] = 9'b111101100;
assign camion[24][4] = 9'b111110000;
assign camion[24][5] = 9'b111110000;
assign camion[24][6] = 9'b111110000;
assign camion[24][7] = 9'b111110000;
assign camion[24][8] = 9'b111110000;
assign camion[24][9] = 9'b111110000;
assign camion[24][10] = 9'b111110000;
assign camion[24][11] = 9'b111110000;
assign camion[24][12] = 9'b111110000;
assign camion[24][13] = 9'b111110000;
assign camion[24][14] = 9'b111110000;
assign camion[24][15] = 9'b111110000;
assign camion[24][16] = 9'b111110000;
assign camion[24][17] = 9'b111110000;
assign camion[24][18] = 9'b111110000;
assign camion[24][19] = 9'b111110000;
assign camion[24][20] = 9'b111110000;
assign camion[25][4] = 9'b111110000;
assign camion[25][5] = 9'b111110000;
assign camion[25][6] = 9'b111110000;
assign camion[25][7] = 9'b111110000;
assign camion[25][8] = 9'b111110000;
assign camion[25][9] = 9'b111110000;
assign camion[25][10] = 9'b111110000;
assign camion[25][11] = 9'b111110000;
assign camion[25][12] = 9'b111110100;
assign camion[25][13] = 9'b111110100;
assign camion[25][14] = 9'b111110100;
assign camion[25][15] = 9'b111110100;
assign camion[25][16] = 9'b111110100;
assign camion[25][17] = 9'b111110100;
assign camion[25][18] = 9'b111110100;
assign camion[25][19] = 9'b111111100;
assign camion[25][20] = 9'b111110100;
assign camion[26][4] = 9'b111110000;
assign camion[26][5] = 9'b111110000;
assign camion[26][6] = 9'b111110000;
assign camion[26][7] = 9'b111110000;
assign camion[26][8] = 9'b111110000;
assign camion[26][9] = 9'b111110000;
assign camion[26][10] = 9'b111110000;
assign camion[26][11] = 9'b111110100;
assign camion[26][12] = 9'b111110100;
assign camion[26][13] = 9'b111110100;
assign camion[26][14] = 9'b111110100;
assign camion[26][15] = 9'b111110100;
assign camion[26][16] = 9'b111110100;
assign camion[26][17] = 9'b111110100;
assign camion[26][18] = 9'b111110100;
assign camion[26][19] = 9'b111111100;
assign camion[26][20] = 9'b111110100;
assign camion[27][4] = 9'b111110000;
assign camion[27][5] = 9'b111110000;
assign camion[27][6] = 9'b111110000;
assign camion[27][7] = 9'b111110000;
assign camion[27][8] = 9'b111110000;
assign camion[27][9] = 9'b111110000;
assign camion[27][10] = 9'b111110000;
assign camion[27][11] = 9'b111110100;
assign camion[27][12] = 9'b111110100;
assign camion[27][13] = 9'b111110100;
assign camion[27][14] = 9'b111110100;
assign camion[27][15] = 9'b111110100;
assign camion[27][16] = 9'b111110100;
assign camion[27][17] = 9'b111110100;
assign camion[27][18] = 9'b111110100;
assign camion[27][19] = 9'b111111100;
assign camion[27][20] = 9'b111110100;
assign camion[28][4] = 9'b111110000;
assign camion[28][5] = 9'b111110000;
assign camion[28][6] = 9'b111110000;
assign camion[28][7] = 9'b111110000;
assign camion[28][8] = 9'b111110000;
assign camion[28][9] = 9'b111110000;
assign camion[28][10] = 9'b111110000;
assign camion[28][11] = 9'b111110100;
assign camion[28][12] = 9'b111110100;
assign camion[28][13] = 9'b111110100;
assign camion[28][14] = 9'b111110100;
assign camion[28][15] = 9'b111110100;
assign camion[28][16] = 9'b111110100;
assign camion[28][17] = 9'b111110100;
assign camion[28][18] = 9'b111110100;
assign camion[28][19] = 9'b111111100;
assign camion[28][20] = 9'b111110100;
assign camion[29][5] = 9'b110001100;
assign camion[29][6] = 9'b111101100;
assign camion[29][7] = 9'b111110000;
assign camion[29][8] = 9'b111110000;
assign camion[29][9] = 9'b111110000;
assign camion[29][10] = 9'b111110000;
assign camion[29][11] = 9'b111110000;
assign camion[29][12] = 9'b111110000;
assign camion[29][13] = 9'b111110000;
assign camion[29][14] = 9'b111110100;
assign camion[29][15] = 9'b111110100;
assign camion[29][16] = 9'b111110100;
assign camion[29][17] = 9'b111110100;
assign camion[29][18] = 9'b111110100;
assign camion[29][19] = 9'b110110000;
assign camion[30][5] = 9'b100100100;
assign camion[30][6] = 9'b111101100;
assign camion[30][7] = 9'b111110000;
assign camion[30][8] = 9'b111110101;
assign camion[30][9] = 9'b111110101;
assign camion[30][10] = 9'b111110101;
assign camion[30][11] = 9'b111111101;
assign camion[30][12] = 9'b111111101;
assign camion[30][13] = 9'b111111101;
assign camion[30][14] = 9'b111111101;
assign camion[30][15] = 9'b111111101;
assign camion[30][16] = 9'b111111101;
assign camion[30][17] = 9'b111111101;
assign camion[30][18] = 9'b111111100;
assign camion[30][19] = 9'b110010001;
assign camion[31][5] = 9'b111101100;
assign camion[31][6] = 9'b110001000;
assign camion[31][7] = 9'b101101000;
assign camion[31][8] = 9'b110001000;
assign camion[31][9] = 9'b110001100;
assign camion[31][10] = 9'b110001100;
assign camion[31][11] = 9'b110001100;
assign camion[31][12] = 9'b110001100;
assign camion[31][13] = 9'b110010000;
assign camion[31][14] = 9'b110010000;
assign camion[31][15] = 9'b110010000;
assign camion[31][16] = 9'b110001100;
assign camion[31][17] = 9'b101101100;
assign camion[31][18] = 9'b101101100;
assign camion[31][19] = 9'b111111101;
assign camion[32][5] = 9'b111101100;
assign camion[32][6] = 9'b100100100;
assign camion[32][7] = 9'b100000000;
assign camion[32][8] = 9'b100000000;
assign camion[32][9] = 9'b100000100;
assign camion[32][10] = 9'b100100100;
assign camion[32][11] = 9'b100100100;
assign camion[32][12] = 9'b100100100;
assign camion[32][13] = 9'b100100100;
assign camion[32][14] = 9'b100100100;
assign camion[32][15] = 9'b100101001;
assign camion[32][16] = 9'b100100100;
assign camion[32][17] = 9'b100000100;
assign camion[32][18] = 9'b100100100;
assign camion[32][19] = 9'b110110000;
assign camion[33][3] = 9'b110001100;
assign camion[33][4] = 9'b101101000;
assign camion[33][5] = 9'b110001000;
assign camion[33][6] = 9'b100100100;
assign camion[33][7] = 9'b100000000;
assign camion[33][8] = 9'b100100100;
assign camion[33][9] = 9'b100100100;
assign camion[33][10] = 9'b100100100;
assign camion[33][11] = 9'b100100100;
assign camion[33][12] = 9'b100101000;
assign camion[33][13] = 9'b101001000;
assign camion[33][14] = 9'b101001001;
assign camion[33][15] = 9'b101001001;
assign camion[33][16] = 9'b100100100;
assign camion[33][17] = 9'b100100100;
assign camion[33][18] = 9'b100100100;
assign camion[33][19] = 9'b110001100;
assign camion[33][20] = 9'b101101000;
assign camion[33][21] = 9'b110001100;
assign camion[34][4] = 9'b110001100;
assign camion[34][5] = 9'b110001000;
assign camion[34][6] = 9'b100100000;
assign camion[34][7] = 9'b100000000;
assign camion[34][8] = 9'b100000100;
assign camion[34][9] = 9'b100100100;
assign camion[34][10] = 9'b100100100;
assign camion[34][11] = 9'b100100100;
assign camion[34][12] = 9'b100101000;
assign camion[34][13] = 9'b101001000;
assign camion[34][14] = 9'b101001001;
assign camion[34][15] = 9'b100100100;
assign camion[34][16] = 9'b100100100;
assign camion[34][17] = 9'b100100100;
assign camion[34][18] = 9'b100000100;
assign camion[34][19] = 9'b110001100;
assign camion[34][20] = 9'b110001100;
assign camion[35][5] = 9'b111101100;
assign camion[35][6] = 9'b101101000;
assign camion[35][7] = 9'b100100100;
assign camion[35][8] = 9'b100000000;
assign camion[35][9] = 9'b100000000;
assign camion[35][10] = 9'b100000000;
assign camion[35][11] = 9'b100100100;
assign camion[35][12] = 9'b100000100;
assign camion[35][13] = 9'b100000100;
assign camion[35][14] = 9'b100100100;
assign camion[35][15] = 9'b100100100;
assign camion[35][16] = 9'b100100100;
assign camion[35][17] = 9'b101000100;
assign camion[35][18] = 9'b101101000;
assign camion[35][19] = 9'b111110000;
assign camion[35][20] = 9'b101101000;
assign camion[36][5] = 9'b111110000;
assign camion[36][6] = 9'b111110000;
assign camion[36][7] = 9'b111101100;
assign camion[36][8] = 9'b101101000;
assign camion[36][9] = 9'b101101000;
assign camion[36][10] = 9'b110001100;
assign camion[36][11] = 9'b110001100;
assign camion[36][12] = 9'b110101100;
assign camion[36][13] = 9'b110101100;
assign camion[36][14] = 9'b110110000;
assign camion[36][15] = 9'b111110101;
assign camion[36][16] = 9'b111110000;
assign camion[36][17] = 9'b111101100;
assign camion[36][18] = 9'b111101100;
assign camion[36][19] = 9'b111110000;
assign camion[36][20] = 9'b101001000;
assign camion[37][5] = 9'b111110000;
assign camion[37][6] = 9'b111110000;
assign camion[37][7] = 9'b111110000;
assign camion[37][8] = 9'b110001100;
assign camion[37][9] = 9'b110001000;
assign camion[37][10] = 9'b111101100;
assign camion[37][11] = 9'b111110000;
assign camion[37][12] = 9'b111110100;
assign camion[37][13] = 9'b111110100;
assign camion[37][14] = 9'b111111101;
assign camion[37][15] = 9'b111111101;
assign camion[37][16] = 9'b111110000;
assign camion[37][17] = 9'b111110000;
assign camion[37][18] = 9'b111110000;
assign camion[37][19] = 9'b111110000;
assign camion[37][20] = 9'b101101101;
assign camion[38][5] = 9'b111110101;
assign camion[38][6] = 9'b111110000;
assign camion[38][7] = 9'b111110000;
assign camion[38][8] = 9'b110101100;
assign camion[38][9] = 9'b110001000;
assign camion[38][10] = 9'b111101100;
assign camion[38][11] = 9'b111110000;
assign camion[38][12] = 9'b111110000;
assign camion[38][13] = 9'b111110000;
assign camion[38][14] = 9'b111110100;
assign camion[38][15] = 9'b111111101;
assign camion[38][16] = 9'b111110100;
assign camion[38][17] = 9'b111110000;
assign camion[38][18] = 9'b111110100;
assign camion[38][19] = 9'b111110100;
assign camion[38][20] = 9'b101101101;
assign camion[39][5] = 9'b111110000;
assign camion[39][6] = 9'b111110100;
assign camion[39][7] = 9'b111110100;
assign camion[39][8] = 9'b111110000;
assign camion[39][9] = 9'b110001000;
assign camion[39][10] = 9'b111101100;
assign camion[39][11] = 9'b111110000;
assign camion[39][12] = 9'b111110000;
assign camion[39][13] = 9'b111110000;
assign camion[39][14] = 9'b111110101;
assign camion[39][15] = 9'b111111101;
assign camion[39][16] = 9'b111110100;
assign camion[39][17] = 9'b111110100;
assign camion[39][18] = 9'b111111100;
assign camion[39][19] = 9'b111110100;
assign camion[39][20] = 9'b101001001;
assign camion[40][5] = 9'b111110000;
assign camion[40][6] = 9'b111110100;
assign camion[40][7] = 9'b111110000;
assign camion[40][8] = 9'b111110000;
assign camion[40][9] = 9'b110001100;
assign camion[40][10] = 9'b111101100;
assign camion[40][11] = 9'b111110000;
assign camion[40][12] = 9'b111110000;
assign camion[40][13] = 9'b111110000;
assign camion[40][14] = 9'b111110101;
assign camion[40][15] = 9'b111111101;
assign camion[40][16] = 9'b111110000;
assign camion[40][17] = 9'b111110100;
assign camion[40][18] = 9'b111111100;
assign camion[40][19] = 9'b111110000;
assign camion[41][6] = 9'b111110100;
assign camion[41][7] = 9'b111110100;
assign camion[41][8] = 9'b111110100;
assign camion[41][9] = 9'b111101100;
assign camion[41][10] = 9'b111110000;
assign camion[41][11] = 9'b111110000;
assign camion[41][12] = 9'b111110100;
assign camion[41][13] = 9'b111110100;
assign camion[41][14] = 9'b111111101;
assign camion[41][15] = 9'b111111101;
assign camion[41][16] = 9'b111110100;
assign camion[41][17] = 9'b111110100;
assign camion[41][18] = 9'b111111100;
assign camion[41][19] = 9'b111110101;
assign camion[42][7] = 9'b110110000;
assign camion[42][8] = 9'b110001100;
assign camion[42][9] = 9'b110001100;
assign camion[42][10] = 9'b110010001;
assign camion[42][11] = 9'b110110001;
assign camion[42][12] = 9'b110110001;
assign camion[42][13] = 9'b111110101;
assign camion[42][14] = 9'b110110101;
assign camion[42][15] = 9'b110010001;
assign camion[42][16] = 9'b110001100;
assign camion[42][17] = 9'b110110000;
assign camion[42][18] = 9'b111110101;
assign camion[43][10] = 9'b100000000;
assign camion[43][11] = 9'b100000000;
assign camion[43][12] = 9'b100000100;
assign camion[43][13] = 9'b100000100;
assign camion[43][14] = 9'b100000000;
//Total de Lineas = 651
endmodule
