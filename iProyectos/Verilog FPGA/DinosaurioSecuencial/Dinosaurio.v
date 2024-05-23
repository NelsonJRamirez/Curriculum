`timescale 1ns / 1ps

module Dinosaurio(

	// FLIP FLOP 1
	input reset_n, // RESET
	output reg FA, // SALIDA FLIP FLOP 
	output reg FA_n, //  SALIDA FLIP FLOP
  
	// FLIP FLOP 2
	output reg FB, // SALIDA FLIP FLOP 
	output reg FB_n, //  SALIDA FLIP FLOP
  
	// VARIABLES DE LOS LED
	output iGameOver,
	output iComenzar,
	output iSaltar,
	output iAgacharse,
	output iCorriendo,  
  
	// DEMAS VARIABLES
	input clk_in, // ENTRADA CLK 100MHZ
	output reg clk_out, // SALIDA CLK 5HZ
	output reg clk_out3, // SALIDA CLK 5HZ
	input Z, // AGACHARSE
	input X, // SALTAR
  
	// DISPLAY
	output [6:0] out, // Salida 
	output [6:0] out2, // Salida 
	output [6:0] out3, // Salida 
	output reg [11:0] iSelect, // Salida de selección 
	output reg [2:0] iBase_Segmentos, // Salida de base 
	output reg [6:0] iSegmentos_Display, // Salida de segmentos 
	output [3:0] leds_Contador // LEDs para mostrar el contador

);

////////////////////////////////////////////////////////////////////////

///////////////     DIVISOR DE FRECUENCIA PARA EL CLK    ///////////////

////////////////////////////////////////////////////////////////////////

reg [26:0] count; // Contador de 27 bits (2^27 = 134217728 > 1000000/5)

always @(posedge clk_in) begin
  if (count == 100000) begin // Si se han contado suficientes ciclos
    count <= 0; // Reiniciar el contador
    clk_out <= ~clk_out; // Invertir el valor del clk de salida
  end else begin
    count <= count + 1; // Incrementar el contador
  end
end

////////////////////////////////////////////////////////////////////////

///////////////     DIVISOR DE FRECUENCIA PARA EL CLK    ///////////////

////////////////////////////////////////////////////////////////////////

reg [26:0] count3; // Contador de 27 bits (2^27 = 134217728 > 1000000/5)

always @(posedge clk_in) begin
  if (count3 == 20000000) begin // Si se han contado suficientes ciclos
    count3 <= 0; // Reiniciar el contador
    clk_out3 <= ~clk_out3; // Invertir el valor del clk de salida
  end else begin
    count3 <= count3 + 1; // Incrementar el contador
  end
end

////////////////////////////////////////////////////////////////////////

///////////////     IMPLEMENTACION DE LOS 2 FLIP FLOP    ///////////////

////////////////////////////////////////////////////////////////////////

always @(posedge clk_out or negedge reset_n) begin
  if (~reset_n) begin
    FA <= 1'b0;
    FA_n <= 1'b1;
    FB <= 1'b0;
    FB_n <= 1'b1;
  end else begin
    FA <= (~Z);
    FA_n <= Z;
    FB <= (FB_n*~X)|(FA_n*~X);
    FB_n <= ~(FA_n & ~X) & ~(FB_n & ~X);
  end
end

////////////////////////////////////////////////////////////////////////

///////////////                 CONTADOR                   //////////////

////////////////////////////////////////////////////////////////////////


reg [3:0] count2; // registro para almacenar el valor del contador
reg counting = 1; // registro para indicar si el contador está en marcha o no

reg enable; // variable de control

always @(posedge clk_out3 or negedge reset_n) begin
    if (!reset_n) begin
        count2 <= 4'b0000; // reiniciar el contador a 0
        counting <= 0; // detener el contador
        enable <= 0; // deshabilitar el contador
    end else begin
        /*if (iSaltar || iAgacharse) begin
            enable <= 1; // habilitar el contador
        end*/
        if (iSaltar || iAgacharse) begin
            counting <= 1; // iniciar el contador
            if (count2 == 4'b1111) begin
                counting <= 0; // detener el contador
                count2 <= 4'b0000; // reiniciar el contador a 0
                //enable <= 0; // deshabilitar el contador
            end else begin
                count2 <= count2 + 1; // incrementar contador
            end
        end
    end
end


assign leds_Contador = count2; // conectar el valor del contador a los LEDs
////////////////////////////////////////////////////////////////////////

///////////////     LOGICA COMBINACIONAL PARA LOS LED    ///////////////

////////////////////////////////////////////////////////////////////////

assign iGameOver = FA & FB;
assign iSaltar = FB & FA_n & Z;
assign iAgacharse = FB_n & FA & X;
assign iComenzar = ~(iGameOver | iSaltar | iAgacharse);
assign iCorriendo = ~(iGameOver ^ iComenzar ^ Z ^ X);

//assign ~( A ^ B ) = iComenzar; // Donde ^ significa que es una XOR

////////////////////////////////////////////////////////////////////////

///////////////        DECLARACIONES DE LOS DISPLAY      ///////////////

////////////////////////////////////////////////////////////////////////

////////////          DISPLAY 1          ////////////

wire A,B,C,D;	
assign A = iSelect[3];
assign B = iSelect[2];
assign C = iSelect[1];
assign D = iSelect[0];

assign out[0] = (~A & ~B & D)|(B & ~D)|(A & C)|(A & B);
assign out[1] = (~B & ~C)|(B & ~D)|(A & ~D)|(A & B);
assign out[2] = (~B & ~C & D)|(~A & C & ~D)|(A & B);
assign out[3] = (~B & C & ~D)|(B & ~C & D)|(A & B);
assign out[4] = (~A & ~B & ~C & ~D)|(A & B);
assign out[5] = (B & ~C & ~D)|(~B & C & D)|(A & ~D)|(A & B);
assign out[6] = (~A & C & D)|(B)|(A & ~C & ~D);


////////////          DISPLAY 2          ////////////

wire A2,B2,C2,D2;
assign A2 = iSelect[7];
assign B2 = iSelect[6];
assign C2 = iSelect[5];
assign D2 = iSelect[4];

assign out2[0] = (~A2 & ~B2 & D2 )+(B2 & ~D2 )+(A2 & C2)+(A2 & B2);
assign out2[1] = (~B2 & ~C2)+(B2 & ~D2)+(A2 & ~D2)+(A2 & B2);
assign out2[2] = (~B2 & ~C2 & D2)+(~A2 & C2 & ~D2)+( A2 & B2);
assign out2[3] = (~B2 & C2 & ~D2 )+(B2 & ~C2 & D2)+(A2 & B2);
assign out2[4] = (~A2 & ~B2 & ~C2 & ~D2)+(A2 & B2);
assign out2[5] = (B2 & ~C2 & ~D2)+(~B2 & C2 & D2)+(A2 & ~D2)+(A2 & B2);
assign out2[6] = (~A2 & C2 & D2)+(B2)+(A2 & ~C2 & ~D2);

////////////          DISPLAY 3          ////////////

wire AA,BB,CC,DD;	
assign AA = iSelect[11];
assign BB = iSelect[10];
assign CC = iSelect[9];
assign DD = iSelect[8];

assign out3[0] = (~AA & ~BB & DD)+(BB & ~DD)+(AA & CC)+(AA & BB);
assign out3[1] = (~BB & ~CC)+(BB & ~DD)+(AA & ~DD)+(AA & BB);
assign out3[2] = (~BB & ~CC & DD)+(~AA & CC & ~DD)+(AA & BB);
assign out3[3] = (~BB & CC & ~DD)+(BB & ~CC & DD)+(AA & BB);
assign out3[4] = (~AA & ~BB & ~CC & ~DD)+(AA & BB);
assign out3[5] = (BB & ~CC & ~DD)+(~BB & CC & DD)+(AA & ~DD)+(AA & BB);
assign out3[6] = (~AA & CC & DD)+(BB)+(AA & ~CC & ~DD);

////////////////////////////////////////////////////////////////////////

///////////////          SALIDAS DE LOS DISPLAY          ///////////////

////////////////////////////////////////////////////////////////////////

always @(*) begin
		
		
		/*
		0	0	0	0	S
		0	0	0	1	T
		0	0	1	0	P
		0	0	1	1	J
		0	1	0	0	U
		0	1	0	1	M
		0	1	1	0	L
		0	1	1	1	O
		1	0	0	0	W
		1	0	0	1	E
		1	0	1	0	N
		1	0	1	1	D

		*/
		
		// AQUI APARECERA STP = STOP
		if (iComenzar)
			iSelect = 12'b000000010010;
		
		// AQUI APARECERA JMP = JUMP
		else if (iSaltar)
			iSelect = 12'b001101000101;
			
		// AQUI APARECERA LOW = AGACHARSE
		else if (iAgacharse)
			iSelect = 12'b011001111000;
			
		//AQUI APARECERA END = GAME OVER
		else if (iGameOver)
			iSelect = 12'b100110101011;
		else
			iSelect = 12'b111111111111; // Valor por defecto
end

////////////////////////////////////////////////////////////////////////

/////////////     SELECTOR PARA EL CAMBIO DE LAS BASES     /////////////

////////////////////////////////////////////////////////////////////////

reg [2:0] selector;
		always @ (posedge clk_out)
		
	begin 
	if  (selector == 3'b000)
	begin iSegmentos_Display = out; iBase_Segmentos = 3'b110; end
	
	else if (selector == 3'b010)
	begin iSegmentos_Display = out2; iBase_Segmentos = 3'b101; end
	
	else if (selector == 3'b100)
	begin iSegmentos_Display = out3; iBase_Segmentos = 3'b011; end 
	
	selector = selector + 1'b1; // Incrementa el selector
	
end

endmodule
