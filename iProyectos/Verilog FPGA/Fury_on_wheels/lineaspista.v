`timescale 1ns / 1ps
module lineacentro (
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
			if (lineacentro[vcount - posy][hcount - posx][8] == 1'b1)
			begin
				red   <= lineacentro[vcount- posy][hcount- posx][7:5];
				green <= lineacentro[vcount- posy][hcount- posx][4:2];
            blue 	<= lineacentro[vcount- posy][hcount- posx][1:0];
				data  <= 1'b1;
			end
			else
				data <= 0;
			end
		else
		data <= 0;
	end
end

parameter RESOLUCION_X = 27;
parameter RESOLUCION_Y = 60;
wire [8:0] lineacentro[RESOLUCION_Y - 1'b1 : 0][RESOLUCION_X - 1'b1 : 0];
assign lineacentro[11][10] = 9'b111100000;
assign lineacentro[11][11] = 9'b111100000;
assign lineacentro[11][12] = 9'b111100000;
assign lineacentro[11][13] = 9'b111100000;
assign lineacentro[11][14] = 9'b111100000;
assign lineacentro[12][10] = 9'b111100000;
assign lineacentro[12][11] = 9'b111100000;
assign lineacentro[12][12] = 9'b111100000;
assign lineacentro[12][13] = 9'b111100000;
assign lineacentro[12][14] = 9'b111100000;
assign lineacentro[13][10] = 9'b111100000;
assign lineacentro[13][11] = 9'b111100000;
assign lineacentro[13][12] = 9'b111100000;
assign lineacentro[13][13] = 9'b111100000;
assign lineacentro[13][14] = 9'b111100000;
assign lineacentro[14][10] = 9'b111100000;
assign lineacentro[14][14] = 9'b111100000;
assign lineacentro[15][10] = 9'b111100000;
assign lineacentro[15][14] = 9'b111100000;
assign lineacentro[16][10] = 9'b111100000;
assign lineacentro[16][14] = 9'b111100000;
assign lineacentro[17][10] = 9'b111100000;
assign lineacentro[17][14] = 9'b111100000;
assign lineacentro[18][10] = 9'b111100000;
assign lineacentro[18][14] = 9'b111100000;
assign lineacentro[19][10] = 9'b111100000;
assign lineacentro[19][14] = 9'b111100000;
assign lineacentro[20][10] = 9'b111100000;
assign lineacentro[20][14] = 9'b111100000;
assign lineacentro[21][10] = 9'b111100000;
assign lineacentro[21][14] = 9'b111100000;
assign lineacentro[22][10] = 9'b111100000;
assign lineacentro[22][14] = 9'b111100000;
assign lineacentro[23][10] = 9'b111100000;
assign lineacentro[23][14] = 9'b111100000;
assign lineacentro[24][10] = 9'b111100000;
assign lineacentro[24][14] = 9'b111100000;
assign lineacentro[25][10] = 9'b111100000;
assign lineacentro[25][14] = 9'b111100000;
assign lineacentro[26][10] = 9'b111100000;
assign lineacentro[26][14] = 9'b111100000;
assign lineacentro[27][10] = 9'b111100000;
assign lineacentro[27][14] = 9'b111100000;
assign lineacentro[28][10] = 9'b111100000;
assign lineacentro[28][14] = 9'b111100000;
assign lineacentro[29][10] = 9'b111100000;
assign lineacentro[29][14] = 9'b111100000;
assign lineacentro[30][10] = 9'b111100000;
assign lineacentro[30][14] = 9'b111100000;
assign lineacentro[31][10] = 9'b111100000;
assign lineacentro[31][14] = 9'b111100000;
assign lineacentro[32][10] = 9'b111100000;
assign lineacentro[32][14] = 9'b111100000;
assign lineacentro[33][10] = 9'b111100000;
assign lineacentro[33][14] = 9'b111100000;
assign lineacentro[34][10] = 9'b111100000;
assign lineacentro[34][14] = 9'b111100000;
assign lineacentro[35][10] = 9'b111100000;
assign lineacentro[35][14] = 9'b111100000;
assign lineacentro[36][10] = 9'b111100000;
assign lineacentro[36][14] = 9'b111100000;
assign lineacentro[37][10] = 9'b111100000;
assign lineacentro[37][14] = 9'b111100000;
assign lineacentro[38][10] = 9'b111100000;
assign lineacentro[38][14] = 9'b111100000;
assign lineacentro[39][10] = 9'b111100000;
assign lineacentro[39][14] = 9'b111100000;
assign lineacentro[40][10] = 9'b111100000;
assign lineacentro[40][14] = 9'b111100000;
assign lineacentro[41][10] = 9'b111100000;
assign lineacentro[41][14] = 9'b111100000;
assign lineacentro[42][10] = 9'b111100000;
assign lineacentro[42][14] = 9'b111100000;
assign lineacentro[43][10] = 9'b111100000;
assign lineacentro[43][14] = 9'b111100000;
assign lineacentro[44][10] = 9'b111100000;
assign lineacentro[44][14] = 9'b111100000;
assign lineacentro[45][10] = 9'b111100000;
assign lineacentro[45][14] = 9'b111100000;
assign lineacentro[46][10] = 9'b111100000;
assign lineacentro[46][14] = 9'b111100000;
assign lineacentro[47][10] = 9'b111100000;
assign lineacentro[47][14] = 9'b111100000;
assign lineacentro[48][10] = 9'b111100000;
assign lineacentro[48][14] = 9'b111100000;
assign lineacentro[49][10] = 9'b111100000;
assign lineacentro[49][11] = 9'b111100000;
assign lineacentro[49][12] = 9'b111100000;
assign lineacentro[49][13] = 9'b111100000;
assign lineacentro[49][14] = 9'b111100000;
assign lineacentro[50][10] = 9'b111100000;
assign lineacentro[50][11] = 9'b111100000;
assign lineacentro[50][12] = 9'b111100000;
assign lineacentro[50][13] = 9'b111100000;
assign lineacentro[50][14] = 9'b111100000;
assign lineacentro[51][10] = 9'b111100000;
assign lineacentro[51][11] = 9'b111100000;
assign lineacentro[51][12] = 9'b111100000;
assign lineacentro[51][13] = 9'b111100000;
assign lineacentro[51][14] = 9'b111100000;
//Total de Lineas = 100
endmodule

