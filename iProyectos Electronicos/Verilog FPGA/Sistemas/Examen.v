`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:41:29 03/27/2023 
// Design Name: 
// Module Name:    Examen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Examen(
	input clk_in,
	output reg clk_out,  
	output reg clk_outs,  
	output reg iMusicLed, // salida del LED
	input pb, // boton
	input iEncender, // boton
    output reg btn, // Botón de entrada
    output reg iEncendido, // Botón de entrada
    output reg [2:0] estado, // Estado actual de la lavadora
	output reg iLavado_Fast,
	 output reg iEnjuagar_Centrifugar,
    output reg iCentrifugarL,	 
	output reg iSalidaClock, // SEL del reloj 
	output reg iMusic,

	 // Temperatura de agua y tiempo lavado
    input iBoton_Temperatura,
    input iBoton_Tiempo_Lavado,
    output reg [1:0] iEstado_Temp,
    output reg iAgua_Fria,
    output reg iAgua_Caliente,
    output reg iTiempoLavado_1, iTiempoLavado_2, iTiempoLavado_3, iTiempoLavado_4,
    output reg iTiempoCentrifugado_1, iTiempoCentrifugado_2, iTiempoCentrifugado_3, iTiempoCentrifugado_4,
    output reg [3:0] iLed_Temperatura,
    output reg [3:0] iLed_Tiempo_Lavado,
    output reg [3:0] iLed_Tiempo_Centrifugado,
    output reg [3:0] iLed_Segundos_Lavado,
	 
	 // Contador 
	 output LED3, // LEDs para mostrar el contador
	 output LEDMUSIC, // LEDs para mostrar el contador
	 output reg iCLK_Tiempo_1HZ,
    input iBoton_Tiempo,
    input iStart,
    input iPausa,
    output reg [1:0] iEstado_Temp2,
    output reg [1:0] iEstado_Temp1,
    output reg iTiempo_Bajo,
    output reg iTiempo_Medio,
	 output reg iTiempo_Alto,
    output reg iTiempo_FULL,
    //output reg iCentri_1, iCentri_2, iCentri_3, iCentri_4
	 
    output wire iLed_Llenando, 
    output wire iLed_Vaceando, 
    output wire iLed_Motor, 
	 
	 output wire led,
	 output ConteoMusic,
	 output reg iStart_out,
	 
	 // Display.
	 output reg clk_outDisplay, // SALIDA CLK 5HZ
	 output [6:0] out, // Salida Display 1
	 output [6:0] out2, // Salida Display 2
	 output [6:0] out3, // Salida Display 3
	 output reg [14:0] iSelect, // Salida de selección 
	 output reg [9:0] iSelectMusic, // Salida de selección 
	 output reg [2:0] iBase_Segmentos, // Salida de base 
	 output reg [6:0] iSegmentos_Display, // Salida de segmentos
	 output [6:0] iOu1t, // Salida 
	 output reg [2:0] iSelect_2 // Salida de selección 

);

parameter iLavado_Rapido = 2'b00;
parameter iEsjuagarYCentrifugar = 2'b01;
parameter iCentrifugar = 2'b10;

// Variable de estados para saber si el botón fue presionado anteriormente
reg [1:0] state = 2'b00;
reg [1:0] state2 = 2'b00;

reg [2:0] siguiente_estado;

reg [31:0] count;
reg [31:0] counts;
reg [31:0] count5;
reg [31:0] count2;

always @(posedge clk_in) begin
  if (count == 25000000) begin
    clk_out <= ~clk_out;
    count <= 0;
  end else begin
    count <= count + 1;
  end
end


always @(posedge clk_in) begin
  if (iLed_Vaceando == 0 && iLed_Llenando == 0 && iLed_Motor == 0 && bContando == 0 && iStart_out == 0) begin
    if (counts == 454545) begin
      clk_outs <= ~clk_outs;
      counts <= 0;
    end else begin
      counts <= counts + 1;
    end
  end
end

always @(posedge iEncender) begin
    // Si el botón fue presionado por primera vez
    if (state == 2'b00) begin
        iEncendido <= 1;  // Enciende 
        state <= 2'b01;  // Cambia el estado a "presionado una vez"
    end
    // Si el botón fue presionado por segunda vez
    else if (state == 2'b01) begin
        iEncendido <= 0;  // Apaga
        state <= 2'b00;  // Cambia el estado a "no presionado"
    end
end

always @(posedge pb or negedge iEncendido) begin
    if (!iEncendido) begin
        state2 <= 2'b00;
        btn <= 0;
    end else begin
        if (state2 == 2'b00) begin
            if (iEncendido == 1) begin
                btn <= 1; // Enciende
            end else begin
                btn <= 0; // Apaga
            end
            state2 <= 2'b01; // Cambia el estado a "presionado una vez"
        end else if (state2 == 2'b01) begin
            btn <= 0; // Apaga
            state2 <= 2'b00; // Cambia el estado a "no presionado"
        end
    end
end

// Selección de la frecuencia de salida 
always @ (posedge clk_out or negedge iEncender) begin
    if (!iEncender) begin // Si se recibe una señal de reset, establece los valores iniciales
        siguiente_estado <= iLavado_Rapido; // Establece el siguiente estado en iNormal
        estado <= iLavado_Rapido; // Establece el estado actual en iNormal
			iLavado_Fast <= 1'b0;
        iEnjuagar_Centrifugar <= 1'b0;
        iCentrifugarL <= 1'b0;

    end // Fin del bloque if para reset
    else if (iEncendido == 0) begin 
        siguiente_estado <= iLavado_Rapido; 
        estado <= iLavado_Rapido; 
		  iLavado_Fast <= 1'b0;
        iEnjuagar_Centrifugar <= 1'b0;
        iCentrifugarL <= 1'b0;

    end 
    else begin
	if (iEncendido == 1 && btn == 0 && led == 0) begin
            case (estado)
                iLavado_Rapido: begin
                    siguiente_estado <= iEsjuagarYCentrifugar;
						  iLavado_Fast <= 1'b1;
						  iEnjuagar_Centrifugar <= 1'b0;
						  iCentrifugarL <= 1'b0;
                end
                iEsjuagarYCentrifugar: begin
                    siguiente_estado <= iCentrifugar;
						  iLavado_Fast <= 1'b0;
						  iEnjuagar_Centrifugar <= 1'b1;
						  iCentrifugarL <= 1'b0;
                end
                iCentrifugar: begin
                    siguiente_estado <= iLavado_Rapido;
						  iLavado_Fast <= 1'b0;
						  iEnjuagar_Centrifugar <= 1'b0;
						  iCentrifugarL <= 1'b1;
						end
                default: begin
                    siguiente_estado <= iLavado_Rapido;
                end
            endcase
        end
        else begin
            siguiente_estado <= estado;
        end
        estado <= siguiente_estado;
    end
end


reg [1:0] state_Temperatura;
always @(posedge iBoton_Temperatura or negedge iEncender) begin
    if (!iEncender || iCentrifugarL) begin
        state_Temperatura <= 2'd0;
        iLed_Temperatura <= 4'b0000;
        iAgua_Fria <= 1'b0;
        iAgua_Caliente <= 1'b0;
    end else if (btn == 1  && iEncendido == 1 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 ) && led == 0) begin
        state_Temperatura <= state_Temperatura + 1;
        case (state_Temperatura)
            2'd0: begin
                iLed_Temperatura <= 4'b0001; // Caliente
                iAgua_Fria <= 1'b0; // LED de llave
                iAgua_Caliente <= 1'b1; // LLave caliente
            end
            2'd1: begin
                iLed_Temperatura <= 4'b0010; // Frio
                iAgua_Fria <= 1'b1; // LED de llave
                iAgua_Caliente <= 1'b0; // LLave caliente
            end
            2'd2: begin
                iLed_Temperatura <= 4'b0100; // Tibia
                iAgua_Fria <= 1'b0; // LED de llave
                iAgua_Caliente <= 1'b1; // LLave caliente
            end
            2'd3: begin
                iLed_Temperatura <= 4'b1000; // Ambiente
                iAgua_Fria <= 1'b1; // LED de llave
                iAgua_Caliente <= 1'b1; // LLave caliente
            end
        endcase
    end
end


reg [1:0] iState_Tiempo_Lavado;
always @(posedge iBoton_Tiempo_Lavado or negedge iEncender) begin
    if (!iEncender || iCentrifugarL) begin
        iState_Tiempo_Lavado <= 2'd0;
        iLed_Tiempo_Lavado <= 4'b0000;
        iTiempoLavado_1 <= 1'b0;
        iTiempoLavado_2 <= 1'b0;
		  iTiempoLavado_3 <= 1'b0;
        iTiempoLavado_4 <= 1'b0;
    end else if (btn == 1  && iEncendido == 1 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
        iState_Tiempo_Lavado <= iState_Tiempo_Lavado + 1;
        case (iState_Tiempo_Lavado)
            2'd0: begin
                iLed_Tiempo_Lavado <= 4'b0001; // Primer tiempo
                iTiempoLavado_1 <= 1'b1; // Tiempo 1  = 
                iTiempoLavado_2 <= 1'b0; // Tiempo 2  = 
					 iTiempoLavado_3 <= 1'b0;
					iTiempoLavado_4 <= 1'b0;
            end
            2'd1: begin
                iLed_Tiempo_Lavado <= 4'b0010; // Segundo tiempo
                iTiempoLavado_1 <= 1'b0; // Tiempo 1  = 
                iTiempoLavado_2 <= 1'b1; // Tiempo 2  = 
					 iTiempoLavado_3 <= 1'b0;
						iTiempoLavado_4 <= 1'b0;
            end
            2'd2: begin
                iLed_Tiempo_Lavado <= 4'b0100; // Cuarto tiempo
                iTiempoLavado_1 <= 1'b0; // Tiempo 1  = 
                iTiempoLavado_2 <= 1'b0; // Tiempo 2  = 
					 iTiempoLavado_3 <= 1'b1;
					iTiempoLavado_4 <= 1'b0;
            end
            2'd3: begin
                iLed_Tiempo_Lavado <= 4'b1000; // Quinto tiempo
                iTiempoLavado_1 <= 1'b0; // Tiempo 1  = 
                iTiempoLavado_2 <= 1'b0; // Tiempo 2  = 
					 iTiempoLavado_3 <= 1'b0;
					iTiempoLavado_4 <= 1'b1;
            end
        endcase
    end
end


reg [1:0] iState_Segundos_Lavado;
always @(posedge iBoton_Tiempo or negedge iEncender) begin
    if (!iEncender || iCentrifugarL == 1) begin
        iState_Segundos_Lavado <= 2'd0;
        iLed_Segundos_Lavado <= 4'b0000;
        iTiempo_Bajo <= 1'b0;
        iTiempo_Medio <= 1'b0;
		  iTiempo_Alto <= 1'b0;
        iTiempo_FULL <= 1'b0;
    end else if (btn == 1  && iEncendido == 1 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
        iState_Segundos_Lavado <= iState_Segundos_Lavado + 1;
        case (iState_Segundos_Lavado)
            2'd0: begin
                iLed_Segundos_Lavado <= 4'b0001; // Primer tiempo
                iTiempo_Bajo <= 1'b1; // Tiempo 1  = 
                iTiempo_Medio <= 1'b0; // Tiempo 2  = 
					 iTiempo_Alto <= 1'b0;
					iTiempo_FULL <= 1'b0;
            end
            2'd1: begin
                iLed_Segundos_Lavado <= 4'b0010; // Segundo tiempo
                iTiempo_Bajo <= 1'b0; // Tiempo 1  = 
                iTiempo_Medio <= 1'b1; // Tiempo 2  = 
					 iTiempo_Alto <= 1'b0;
						iTiempo_FULL <= 1'b0;
            end
            2'd2: begin
                iLed_Segundos_Lavado <= 4'b0100; // Cuarto tiempo
                iTiempo_Bajo <= 1'b0; // Tiempo 1  = 
                iTiempo_Medio <= 1'b0; // Tiempo 2  = 
					 iTiempo_Alto <= 1'b1;
					iTiempo_FULL <= 1'b0;
            end
            2'd3: begin
                iLed_Segundos_Lavado <= 4'b1000; // Quinto tiempo
                iTiempo_Bajo <= 1'b0; // Tiempo 1  = 
                iTiempo_Medio <= 1'b0; // Tiempo 2  = 
					 iTiempo_Alto <= 1'b0;
					iTiempo_FULL <= 1'b1;
            end
        endcase
    end
end
reg [1:0] iConteo_Tiempo_LH;
reg [3:0] iPulso_Tiempo2;
reg iBoton_Tiempo_stable;
	
assign led = !iStart_out;

/*////////////////////////////////////////////////////////////////////////////////////////////

                                          CONTADORES 

///////////////////////////////////////////////////////////////////////////////////////////*/

reg previousState;
always @(posedge iStart) begin
    if (previousState == 2'b00) begin
      iStart_out <= 1'b1;
      previousState <= 2'b01;
    end else if (previousState == 2'b01) begin
      iStart_out <= 1'b0;
      previousState <= 2'b10;
    end else begin
      iStart_out <= 1'b1;
      previousState <= 2'b01;
    end
  end

/*
reg [36:0] iConteo_Tiempo_CLK = 0;

always @(posedge clk_in) begin
  if (iLavado_Fast == 1) begin
    if (iConteo_Tiempo_CLK == 40000000) begin // 100MHz/5Hz = 10000000
      iConteo_Tiempo_CLK <= 0;
      iCLK_Tiempo_1HZ <= ~iCLK_Tiempo_1HZ;
    end
    else begin
      iConteo_Tiempo_CLK <= iConteo_Tiempo_CLK + 1;
    end
  end else begin
    if (iConteo_Tiempo_CLK ==  10000000) begin // 100MHz/60Hz = 1666666
      iConteo_Tiempo_CLK <= 0;
      iCLK_Tiempo_1HZ <= ~iCLK_Tiempo_1HZ;
    end
    else begin
      iConteo_Tiempo_CLK <= iConteo_Tiempo_CLK + 1;
    end
  end
end
*/

reg [23:0] iCount_Frecuencias; // contador de frecuencia

always @(posedge clk_in or posedge iPausa) begin
    // Verificar si el botón de pausa está presionado
    if (iPausa) begin
      // Detener el reloj del sistema y mantener las salidas actuales
      iCount_Frecuencias <= iCount_Frecuencias;
      iCLK_Tiempo_1HZ <= iCLK_Tiempo_1HZ;
    end else begin
      // Si iLavado_Fast es 1, la frecuencia de salida es 15Hz
      if (iLavado_Fast == 1'b1) begin
        if (iCount_Frecuencias < 666666) begin // 100MHz / 15Hz = 666666
          iCount_Frecuencias <= iCount_Frecuencias + 1;
        end else begin
          iCount_Frecuencias <= 0;
          iCLK_Tiempo_1HZ <= ~iCLK_Tiempo_1HZ;
        end
      end
      // Si iEnjuagar_Centrifugar es 1, la frecuencia de salida es 3Hz
      else if (iEnjuagar_Centrifugar == 1'b1) begin
        if (iCount_Frecuencias < 3333333) begin // 100MHz / 3Hz = 3333333
          iCount_Frecuencias <= iCount_Frecuencias + 1;
        end else begin
          iCount_Frecuencias <= 0;
          iCLK_Tiempo_1HZ <= ~iCLK_Tiempo_1HZ;
        end
      end
      // Si ninguna de las variables es 1, el clk de salida se mantiene en 0
      else begin
        iCLK_Tiempo_1HZ <= 0;
        iCount_Frecuencias <= 0;
      end
    end
  end

reg [8:0] iConteo_Tiempo_Llenado = 9'd0; // inicializar en 0

reg bContando; // bandera para indicar si se está contando

always @(posedge iCLK_Tiempo_1HZ, negedge iEncender) begin
    if (!iEncender ||  iCentrifugarL == 1 || iEncendido == 0) begin
        iConteo_Tiempo_Llenado <= 9'd0; // resetear el contador a 
        bContando <= 0; // resetear la bandera al reiniciar el contador
    end else begin
	 
	 ///////////////////////////////////////////////////                   PRIMER TIEMPO                 ///////////////////////////
	 
        if (iTiempo_Bajo == 1 && iTiempoLavado_1 == 1 && led == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd162; // 5 sg TIEMPO BAJO + 150 sg tiempo 1 + 5 sg tiempo bajo para vacear
        end 
		  else 
		  if (iTiempo_Bajo == 1 && iTiempoLavado_2 == 1 && led == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd212; //   
            bContando <= 1; //   
        end 
		  else 
		  if (iTiempo_Bajo == 1 && iTiempoLavado_3 == 1 && led == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd282; //   
            bContando <= 1; //   
        end 
		  else 
		  if (iTiempo_Bajo == 1 && iTiempoLavado_4 == 1 && led == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd388; //   
            bContando <= 1; //   
        end 
		  else 
	///////////////////////////////////////////////////                   SEGUNDO TIEMPO                 ///////////////////////////
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 1 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 0 && led == 0 && iTiempo_Medio == 1 && iTiempo_Alto == 0 && iTiempo_FULL == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd168; // Conteo
            bContando <= 1;
        end 
		  else 
		   if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 1 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 0  && led == 0 && iTiempo_Medio == 1 && iTiempo_Alto == 0 && iTiempo_FULL == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd218; // Conteo
            bContando <= 1;
        end 
		  else 
		   if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 1 && iTiempoLavado_4 == 0 && led == 0 && iTiempo_Medio == 1 && iTiempo_Alto == 0 && iTiempo_FULL == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd288; // Conteo
            bContando <= 1;
        end 
		  else 
		   if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 1 && led == 0 && iTiempo_Medio == 1 && iTiempo_Alto == 0 && iTiempo_FULL == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd394; // Conteo
            bContando <= 1;
        end 
		  else 
	///////////////////////////////////////////////////                   TERCER TIEMPO                 ///////////////////////////
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 1 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 0  && led == 0 && iTiempo_Medio == 0 && iTiempo_Alto == 1 && iTiempo_FULL == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd176; // contar del 9 al 0 en binario
            bContando <= 1;
        end 
		  else
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 1 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 0  && led == 0 && iTiempo_Medio == 0 && iTiempo_Alto == 1 && iTiempo_FULL == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd226; // contar del 9 al 0 en binario
            bContando <= 1;
        end 
		  else
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 1 && iTiempoLavado_4 == 0  && led == 0 && iTiempo_Medio == 0 && iTiempo_Alto == 1 && iTiempo_FULL == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd296; // contar del 9 al 0 en binario
            bContando <= 1;
        end 
		  else
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 1  && led == 0 && iTiempo_Medio == 0 && iTiempo_Alto == 1 && iTiempo_FULL == 0 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd402; // contar del 9 al 0 en binario
            bContando <= 1;
        end 
		  else
	///////////////////////////////////////////////////                   CUARTO TIEMPO                 ///////////////////////////
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 1 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 0  && led == 0 && iTiempo_Medio == 0 && iTiempo_Alto == 0 && iTiempo_FULL == 1 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd182; // contar del 15 al 0 en binario
            bContando <= 1;
		  end 
		  else 
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 1 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 0  && led == 0 && iTiempo_Medio == 0 && iTiempo_Alto == 0 && iTiempo_FULL == 1 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd232; // contar del 15 al 0 en binario
            bContando <= 1;
		  end 
		  else 
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 1 && iTiempoLavado_4 == 0  && led == 0 && iTiempo_Medio == 0 && iTiempo_Alto == 0 && iTiempo_FULL == 1 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd302; // contar del 15 al 0 en binario
            bContando <= 1;
		  end 
		  else 
		  if (iTiempo_Bajo == 0 && iTiempoLavado_1 == 0 && iTiempoLavado_2 == 0 && iTiempoLavado_3 == 0 && iTiempoLavado_4 == 1  && led == 0 && iTiempo_Medio == 0 && iTiempo_Alto == 0 && iTiempo_FULL == 1 && ( iLavado_Fast == 1 || iEnjuagar_Centrifugar == 1 )) begin
            iConteo_Tiempo_Llenado <= 9'd407; // contar del 15 al 0 en binario
            bContando <= 1;
        end 
		  else 
		  begin
            if (bContando == 1 && iConteo_Tiempo_Llenado != 0) begin // si ya se está contando y el contador no está en 0, continuar contando
                iConteo_Tiempo_Llenado <= iConteo_Tiempo_Llenado - 1;
            end else begin // si no se está contando o el contador está en 0, no hacer nada
                iConteo_Tiempo_Llenado <= 9'd0;
                bContando <= 0;
            end
        end
    end
end

assign LED3 = bContando;
assign iLed_Llenando = ((iConteo_Tiempo_Llenado > 9'd157 && bContando == 1 && iPausa == 0 && iTiempo_Bajo == 1 && iTiempoLavado_1 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd207 && bContando == 1 && iPausa == 0 && iTiempo_Bajo == 1 && iTiempoLavado_2 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd277 && bContando == 1 && iPausa == 0 && iTiempo_Bajo == 1 && iTiempoLavado_3 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd383 && bContando == 1 && iPausa == 0 && iTiempo_Bajo == 1 && iTiempoLavado_4 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd160 && bContando == 1 && iPausa == 0 && iTiempo_Medio == 1 && iTiempoLavado_1 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd210 && bContando == 1 && iPausa == 0 && iTiempo_Medio == 1 && iTiempoLavado_2 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd280 && bContando == 1 && iPausa == 0 && iTiempo_Medio == 1 && iTiempoLavado_3 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd386 && bContando == 1 && iPausa == 0 && iTiempo_Medio == 1 && iTiempoLavado_4 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd164 && bContando == 1 && iPausa == 0 && iTiempo_Alto == 1 && iTiempoLavado_1 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd214 && bContando == 1 && iPausa == 0 && iTiempo_Alto == 1 && iTiempoLavado_2 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd284 && bContando == 1 && iPausa == 0 && iTiempo_Alto == 1 && iTiempoLavado_3 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd390 && bContando == 1 && iPausa == 0 && iTiempo_Alto == 1 && iTiempoLavado_4 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd167 && bContando == 1 && iPausa == 0 && iTiempo_FULL == 1 && iTiempoLavado_1 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd217 && bContando == 1 && iPausa == 0 && iTiempo_FULL == 1 && iTiempoLavado_2 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd287 && bContando == 1 && iPausa == 0 && iTiempo_FULL == 1 && iTiempoLavado_3 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0) ||
(iConteo_Tiempo_Llenado > 9'd392 && bContando == 1 && iPausa == 0 && iTiempo_FULL == 1 && iTiempoLavado_4 == 1 && iStart_out == 0 && iConteo_Tiempo_Llenado != 9'd0));

assign iLed_Vaceando = ((iConteo_Tiempo_Llenado <= 9'd7 && bContando == 1 && iStart_out == 0 && iPausa == 0 && iTiempo_Bajo == 1 && (iTiempoLavado_1 == 1||iTiempoLavado_2== 1||iTiempoLavado_3== 1||iTiempoLavado_4== 1)) && (iConteo_Tiempo_Llenado != 9'd0)) ||
((iConteo_Tiempo_Llenado <= 9'd10 && bContando == 1 && iStart_out == 0 && iPausa == 0 && iTiempo_Medio == 1 && (iTiempoLavado_1 == 1||iTiempoLavado_2== 1||iTiempoLavado_3== 1||iTiempoLavado_4== 1)) && (iConteo_Tiempo_Llenado != 9'd0)) ||
((iConteo_Tiempo_Llenado <= 9'd14 && bContando == 1 && iStart_out == 0 && iPausa == 0 && iTiempo_Alto == 1 && (iTiempoLavado_1 == 1||iTiempoLavado_2== 1||iTiempoLavado_3== 1||iTiempoLavado_4== 1)) && (iConteo_Tiempo_Llenado != 9'd0)) ||
((iConteo_Tiempo_Llenado <= 9'd17 && bContando == 1 && iStart_out == 0 && iPausa == 0 && iTiempo_FULL == 1 && (iTiempoLavado_1 == 1||iTiempoLavado_2== 1||iTiempoLavado_3== 1||iTiempoLavado_4== 1)) && (iConteo_Tiempo_Llenado != 9'd0));

assign iLed_Motor = bContando == 1 && iLed_Llenando == 0 && iLed_Vaceando == 0 && iStart_out == 0 && iPausa == 0;

// Señales para la conversión BCD a 7seg
assign A = iSelect[4];
assign B = iSelect[3];
assign C = iSelect[2];
assign D = iSelect[1];
assign E = iSelect[0];

// Conversión BCD a 7seg
assign out[0] = (~B*~C*~D*E)|(C*~D*~E)|(B*~C*D)|(A)|(B*C*~E);
assign out[1] = (C*~D*E)|(~B*C*D*~E)|(B*C*~D)|(B*~C*D)|(A);
assign out[2] = (~C*D*~E)|(B*C*~D)|(A)|(B*D*E);
assign out[3] = (C*~D*~E)|(~C*~D*E)|(C*D*E)|(A)|(B*~C*E);
assign out[4] = (C*~D*~E)|(~C*~D*E)|(~B*E)|(A);
assign out[5] = (~B*~C*E)|(~B*~C*D)|(B*C*~E)|(~C*D*E)|(~B*D*E)|(A);
assign out[6] = (B*C*~D*~E)|(~B*C*D*E)|(~B*~C*~D)|(A);

assign A2 = iSelect[9];
assign B2 = iSelect[8];
assign C2 = iSelect[7];
assign D2 = iSelect[6];
assign E2 = iSelect[5];

assign out2[0] = (~B2*~C2*~D2*E2)|(C2*~D2*~E2)|(B2*~C2*D2)|(A2)|(B2*C2*~E2);
assign out2[1] = (C2*~D2*E2)|(~B2*C2*D2*~E2)|(B2*C2*~D2)|(B2*~C2*D2)|(A2);
assign out2[2] = (~C2*D2*~E2)|(B2*C2*~D2)|(A2)|(B2*D2*E2);
assign out2[3] = (C2*~D2*~E2)|(~C2*~D2*E2)|(C2*D2*E2)|(A2)|(B2*~C2*E2);
assign out2[4] = (C2*~D2*~E2)|(~C2*~D2*E2)|(~B2*E2)|(A2);
assign out2[5] = (~B2*~C2*E2)|(~B2*~C2*D2)|(B2*C2*~E2)|(~C2*D2*E2)|(~B2*D2*E2)|(A2);
assign out2[6] = (B2*C2*~D2*~E2)|(~B2*C2*D2*E2)|(~B2*~C2*~D2)|(A2);

assign A23 = iSelect[14];
assign B23 = iSelect[13];
assign C23 = iSelect[12];
assign D23 = iSelect[11];
assign E23 = iSelect[10];

assign out3[0] = (~B23*~C23*~D23*E23)|(C23*~D23*~E23)|(B23*~C23*D23)|(A23)|(B23*C23*~E23);
assign out3[1] = (C23*~D23*E23)|(~B23*C23*D23*~E23)|(B23*C23*~D23)|(B23*~C23*D23)|(A23);
assign out3[2] = (~C23*D23*~E23)|(B23*C23*~D23)|(A23)|(B23*D23*E23);
assign out3[3] = (C23*~D23*~E23)|(~C23*~D23*E23)|(C23*D23*E23)|(A23)|(B23*~C23*E23);
assign out3[4] = (C23*~D23*~E23)|(~C23*~D23*E23)|(~B23*E23)|(A23);
assign out3[5] = (~B23*~C23*E23)|(~B23*~C23*D23)|(B23*C23*~E23)|(~C23*D23*E23)|(~B23*D23*E23)|(A23);
assign out3[6] = (B23*C23*~D23*~E23)|(~B23*C23*D23*E23)|(~B23*~C23*~D23)|(A23);

always @ (*) begin
    if (!btn) begin
        iSelect = 15'b100001000010000; // APAGADO
    end else 
	 if (iPausa) begin
        iSelect = 15'b001010101001001; // APAGADO
    end else begin
        case (iConteo_Tiempo_Llenado)
				9'b000000000 : iSelect = 15'b001010101001011;  // APAGADO
				9'b000000001 : iSelect = 15'b000000000000000; // END
				9'b000000010 : iSelect = 15'b000000000000000; // 0
				9'b000000011 : iSelect = 15'b000000000000001;// 1
				9'b000000100 : iSelect = 15'b000000000000010; // 2
				9'b000000101 : iSelect = 15'b000000000000011; // 3
				9'b000000110 : iSelect = 15'b000000000000100; // 4
				9'b000000111 : iSelect = 15'b000000000000101; // 5
				9'b000001000 : iSelect = 15'b000000000000110; // 6
				9'b000001001 : iSelect = 15'b000000000000111; // 7
				9'b000001010 : iSelect = 15'b000000000001000; // 8
				9'b000001011 : iSelect = 15'b000000000001001; // 9
				9'b000001100 : iSelect = 15'b000000000100000;// 10
				9'b000001101 : iSelect = 15'b000000000100001;// 11
				9'b000001110 : iSelect = 15'b000000000100010; // 12
				9'b000001111 : iSelect = 15'b000000000100011; // 13
				9'b000010000 : iSelect = 15'b000000000100100; // 14
				9'b000010001 : iSelect = 15'b000000000100101; // 15
				9'b000010010 : iSelect = 15'b000000000100110; // 16
				9'b000010011 : iSelect = 15'b000000000100111; // 17
				9'b000010100 : iSelect = 15'b000000000101000; // 18
				9'b000010101 : iSelect = 15'b000000000101001; // 19
				9'b000010110 : iSelect = 15'b000000001000000; // 20
				9'b000010111 : iSelect = 15'b000000001000001; // 21
				9'b000011000 : iSelect = 15'b000000001000010; // 22
				9'b000011001 : iSelect = 15'b000000001000011; // 23
				9'b000011010 : iSelect = 15'b000000001000100; // 24
				9'b000011011 : iSelect = 15'b000000001000101; // 25
				9'b000011100 : iSelect = 15'b000000001000110; // 26
				9'b000011101 : iSelect = 15'b000000001000111; // 27
				9'b000011110 : iSelect = 15'b000000001001000; // 28
				9'b000011111 : iSelect = 15'b000000001001001; // 29
				9'b000100000 : iSelect = 15'b000000001100000; // 30
				9'b000100001 : iSelect = 15'b000000001100001;// 31
				9'b000100010 : iSelect = 15'b000000001100010;// 32
				9'b000100011 : iSelect = 15'b000000001100011;// 33
				9'b000100100 : iSelect = 15'b000000001100100;// 34
				9'b000100101 : iSelect = 15'b000000001100101;// 35
				9'b000100110 : iSelect = 15'b000000001100110;// 36
				9'b000100111 : iSelect = 15'b000000001100111;// 37
				9'b000101000 : iSelect = 15'b000000001101000;// 38
				9'b000101001 : iSelect = 15'b000000001101001;// 39
				9'b000101010 : iSelect = 15'b000000010000000;// 40
				9'b000101011 : iSelect = 15'b000000010000001;// 41
				9'b000101100 : iSelect = 15'b000000010000010;// 42
				9'b000101101 : iSelect = 15'b000000010000011;// 43
				9'b000101110 : iSelect = 15'b000000010000100;// 44
				9'b000101111 : iSelect = 15'b000000010000101;// 45
				9'b000110000 : iSelect = 15'b000000010000110;// 46
				9'b000110001 : iSelect = 15'b000000010000111;// 47
				9'b000110010 : iSelect = 15'b000000010001000;// 48
				9'b000110011 : iSelect = 15'b000000010001001;// 49
				9'b000110100 : iSelect = 15'b000000010100000;// 50
				9'b000110101 : iSelect = 15'b000000010100001;// 51
				9'b000110110 : iSelect = 15'b000000010100010;// 52
				9'b000110111 : iSelect = 15'b000000010100011;// 53
				9'b000111000 : iSelect = 15'b000000010100100;// 54
				9'b000111001 : iSelect = 15'b000000010100101;// 55
				9'b000111010 : iSelect = 15'b000000010100110;// 56
				9'b000111011 : iSelect = 15'b000000010100111;// 57
				9'b000111100 : iSelect = 15'b000000010101000;// 58
				9'b000111101 : iSelect = 15'b000000010101001;// 59
				9'b000111110 : iSelect = 15'b000000011000000;// 60
				9'b000111111 : iSelect = 15'b000000011000001;// 61
				9'b001000000 : iSelect = 15'b000000011000010;// 62
				9'b001000001 : iSelect = 15'b000000011000011;// 63
				9'b001000010 : iSelect = 15'b000000011000100; // 64
				9'b001000011 : iSelect = 15'b000000011000101;// 65
				9'b001000100 : iSelect = 15'b000000011000110;// 66
				9'b001000101 : iSelect = 15'b000000011000111;// 67
				9'b001000110 : iSelect = 15'b000000011001000;// 68
				9'b001000111 : iSelect = 15'b000000011001001;// 69
				9'b001001000 : iSelect = 15'b000000011100000;// 70
				9'b001001001 : iSelect = 15'b000000011100001;// 71
				9'b001001010 : iSelect = 15'b000000011100010;// 72
				9'b001001011 : iSelect = 15'b000000011100011;// 73
				9'b001001100 : iSelect = 15'b000000011100100;// 74
				9'b001001101 : iSelect = 15'b000000011100101;// 75
				9'b001001110 : iSelect = 15'b000000011100110;// 76
				9'b001001111 : iSelect = 15'b000000011100111;// 77
				9'b001010000 : iSelect = 15'b000000011101000;// 78
				9'b001010001 : iSelect = 15'b000000011101001;// 79
				9'b001010010 : iSelect = 15'b000000100000000;// 80;
				9'b001010011 : iSelect = 15'b000000100000001;// 81
				9'b001010100 : iSelect = 15'b000000100000010;// 82
				9'b001010101 : iSelect = 15'b000000100000011;// 83
				9'b001010110 : iSelect = 15'b000000100000100;// 84
				9'b001010111 : iSelect = 15'b000000100000101;// 85
				9'b001011000 : iSelect = 15'b000000100000110;// 86
				9'b001011001 : iSelect = 15'b000000100000111;// 87
				9'b001011010 : iSelect = 15'b000000100001000;// 88
				9'b001011011 : iSelect = 15'b000000100001001;// 89
				9'b001011100 : iSelect = 15'b000000100100000;// 90;
				9'b001011101 : iSelect = 15'b000000100100001;// 91
				9'b001011110 : iSelect = 15'b000000100100010;// 92
				9'b001011111 : iSelect = 15'b000000100100011;// 93
				9'b001100000 : iSelect = 15'b000000100100100;// 94
				9'b001100001 : iSelect = 15'b000000100100101;// 95
				9'b001100010 : iSelect = 15'b000000100100110;// 96
				9'b001100011 : iSelect = 15'b000000100100111;// 97
				9'b001100100 : iSelect = 15'b000000100101000;// 98
				9'b001100101 : iSelect = 15'b000000100101001;// 99
				9'b001100110 : iSelect = 15'b000010000000000;// 100
				9'b001100111 : iSelect = 15'b000010000000001;// 101
				9'b001101000 : iSelect = 15'b000010000000010;// 102
				9'b001101001 : iSelect = 15'b000010000000011;// 103
				9'b001101010 : iSelect = 15'b000010000000100;// 104
				9'b001101011 : iSelect = 15'b000010000000101;// 105
				9'b001101100 : iSelect = 15'b000010000000110;// 106
				9'b001101101 : iSelect = 15'b000010000000111;//  107
				9'b001101110 : iSelect = 15'b000010000001000;// 108
				9'b001101111 : iSelect = 15'b000010000001001;// 109
				9'b001110000 : iSelect = 15'b000010000100000;// 110
				9'b001110001 : iSelect = 15'b000010000100001;// 111
				9'b001110010 : iSelect = 15'b000010000100010;// 112
				9'b001110011 : iSelect = 15'b000010000100011;// 113
				9'b001110100 : iSelect = 15'b000010000100100;// 114
				9'b001110101 : iSelect = 15'b000010000100101;// 115
				9'b001110110 : iSelect = 15'b000010000100110;// 116
				9'b001110111 : iSelect = 15'b000010000100111;// 117
				9'b001111000 : iSelect = 15'b000010000101000;// 118
				9'b001111001 : iSelect = 15'b000010000101001;// 119
				9'b001111010 : iSelect = 15'b000010001000000;// 120
				9'b001111011 : iSelect = 15'b000010001000001;// 121
				9'b001111100 : iSelect = 15'b000010001000010;// 122
				9'b001111101 : iSelect = 15'b000010001000011;// 123
				9'b001111110 : iSelect = 15'b000010001000100;// 124
				9'b001111111 : iSelect = 15'b000010001000101;// 125
				9'b010000000 : iSelect = 15'b000010001000110;// 126
				9'b010000001 : iSelect = 15'b000010001000111;// 127
				9'b010000010 : iSelect = 15'b000010001001000;// 128
				9'b010000011 : iSelect = 15'b000010001001001;// 129
				9'b010000100 : iSelect = 15'b000010001100000;// 130
				9'b010000101 : iSelect = 15'b000010001100001;// 131
				9'b010000110 : iSelect = 15'b000010001100010;// 132
				9'b010000111 : iSelect = 15'b000010001100011;// 133
				9'b010001000 : iSelect = 15'b000010001100100;// 134
				9'b010001001 : iSelect = 15'b000010001100101;// 135
				9'b010001010 : iSelect = 15'b000010001100110;// 136
				9'b010001011 : iSelect = 15'b000010001100111;// 137
				9'b010001100 : iSelect = 15'b000010001101000;// 138
				9'b010001101 : iSelect = 15'b000010001101001;// 139
				9'b010001110 : iSelect = 15'b000010010000000;// 140
				9'b010001111 : iSelect = 15'b000010010000001;// 141
				9'b010010000 : iSelect = 15'b000010010000010;// 142
				9'b010010001 : iSelect = 15'b000010010000011;// 143
				9'b010010010 : iSelect = 15'b000010010000100;// 144
				9'b010010011 : iSelect = 15'b000010010000101;// 145
				9'b010010100 : iSelect = 15'b000010010000110;// 146
				9'b010010101 : iSelect = 15'b000010010000111;// 147
				9'b010010110 : iSelect = 15'b000010010001000;// 148
				9'b010010111 : iSelect = 15'b000010010001001;// 149
				9'b010011000 : iSelect = 15'b000010010100000;// 150
				9'b010011001 : iSelect = 15'b000010010100001;// 151
				9'b010011010 : iSelect = 15'b000010010100010;// 152
				9'b010011011 : iSelect = 15'b000010010100011;// 153
				9'b010011100 : iSelect = 15'b000010010100100;// 154
				9'b010011101 : iSelect = 15'b000010010100101;// 155
				9'b010011110 : iSelect = 15'b000010010100110;// 156
				9'b010011111 : iSelect = 15'b000010010100111;// 157
				9'b010100000 : iSelect = 15'b000010010101000;// 158
				9'b010100001 : iSelect = 15'b000010010101001;// 159
				9'b010100010 : iSelect = 15'b000010011000000;// 160
				9'b010100011 : iSelect = 15'b000010011000001;// 161
				9'b010100100 : iSelect = 15'b000010011000010;// 162
				9'b010100101 : iSelect = 15'b000010011000011;// 163
				9'b010100110 : iSelect = 15'b000010011000100;// 164
				9'b010100111 : iSelect = 15'b000010011000101;// 165
				9'b010101000 : iSelect = 15'b000010011000110;// 166
				9'b010101001 : iSelect = 15'b000010011000111;// 167
				9'b010101010 : iSelect = 15'b000010011001000;// 168
				9'b010101011 : iSelect = 15'b000010011001001;// 169
				9'b010101100 : iSelect = 15'b000010011100000;// 170
				9'b010101101 : iSelect = 15'b000010011100001;// 171
				9'b010101110 : iSelect = 15'b000010011100010;// 172
				9'b010101111 : iSelect = 15'b000010011100011;// 173
				9'b010110000 : iSelect = 15'b000010011100100;// 174
				9'b010110001 : iSelect = 15'b000010011100101;// 175
				9'b010110010 : iSelect = 15'b000010011100110;// 176
				9'b010110011 : iSelect = 15'b000010011100111;// 177
				9'b010110100 : iSelect = 15'b000010011101000;// 178
				9'b010110101 : iSelect = 15'b000010011101001;// 179
				9'b010110110 : iSelect = 15'b000010100000000;// 180
				9'b010110111 : iSelect = 15'b000010100000001;// 181
				9'b010111000 : iSelect = 15'b000010100000010;// 182
				9'b010111001 : iSelect = 15'b000010100000011;// 183
				9'b010111010 : iSelect = 15'b000010100000100;// 184
				9'b010111011 : iSelect = 15'b000010100000101;// 185
				9'b010111100 : iSelect = 15'b000010100000110;// 186
				9'b010111101 : iSelect = 15'b000010100000111;// 187
				9'b010111110 : iSelect = 15'b000010100001000;// 188
				9'b010111111 : iSelect = 15'b000010100001001;// 189
				9'b011000000 : iSelect = 15'b000010100100000;// 190
				9'b011000001 : iSelect = 15'b000010100100001;// 191
				9'b011000010 : iSelect = 15'b000010100100010;// 192
				9'b011000011 : iSelect = 15'b000010100100011;// 3
				9'b011000100 : iSelect = 15'b000010100100100;// 4
				9'b011000101 : iSelect = 15'b000010100100101;// 5
				9'b011000110 : iSelect = 15'b000010100100110;// 6
				9'b011000111 : iSelect = 15'b000010100100111;// 7
				9'b011001000 : iSelect = 15'b000010100101000;// 8
				9'b011001001 : iSelect = 15'b000010100101001;// 9
				9'b011001010 : iSelect = 15'b000100000000000;// 200
				9'b011001011 : iSelect = 15'b000100000000001;// 1
				9'b011001100 : iSelect = 15'b000100000000010;// 2
				9'b011001101 : iSelect = 15'b000100000000011;// 3
				9'b011001110 : iSelect = 15'b000100000000100;// 4
				9'b011001111 : iSelect = 15'b000100000000101;// 5
				9'b011010000 : iSelect = 15'b000100000000110;// 6
				9'b011010001 : iSelect = 15'b000100000000111;// 7
				9'b011010010 : iSelect = 15'b000100000001000;// 8
				9'b011010011 : iSelect = 15'b000100000001001;// 9
				9'b011010100 : iSelect = 15'b000100000100000;// 210
				9'b011010101 : iSelect = 15'b000100000100001;// 1
				9'b011010110 : iSelect = 15'b000100000100010;// 2
				9'b011010111 : iSelect = 15'b000100000100011;// 3
				9'b011011000 : iSelect = 15'b000100000100100;// 4
				9'b011011001 : iSelect = 15'b000100000100101;// 5
				9'b011011010 : iSelect = 15'b000100000100110;// 6
				9'b011011011 : iSelect = 15'b000100000100111;// 7
				9'b011011100 : iSelect = 15'b000100000101000;// 8
				9'b011011101 : iSelect = 15'b000100000101001;// 9
				9'b011011110 : iSelect = 15'b000100001000000;// 220
				9'b011011111 : iSelect = 15'b000100001000001;// 1
				9'b011100000 : iSelect = 15'b000100001000010;// 2
				9'b011100001 : iSelect = 15'b000100001000011;// 3
				9'b011100010 : iSelect = 15'b000100001000100;// 4
				9'b011100011 : iSelect = 15'b000100001000101;// 5
				9'b011100100 : iSelect = 15'b000100001000110;// 6
				9'b011100101 : iSelect = 15'b000100001000111;// 7
				9'b011100110 : iSelect = 15'b000100001001000;// 8
				9'b011100111 : iSelect = 15'b000100001001001;// 9
				9'b011101000 : iSelect = 15'b000100001100000;// 230
				9'b011101001 : iSelect = 15'b000100001100001;// 1
				9'b011101010 : iSelect = 15'b000100001100010;// 2
				9'b011101011 : iSelect = 15'b000100001100011;// 3
				9'b011101100 : iSelect = 15'b000100001100100;// 4
				9'b011101101 : iSelect = 15'b000100001100101;// 5
				9'b011101110 : iSelect = 15'b000100001100110;// 6
				9'b011101111 : iSelect = 15'b000100001100111;// 7
				9'b011110000 : iSelect = 15'b000100001101000;// 8
				9'b011110001 : iSelect = 15'b000100001101001;// 9
				9'b011110010 : iSelect = 15'b000100010000000;// 240
				9'b011110011 : iSelect = 15'b000100010000001;// 1
				9'b011110100 : iSelect = 15'b000100010000010;// 2
				9'b011110101 : iSelect = 15'b000100010000011;// 3
				9'b011110110 : iSelect = 15'b000100010000100;// 4
				9'b011110111 : iSelect = 15'b000100010000101;// 5
				9'b011111000 : iSelect = 15'b000100010000110;// 6
				9'b011111001 : iSelect = 15'b000100010000111;// 7
				9'b011111010 : iSelect = 15'b000100010001000;// 8
				9'b011111011 : iSelect = 15'b000100010001001;// 9
				9'b011111100 : iSelect = 15'b000100010100000;// 250
				9'b011111101 : iSelect = 15'b000100010100001;// 1
				9'b011111110 : iSelect = 15'b000100010100010;// 2
				9'b011111111 : iSelect = 15'b000100010100011;// 3
				9'b100000000 : iSelect = 15'b000100010100100;// 4
				9'b100000001 : iSelect = 15'b000100010100101;// 5
				9'b100000010 : iSelect = 15'b000100010100110;// 6
				9'b100000011 : iSelect = 15'b000100010100111;// 7
				9'b100000100 : iSelect = 15'b000100010101000;// 8
				9'b100000101 : iSelect = 15'b000100010101001;// 9
				9'b100000110 : iSelect = 15'b000100011000000;// 260
				9'b100000111 : iSelect = 15'b000100011000001;// 1
				9'b100001000 : iSelect = 15'b000100011000010;// 2
				9'b100001001 : iSelect = 15'b000100011000011;// 3
				9'b100001010 : iSelect = 15'b000100011000100;// 4
				9'b100001011 : iSelect = 15'b000100011000101;// 5
				9'b100001100 : iSelect = 15'b000100011000110;// 6
				9'b100001101 : iSelect = 15'b000100011000111;// 7
				9'b100001110 : iSelect = 15'b000100011001000;// 8
				9'b100001111 : iSelect = 15'b000100011001001;// 9
				9'b100010000 : iSelect = 15'b000100011100000;// 270
				9'b100010001 : iSelect = 15'b000100011100001;// 1
				9'b100010010 : iSelect = 15'b000100011100010;// 2
				9'b100010011 : iSelect = 15'b000100011100011;// 3
				9'b100010100 : iSelect = 15'b000100011100100;// 4
				9'b100010101 : iSelect = 15'b000100011100101;// 5
				9'b100010110 : iSelect = 15'b000100011100110;// 6
				9'b100010111 : iSelect = 15'b000100011100111;// 7
				9'b100011000 : iSelect = 15'b000100011101000;// 8
				9'b100011001 : iSelect = 15'b000100011101001;// 9
				9'b100011010 : iSelect = 15'b000100100000000;// 280
				9'b100011011 : iSelect = 15'b000100100000001;// 1
				9'b100011100 : iSelect = 15'b000100100000010;// 2
				9'b100011101 : iSelect = 15'b000100100000011;// 3
				9'b100011110 : iSelect = 15'b000100100000100;// 4
				9'b100011111 : iSelect = 15'b000100100000101;//5
				9'b100100000 : iSelect = 15'b000100100000110;// 6
				9'b100100001 : iSelect = 15'b000100100000111;//7
				9'b100100010 : iSelect = 15'b000100100001000;//8
				9'b100100011 : iSelect = 15'b000100100001001;//9
				9'b100100100 : iSelect = 15'b000100100100000;// 290
				9'b100100101 : iSelect = 15'b000100100100001;//1
				9'b100100110 : iSelect = 15'b000100100100010;//2
				9'b100100111 : iSelect = 15'b000100100100011;//3
				9'b100101000 : iSelect = 15'b000100100100100;//4
				9'b100101001 : iSelect = 15'b000100100100101;//5
				9'b100101010 : iSelect = 15'b000100100100110;//6
				9'b100101011 : iSelect = 15'b000100100100111;//7
				9'b100101100 : iSelect = 15'b000100100101000;//8
				9'b100101101 : iSelect = 15'b000100100101001;//9
				9'b100101110 : iSelect = 15'b000110000000000;//300
				9'b100101111 : iSelect = 15'b000110000000001;//1
				9'b100110000 : iSelect = 15'b000110000000010;//2
				9'b100110001 : iSelect = 15'b000110000000011;//3
				9'b100110010 : iSelect = 15'b000110000000100;//4
				9'b100110011 : iSelect = 15'b000110000000101;//5
				9'b100110100 : iSelect = 15'b000110000000110;//6
				9'b100110101 : iSelect = 15'b000110000000111;//7
				9'b100110110 : iSelect = 15'b000110000001000;//8
				9'b100110111 : iSelect = 15'b000110000001001;//9
				9'b100111000 : iSelect = 15'b000110000100000;//310
				9'b100111001 : iSelect = 15'b000110000100001;//1
				9'b100111010 : iSelect = 15'b000110000100010;//2
				9'b100111011 : iSelect = 15'b000110000100011;//3
				9'b100111100 : iSelect = 15'b000110000100100;//4
				9'b100111101 : iSelect = 15'b000110000100101;//5
				9'b100111110 : iSelect = 15'b000110000100110;//6
				9'b100111111 : iSelect = 15'b000110000100111;//78
				9'b101000000 : iSelect = 15'b000110000101000;//8
				9'b101000001 : iSelect = 15'b000110000101001;//9
				9'b101000010 : iSelect = 15'b000110001000000;//320
				9'b101000011 : iSelect = 15'b000110001000001;//1
				9'b101000100 : iSelect = 15'b000110001000010;//2
				9'b101000101 : iSelect = 15'b000110001000011;//3
				9'b101000110 : iSelect = 15'b000110001000100;//3
				9'b101000111 : iSelect = 15'b000110001000101;//4
				9'b101001000 : iSelect = 15'b000110001000110;//5
				9'b101001001 : iSelect = 15'b000110001000111;//6
				9'b101001010 : iSelect = 15'b000110001001000;//7
				9'b101001011 : iSelect = 15'b000110001001001;//8
				9'b101001100 : iSelect = 15'b000110001001001;//9
				9'b101001101 : iSelect = 15'b000110001100000;//330
				9'b101001110 : iSelect = 15'b000110001100001;//1
				9'b101001111 : iSelect = 15'b000110001100010;//2
				9'b101010000 : iSelect = 15'b000110001100011;//3
				9'b101010001 : iSelect = 15'b000110001100100;//4
				9'b101010010 : iSelect = 15'b000110001100101;//5
				9'b101010011 : iSelect = 15'b000110001100110;//6
				9'b101010100 : iSelect = 15'b000110001100111;//7
				9'b101010101 : iSelect = 15'b000110001101000;//8
				9'b101010110 : iSelect = 15'b000110001101001;//9
				9'b101010111 : iSelect = 15'b000110010000000;//340
				9'b101011000 : iSelect = 15'b000110010000001;//1
				9'b101011001 : iSelect = 15'b000110010000010;//2
				9'b101011010 : iSelect = 15'b000110010000011;//3
				9'b101011011 : iSelect = 15'b000110010000100;//4
				9'b101011100 : iSelect = 15'b000110010000101;//5
				9'b101011101 : iSelect = 15'b000110010000110;//6
				9'b101011110 : iSelect = 15'b000110010000111;//7
				9'b101011111 : iSelect = 15'b000110010001000;//8
				9'b101100000 : iSelect = 15'b000110010001001;//9
				9'b101100001 : iSelect = 15'b000110010100000;//350
				9'b101100010 : iSelect = 15'b000110010100001;//1
				9'b101100011 : iSelect = 15'b000110010100010;//2
				9'b101100100 : iSelect = 15'b000110010100011;//3
				9'b101100101 : iSelect = 15'b000110010100100;//4
				9'b101100110 : iSelect = 15'b000110010100101;//5
				9'b101100111 : iSelect = 15'b000110010100110;//6
				9'b101101000 : iSelect = 15'b000110010100111;//7
				9'b101101001 : iSelect = 15'b000110010101000;//8
				9'b101101010 : iSelect = 15'b000110010101001;//9
				9'b101101011 : iSelect = 15'b000110011000000;//360
				9'b101101100 : iSelect = 15'b000110011000001;//1
				9'b101101101 : iSelect = 15'b000110011000010;//2
				9'b101101110 : iSelect = 15'b000110011000011;//3
				9'b101101111 : iSelect = 15'b000110011000100;//4
				9'b101110000 : iSelect = 15'b000110011000101;//5
				9'b101110001 : iSelect = 15'b000110011000110;//6
				9'b101110010 : iSelect = 15'b000110011000111;//7
				9'b101110011 : iSelect = 15'b000110011001000;//8
				9'b101110100 : iSelect = 15'b000110011001001;//9
				9'b101110101 : iSelect = 15'b000110011100000;//370
				9'b101110110 : iSelect = 15'b000110011100001;//1
				9'b101110111 : iSelect = 15'b000110011100010;//2
				9'b101111000 : iSelect = 15'b000110011100011;//3
				9'b101111001 : iSelect = 15'b000110011100100;//4
				9'b101111010 : iSelect = 15'b000110011100101;//5
				9'b101111011 : iSelect = 15'b000110011100110;//6
				9'b101111100 : iSelect = 15'b000110011100111;//7
				9'b101111101 : iSelect = 15'b000110011101000;//8
				9'b101111110 : iSelect = 15'b000110011101001;//9
				9'b101111111 : iSelect = 15'b000110100000000;//380
				9'b110000000 : iSelect = 15'b000110100000001;//1
				9'b110000001 : iSelect = 15'b000110100000010;//2
				9'b110000010 : iSelect = 15'b000110100000011;//3
				9'b110000011 : iSelect = 15'b000110100000100;//4
				9'b110000100 : iSelect = 15'b000110100000101;//5
				9'b110000101 : iSelect = 15'b000110100000110;//6
				9'b110000110 : iSelect = 15'b000110100000111;//7
				9'b110000111 : iSelect = 15'b000110100001000;//8
				9'b110001000 : iSelect = 15'b000110100001001;//9
				9'b110001001 : iSelect = 15'b000110100100000;//390
				9'b110001010 : iSelect = 15'b000110100100001;//1
				9'b110001011 : iSelect = 15'b000110100100010;//2
				9'b110001100 : iSelect = 15'b000110100100011;//3
				9'b110001101 : iSelect = 15'b000110100100100;//4
				9'b110001110 : iSelect = 15'b000110100100101;//5
				9'b110001111 : iSelect = 15'b000110100100110;//6
				9'b110010000 : iSelect = 15'b000110100100111;//7
				9'b110010001 : iSelect = 15'b000110100101000;//8
				9'b110010010 : iSelect = 15'b000110100101001;//9
				9'b110010011 : iSelect = 15'b001000000000000;//400
				9'b110010100 : iSelect = 15'b001000000000001;//401
				9'b110010101 : iSelect = 15'b001000000000010;//402
				9'b110010110 : iSelect = 15'b001000000000011;//403
				9'b110010111 : iSelect = 15'b001000000000100;//404
				9'b110011000 : iSelect = 15'b001000000000101;//405
				9'b110011001 : iSelect = 15'b001000000000110;//406
				9'b110011010 : iSelect = 15'b001000000000111;//407
				9'b110011011 : iSelect = 15'b001000000001000;//408
				9'b110011100 : iSelect = 15'b001000000001001;//409

				default: iSelect = 0; // Valor por defecto
        endcase // Fin del case                            
    end // Fin del bloque else
end


reg [25:0] iConteoMusic = 0;

always @(posedge clk_in) begin
    if (iConteoMusic == 20000000) begin // 100 MHz / 2 / 20000000 = 2.5 Hz
        iConteoMusic <= 0;
        iMusic <= ~iMusic; // Invierte el estado del iMusic
    end else begin
        iConteoMusic <= iConteoMusic + 1;
    end
end


reg [28:0] countD; // Contador de 27 bits (2^27 = 134217728 > 1000000/5)

always @(posedge clk_in) begin
  if (countD == 100000) begin // Si se han contado suficientes ciclos
    countD <= 0; // Reiniciar el contador
    clk_outDisplay <= ~clk_outDisplay; // Invertir el valor del clk de salida
  end else begin
    countD <= countD + 1; // Incrementar el contador
  end
end

// Selección de los segmentos 
reg [2:0] selector;
		always @ (posedge clk_outDisplay)
		
	begin 
	if  (selector == 3'b000)
	begin iSegmentos_Display = out; iBase_Segmentos = 3'b110; end
	
	else if (selector == 3'b010)
	begin iSegmentos_Display = out2; iBase_Segmentos = 3'b101; end
	
	else if (selector == 3'b100)
	begin iSegmentos_Display = out3; iBase_Segmentos = 3'b011; end 
	
	selector = selector + 1'b1; // Incrementa el selector
	
end

// Señales para la conversión BCD a 7seg
wire F,G,H;
assign F = iSelect_2[2];
assign G = iSelect_2[1];
assign H = iSelect_2[0];

// Conversión BCD a 7seg
assign iOu1t[0] = (F*~G);
assign iOu1t[1] = (G*H)|(F*~G);
assign iOu1t[2] = (H)|(F*~G)|(~F*G);
assign iOu1t[3] = (~F*H)|(G)|(F*~H);
assign iOu1t[4] = (H)|(G)|(F);
assign iOu1t[5] = (G*H)|(F);
assign iOu1t[6] = (~F*G*~H)|(F*~G*H);

always @(*) begin
		
		// AQUI APARECERA V QUE INDICA QUE SE ESTA VACEANDO
		if (iLed_Vaceando && bContando == 1 && iStart_out == 0)
			iSelect_2 = 3'b111;
			
		else if (iLed_Motor && bContando == 1 && iStart_out == 0)
			iSelect_2 = 3'b100;
			
		else if (iLed_Llenando && bContando == 1 && iStart_out == 0)
			iSelect_2 = 3'b101;
			
		// AQUI APARECERA 40%
		else if (iTiempo_Bajo && bContando == 0)
			iSelect_2 = 3'b001;
		
		// AQUI APARECERA 50%
		else if (iTiempo_Medio && bContando == 0)
			iSelect_2 = 3'b010;
			
		// AQUI APARECERA 90%
		else if (iTiempo_Alto && bContando == 0)
			iSelect_2 = 3'b011;
			
		//AQUI APARECERA 100%
		else if (iTiempo_FULL && bContando == 0)
			iSelect_2 = 3'b100;
			
		else
			iSelect_2 = 3'b000; // Valor por defecto
end

endmodule
