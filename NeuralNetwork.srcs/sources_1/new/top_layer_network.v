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
        .weightValue(weightValue),
        .biasValue(biasValue),
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

wire [`numNeuronLayer2-1:0] o2_valid;
wire [`numNeuronLayer2 * `dataWidth-1:0] x2_out;
reg [`numNeuronLayer2* `dataWidth-1:0] hold_data2;
reg [`dataWidth-1:0] out_data2;
reg data_out_valid_2;

Layer2 #(.NN(`numNeuronLayer2), .numWeight(`numWeightLayer2), .dataWidth(`dataWidth), .layerNum(2), .sigmoidSize(`sigmoidSize), .weightIntWidth(`weightIntWidth), .actType(`Layer2ActType)) l2(
    .clk(axi_clk),
    .rst(reset),
    .weightValid(weight_valid),
    .biasValid(biasValid),
    .weightValue(weightValue),
    .biasValue(biasValue),
    .config_layer_num(config_layer_num),
    .config_neuron_num(config_neuron_num),
    .x_valid(data_out_valid_1),
    .x_in(out_data_1),
    .o_valid(o2_valid),
    .x_out(x2_out)
);


    reg state_2;
    wire integer count_2;

    always @(posedge axi_clk) begin
    
    if(reset)
    begin
        
        state_2 <= IDLE;
        count_2<=0;
        data_out_valid_2<=0;
        
    end
    else begin
        
        case(state_2)
            IDLE: begin
                count_2<=0;
                data_out_valid_2<=0;

                if (o2_valid[0] == 1'b1) begin 
                    hold_data2 <= x2_out;
                    state_2 <= SEND;
                end
                
            end

            SEND: begin
                out_data_2 <= hold_data2[`dataWidth-1:0];
                hold_data2 <= hold_data2>>`dataWidth;
                count_2 <= count_2 +1;
                data_out_valid_2 <= 1;

                    if(count_2 == `numNeuronLayer2) begin
                        state_2 <= IDLE;
                        data_out_valid_2 <=0;
                    end
            
            end

        endcase


    end
    end







wire [`numNeuronLayer3-1:0] o3_valid;
wire [`numNeuronLayer3 * `dataWidth-1:0] x3_out;
reg [`numNeuronLayer3* `dataWidth-1:0] holdData3;
reg [`dataWidth-1:0] out_data3;
reg data_out_valid_3;

Layer3 #(.NN(`numNeuronLayer3), .numWeight(`numWeightLayer3), .dataWidth(`dataWidth), .layerNum(3), .sigmoidSize(`sigmoidSize), .weightIntWidth(`weightIntWidth), .actType(`Layer3ActType)) l3(
    .clk(axi_clk),
    .rst(reset),
    .weightValid(weight_valid),
    .biasValid(biasValid),
    .weightValue(weightValue),
    .biasValue(biasValue),
    .config_layer_num(config_layer_num),
    .config_neuron_num(config_neuron_num),
    .x_valid(data_out_valid_2),
    .x_in(out_data_2),
    .o_valid(o3_valid),
    .x_out(x3_out)
);



    reg state_3;
    wire integer count_3;

    always @(posedge axi_clk) begin
    
    if(reset)
    begin
        
        state_3 <= IDLE;
        count_3<=0;
        data_out_valid_3<=0;
        
    end
    else begin
        
        case(state_3)
            IDLE: begin
                count_3<=0;
                data_out_valid_3<=0;

                if (o3_valid[0] == 1'b1) begin 
                    hold_data3 <= x3_out;
                    state_3 <= SEND;
                end
                
            end

            SEND: begin
                out_data_3 <= hold_data3[`dataWidth-1:0];
                hold_data3 <= hold_data3>>`dataWidth;
                count_3 <= count_3 +1;
                data_out_valid_3 <= 1;

                    if(count_3 == `numNeuronLayer3) begin
                        state_3 <= IDLE;
                        data_out_valid_3 <=0;
                    end
            
            end

        endcase


    end
    end




reg [`numNeuronLayer4*`dataWidth-1:0] holdData_5;
assign axi_rd_data = holdData_5[`dataWidth-1:0];

always @(posedge s_axi_aclk)
    begin
        if (o4_valid[0] == 1'b1)
            holdData_5 <= x4_out;
        else if(axi_rd_en)
        begin
            holdData_5 <= holdData_5>>`dataWidth;
        end
    end


wire [`numNeuronLayer4-1:0] o4_valid;
wire [`numNeuronLayer4 * `dataWidth-1:0] x4_out;
reg [`numNeuronLayer4* `dataWidth-1:0] holdData4;
reg [`dataWidth-1:0] out_data4;
reg data_out_valid_4;

Layer4 #(.NN(`numNeuronLayer4), .numWeight(`numWeightLayer4), .dataWidth(`dataWidth), .layerNum(4), .sigmoidSize(`sigmoidSize), .weightIntWidth(`weightIntWidth), .actType(`Layer4ActType)) l4(
    .clk(axi_clk),
    .rst(reset),
    .weightValid(weight_valid),
    .biasValid(biasValid),
    .weightValue(weightValue),
    .biasValue(biasValue),
    .config_layer_num(config_layer_num),
    .config_neuron_num(config_neuron_num),
    .x_valid(data_out_valid_3),
    .x_in(out_data_3),
    .o_valid(o4_valid),
    .x_out(x4_out)
);


    reg state_4;
    wire integer count_4;

    always @(posedge axi_clk) begin
    
    if(reset)
    begin
        
        state_4 <= IDLE;
        count_4<=0;
        data_out_valid_3<=0;
        
    end
    else begin
        
        case(state_4)
            IDLE: begin
                count_4<=0;
                data_out_valid_4<=0;

                if (o4_valid[0] == 1'b1) begin 
                    hold_data4 <= x4_out;
                    state_4 <= SEND;
                end
                
            end

            SEND: begin
                out_data_4 <= hold_data4[`dataWidth-1:0];
                hold_data4 <= hold_data4>>`dataWidth;
                count_4 <= count_4 +1;
                data_out_valid_4 <= 1;

                    if(count_4 == `numNeuronLayer4) begin
                        state_4 <= IDLE;
                        data_out_valid_4 <=0;
                    end
            
            end

        endcase


    end
    end

reg [`numNeuronLayer4*`dataWidth-1:0] hold_data_5;
assign axi_rd_data = hold_data_5[`dataWidth-1:0];

always @(posedge s_axi_aclk)
    begin
        if (o4_valid[0] == 1'b1)
            hold_data_5 <= x4_out;
        else if(axi_rd_en)
        begin
            hold_data_5 <= hold_data_5>>`dataWidth;
        end
    end








endmodule
