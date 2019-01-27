`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/19 14:01:08
// Design Name: 
// Module Name: DAC0832
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


module DAC0832(
    input clk_100M,
    output dac_cs_n,
    output dac_wr1_n,
    output dac_wr2_n,
    output dac_xfer_n,
    output dac_ile,
    output [7:0] sine
    );
    wire clk_10M;
    wire clk_ila_T;
    wire clk_ila;
    reg [15:0] phase_tdata;
    wire [7:0] data_tdata;
    wire data_tvalid;
    assign dac_ile =1;
    assign dac_cs_n=0;
    assign dac_wr1_n=0;
    assign dac_wr2_n=0;
    assign dac_xfer_n=0;
    assign sine=data_tdata[7:0]+8'd128;
    
    always @(posedge clk_10M)begin
        if(phase_tdata<16'b1111_1111_1111_1111)begin
            phase_tdata <= phase_tdata+16'd65;
        end
        else begin
            phase_tdata <=16'd0;
        end
    end
    
    clk_wiz_0 clk(
        .clk_in1(clk_100M),
        .clk_out1(clk_10M),
        .clk_out2(clk_ila_T)
    );
    
    dds_compiler_0 dds_inst(
        .aclk(clk_10M),
        .s_axis_phase_tvalid(1'b1),
        .s_axis_phase_tdata(phase_tdata),
        .m_axis_data_tvalid(data_tvalid),
        .m_axis_data_tdata(data_tdata)                
    );
    BUFGCE_1 BUFFGCE_1_inst(
        .O(clk_ila),
        .CE(1'b1),
        .I(clk_ila_T)
    );
    ila_0 ila4DDS(
        .clk(clk_ila),
        .probe0(data_tdata+8'd128)
    );

endmodule
