module IMGPROC(	
	tap0,
    tap1,
    clk,
    rst,
    DVAL
);

    input [11:0] tap0, tap1;
    input clk, rst, DVAL;

    logic [11:0] gs_out, conv_out;

    greyscale greyscale(
        .data_in_2(tap1), 
        .data_in_1(tap0), 
        .clk(clk), 
        .rst(rst), 
        .data_out(gs_out)
    );

    convolution convolution(
        .iCLK(clk),
        .iRST(rst),
        .iDVAL(DVAL),
        .vertical(???),
        .row_2_col_0(gs_out),
        .pixel_out(conv_out)
    );

endmodule