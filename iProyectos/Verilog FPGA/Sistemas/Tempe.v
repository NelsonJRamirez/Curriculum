module pushbutton(
    input iReset_Temperatura,
    input iBoton_Temperatura,
    output reg [1:0] iEstado_Temp,
    output reg iAgua_Fria,
    output reg iAgua_Caliente,
	 output reg iLed_Agua1,
	 output reg iLed_Agua2,
	 output reg iLed_Agua3,
	 output reg iLed_Agua4
);

reg [1:0] iCount_Temperatura;
reg [3:0] iPulso_Temperatura;
reg iBoton_Temperatura_stable;

always @(iBoton_Temperatura) begin
    iBoton_Temperatura_stable <= iBoton_Temperatura;
end

always @(posedge iBoton_Temperatura_stable or negedge iReset_Temperatura) begin
    if (!iReset_Temperatura) begin
        iCount_Temperatura <= 2'b00;
        iPulso_Temperatura <= 4'b0000;
        iEstado_Temp <= 2'b00;
        iAgua_Fria <= 1'b0;
        iAgua_Caliente <= 1'b0;
        iLed_Agua1 <= 1'b0;
        iLed_Agua2 <= 1'b0;
        iLed_Agua3 <= 1'b0;
        iLed_Agua4 <= 1'b0;
    end
    else begin
        if (iCount_Temperatura == 2'b00 && iBoton_Temperatura_stable == 1'b1) begin // Caliente
            iCount_Temperatura <= iCount_Temperatura + 1;
            iPulso_Temperatura <= 4'b0001;
            iEstado_Temp <= 2'b01;
            iAgua_Fria <= 1'b0;
            iAgua_Caliente <= 1'b1;
            iLed_Agua1 <= 1'b1;
        end
        else if (iCount_Temperatura == 2'b01 && iBoton_Temperatura_stable == 1'b1) begin // Tibia
            iCount_Temperatura <= iCount_Temperatura + 1;
            iPulso_Temperatura <= 4'b0010;
            iEstado_Temp <= 2'b10;
            iAgua_Fria <= 1'b0;
            iAgua_Caliente <= 1'b1;
				iLed_Agua2 <= 1'b1;
        end
        else if (iCount_Temperatura == 2'b10 && iBoton_Temperatura_stable == 1'b1) begin //  Fria
            iCount_Temperatura <= iCount_Temperatura + 1;
            iPulso_Temperatura <= 4'b0011;
            iEstado_Temp <= 2'b11;
            iAgua_Fria <= 1'b1;
            iAgua_Caliente <= 1'b0;
				iLed_Agua3 <= 1'b1;
        end
        else if (iCount_Temperatura == 2'b11 && iBoton_Temperatura_stable == 1'b1) begin // Ambiente 
            iCount_Temperatura <= iCount_Temperatura + 1;
            iPulso_Temperatura <= 4'b0000;
            iEstado_Temp <= 2'b00;
            iAgua_Fria <= 1'b1;
            iAgua_Caliente <= 1'b1;
				iLed_Agua4 <= 1'b1;
        end
        else if (iBoton_Temperatura_stable == 1'b0) begin
            // Reiniciar el conteo si se suelta el botón antes de la cuarta pulsación
            iCount_Temperatura <= 2'b00;
        end
    end
end

endmodule
