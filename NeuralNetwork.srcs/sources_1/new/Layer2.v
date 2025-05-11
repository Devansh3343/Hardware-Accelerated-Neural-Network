`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2025 04:32:35 PM
// Design Name: 
// Module Name: Layer1
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


module Layer2 #(parameter NN=30, numWeight=784, dataWidth=16, layerNum=2, sigmoidSize=10, weightIntWidth=4, actType ="relu")
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

    Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(0), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_0.mif"), .weightFile("w_2_0.mif")) n_0(
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
        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(1), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_1.mif"), .weightFile("w_2_1.mif")) n_1(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(2), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_2.mif"), .weightFile("w_2_2.mif")) n_2(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(3), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_3.mif"), .weightFile("w_2_3.mif")) n_3(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(4), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_4.mif"), .weightFile("w_2_4.mif")) n_4(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(5), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_5.mif"), .weightFile("w_2_5.mif")) n_5(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(6), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_6.mif"), .weightFile("w_2_6.mif")) n_6(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(7), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_7.mif"), .weightFile("w_2_7.mif")) n_7(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(8), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_8.mif"), .weightFile("w_2_8.mif")) n_8(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(9), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_9.mif"), .weightFile("w_2_9.mif")) n_9(
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

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(10), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_10.mif"), .weightFile("w_2_10.mif")) n_10(
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
        .out(x_out[10*dataWidth+:dataWidth]),
        .outvalid(o_valid[10])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(11), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_11.mif"), .weightFile("w_2_11.mif")) n_11(
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
        .out(x_out[11*dataWidth+:dataWidth]),
        .outvalid(o_valid[11])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(12), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_12.mif"), .weightFile("w_2_12.mif")) n_12(
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
        .out(x_out[12*dataWidth+:dataWidth]),
        .outvalid(o_valid[12])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(13), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_13.mif"), .weightFile("w_2_13.mif")) n_13(
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
        .out(x_out[13*dataWidth+:dataWidth]),
        .outvalid(o_valid[13])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(14), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_14.mif"), .weightFile("w_2_14.mif")) n_14(
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
        .out(x_out[14*dataWidth+:dataWidth]),
        .outvalid(o_valid[14])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(15), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_15.mif"), .weightFile("w_2_15.mif")) n_15(
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
        .out(x_out[15*dataWidth+:dataWidth]),
        .outvalid(o_valid[15])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(16), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_16.mif"), .weightFile("w_2_16.mif")) n_16(
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
        .out(x_out[16*dataWidth+:dataWidth]),
        .outvalid(o_valid[16])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(17), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_17.mif"), .weightFile("w_2_17.mif")) n_17(
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
        .out(x_out[17*dataWidth+:dataWidth]),
        .outvalid(o_valid[17])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(18), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_18.mif"), .weightFile("w_2_18.mif")) n_18(
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
        .out(x_out[18*dataWidth+:dataWidth]),
        .outvalid(o_valid[18])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(19), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_19.mif"), .weightFile("w_2_19.mif")) n_19(
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
        .out(x_out[19*dataWidth+:dataWidth]),
        .outvalid(o_valid[19])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(20), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_20.mif"), .weightFile("w_2_20.mif")) n_20(
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
        .out(x_out[20*dataWidth+:dataWidth]),
        .outvalid(o_valid[20])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(21), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_21.mif"), .weightFile("w_2_21.mif")) n_21(
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
        .out(x_out[21*dataWidth+:dataWidth]),
        .outvalid(o_valid[21])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(22), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_22.mif"), .weightFile("w_2_22.mif")) n_22(
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
        .out(x_out[22*dataWidth+:dataWidth]),
        .outvalid(o_valid[22])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(23), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_23.mif"), .weightFile("w_2_23.mif")) n_23(
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
        .out(x_out[23*dataWidth+:dataWidth]),
        .outvalid(o_valid[23])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(24), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_24.mif"), .weightFile("w_2_24.mif")) n_24(
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
        .out(x_out[24*dataWidth+:dataWidth]),
        .outvalid(o_valid[24])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(25), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_25.mif"), .weightFile("w_2_25.mif")) n_25(
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
        .out(x_out[25*dataWidth+:dataWidth]),
        .outvalid(o_valid[25])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(26), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_26.mif"), .weightFile("w_2_26.mif")) n_26(
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
        .out(x_out[26*dataWidth+:dataWidth]),
        .outvalid(o_valid[26])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(27), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_27.mif"), .weightFile("w_2_27.mif")) n_27(
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
        .out(x_out[27*dataWidth+:dataWidth]),
        .outvalid(o_valid[27])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(28), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_28.mif"), .weightFile("w_2_28.mif")) n_28(
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
        .out(x_out[28*dataWidth+:dataWidth]),
        .outvalid(o_valid[28])

    );

        Neuron #(.numWeight(numWeight), .layerNo(layerNum), .neuronNo(29), .dataWidth(dataWidth), .sigmoidSize(sigmoidSize), .weightIntWidth(weightIntWidth), .actType(actType), .biasFile("b_2_29.mif"), .weightFile("w_2_29.mif")) n_29(
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
        .out(x_out[29*dataWidth+:dataWidth]),
        .outvalid(o_valid[29])

    );

endmodule
