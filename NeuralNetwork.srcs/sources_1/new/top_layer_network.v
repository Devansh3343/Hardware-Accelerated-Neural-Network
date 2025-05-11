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
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`include "include.v"

module top_layer_network #(
      parameter integer C_S_AXI_DATA_WIDTH = 32,
      parameter integer C_S_AXI_ADDR_WIDTH = 5
  )(
      input  wire                   axi_clk,
      input  wire                   axi_asyncrst,

      //axi stream interface
      input  wire [ `dataWidth-1:0] axi_indata,
      input  wire                   axi_indata_valid,
      output wire                   axi_indata_ready,

      // axi lite interface
      input  wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR,
      input  wire [2:0]                   S_AXI_AWPROT,
      input  wire                         S_AXI_AWVALID,
      output wire                         S_AXI_AWREADY,
      input  wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA,
      input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB,
      input  wire                         S_AXI_WVALID,
      output wire                         S_AXI_WREADY,
      output wire [1:0]                   S_AXI_BRESP,
      output wire                         S_AXI_BVALID,
      input  wire                         S_AXI_BREADY,
      input  wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR,
      input  wire [2:0]                   S_AXI_ARPROT,
      input  wire                         S_AXI_ARVALID,
      output wire                         S_AXI_ARREADY,
      output wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA,
      output wire [1:0]                   S_AXI_RRESP,
      output wire                         S_AXI_RVALID,
      input  wire                         S_AXI_RREADY,

      //interrupt interface
      output wire intr
  );

    // -----------------------------------------------------------------------
    // Internal control signals (to be driven by your AXI-Lite interface)
    // -----------------------------------------------------------------------
    wire reset;
    wire [31:0] config_layer_num;
    wire [31:0] config_neuron_num;
    wire [31:0] weightValue;
    wire [31:0] biasValue;
    wire        weightValid;
    wire        biasValid;
    wire        axi_rd_en;
    wire [31:0] axi_rd_data;
    wire softReset;

    wire out_valid;
    wire [31:0] out;
    
  

    assign intr = out_valid;

    //instantiate axilite wrapper
    NN_AXILite_Wrapper_slave_lite_v1_0_S00_AXI #(.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH), .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH)) axiLiteWrapper(
//    axi_lite_wrapper #(.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH), .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH)) axiLiteWrapper(

    .S_AXI_ACLK(axi_clk),
    .S_AXI_ARESETN(axi_asyncrst),
    .S_AXI_AWADDR(S_AXI_AWADDR),
    .S_AXI_AWPROT(S_AXI_AWPROT),
    .S_AXI_AWVALID(S_AXI_AWVALID),
    .S_AXI_AWREADY(S_AXI_AWREADY),
    .S_AXI_WDATA(S_AXI_WDATA),
    .S_AXI_WSTRB(S_AXI_WSTRB),
    .S_AXI_WVALID(S_AXI_WVALID),
    .S_AXI_WREADY(S_AXI_WREADY),
    .S_AXI_BRESP(S_AXI_BRESP),
    .S_AXI_BVALID(S_AXI_BVALID),
    .S_AXI_BREADY(S_AXI_BREADY),
    .S_AXI_ARADDR(S_AXI_ARADDR),
    .S_AXI_ARPROT(S_AXI_ARPROT),
    .S_AXI_ARVALID(S_AXI_ARVALID),
    .S_AXI_ARREADY(S_AXI_ARREADY),
    .S_AXI_RDATA(S_AXI_RDATA),
    .S_AXI_RRESP(S_AXI_RRESP),
    .S_AXI_RVALID(S_AXI_RVALID),
    .S_AXI_RREADY(S_AXI_RREADY),
    .layerNumber(config_layer_num),
    .neuronNumber(config_neuron_num),
    .weightValue(weightValue),
    .weightValid(weightValid),
    .biasValid(biasValid),
    .biasValue(biasValue),
    .nnOut_valid(out_valid),
    .nnOut(out),
    .axi_rd_en(axi_rd_en),
    .axi_rd_data(axi_rd_data),
    .softReset(softReset)
    );
    
    // -----------------------------------------------------------------------
    // Tie off AXI-Stream ready
    // -----------------------------------------------------------------------
    assign axi_indata_ready = 1'b1;

    // Active-high reset
    assign reset = ~axi_asyncrst|softReset;

    // State constants
    localparam IDLE = 'd0,
               SEND = 'd1;

    // -----------------------------------------------------------------------
    // Layer 1 instantiation + pipeline FSM
    // -----------------------------------------------------------------------
    wire [ `numNeuronLayer1-1          :0] o1_valid;
    wire [ `numNeuronLayer1*`dataWidth-1:0] x1_out;
    reg  [ `numNeuronLayer1*`dataWidth-1:0] hold_data1;
    reg  [ `dataWidth-1               :0] out_data_1;
    reg                                    data_out_valid_1;
    reg                                    state_1;
    integer                                count_1;

    Layer1 #(
        .NN(`numNeuronLayer1),
        .numWeight(`numWeightLayer1),
        .dataWidth(`dataWidth),
        .layerNum(1),
        .sigmoidSize(`sigmoidSize),
        .weightIntWidth(`weightIntWidth),
        .actType(`Layer1ActType)
    ) l1 (
        .clk            (axi_clk),
        .rst            (reset),
        .weightValid    (weightValid),
        .biasValid      (biasValid),
        .weightValue    (weightValue),
        .biasValue      (biasValue),
        .config_layer_num (config_layer_num),
        .config_neuron_num(config_neuron_num),
        .x_valid        (axi_indata_valid),
        .x_in           (axi_indata),
        .o_valid        (o1_valid),
        .x_out          (x1_out)
    );

    always @(posedge axi_clk) begin
        if (reset) begin
            state_1          <= IDLE;
            count_1          <= 0;
            data_out_valid_1 <= 0;
        end else begin
            case (state_1)
                IDLE: begin
                    count_1          <= 0;
                    data_out_valid_1 <= 1'b0;
                    if (o1_valid[0] == 1'b1) begin
                        hold_data1 <= x1_out;
                        state_1    <= SEND;
                    end
                end
                SEND: begin
                    out_data_1        <= hold_data1[`dataWidth-1:0];
                    hold_data1        <= hold_data1 >> `dataWidth;
                    count_1           <= count_1 + 1;
                    data_out_valid_1  <= 1;
                    if (count_1 == `numNeuronLayer1) begin
                        state_1          <= IDLE;
                        data_out_valid_1 <= 0;
                    end
                end
            endcase
        end
    end

    // -----------------------------------------------------------------------
    // Layer 2 instantiation + pipeline FSM
    // -----------------------------------------------------------------------
    wire [ `numNeuronLayer2-1          :0] o2_valid;
    wire [ `numNeuronLayer2*`dataWidth-1:0] x2_out;
    reg  [ `numNeuronLayer2*`dataWidth-1:0] hold_data2;
    reg  [ `dataWidth-1               :0] out_data_2;
    reg                                    data_out_valid_2;
    reg                                    state_2;
    integer                                count_2;

    Layer2 #(
        .NN(`numNeuronLayer2),
        .numWeight(`numWeightLayer2),
        .dataWidth(`dataWidth),
        .layerNum(2),
        .sigmoidSize(`sigmoidSize),
        .weightIntWidth(`weightIntWidth),
        .actType(`Layer2ActType)
    ) l2 (
        .clk            (axi_clk),
        .rst            (reset),
        .weightValid    (weightValid),
        .biasValid      (biasValid),
        .weightValue    (weightValue),
        .biasValue      (biasValue),
        .config_layer_num (config_layer_num),
        .config_neuron_num(config_neuron_num),
        .x_valid        (data_out_valid_1),
        .x_in           (out_data_1),
        .o_valid        (o2_valid),
        .x_out          (x2_out)
    );

    always @(posedge axi_clk) begin
        if (reset) begin
            state_2          <= IDLE;
            count_2          <= 0;
            data_out_valid_2 <= 0;
        end else begin
            case (state_2)
                IDLE: begin
                    count_2          <= 0;
                    data_out_valid_2 <= 0;
                    if (o2_valid[0] == 1'b1) begin
                        hold_data2 <= x2_out;
                        state_2    <= SEND;
                    end
                end
                SEND: begin
                    out_data_2        <= hold_data2[`dataWidth-1:0];
                    hold_data2        <= hold_data2 >> `dataWidth;
                    count_2           <= count_2 + 1;
                    data_out_valid_2  <= 1;
                    if (count_2 == `numNeuronLayer2) begin
                        state_2          <= IDLE;
                        data_out_valid_2 <= 0;
                    end
                end
            endcase
        end
    end

    // -----------------------------------------------------------------------
    // Layer 3 instantiation + pipeline FSM
    // -----------------------------------------------------------------------
    wire [ `numNeuronLayer3-1          :0] o3_valid;
    wire [ `numNeuronLayer3*`dataWidth-1:0] x3_out;
    reg  [ `numNeuronLayer3*`dataWidth-1:0] hold_data3;
    reg  [ `dataWidth-1               :0] out_data_3;
    reg                                    data_out_valid_3;
    reg                                    state_3;
    integer                                count_3;

    Layer3 #(
        .NN(`numNeuronLayer3),
        .numWeight(`numWeightLayer3),
        .dataWidth(`dataWidth),
        .layerNum(3),
        .sigmoidSize(`sigmoidSize),
        .weightIntWidth(`weightIntWidth),
        .actType(`Layer3ActType)
    ) l3 (
        .clk            (axi_clk),
        .rst            (reset),
        .weightValid    (weightValid),
        .biasValid      (biasValid),
        .weightValue    (weightValue),
        .biasValue      (biasValue),
        .config_layer_num (config_layer_num),
        .config_neuron_num(config_neuron_num),
        .x_valid        (data_out_valid_2),
        .x_in           (out_data_2),
        .o_valid        (o3_valid),
        .x_out          (x3_out)
    );

    always @(posedge axi_clk) begin
        if (reset) begin
            state_3          <= IDLE;
            count_3          <= 0;
            data_out_valid_3 <= 0;
        end else begin
            case (state_3)
                IDLE: begin
                    count_3          <= 0;
                    data_out_valid_3 <= 0;
                    if (o3_valid[0]==1'b1) begin
                        hold_data3 <= x3_out;
                        state_3    <= SEND;
                    end
                end
                SEND: begin
                    out_data_3        <= hold_data3[`dataWidth-1:0];
                    hold_data3        <= hold_data3 >> `dataWidth;
                    count_3           <= count_3 + 1;
                    data_out_valid_3  <= 1;
                    if (count_3 == `numNeuronLayer3) begin
                        state_3          <= IDLE;
                        data_out_valid_3 <= 0;
                    end
                end
            endcase
        end
    end

    // -----------------------------------------------------------------------
    // Layer 4 instantiation + pipeline FSM
    // -----------------------------------------------------------------------
    wire [ `numNeuronLayer4-1          :0] o4_valid;
    wire [ `numNeuronLayer4*`dataWidth-1:0] x4_out;
    reg  [ `numNeuronLayer4*`dataWidth-1:0] hold_data4;
    reg  [ `dataWidth-1               :0] out_data_4;
    reg                                    data_out_valid_4;
    reg                                    state_4;
    integer                                count_4;

    Layer4 #(
        .NN(`numNeuronLayer4),
        .numWeight(`numWeightLayer4),
        .dataWidth(`dataWidth),
        .layerNum(4),
        .sigmoidSize(`sigmoidSize),
        .weightIntWidth(`weightIntWidth),
        .actType(`Layer4ActType)
    ) l4 (
        .clk            (axi_clk),
        .rst            (reset),
        .weightValid    (weightValid),
        .biasValid      (biasValid),
        .weightValue    (weightValue),
        .biasValue      (biasValue),
        .config_layer_num (config_layer_num),
        .config_neuron_num(config_neuron_num),
        .x_valid        (data_out_valid_3),
        .x_in           (out_data_3),
        .o_valid        (o4_valid),
        .x_out          (x4_out)
    );

    always @(posedge axi_clk) begin
        if (reset) begin
            state_4          <= IDLE;
            count_4          <= 0;
            data_out_valid_4 <= 0;
        end else begin
            case (state_4)
                IDLE: begin
                    count_4          <= 0;
                    data_out_valid_4 <= 0;
                    if (o4_valid[0]==1'b1) begin
                        hold_data4 <= x4_out;
                        state_4    <= SEND;
                    end
                end
                SEND: begin
                    out_data_4        <= hold_data4[`dataWidth-1:0];
                    hold_data4        <= hold_data4 >> `dataWidth;
                    count_4           <= count_4 + 1;
                    data_out_valid_4  <= 1;
                    if (count_4 == `numNeuronLayer4) begin
                        state_4          <= IDLE;
                        data_out_valid_4 <= 0;
                    end
                end
            endcase
        end
    end
    
    reg [`numNeuronLayer4*`dataWidth-1:0] hold_data5;

    always @(posedge axi_clk) begin
        if(o4_valid[0] == 1'b1)
            hold_data5 <= x4_out;
        else if(axi_rd_en)
        hold_data5 <= hold_data5>>`dataWidth;
    end
    
        assign axi_rd_data = hold_data5[`dataWidth-1:0];
    

    // -----------------------------------------------------------------------
    // Find max and output
    // -----------------------------------------------------------------------


    maxFinder #(
        .numInput  (`numNeuronLayer4),
        .inputWidth(`dataWidth)
    ) mFind (
        .i_clk       (axi_clk),       // fixed to use axi_clk
        .i_data      (x4_out),
        .i_valid     (o4_valid),
        .o_data      (out),
        .o_data_valid(out_valid)
    );



endmodule
