`default_nettype none
`timescale 1ns/1ps
module frequency_counter #(
    // see calculations.py
    parameter UPDATE_PERIOD = 1200 - 1,
    parameter BITS = 12
)(
    input wire              clk,
    input wire              reset,
    input wire              signal,

    input wire [BITS-1:0]   period,
    input wire              period_load,

    output wire [6:0]       segments,
    output wire             digit,

    // some debug wires
    output wire [1:0]       dbg_state,      // state machine
    output wire [2:0]       dbg_clk_count,  // top 3 bits of clk counter
    output wire [2:0]       dbg_edge_count  // top 3 bits of edge counter
    );

    // debug assigns
    assign dbg_state = state;
    assign dbg_clk_count = clk_counter[BITS-1:BITS-3];
    assign dbg_edge_count = edge_counter[6:4];


endmodule
