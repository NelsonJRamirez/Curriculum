`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Centrifugado(
    input iBoton_TiempoCentri,
	 output reg iCentri_1, iCentri_2, iCentri_3, iCentri_4,
	 output reg [3:0] iLed_Centri


    );

Examen instancia_examen(
    .clk_in(clk_in),
    .clk_out(clk_out),
    .clk_outs(clk_outs),
    .iMusicLed(iMusicLed),
    .pb(pb),
    .iEncender(iEncender),
    .btn(btn),
    .iEncendido(iEncendido),
    .estado(estado),
    .iLavado_Fast(iLavado_Fast),
    .iEnjuagar_Centrifugar(iEnjuagar_Centrifugar),
    .iCentrifugarL(iCentrifugarL),
    .iSalidaClock(iSalidaClock),
    .iMusic(iMusic),
    .iBoton_Temperatura(iBoton_Temperatura),
    .iBoton_Tiempo_Lavado(iBoton_Tiempo_Lavado),
    .iEstado_Temp(iEstado_Temp),
    .iAgua_Fria(iAgua_Fria),
    .iAgua_Caliente(iAgua_Caliente),
    .iTiempoLavado_1(iTiempoLavado_1),
    .iTiempoLavado_2(iTiempoLavado_2),
    .iTiempoLavado_3(iTiempoLavado_3),
    .iTiempoLavado_4(iTiempoLavado_4),
    .iTiempoCentrifugado_1(iTiempoCentrifugado_1),
    .iTiempoCentrifugado_2(iTiempoCentrifugado_2),
    .iTiempoCentrifugado_3(iTiempoCentrifugado_3),
    .iTiempoCentrifugado_4(iTiempoCentrifugado_4),
    .iLed_Temperatura(iLed_Temperatura),
    .iLed_Tiempo_Lavado(iLed_Tiempo_Lavado),
    .iLed_Tiempo_Centrifugado(iLed_Tiempo_Centrifugado),
    .iLed_Segundos_Lavado(iLed_Segundos_Lavado),
    .LED3(LED3),
    .LEDMUSIC(LEDMUSIC),
    .iCLK_Tiempo_1HZ(iCLK_Tiempo_1HZ),
    .iBoton_Tiempo(iBoton_Tiempo),
    .iStart(iStart),
    .iPausa(iPausa),
    .iEstado_Temp2(iEstado_Temp2),
    .iEstado_Temp1(iEstado_Temp1),
    .iTiempo_Bajo(iTiempo_Bajo),
    .iTiempo_Medio(iTiempo_Medio),
    .iTiempo_Alto(iTiempo_Alto),
    .iTiempo_FULL(iTiempo_FULL),
    .iLed_Llenando(iLed_Llenando),
    .iLed_Vaceando(iLed_Vaceando),
    .iLed_Motor(iLed_Motor),
    .led(led),
    .ConteoMusic(ConteoMusic),
    .iStart_out(iStart_out),
    .clk_outDisplay(clk_outDisplay),
    .out(out),
    .out2(out2),
    .out3(out3),
    .iSelect(iSelect),
    .iSelectMusic(iSelectMusic),
    .iBase_Segmentos(iBase_Segmentos),
    .iSegmentos_Display(iSegmentos_Display),
    .iOu1t(iOu1t),
	 .iSelect_2(iSelect_2)
);


reg [1:0] state_TiempoCentri;
always @(posedge iBoton_TiempoCentri or negedge iEncender) begin
    if (!iEncender || !iCentrifugarL) begin
        state_TiempoCentri <= 2'd0;
        iLed_Centri <= 4'b0000;
        iCentri_1 <= 1'b0;
        iCentri_2 <= 1'b0;
		  iCentri_3 <= 1'b0;
        iCentri_4 <= 1'b0;
    end else if (btn == 1  && iEncendido == 1 && iLavado_Fast == 0 && iEnjuagar_Centrifugar == 0 && iCentrifugarL == 1 && led == 0) begin
        state_TiempoCentri <= state_TiempoCentri + 1;
        case (state_TiempoCentri)
            2'd0: begin
                iLed_Centri <= 4'b0001; // 150
                iCentri_1 <= 1'b1; // Tiempo 1
                iCentri_2 <= 1'b0; // Tiempo 2
					 iCentri_3 <= 1'b0; // Tiempo 3
                iCentri_4 <= 1'b0; // Tiempo 4
            end
            2'd1: begin
                iLed_Centri <= 4'b0010; // 200
                iCentri_1 <= 1'b0; // Tiempo 1
                iCentri_2 <= 1'b1; // Tiempo 2
					 iCentri_3 <= 1'b0; // Tiempo 3
                iCentri_4 <= 1'b0; // Tiempo 4
            end
            2'd2: begin
                iLed_Centri <= 4'b0100; // 275
                iCentri_1 <= 1'b0; // Tiempo 1
                iCentri_2 <= 1'b0; // Tiempo 2
					 iCentri_3 <= 1'b1; // Tiempo 3
                iCentri_4 <= 1'b0; // Tiempo 4
            end
            2'd3: begin
                iLed_Centri <= 4'b1000; // 375
                iCentri_1 <= 1'b0; // Tiempo 1
                iCentri_2 <= 1'b0; // Tiempo 2
					 iCentri_3 <= 1'b0; // Tiempo 3
                iCentri_4 <= 1'b1; // Tiempo 4
            end
        endcase
    end
end

endmodule
