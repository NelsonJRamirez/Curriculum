//Ejemplo 5
//Generacion de Codigo Con Modulo y Matriz
//Este ejemplo demostrara como utilizar el codigo generado cuando se trate de este caso:
//Matriz: Seleccionada 
//Crear Modulo: Seleccionado

`timescale 1ns / 1ps

module Prueba_VGA(
input clock,
input [1:0]botones,
input [2:0]botones2,
output reg [2:0 ] red,
output reg [2:0 ] green,
output reg [1:0 ] blue,
output reg hsync,
output reg vsync,
input Arriba,Abajo,Derecha,Izquierda,
 output reg [8:0] count,
  output [6:0]SevenSegment,
output  [2:0]SevenSegmentEnable
);

//Este codigo no se modifica
reg [9:0] hcount = 0;
reg [9:0] vcount = 0;
reg [1:0] counter = 0;
reg enable;
//Enable 
always @ (posedge clock)
begin
if (counter == 3)
begin
counter <= 1'b0;
enable <= 1'b1;
end
else
begin
counter <= counter + 1'b1;
enable <= 1'b0;
end
end

//Vsync y Hsync
always @(posedge clock)
begin
if (enable == 1)
begin
if(hcount == 799)
begin
hcount <= 0;
if(vcount == 524)
vcount <= 0;
else
vcount <= vcount+1'b1;
end
else
hcount <= hcount+1'b1;
if (vcount >= 490 && vcount < 492)
vsync <= 1'b0;
else
vsync <= 1'b1;
if (hcount >= 656 && hcount < 752)
hsync <= 1'b0;
else
hsync <= 1'b1;
end
end
//Fin de codigo no modificable

//Asi seria el modulo generado
//module BooMat (
//input enable,
//input clock,
//input [9:0] posx, posy,
//input [9:0] hcount,
//input [9:0] vcount,
//output reg[2:0] red,
//output reg[2:0] green,
//output reg[1:0] blue,
//output reg data);

//Entonces, siguiendo el orden lo instanciaremos

//Creamos las variables de posicion relativa
reg [9:0] jugadorh=305,jugadorv=350;
reg [9:0] enemigo1h=225,enemigo1v=100;
reg [9:0] enemigo2h=290,enemigo2v=100;
reg [9:0] enemigo3h=310,enemigo3v=100;
reg [9:0] enemigo4h=340,enemigo4v=100;
reg [9:0] enemigo5h=380,enemigo5v=100;
reg [9:0] enemigo6h=250,enemigo6v=100;
reg [9:0] lineacentroh=315,lineacentrov=1;
//wire pantalla start
reg [9:0] logo_starth=8'd200;
reg [9:0] logo_startv=8'd300;
reg [9:0] logoh=300;
reg [9:0] logov=100;
reg [9:0] logo_ruedah=8'd100;
reg [9:0] logo_ruedav=8'd300;
//perdio
reg [9:0] game_overh=8'd300;
reg [9:0] game_overv=8'd300;
//reset
reg [9:0] reset_logoh=8'd250;
reg [9:0] reset_logov=8'd300;
//Utilizamos Wires para almacenar la salida del modulo
wire [2:0] r [15:0];
wire [2:0] g [15:0];
wire [1:0] b [15:0];
//Utilizamos un Wire para la salida de Data
wire [15:0]Dat;
//Aqui hacemos nuestra instanciacion con nuestros vehiculos
jugador Imagen1(enable,clock,jugadorh,jugadorv,hcount,vcount,r[0],g[0],b[0],Dat[0]);
enemigo1 Imagen3(enable,clock,enemigo1h,enemigo1v,hcount,vcount,r[2],g[2],b[2],Dat[2]);
enemigo2 Imagen4(enable,clock,enemigo2h,enemigo2v,hcount,vcount,r[3],g[3],b[3],Dat[3]);
enemigo3 Imagen5(enable,clock,enemigo3h,enemigo3v,hcount,vcount,r[4],g[4],b[4],Dat[4]);
enemigo4 Imagen6(enable,clock,enemigo4h,enemigo4v,hcount,vcount,r[5],g[5],b[5],Dat[5]);
enemigo5 Imagen7(enable,clock,enemigo5h,enemigo5v,hcount,vcount,r[6],g[6],b[6],Dat[6]);
enemigo6 Imagen8(enable,clock,enemigo6h,enemigo6v,hcount,vcount,r[7],g[7],b[7],Dat[7]);
logo_start Imagen9(enable,clock,logo_starth,logo_startv,hcount,vcount,r[8],g[8],b[8],Dat[8]);//start
logo Imagen10(enable,clock,logoh,logov,hcount,vcount,r[10],g[10],b[10],Dat[10]); //logo juego
logo_rueda Imagen11(enable,clock,logo_ruedah,logo_ruedav,hcount,vcount,r[11],g[11],b[11],Dat[11]);//rueda logo
game_over Imagen12(enable,clock,game_overh,game_overv,hcount,vcount,r[12],g[12],b[12],Dat[12]);//game over
reset_logo Imagen13(enable,clock,reset_logoh,reset_logov,hcount,vcount,r[13],g[13],b[13],Dat[13]);//reiniciar
//instanciacion lineas calle
lineacentro Imagen2(enable,clock,lineacentroh,lineacentrov,hcount,vcount,r[1],g[1],b[1],Dat[1]);//linea centro

// la maquinaria de eventos

wire [1:0]start_pausa;
wire [1:0]state;
reg gameover=1'd0;
machine mp(clock,botones2,start_pausa,gameover);


wire clk_1hz;
clk_hz1 reloj(clock,clk_hz);
reg [4:0]cont_move=5'd0;
wire cambios;
//start y pausa
always@(posedge clk_hz)
begin
if(start_pausa==3||start_pausa==0)
begin cont_move<=5'd0;end
else if(cont_move<=25&&start_pausa==1)
cont_move<=cont_move+1'd1;
else
cont_move<=cont_move;
end


////puntos
reg [8:0]puntos=9'd0;
always@(posedge clk_hz)
begin
if(start_pausa==0||(start_pausa==3&&botones2[0]==0))
puntos<=9'd0;
else if(puntos==511)
puntos<=9'd0;
else if(start_pausa==1)
puntos<=puntos+4'd10;
end

////display
wire [11:0]n1;

wire [6:0] s0,s1,s2;
wire velo2;
display dis0(velo3,SevenSegment,s0,s1,s2,SevenSegmentEnable);
Doble_dd d4(puntos,n1);
Decodificador d1(n1[3:0],s0);
Decodificador d2(n1[7:4],s1);
Decodificador d3(n1[11:8],s2);




////cambio de velocidad
clk v1(clock,velo1);
segunda_velocidad v2(clock,velo2);
tercera_velocidad v3(clock,velo3);
velocidades cambio_velocidad(clock,puntos,{velo3,velo2,velo1},cambios);











//movimiento jugador principal
movimiento_pepa reloj111 (clock,move);
//movimiento arriba,abajo.
always@(posedge move)
begin
if(~Arriba)
begin
if(jugadorv>300)
jugadorv<=jugadorv-1'd1;
end
else if(~Abajo)
begin
if(jugadorv+50<480)
jugadorv<=jugadorv+1'd1;
end
else
jugadorv<=jugadorv;
/////////////////////////////////
//movimiento derecha,izquierda///
/////////////////////////////////
if(~Derecha)
begin
if(jugadorh+50<460)
jugadorh<=jugadorh+1'd1;
end
else if(~Izquierda)
begin
if(jugadorh>220)
jugadorh<=jugadorh-1'd1;
end
else
jugadorh<=jugadorh;
end
//inicio












///////////////////////////
//movimiento lineaspista///
///////////////////////////
reloj  reloj2 (clock,move2);
always @(posedge move2)
begin
if(lineacentrov < 640)
lineacentrov<=lineacentrov+1'b1;
else
lineacentrov<=0;
end
////////////////////////////////////
//movimiento enemigo1 por el mapa///
////////////////////////////////////
always@(posedge cambios)
begin
if(start_pausa==3||start_pausa==0)
enemigo1v<=300;
else if(start_pausa==1)
begin
if(cont_move>=0&&enemigo1v>10)
enemigo1v<=enemigo1v-1'b1;
else
enemigo1v<=480;
end

end

////////////////////////////////////
//movimiento enemigo2 por el mapa///
////////////////////////////////////
always@(posedge cambios)
begin
if(start_pausa==3||start_pausa==0)
enemigo2v<=300;
else if(start_pausa==1)
begin
if(cont_move>=0&&enemigo2v>10)
enemigo2v<=enemigo2v-1'b1;
else
enemigo2v<=480;
end

end
////////////////////////////////////
//movimiento enemigo3 por el mapa///
////////////////////////////////////
always@(posedge cambios)
begin
if(start_pausa==3||start_pausa==0)
enemigo3v<=300;
else if(start_pausa==1)
begin
if(cont_move>=0&&enemigo3v>10)
enemigo3v<=enemigo3v-1'b1;
else
enemigo3v<=480;
end

end
////////////////////////////////////
//movimiento enemigo4 por el mapa///
////////////////////////////////////
always@(posedge cambios)
begin
if(start_pausa==3||start_pausa==0)
enemigo4v<=300;
else if(start_pausa==1)
begin
if(cont_move>=0&&enemigo4v>10)
enemigo4v<=enemigo4v-1'b1;
else
enemigo4v<=480;
end

end
////////////////////////////////////
//movimiento enemigo5 por el mapa///
////////////////////////////////////
always@(posedge cambios)
begin
if(start_pausa==3||start_pausa==0)
enemigo5v<=300;
else if(start_pausa==1)
begin
if(cont_move>=0&&enemigo5v>10)
enemigo5v<=enemigo5v-1'b1;
else
enemigo5v<=480;
end

end
////////////////////////////////////
//movimiento enemigo5 por el mapa///
////////////////////////////////////
always@(posedge cambios)
begin
if(start_pausa==3||start_pausa==0)
enemigo6v<=300;
else if(start_pausa==1)
begin
if(cont_move>=0&&enemigo6v>10)
enemigo6v<=enemigo6v-1'b1;
else
enemigo6v<=480;
end

end
/////////////////////////////////////
//bloque de datos de imagenes etc////
/////////////////////////////////////
always @ (posedge clock)
begin
	if (enable)
	begin
	//pantalla de juego 
	if(start_pausa==1)
	begin
//colision
	if(Dat[0]==1&&(Dat[2]==1||Dat[3]==1||Dat[4]==1||Dat[5]==1||Dat[6]==1||Dat[7]==1))
	begin
	gameover<=1'd1;
	end
	else if(gameover==1)
	begin
	gameover<=1'd0;
	end
	
// data jugador ,enemigos,pista y niveles	
	 if(Dat[7] == 1'b1) //enemigo6
		begin
			red	<=	r[7];
			green	<=	g[7];
			blue	<=	b[7];
		end
		else	if(Dat[1] == 1'b1)//linea centro
		begin
			red	<=	r[1];
			green	<=	g[1];
			blue	<=	b[1];
		end
	 else if(Dat[6] == 1'b1)//enemigo5
		begin
			red	<=	r[6];
			green	<=	g[6];
			blue	<=	b[6];
		end
	  else if(Dat[5] == 1'b1)//enemigo4
		begin
			red	<=	r[5];
			green	<=	g[5];
			blue	<=	b[5];
		end
	  else if(Dat[4] == 1'b1)//enemigo3
		begin
			red	<=	r[4];
			green	<=	g[4];
			blue	<=	b[4];
		end
	  else if(Dat[3] == 1'b1)//enemigo2
		begin
			red	<=	r[3];
			green	<=	g[3];
			blue	<=	b[3];
		end
	 else if(Dat[2] == 1'b1)//enemigo1
		begin
			red	<=	r[2];
			green	<=	g[2];
			blue	<=	b[2];
		end
		else if(Dat[0] == 1'b1)//jugador carro
		begin
			red	<=	r[0];
			green	<=	g[0];
			blue	<=	b[0];
		end
		//autopista
			else if (hcount>220&&hcount<440&&vcount<480&&vcount>0)//cuadro negro de la pista negra
		begin                
				red    <= 3'b100;
				green  <= 3'b001;
				blue   <= 2'b01;;
		end 
		///////////////////////////
		//niveles cambio de color//
		///////////////////////////
		else if( puntos>100 && puntos <200)//nivel_1
				begin
				red 	<= 3'b100;
				green	<= 3'b000;
				blue 	<= 2'b00;
				end
		
		 else if( puntos>200 && puntos<300)//nive_2
				begin
				red 	<= 3'b000;
				green	<= 3'b111;
				blue 	<= 2'b00;
				end
			else if( puntos>300 && puntos<450)//nivel_3
				begin
				red    <= 3'b011;
				green  <= 3'b101;
				blue   <= 2'b11;

				end
         else if( puntos>450 && puntos<500)//nivel_4
				begin
				red    <= 3'b100;
            green  <= 3'b110;
            blue   <= 2'b00;

				end			
			else
		begin
			red 	<= 3'b0;
			green	<= 3'b0;
			blue 	<= 2'b0;
		end
		end
///////////////////////////////////////////////////////////////////////////////////////////////////////////		
		//////////////////////
      //pantalla de inicio//
		//////////////////////
		else if(start_pausa==0)
		begin
		
		if(gameover==1)
		begin
		gameover<=0;
		end
			if(Dat[10] == 1'b1)//presentacion o logo juego
		begin
			red	<=	r[10];
			green	<=	g[10];
			blue	<=	b[10];
		end
		
		else if(Dat[8] == 1'b1)//imagen start
		begin
			red	<=	r[8];
			green	<=	g[8];
			blue	<=	b[8];
		end
		 else if(Dat[11] == 1'b1)//rueda
		begin
			red	<=	r[11];
			green	<=	g[11];
			blue	<=	b[11];
		end
	
		else if(hcount>0&&hcount<640&&vcount<480&&vcount>0)//fondo pantalla negro
	   begin
			red 	<= 3'b000;
			green	<= 3'b000;
			blue 	<= 2'b00;
		end
				
			else
		begin
			red 	<= 3'b0;
			green	<= 3'b0;
			blue 	<= 2'b0;
		end
		end
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		/////////////////////
      //pantalla de pausa//
		/////////////////////
		else if(start_pausa==2)
		
		begin
	 if(Dat[8] == 1'b1)//start imagen
		begin
			red	<=	r[8];
			green	<=	g[8];
			blue	<=	b[8];
		end
			else if(Dat[13] == 1'b1)//reset imagen
		begin
			red	<=	r[13];
			green	<=	g[13];
			blue	<=	b[13];
		end
		
		
		 else if(hcount>0&&hcount<640&&vcount<480&&vcount>0)//fondo de esa pantalla
		begin
			red 	<= 3'b000;
			green	<= 3'b010;
			blue 	<= 2'b10;
		end
			else
		begin
			red 	<= 3'b0;
			green	<= 3'b0;
			blue 	<= 2'b0;
		end
		end
//////////////////////////////////////////////////////////////////////////////////////////////////////////		
	  ////////////////////////
     //pantalla de gameover//
	  ///////////////////////
		else if(start_pausa==3)
		
		begin
		if(Dat[12] == 1'b1) //logo gameover
		begin
			red	<=	r[12];
			green	<=	g[12];
			blue	<=	b[12];
		end
		
	 else if(Dat[13] == 1'b1)//reser logo
		begin
			red	<=	r[13];
			green	<=	g[13];
			blue	<=	b[13];
		end
		
		 else if(hcount>0&&hcount<640&&vcount<480&&vcount>0)//fondo de esa pantalla
		begin
			red 	<= 3'b000;
			green	<= 3'b000;
			blue 	<= 2'b00;
		end
			else
		begin
			red 	<= 3'b0;
			green	<= 3'b0;
			blue 	<= 2'b0;
		end
		end

	end
end

endmodule
