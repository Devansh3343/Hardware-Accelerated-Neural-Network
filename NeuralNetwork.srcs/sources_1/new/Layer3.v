`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2025 05:10:59 PM
// Design Name: 
// Module Name: Layer3
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


module Layer3 #(parameter NN=10, numWeight=784, dataWidth=16, layerNum=3, sigmoidSize=10, weightIntWidth=4, actType ="relu")
    (
    input clk,
    input rst,
    input weightValid,
    input biasValid,
    input [31:0] weightValue,
    input [31:0] biasValue,
    input [31:0] config_layer_num,
    input [31:0] config_neuron_num,
    input x_valid,
    input [dataWidth-1:0] x_in,
    output [NN-1:0] o_valid,
    output [NN*dataWidth-1:0] x_out
    );

    Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(0), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_0(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[0*dataWidth+:dataWidth]),
        .outvalid(o_valid[0])

    );
        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(1), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_1(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[1*dataWidth+:dataWidth]),
        .outvalid(o_valid[1])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(2), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_2(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[2*dataWidth+:dataWidth]),
        .outvalid(o_valid[2])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(3), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_3(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[3*dataWidth+:dataWidth]),
        .outvalid(o_valid[3])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(4), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_4(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[4*dataWidth+:dataWidth]),
        .outvalid(o_valid[4])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(5), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_5(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[5*dataWidth+:dataWidth]),
        .outvalid(o_valid[5])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(6), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_6(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[6*dataWidth+:dataWidth]),
        .outvalid(o_valid[6])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(7), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_7(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[7*dataWidth+:dataWidth]),
        .outvalid(o_valid[7])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(8), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_8(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[8*dataWidth+:dataWidth]),
        .outvalid(o_valid[8])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(9), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile(""), .WeightFile("")) n_9(
        .clk(clk),
        .rst(rst),
        .myinput(x_in),
        .myinputValid(x_valid),
        .weightValid(weightValid),
        .biasValid(biasValid),
        .weightValue(weightValue),
        .biasValue(biasValue),
        .config_layer_num(config_layer_num),
        .config_neuron_num(config_neuron_num),
        .out(x_out[9*dataWidth+:dataWidth]),
        .outvalid(o_valid[9])

    );
endmodule
