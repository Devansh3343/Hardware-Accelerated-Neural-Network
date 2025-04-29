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
    input [`dataWidth-1:0] axi_indata,
    input axi_indata_valid,
    output axi_indata_ready
    );

    wire reset;
    wire weightValid;
    wire biasValid;


    assign reset = ~axi_asyncrst;

    localparam IDLE = 'd0,
               SEND = 'd1;

    wire[`numNeuronLayer1-1:0] o1_valid;
    wire[`numNeuronLayer1 * `dataWidth-1:0] x1_out;
    reg[`numNeuronLayer1 * `dataWidth-1:0] hold_data1;
    reg [`dataWidth-1:0] out_data_1;
    reg data_out_valid_1;


    Layer1 #(.NN(`numNeuronLayer1), .numWeight(`numWeightLayer1), .dataWidth(`dataWidth), .layerNum(1), .sigmoidSize(`sigmoidSize), weightIntWidth(`weightIntWidth, .actType(`Layer1ActType))) l1(
        .clk(axi_clk),
        .rst(reset),
        .weightValid(weight_valid),
        .biasValid(biasValid),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .x_valid(axi_indata_valid),
        .x_in(axi_indata),
        .o_valid(o1_valid),
        .x_out(x1_out)
    );

    reg state_1;
    wire integer count_1;

    always @(posedge axi_clk) begin
    
    if(reset)
    begin
        
        state_1 <= IDLE;
        count_1<=0;
        data_out_valid_1<=0;
        
    end
    else begin
        
        case(state_1)
            IDLE: begin
                count_1<=0;
                data_out_valid_1<=0;

                if (o1_valid[0] == 1'b1) begin 
                    hold_data1 <= x1_out;
                    state_1 <= SEND;
                end
                
            end

            SEND: begin
                out_data_1 <= hold_data1[`dataWidth-1:0];
                hold_data1 <= hold_data1>>`dataWidth;
                count_1 <= count_1 +1;
                data_out_valid_1 <= 1;

                    if(count_1 == `numNeuronLayer1) begin
                        state_1 <= IDLE;
                        data_out_valid_1 <=0;
                    end
            
            end

        endcase


    end
    end

wire [`numNeuronLayer2-1:0 o2_valid];
wire []


endmodule
