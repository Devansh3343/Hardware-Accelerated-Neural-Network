`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2025 08:02:59 PM
// Design Name: 
// Module Name: Neuron
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

`define DEBUG

`include "include.v"
module Neuron #(parameter layerNo=0, neuronNo=0, numWeight=784, dataWidth=16, sigmoidSize=5, weightIntWidth=1, actType="relu", biasFile="", weightFile="")(
    input clk,
    input rst,
    input [dataWidth-1:0] myinput,
    input myinputValid,
    input weightValid,
    input biasValid,
    input [31:0] weightValue,
    input [31:0] biasValue,
    input [31:0] config_layer_num,
    input [31:0] config_neuron_num,
    output [dataWidth-1:0] out,
    output reg outvalid
    );

    parameter addressWidth = $clog2(numWeight);

    reg wen;
    wire ren;
    reg [addressWidth-1:0] w_addr;
    reg [addressWidth:0] r_addr;

    reg [dataWidth-1:0] win;
    wire [dataWidth-1:0] wout;
    reg [dataWidth-1:0] myinputdelay;

    reg [2*dataWidth-1:0] mul;
    reg [2*dataWidth-1:0] sum;
    reg [2*dataWidth-1:0] bias;
    reg[31:0] biasReg[0:0];

    reg weight_valid;
    reg mult_valid;
    wire mux_valid;
    reg sigValid;

    wire [2*dataWidth:0] comboAdd;
    wire [2*dataWidth:0] BiasAdd;
    reg muxValid_d;
    reg muxValid_f;
    reg addr=0;

    

    

    


    always @(posedge clk) begin 
        if(rst)
        begin 
            w_addr <= {addressWidth{1'b1}}; //replicate 1 for as many digits as addressWidth
            wen <= 0;

        end
        else if (weightValid & (config_layer_num == layerNo) & (config_neuron_num == neuronNo)) //checks if the weight is supposed to be for this layer and this neuron
        begin
            win <= weightValue;
            w_addr <= w_addr + 1; //increment address to 
            wen <= 1;
        end
        else
            wen<=0;
            
        end

    `ifdef pretrained
        initial 
        begin
            $readmemb(biasFile, biasReg);
        end
        always @(posedge clk) begin
        bias <= {biasReg[addr][dataWidth-1:0], {dataWidth{1'b0}}};
        end
    `else
        always @(posedge clk)
            begin
                if(biasValid & (config_layer_num==layerNo) & (config_neuron_num==neuronNo))
                begin
                    bias <={biasValue[dataWidth-1:0], {dataWidth{1'b0}}};
                end
            end
    `endif

    //delays the input
    always @(posedge clk) begin 
        myinputdelay <= myinput;

        weight_valid <= myinputValid;
        mult_valid <= weight_valid;
        sigValid <= ((r_addr == numWeight) & muxValid_f) ? 1'b1 : 1'b0;
        outvalid <= sigValid;
        muxValid_d <= mux_valid;
        muxValid_f <= !mux_valid & muxValid_d;

    end

    always @(posedge clk)begin 
        if(rst|outvalid)
            r_addr<=0;
        else if(myinputValid)
            r_addr<=r_addr+1;
    end

    //multiplies the delayed input and the output of the weight memory
    always @(posedge clk) begin
        mul <= $signed(myinputdelay) * $signed(wout);
    
    end


        assign mux_valid = mult_valid;
        assign comboAdd = mul+sum;
        assign BiasAdd = bias+sum;
        assign ren = myinputValid;


    always @(posedge clk) begin 
        if(rst|outvalid)
            sum <= 0;
        
        else if((r_addr == numWeight) & muxValid_f)
        begin
            if(!bias[2*dataWidth-1] & !sum[2*dataWidth-1] & BiasAdd[2*dataWidth-1]) begin
                sum[2*dataWidth-1] <= 1'b0;
                sum[2*dataWidth-2:0] <= {2*dataWidth-1{1'b1}};
            end
            else if(bias[2*dataWidth-1] & sum[2*dataWidth-1] & !BiasAdd[2*dataWidth-1]) begin
                sum[2*dataWidth-1] <= 1'b1;
                sum[2*dataWidth-2:0] <= {2*dataWidth-1{1'b0}};
            end
            else
                sum<=BiasAdd;
                
        end

        else if(mux_valid)
        begin
            if(!mul[2*dataWidth-1] & !sum[2*dataWidth-1] & comboAdd[2*dataWidth-1]) begin //overflow Handling aka when you add 2 positive numbers and the result is negative something went wrong
                sum[2*dataWidth-1] <= 1'b0;
                sum[2*dataWidth-2:0] <= {2*dataWidth-1{1'b1}};
        end
        else if(mul[2*dataWidth-1] & sum[2*dataWidth-1] & !comboAdd[2*dataWidth-1]) begin //underflow Handling aka when you add 2 negative numbers and the output is a positive number
            sum[2*dataWidth-1] <= 1'b1;
            sum[2*dataWidth-2:0] <= {2*dataWidth-1{1'b0}};
        end
        else
            sum <=comboAdd;
        end
    end

    

    

    Weight_Memory #(.numWeight(numWeight), .neuronNo(neuronNo), .layerNo(layerNo), .addressWidth(addressWidth), .dataWidth(dataWidth), .weightFile(weightFile)) WM(
        .clk(clk),
        .wen(wen),
        .ren(ren),
        .wadd(w_addr),
        .radd(r_addr),
        .win(win),
        .wout(wout)
    );

    generate
        
        if(actType == "sigmoid")
        begin:sigmoidinst
            Sigmoid_ROM #(.inWidth(sigmoidSize), .dataWidth(dataWidth)) s1 (
                .clk(clk),
                .x(sum[2*dataWidth-1-:sigmoidSize]),
                .out(out)
            );
        end
        else
        begin:ReLuInst
            ReLu #(.dataWidth(dataWidth), .weightIntWidth(weightIntWidth)) s1(
                .clk(clk),
                .x(sum),
                .out(out)
            );

        end

    endgenerate

    `ifdef DEBUG
    always @(posedge clk) begin
        if(outvalid)
            $display(neuronNo,,,,"%b", out);
    end
    `endif

    
endmodule
