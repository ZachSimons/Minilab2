module IMGPROC(	 
    oRed,
    oGreen,
    oBlue,
    oDVAL,
    iX_Cont,
    iY_Cont,
    iDATA,
    iDVAL,
    iCLK,
    iRST,
    conv,
    conv_on
);

input	[10:0]	iX_Cont;
input	[10:0]	iY_Cont;
input	[11:0]	iDATA;
input			iDVAL;
input			iCLK;
input			iRST;
input conv, conv_on;
output	[11:0]	oRed;
output	[11:0]	oGreen;
output	[11:0]	oBlue;
output			oDVAL;
wire	[11:0]	mDATA_0;
wire	[11:0]	mDATA_1;

logic   [11:0]  shift_out;
logic   [11:0]  gs_out, conv_out;
logic [10:0] x_out, y_out;

assign oRed = conv_on ? conv_out : gs_out;
assign oBlue = conv_on ? conv_out : gs_out;
assign oGreen = conv_on ? conv_out : gs_out;
assign oDVAL = (x_out > 1) & (y_out > 1);


LINE_BUFFER_1TAP 	u0	(	.clken(iDVAL),
        .clock(iCLK),
        .shiftin(iDATA),
        //.taps0x(mDATA_1),
        //.taps1x(mDATA_0),
        .taps(mDATA_0),	
        .shiftout(shift_out)
        );

greyscale g1(
        .data_in_2(mDATA_0), 
        .data_in_1(iDATA), 
        .clk(iCLK), 
        .rst(iRST), 
        .gs_out(gs_out),
        .y(iY_Cont),
        .x(iX_Cont),
        .x_out(x_out),
        .y_out(y_out)
        );

 convolution c1(
        .iCLK(iCLK),
        .iRST(iRST),
        .iDVAL(iDVAL),
        .vertical(conv),
        .pixel_in(gs_out),
        .pixel_out(conv_out)
        );


endmodule