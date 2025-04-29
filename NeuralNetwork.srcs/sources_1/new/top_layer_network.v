`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2025 04:44:55 PM
// Design Name: 
// Module Name: top_layer_network
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "include.v"
module top_layer_network #(parameter integer AXI_DATA_WIDTH = 32, parameter integer AXI_ADDR_WIDTH = 5)(
    input axi_clk,
    input axi_asyncrst,
    input [dataWidth-1:0] axi_indata,
    input axi_indata_valid,
    output axi_indata_ready
    );
endmodule
