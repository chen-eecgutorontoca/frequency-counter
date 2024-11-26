`default_nettype none
`timescale 1ns/1ps

module seven_segment (
    input wire          clk,           // Clock input
    input wire          reset,         // Reset input
    input wire          load,          // Load input to store counts
    input wire [3:0]    ten_count,     // Tens digit (4 bits)
    input wire [3:0]    unit_count,    // Ones digit (4 bits)
    output reg [6:0]    segments,      // 7-segment output
    output reg          digit          // Active digit output (0 for tens, 1 for ones)
);

reg [3:0] ten_cnt, unit_cnt; 
reg [3:0] decode; 


always @(posedge clk or negedge reset) begin
    if (!reset) begin
        ten_cnt <= 4'b0;
        unit_cnt <= 4'b0;
    end else if (load) begin
        ten_cnt <= ten_count;
        unit_cnt <= unit_count;
    end else begin
    	ten_cnt <= ten_cnt;
    	unit_cnt <= unit_cnt;
    end
end


always @(posedge clk or negedge reset) begin
    if (!reset)begin
        digit <= 1'b0;  
    end else begin
        digit <= ~digit;  
    end
end


always @(*) begin
    case (digit)
        1'b0: decode = ten_cnt;   
        1'b1: decode = unit_cnt;  
        default: decode = 4'b0000; 
    endcase
end


always @(*) begin
    segments = seg7(decode);  
end



function [6:0] seg7;
    input [3:0] counter; 
    begin
        case(counter)
            4'b0000: seg7 = 7'b0111111;  // 0
            4'b0001: seg7 = 7'b0000110;  // 1
            4'b0010: seg7 = 7'b1011011;  // 2
            4'b0011: seg7 = 7'b1001111;  // 3
            4'b0100: seg7 = 7'b1100110;  // 4
            4'b0101: seg7 = 7'b1101101;  // 5
            4'b0110: seg7 = 7'b1111100;  // 6
            4'b0111: seg7 = 7'b0000111;  // 7
            4'b1000: seg7 = 7'b1111111;  // 8
            4'b1001: seg7 = 7'b1100111;  // 9
            default: seg7 = 7'b0000000;   // Default (off)
        endcase
    end
endfunction

endmodule

