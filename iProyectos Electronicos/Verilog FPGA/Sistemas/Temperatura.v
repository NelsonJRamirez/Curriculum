module pushbutton(
    input rst,
    input btn,
    output reg [1:0] state,
    output reg led1,
    output reg led2,
    output reg led3,
    output reg led4
);

reg [1:0] count;
reg [3:0] pulse;

always @(btn) begin
    if (!rst) begin
        count <= 2'b00;
        pulse <= 4'b0000;
        state <= 2'b00;
        led1 <= 1'b0;
        led2 <= 1'b0;
        led3 <= 1'b0;
        led4 <= 1'b0;
    end
    else if (btn) begin
        count <= count + 1;
        case (count)
            2'b01: begin
                pulse <= 4'b0001;
                state <= 2'b01;
                led1 <= 1'b1;
                led2 <= 1'b0;
                led3 <= 1'b0;
                led4 <= 1'b0;
            end
            2'b10: begin
                pulse <= 4'b0010;
                state <= 2'b10;
                led1 <= 1'b0;
                led2 <= 1'b1;
                led3 <= 1'b0;
                led4 <= 1'b0;
            end
            2'b11: begin
                pulse <= 4'b0011;
                state <= 2'b11;
                led1 <= 1'b0;
                led2 <= 1'b0;
                led3 <= 1'b1;
                led4 <= 1'b0;
            end
            default: begin
                pulse <= 4'b0000;
                state <= 2'b00;
                count <= 2'b00;
                led1 <= 1'b0;
                led2 <= 1'b0;
                led3 <= 1'b0;
                led4 <= 1'b1;
            end
        endcase
    end
end

assign iCaliente = (pulse == 4'b0001);
assign iTibia = (pulse == 4'b0010);
assign Fria = (pulse == 4'b0011);
assign iAmbiente = (pulse == 4'b0000);

endmodule
