module convolution (
    input iCLK,
    input iRST,
    input iDVAL,
    input vertical,
    input [11:0] pixel_in,
    output [11:0] pixel_out
);

logic signed [11:0] sobel_vert [3][3];
logic signed [11:0] sobel_hor [3][3];
logic [11:0] pixel_out_vert, pixel_out_hor, pixel_out_noabs;

// wire for col 0, reg for col 1 & 2
logic [11:0] row_0_col_0;
logic [11:0] row_0_col_1, row_0_col_2;

logic [11:0] row_1_col_0;
logic [11:0] row_1_col_1, row_1_col_2;

logic [11:0] row_2_col_0;
logic [11:0] row_2_col_1, row_2_col_2;

// convolution buffer with 3 taps for 3x3 square
CONV_BUFFER u0 (
    .aclr(~rst_n),
	.clken(iDVAL),
	.clock(clk),
	.shiftin(pixel_in),
	.shiftout(),
	.taps0x(row_2_col_2),
	.taps1x(row_1_col_2),
	.taps2x(row_0_col_2)
);

// FFs for cols 1 & 2
always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        row_0_col_1 <= 0;
        row_0_col_0 <= 0;
        row_1_col_1 <= 0;
        row_1_col_0 <= 0;
        row_2_col_1 <= 0;
        row_2_col_0 <= 0;
    end
    row_0_col_1 <= row_0_col_2;
    row_0_col_0 <= row_0_col_1;
    row_1_col_1 <= row_1_col_2;
    row_1_col_0 <= row_1_col_1;
    row_2_col_1 <= row_2_col_2;
    row_2_col_0 <= row_2_col_1;
end

//sobel vertical
assign sobel_vert[0][0] = -12'd1;
assign sobel_vert[0][1] = 12'd0;
assign sobel_vert[0][2] = 12'd1;
assign sobel_vert[1][0] = -12'd2;
assign sobel_vert[1][1] = 12'd0;
assign sobel_vert[1][2] = 12'd2;
assign sobel_vert[2][0] = -12'd1;
assign sobel_vert[2][1] = 12'd0;
assign sobel_vert[2][2] = 12'd1;

// sobel horizontal
assign sobel_hor[0][0] = -12'd1;
assign sobel_hor[0][1] = -12'd2;
assign sobel_hor[0][2] = -12'd1;
assign sobel_hor[1][0] = 12'd0;
assign sobel_hor[1][1] = 12'd0;
assign sobel_hor[1][2] = 12'd0;
assign sobel_hor[2][0] = 12'd1;
assign sobel_hor[2][1] = 12'd2;
assign sobel_hor[2][2] = 12'd1;

assign pixel_out_vert = (sobel_vert[0][0] * row_0_col_0) + 
                        (sobel_vert[0][1] * row_0_col_1) + 
                        (sobel_vert[0][2] * row_0_col_2) + 
                        (sobel_vert[1][0] * row_1_col_0) + 
                        (sobel_vert[1][1] * row_1_col_1) + 
                        (sobel_vert[1][2] * row_1_col_2) + 
                        (sobel_vert[2][0] * row_2_col_0) + 
                        (sobel_vert[2][1] * row_2_col_1) + 
                        (sobel_vert[2][2] * row_2_col_2);

assign pixel_out_hor =  (sobel_hor[0][0] * row_0_col_0) + 
                        (sobel_hor[0][1] * row_0_col_1) + 
                        (sobel_hor[0][2] * row_0_col_2) + 
                        (sobel_hor[1][0] * row_1_col_0) + 
                        (sobel_hor[1][1] * row_1_col_1) + 
                        (sobel_hor[1][2] * row_1_col_2) + 
                        (sobel_hor[2][0] * row_2_col_0) + 
                        (sobel_hor[2][1] * row_2_col_1) + 
                        (sobel_hor[2][2] * row_2_col_2);

assign pixel_out_noabs = vertical ? pixel_out_vert : pixel_out_hor;
assign pixel_out = pixel_out_noabs[11] ? -pixel_out_noabs : pixel_out_noabs;

endmodule