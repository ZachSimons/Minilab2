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

// signals for each square of 3x3 matrix
// pixel_in is our row 2 col 2 (most current pixel)
logic [11:0] row_0_col_0;
logic [11:0] row_0_col_1, row_0_col_2; 

logic [11:0] row_1_col_0;
logic [11:0] row_1_col_1, row_1_col_2;

logic [11:0] row_2_col_0;
logic [11:0] row_2_col_1;

// convolution buffer with 3 taps for 3x3 square
Line_Buffer1 u0 (
	.clken(iDVAL),
	.clock(iCLK),
	.shiftin(pixel_in),
	.shiftout(),
	.taps0x(row_1_col_2),
	.taps1x(row_0_col_2)
);

// FFs for cols 1 & 0
// flop the taps and incoming pixel twice so we can have all
// the data of our 3x3 matrix to compute the convolution
always @(posedge iCLK, negedge iRST) begin
    if (!iRST) begin
        row_0_col_1 <= 0;
        row_0_col_0 <= 0;
        row_1_col_1 <= 0;
        row_1_col_0 <= 0;
        row_2_col_1 <= 0;
        row_2_col_0 <= 0;
    end
    else begin
    row_0_col_1 <= row_0_col_2;
    row_0_col_0 <= row_0_col_1;
    row_1_col_1 <= row_1_col_2;
    row_1_col_0 <= row_1_col_1;
    row_2_col_1 <= pixel_in;
    row_2_col_0 <= row_2_col_1;
    end
end

//sobel vertical matrix
assign sobel_vert[0][0] = -12'd1;
assign sobel_vert[0][1] = 12'd0;
assign sobel_vert[0][2] = 12'd1;
assign sobel_vert[1][0] = -12'd2;
assign sobel_vert[1][1] = 12'd0;
assign sobel_vert[1][2] = 12'd2;
assign sobel_vert[2][0] = -12'd1;
assign sobel_vert[2][1] = 12'd0;
assign sobel_vert[2][2] = 12'd1;

// sobel horizontal matrix
assign sobel_hor[0][0] = -12'd1;
assign sobel_hor[0][1] = -12'd2;
assign sobel_hor[0][2] = -12'd1;
assign sobel_hor[1][0] = 12'd0;
assign sobel_hor[1][1] = 12'd0;
assign sobel_hor[1][2] = 12'd0;
assign sobel_hor[2][0] = 12'd1;
assign sobel_hor[2][1] = 12'd2;
assign sobel_hor[2][2] = 12'd1;

// convolution computation
assign pixel_out_vert = (sobel_vert[0][0] * row_0_col_0) + 
                        (sobel_vert[0][1] * row_0_col_1) + 
                        (sobel_vert[0][2] * row_0_col_2) + 
                        (sobel_vert[1][0] * row_1_col_0) + 
                        (sobel_vert[1][1] * row_1_col_1) + 
                        (sobel_vert[1][2] * row_1_col_2) + 
                        (sobel_vert[2][0] * row_2_col_0) + 
                        (sobel_vert[2][1] * row_2_col_1) + 
                        (sobel_vert[2][2] * pixel_in);

assign pixel_out_hor =  (sobel_hor[0][0] * row_0_col_0) + 
                        (sobel_hor[0][1] * row_0_col_1) + 
                        (sobel_hor[0][2] * row_0_col_2) + 
                        (sobel_hor[1][0] * row_1_col_0) + 
                        (sobel_hor[1][1] * row_1_col_1) + 
                        (sobel_hor[1][2] * row_1_col_2) + 
                        (sobel_hor[2][0] * row_2_col_0) + 
                        (sobel_hor[2][1] * row_2_col_1) + 
                        (sobel_hor[2][2] * pixel_in);

// choose whether to output vertical or horizontal convolution
assign pixel_out_noabs = vertical ? pixel_out_vert : pixel_out_hor;

// take absolute value of our result
assign pixel_out = pixel_out_noabs[11] ? -pixel_out_noabs : pixel_out_noabs;

endmodule