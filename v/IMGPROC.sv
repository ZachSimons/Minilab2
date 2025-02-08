module IMGPROC(
    iDATA,
    iDVAL,
    iCLK,
    iRST,
    conv_dir,
    conv_on,
    img_proc_out
);

input	[11:0]	iDATA;
input		iDVAL;
input		iCLK;
input		iRST;
input           conv_dir; 
input           conv_on;
output  [11:0]  img_proc_out;

wire	[11:0]	mDATA_0;
logic   [11:0]  gs_out, conv_out;

// assigning pixel output based off if convolution is enabled
assign img_proc_out = conv_on ? conv_out : gs_out;

// line buffer where tap output will be used as input for greyscale
LINE_BUFFER_1TAP u0(	
        .clken(iDVAL),
        .clock(iCLK),
        .shiftin(iDATA),
        .taps(mDATA_0),	
        .shiftout()
        );

// outputting greyscale pixel by taking average of 2x2 matrix
greyscale g1(
        .data_in_2(mDATA_0), 
        .data_in_1(iDATA), 
        .clk(iCLK), 
        .rst_n(iRST), 
        .gs_out(gs_out),
        );

// using greyscale output as input for 3x3 convolution
// can select between vertical or horizontal edge detection
 convolution c1(
        .iCLK(iCLK),
        .iRST(iRST),
        .iDVAL(iDVAL),
        .vertical(conv_dir),
        .pixel_in(gs_out),
        .pixel_out(conv_out)
        );

endmodule