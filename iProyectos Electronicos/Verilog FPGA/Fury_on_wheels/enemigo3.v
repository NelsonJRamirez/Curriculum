`timescale 1ns / 1ps
module enemigo3 (
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
			if (enemigo3[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= enemigo3[vcount- posy][hcount- posx][7:5];
				green <= enemigo3[vcount- posy][hcount- posx][4:2];
            blue 	<= enemigo3[vcount- posy][hcount- posx][1:0];
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
wire [8:0] enemigo3[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign enemigo3[10][24] = 9'b100010111;
assign enemigo3[10][25] = 9'b101011111;
assign enemigo3[10][26] = 9'b101011111;
assign enemigo3[10][27] = 9'b101011111;
assign enemigo3[10][28] = 9'b101011111;
assign enemigo3[10][29] = 9'b100010011;
assign enemigo3[11][23] = 9'b100010111;
assign enemigo3[11][24] = 9'b100010111;
assign enemigo3[11][25] = 9'b101011111;
assign enemigo3[11][26] = 9'b101011111;
assign enemigo3[11][27] = 9'b101011111;
assign enemigo3[11][28] = 9'b101011111;
assign enemigo3[11][29] = 9'b100010111;
assign enemigo3[11][30] = 9'b100010111;
assign enemigo3[12][22] = 9'b100010111;
assign enemigo3[12][23] = 9'b111111111;
assign enemigo3[12][24] = 9'b101111111;
assign enemigo3[12][25] = 9'b100110111;
assign enemigo3[12][26] = 9'b101011111;
assign enemigo3[12][27] = 9'b101011111;
assign enemigo3[12][28] = 9'b100110111;
assign enemigo3[12][29] = 9'b101111111;
assign enemigo3[12][30] = 9'b111111111;
assign enemigo3[12][31] = 9'b100010111;
assign enemigo3[13][22] = 9'b100010111;
assign enemigo3[13][23] = 9'b100111111;
assign enemigo3[13][24] = 9'b100010111;
assign enemigo3[13][25] = 9'b100111111;
assign enemigo3[13][26] = 9'b101011111;
assign enemigo3[13][27] = 9'b101011111;
assign enemigo3[13][28] = 9'b100111111;
assign enemigo3[13][29] = 9'b100010111;
assign enemigo3[13][30] = 9'b100111111;
assign enemigo3[13][31] = 9'b100010111;
assign enemigo3[14][21] = 9'b100010011;
assign enemigo3[14][22] = 9'b100010111;
assign enemigo3[14][23] = 9'b100010011;
assign enemigo3[14][24] = 9'b100010011;
assign enemigo3[14][25] = 9'b101011111;
assign enemigo3[14][26] = 9'b101011111;
assign enemigo3[14][27] = 9'b101011111;
assign enemigo3[14][28] = 9'b101011111;
assign enemigo3[14][29] = 9'b100010011;
assign enemigo3[14][30] = 9'b100010011;
assign enemigo3[14][31] = 9'b100010111;
assign enemigo3[14][32] = 9'b100010111;
assign enemigo3[15][21] = 9'b100010111;
assign enemigo3[15][22] = 9'b100010111;
assign enemigo3[15][23] = 9'b100010111;
assign enemigo3[15][24] = 9'b100010011;
assign enemigo3[15][25] = 9'b101011111;
assign enemigo3[15][26] = 9'b101011111;
assign enemigo3[15][27] = 9'b101011111;
assign enemigo3[15][28] = 9'b101011111;
assign enemigo3[15][29] = 9'b100010011;
assign enemigo3[15][30] = 9'b100010011;
assign enemigo3[15][31] = 9'b100010111;
assign enemigo3[15][32] = 9'b100010111;
assign enemigo3[16][21] = 9'b100010011;
assign enemigo3[16][22] = 9'b100010111;
assign enemigo3[16][23] = 9'b100010111;
assign enemigo3[16][24] = 9'b100010111;
assign enemigo3[16][25] = 9'b101011111;
assign enemigo3[16][26] = 9'b101011111;
assign enemigo3[16][27] = 9'b101011111;
assign enemigo3[16][28] = 9'b101011111;
assign enemigo3[16][29] = 9'b100010111;
assign enemigo3[16][30] = 9'b100010111;
assign enemigo3[16][31] = 9'b100010111;
assign enemigo3[16][32] = 9'b100010011;
assign enemigo3[17][22] = 9'b100010111;
assign enemigo3[17][23] = 9'b100010010;
assign enemigo3[17][24] = 9'b100101001;
assign enemigo3[17][25] = 9'b101001101;
assign enemigo3[17][26] = 9'b101001101;
assign enemigo3[17][27] = 9'b101001101;
assign enemigo3[17][28] = 9'b100101101;
assign enemigo3[17][29] = 9'b100101001;
assign enemigo3[17][30] = 9'b100010010;
assign enemigo3[17][31] = 9'b100010111;
assign enemigo3[18][22] = 9'b100010010;
assign enemigo3[18][23] = 9'b100101101;
assign enemigo3[18][24] = 9'b100101001;
assign enemigo3[18][25] = 9'b101000100;
assign enemigo3[18][26] = 9'b100100100;
assign enemigo3[18][27] = 9'b100100100;
assign enemigo3[18][28] = 9'b101000100;
assign enemigo3[18][29] = 9'b100101001;
assign enemigo3[18][30] = 9'b100101101;
assign enemigo3[18][31] = 9'b100010010;
assign enemigo3[19][22] = 9'b100010010;
assign enemigo3[19][23] = 9'b100101001;
assign enemigo3[19][24] = 9'b100010011;
assign enemigo3[19][25] = 9'b100010011;
assign enemigo3[19][26] = 9'b100010011;
assign enemigo3[19][27] = 9'b100010011;
assign enemigo3[19][28] = 9'b100010011;
assign enemigo3[19][29] = 9'b100010011;
assign enemigo3[19][30] = 9'b100101001;
assign enemigo3[19][31] = 9'b100010010;
assign enemigo3[20][22] = 9'b100010010;
assign enemigo3[20][23] = 9'b100101001;
assign enemigo3[20][24] = 9'b100010011;
assign enemigo3[20][25] = 9'b100010111;
assign enemigo3[20][26] = 9'b100010111;
assign enemigo3[20][27] = 9'b100010111;
assign enemigo3[20][28] = 9'b100010111;
assign enemigo3[20][29] = 9'b100010011;
assign enemigo3[20][30] = 9'b100101001;
assign enemigo3[20][31] = 9'b100010010;
assign enemigo3[21][22] = 9'b100010010;
assign enemigo3[21][23] = 9'b100101001;
assign enemigo3[21][24] = 9'b100010011;
assign enemigo3[21][25] = 9'b100010111;
assign enemigo3[21][26] = 9'b101011111;
assign enemigo3[21][27] = 9'b100111111;
assign enemigo3[21][28] = 9'b100010111;
assign enemigo3[21][29] = 9'b100010011;
assign enemigo3[21][30] = 9'b100101001;
assign enemigo3[21][31] = 9'b100010010;
assign enemigo3[22][22] = 9'b100010010;
assign enemigo3[22][23] = 9'b100101001;
assign enemigo3[22][24] = 9'b100010011;
assign enemigo3[22][25] = 9'b100110111;
assign enemigo3[22][26] = 9'b101011111;
assign enemigo3[22][27] = 9'b101111111;
assign enemigo3[22][28] = 9'b100110111;
assign enemigo3[22][29] = 9'b100010011;
assign enemigo3[22][30] = 9'b100101001;
assign enemigo3[22][31] = 9'b100010010;
assign enemigo3[23][22] = 9'b100010010;
assign enemigo3[23][23] = 9'b100101001;
assign enemigo3[23][24] = 9'b100010011;
assign enemigo3[23][25] = 9'b100110111;
assign enemigo3[23][26] = 9'b101011111;
assign enemigo3[23][27] = 9'b101111111;
assign enemigo3[23][28] = 9'b100110111;
assign enemigo3[23][29] = 9'b100010011;
assign enemigo3[23][30] = 9'b100101001;
assign enemigo3[23][31] = 9'b100010010;
assign enemigo3[24][22] = 9'b100010010;
assign enemigo3[24][23] = 9'b100101000;
assign enemigo3[24][24] = 9'b100010011;
assign enemigo3[24][25] = 9'b100010111;
assign enemigo3[24][26] = 9'b101011111;
assign enemigo3[24][27] = 9'b101011111;
assign enemigo3[24][28] = 9'b100010111;
assign enemigo3[24][29] = 9'b100010011;
assign enemigo3[24][30] = 9'b100101000;
assign enemigo3[24][31] = 9'b100001110;
assign enemigo3[25][22] = 9'b100010010;
assign enemigo3[25][23] = 9'b100001110;
assign enemigo3[25][24] = 9'b100010111;
assign enemigo3[25][25] = 9'b100010111;
assign enemigo3[25][26] = 9'b100010011;
assign enemigo3[25][27] = 9'b100010011;
assign enemigo3[25][28] = 9'b100010111;
assign enemigo3[25][29] = 9'b100010111;
assign enemigo3[25][30] = 9'b100001110;
assign enemigo3[25][31] = 9'b100010010;
assign enemigo3[26][22] = 9'b100010111;
assign enemigo3[26][23] = 9'b100010111;
assign enemigo3[26][24] = 9'b100010111;
assign enemigo3[26][25] = 9'b100010111;
assign enemigo3[26][26] = 9'b100010111;
assign enemigo3[26][27] = 9'b100010111;
assign enemigo3[26][28] = 9'b100010111;
assign enemigo3[26][29] = 9'b100010111;
assign enemigo3[26][30] = 9'b100010111;
assign enemigo3[26][31] = 9'b100010111;
assign enemigo3[27][22] = 9'b100010011;
assign enemigo3[27][23] = 9'b100011111;
assign enemigo3[27][24] = 9'b100010011;
assign enemigo3[27][25] = 9'b100001101;
assign enemigo3[27][26] = 9'b100001110;
assign enemigo3[27][27] = 9'b100001110;
assign enemigo3[27][28] = 9'b100001101;
assign enemigo3[27][29] = 9'b100010011;
assign enemigo3[27][30] = 9'b100011111;
assign enemigo3[27][31] = 9'b100010011;
assign enemigo3[28][21] = 9'b100010111;
assign enemigo3[28][22] = 9'b100010111;
assign enemigo3[28][23] = 9'b100010011;
assign enemigo3[28][24] = 9'b100101000;
assign enemigo3[28][25] = 9'b101000100;
assign enemigo3[28][26] = 9'b101000100;
assign enemigo3[28][27] = 9'b101000100;
assign enemigo3[28][28] = 9'b101000100;
assign enemigo3[28][29] = 9'b100101000;
assign enemigo3[28][30] = 9'b100010011;
assign enemigo3[28][31] = 9'b100010111;
assign enemigo3[28][32] = 9'b100010111;
assign enemigo3[29][21] = 9'b100010111;
assign enemigo3[29][22] = 9'b100010111;
assign enemigo3[29][23] = 9'b100010010;
assign enemigo3[29][24] = 9'b100001101;
assign enemigo3[29][25] = 9'b101010010;
assign enemigo3[29][26] = 9'b101010010;
assign enemigo3[29][27] = 9'b101010010;
assign enemigo3[29][28] = 9'b101010010;
assign enemigo3[29][29] = 9'b100001101;
assign enemigo3[29][30] = 9'b100010010;
assign enemigo3[29][31] = 9'b100010111;
assign enemigo3[29][32] = 9'b100010111;
assign enemigo3[30][21] = 9'b100010111;
assign enemigo3[30][22] = 9'b100010111;
assign enemigo3[30][23] = 9'b100010111;
assign enemigo3[30][24] = 9'b100010111;
assign enemigo3[30][25] = 9'b101011111;
assign enemigo3[30][26] = 9'b101011111;
assign enemigo3[30][27] = 9'b101011111;
assign enemigo3[30][28] = 9'b101011111;
assign enemigo3[30][29] = 9'b100010111;
assign enemigo3[30][30] = 9'b100010111;
assign enemigo3[30][31] = 9'b100010111;
assign enemigo3[30][32] = 9'b100010111;
assign enemigo3[31][21] = 9'b100010111;
assign enemigo3[31][22] = 9'b100010111;
assign enemigo3[31][23] = 9'b100010111;
assign enemigo3[31][24] = 9'b100010111;
assign enemigo3[31][25] = 9'b101011111;
assign enemigo3[31][26] = 9'b101011111;
assign enemigo3[31][27] = 9'b101011111;
assign enemigo3[31][28] = 9'b101011111;
assign enemigo3[31][29] = 9'b100010111;
assign enemigo3[31][30] = 9'b100010111;
assign enemigo3[31][31] = 9'b100010111;
assign enemigo3[31][32] = 9'b100010111;
assign enemigo3[32][22] = 9'b100010111;
assign enemigo3[32][23] = 9'b100010111;
assign enemigo3[32][24] = 9'b100010011;
assign enemigo3[32][25] = 9'b101011111;
assign enemigo3[32][26] = 9'b101011111;
assign enemigo3[32][27] = 9'b101011111;
assign enemigo3[32][28] = 9'b101011111;
assign enemigo3[32][29] = 9'b100010011;
assign enemigo3[32][30] = 9'b100010111;
assign enemigo3[32][31] = 9'b100010111;
assign enemigo3[33][23] = 9'b101101001;
assign enemigo3[33][24] = 9'b110000000;
assign enemigo3[33][25] = 9'b101010011;
assign enemigo3[33][26] = 9'b101011111;
assign enemigo3[33][27] = 9'b101011111;
assign enemigo3[33][28] = 9'b101010011;
assign enemigo3[33][29] = 9'b110000000;
assign enemigo3[33][30] = 9'b101101001;
//Total de Lineas = 246
endmodule

