`timescale 1ns / 1ps

module lavadora(
  input clk, // reloj
  input rst, // se�al de reset
  input start, // se�al de inicio de ciclo
  input [1:0] mode, // modo de lavado (0=lavado, 1=enjuague, 2=centrifugado)
  input [3:0] load, // tama�o de la carga (0-15 libras)
  output reg motor, // se�al de control del motor
  output reg [1:0] valve, // se�al de control de la v�lvula (0=entrada de agua, 1=salida de agua, 2=ninguna)
  output reg heater, // se�al de control del calentador
  output reg buzzer // se�al del zumbador
);

// Definici�n de constantes
parameter MAX_LOAD = 4; // tama�o m�ximo de carga en libras
parameter WASH_CYCLES = 3; // n�mero de ciclos de lavado
parameter RINSE_CYCLES = 2; // n�mero de ciclos de enjuague
parameter SPIN_CYCLES = 1; // n�mero de ciclos de centrifugado
parameter WASH_TIME = 20; // duraci�n de ciclo de lavado en segundos
parameter RINSE_TIME = 10; // duraci�n de ciclo de enjuague en segundos
parameter SPIN_TIME = 30; // duraci�n de ciclo de centrifugado en segundos
parameter FILL_TIME = 5; // tiempo de llenado del tanque de agua en segundos
parameter DRAIN_TIME = 5; // tiempo de drenado del tanque de agua en segundos
parameter HEAT_TIME = 10; // tiempo de calentamiento del agua en segundos
parameter BUZZ_TIME = 2; // duraci�n del sonido del zumbador en segundos

// Declaraci�n de variables
reg [3:0] cycle_count = 0; // contador de ciclos de lavado
reg [3:0] time_count = 0; // contador de tiempo de ciclo actual
reg [3:0] fill_count = 0; // contador de tiempo de llenado del tanque de agua
reg [3:0] drain_count = 0; // contador de tiempo de drenado del tanque de agua
reg [3:0] heat_count = 0; // contador de tiempo de calentamiento del agua
reg [3:0] buzzer_count = 0; // contador de tiempo del zumbador

// M�quina de estados del ciclo de lavado
reg [1:0] state = 0; // estado actual
parameter IDLE = 0; // estado de espera
parameter FILL = 1; // estado de llenado del tanque de agua
parameter WASH = 2; // estado de ciclo de lavado
parameter RINSE = 3; // estado de ciclo de enjuague
parameter SPIN = 4; // estado de ciclo de centrifugado
parameter DRAIN = 5; // estado de drenado del tanque de agua
parameter BUZZ = 6; // estado de activaci�n del zumbador

// L�gica de control
always @(posedge clk) begin
  if (rst) begin
    cycle_count <= 0;
    time_count <= 0;
    fill_count <= 0;
    drain_count <= 0;
    heat_count <= 0;
	buzzer_count <= 0;
	state <= IDLE;
	motor <= 0;
	valve <= 2;
	heater <= 0;
	buzzer <= 0;
	
	end else begin
	case (state)
		IDLE: begin
			if (start) begin
				cycle_count <= 0;
				fill_count <= 0;
				drain_count <= 0;
				heat_count <= 0;
				buzzer_count <= 0;
				state <= FILL;
			end
		end
		FILL: begin
			valve <= 0; // abrimos la v�lvula de entrada de agua
			fill_count <= fill_count + 1;
			
		if (fill_count >= FILL_TIME) begin // si el tanque est� lleno
			valve <= 2; // cerramos la v�lvula
			state <= WASH; // pasamos al estado de lavado
			end
		end
		WASH: begin
		motor <= 1; // encendemos el motor
		heater <= 1; // encendemos el calentador
		time_count <= time_count + 1;
		
		if (time_count >= WASH_TIME) begin // si se ha completado el ciclo de lavado
			cycle_count <= cycle_count + 1;
		if (cycle_count >= WASH_CYCLES) begin // si se han completado todos los ciclos de lavado
			cycle_count <= 0;
			state <= DRAIN; // pasamos al estado de drenado del tanque de agua
			
		end else begin
		state <= RINSE; // pasamos al estado de enjuague
		end
			time_count <= 0;
			motor <= 0; // apagamos el motor
			heater <= 0; // apagamos el calentador
			end
		end
RINSE: begin
valve <= 0; // abrimos la v�lvula de entrada de agua
fill_count <= fill_count + 1;
if (fill_count >= FILL_TIME) begin // si el tanque est� lleno
valve <= 2; // cerramos la v�lvula
motor <= 1; // encendemos el motor
time_count <= time_count + 1;
if (time_count >= RINSE_TIME) begin // si se ha completado el ciclo de enjuague
state <= DRAIN; // pasamos al estado de drenado del tanque de agua
time_count <= 0;
motor <= 0; // apagamos el motor
end
end
end
SPIN: begin
motor <= 1; // encendemos el motor
time_count <= time_count + 1;
if (time_count >= SPIN_TIME) begin // si se ha completado el ciclo de centrifugado
cycle_count <= cycle_count + 1;
if (cycle_count >= SPIN_CYCLES) begin // si se han completado todos los ciclos de centrifugado
cycle_count <= 0;
state <= BUZZ; // pasamos al estado de activaci�n del zumbador
end else begin
state <= DRAIN; // pasamos al estado de drenado del tanque de agua
end
time_count <= 0;
motor <= 0; // apagamos el motor
end
end
DRAIN: begin
valve <= 1; // abrimos la v�lvula de salida de agua
drain_count <= drain_count + 1;
if (drain_count >= DRAIN_TIME) begin // si el tanque est� vac�o
valve <= 2; // cerramos la v�lvula
if (state == WASH) begin
state <= RINSE; // pasamos al estado deenjuague
end else begin
state <= SPIN; // pasamos al estado de centrifugado
end
drain_count <= 0;
end
end
BUZZ: begin
buzzer <= 1; // activamos el zumbador
buzzer_count <= buzzer_count + 1;
if (buzzer_count >= BUZZ_TIME) begin // si se ha completado el ciclo de activaci�n del zumbador
buzzer <= 0; // desactivamos el zumbador
state <= IDLE; // volvemos al estado inicial
end
end
endcase
end
endmodule
