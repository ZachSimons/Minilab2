`timescale 1ns / 1ps
module tb_IMGPROC;

  // Testbench signals
  reg [10:0]  iX_Cont;       // X coordinate of current pixel
  reg [10:0]  iY_Cont;       // Y coordinate of current pixel
  reg [11:0]  iDATA;         // Pixel data value
  reg         iDVAL;         // Data valid signal
  reg         iCLK;          // Clock
  reg         iRST;          // Reset
  
  wire [11:0] oRed;          // Output red value
  wire [11:0] oGreen;        // Output green value
  wire [11:0] oBlue;         // Output blue value
  wire        oDVAL;         // Output data valid signal

  // Instantiate the IMGPROC module
  IMGPROC uut (
    .oRed(oRed),
    .oGreen(oGreen),
    .oBlue(oBlue),
    .oDVAL(oDVAL),
    .iX_Cont(iX_Cont),
    .iY_Cont(iY_Cont),
    .iDATA(iDATA),
    .iDVAL(iDVAL),
    .iCLK(iCLK),
    .iRST(iRST)
  );

  // Clock generation
  always begin
    #5 iCLK = ~iCLK;  // Clock period of 10 units
  end

  // Test sequence
  initial begin
    // Initialize signals
    iCLK = 0;
    iRST = 0;
    iDVAL = 0;
    iX_Cont = 0;
    iY_Cont = 0;
    iDATA = 12'h000;  // Initialize with 0 pixel data

    // Apply reset
    #10;
    iRST = 1;
    //#10;
    //iRST = 0;
    iDVAL = 1;

    // Send pixel data for a 6x8 grid
    // First row
    send_pixel(0, 0, 12'h001);
    send_pixel(1, 0, 12'h002);
    send_pixel(2, 0, 12'h003);
    send_pixel(3, 0, 12'h004);
    send_pixel(4, 0, 12'h005);
    send_pixel(5, 0, 12'h006);
    send_pixel(6, 0, 12'h007);
    send_pixel(7, 0, 12'h008);

    // Second row
    send_pixel(0, 1, 12'h009);
    send_pixel(1, 1, 12'h00A);
    send_pixel(2, 1, 12'h00B);
    send_pixel(3, 1, 12'h00C);
    send_pixel(4, 1, 12'h00D);
    send_pixel(5, 1, 12'h00E);
    send_pixel(6, 1, 12'h00F);
    send_pixel(7, 1, 12'h010);

    // Third row
    send_pixel(0, 2, 12'h011);
    send_pixel(1, 2, 12'h012);
    send_pixel(2, 2, 12'h013);
    send_pixel(3, 2, 12'h014);
    send_pixel(4, 2, 12'h015);
    send_pixel(5, 2, 12'h016);
    send_pixel(6, 2, 12'h017);
    send_pixel(7, 2, 12'h018);

    // Fourth row
    send_pixel(0, 3, 12'h019);
    send_pixel(1, 3, 12'h01A);
    send_pixel(2, 3, 12'h01B);
    send_pixel(3, 3, 12'h01C);
    send_pixel(4, 3, 12'h01D);
    send_pixel(5, 3, 12'h01E);
    send_pixel(6, 3, 12'h01F);
    send_pixel(7, 3, 12'h020);

    // Fifth row
    send_pixel(0, 4, 12'h021);
    send_pixel(1, 4, 12'h022);
    send_pixel(2, 4, 12'h023);
    send_pixel(3, 4, 12'h024);
    send_pixel(4, 4, 12'h025);
    send_pixel(5, 4, 12'h026);
    send_pixel(6, 4, 12'h027);
    send_pixel(7, 4, 12'h028);

    // Sixth row
    send_pixel(0, 5, 12'h029);
    send_pixel(1, 5, 12'h02A);
    send_pixel(2, 5, 12'h02B);
    send_pixel(3, 5, 12'h02C);
    send_pixel(4, 5, 12'h02D);
    send_pixel(5, 5, 12'h02E);
    send_pixel(6, 5, 12'h02F);
    send_pixel(7, 5, 12'h030);


    ///////////// second frame //////////////

    // Send pixel data for a 6x8 grid
    // First row
    send_pixel(0, 0, 12'h001);
    send_pixel(1, 0, 12'h002);
    send_pixel(2, 0, 12'h003);
    send_pixel(3, 0, 12'h004);
    send_pixel(4, 0, 12'h005);
    send_pixel(5, 0, 12'h006);
    send_pixel(6, 0, 12'h007);
    send_pixel(7, 0, 12'h008);

    // Second row
    send_pixel(0, 1, 12'h009);
    send_pixel(1, 1, 12'h00A);
    send_pixel(2, 1, 12'h00B);
    send_pixel(3, 1, 12'h00C);
    send_pixel(4, 1, 12'h00D);
    send_pixel(5, 1, 12'h00E);
    send_pixel(6, 1, 12'h00F);
    send_pixel(7, 1, 12'h010);

    // Third row
    send_pixel(0, 2, 12'h011);
    send_pixel(1, 2, 12'h012);
    send_pixel(2, 2, 12'h013);
    send_pixel(3, 2, 12'h014);
    send_pixel(4, 2, 12'h015);
    send_pixel(5, 2, 12'h016);
    send_pixel(6, 2, 12'h017);
    send_pixel(7, 2, 12'h018);

    // Fourth row
    send_pixel(0, 3, 12'h019);
    send_pixel(1, 3, 12'h01A);
    send_pixel(2, 3, 12'h01B);
    send_pixel(3, 3, 12'h01C);
    send_pixel(4, 3, 12'h01D);
    send_pixel(5, 3, 12'h01E);
    send_pixel(6, 3, 12'h01F);
    send_pixel(7, 3, 12'h020);

    // Fifth row
    send_pixel(0, 4, 12'h021);
    send_pixel(1, 4, 12'h022);
    send_pixel(2, 4, 12'h023);
    send_pixel(3, 4, 12'h024);
    send_pixel(4, 4, 12'h025);
    send_pixel(5, 4, 12'h026);
    send_pixel(6, 4, 12'h027);
    send_pixel(7, 4, 12'h028);

    // Sixth row
    send_pixel(0, 5, 12'h029);
    send_pixel(1, 5, 12'h02A);
    send_pixel(2, 5, 12'h02B);
    send_pixel(3, 5, 12'h02C);
    send_pixel(4, 5, 12'h02D);
    send_pixel(5, 5, 12'h02E);
    send_pixel(6, 5, 12'h02F);
    send_pixel(7, 5, 12'h030);

    // End simulation after the test
    #50;
    $stop;
  end

  // Task to send pixel data with valid signal
  task send_pixel(input [10:0] x, input [10:0] y, input [11:0] data);
    begin
      iX_Cont = x;
      iY_Cont = y;
      iDATA = data;
      //iDVAL = 1;  // Set data valid high when sending pixel data
      //#10;         // Wait 10 time units
      //iDVAL = 0;   // Set data valid low after sending pixel
      #10;         // Wait for 10 time units before sending the next pixel
    end
  endtask

always @(posedge iCLK) begin
    if (oDVAL) begin
    $display("current output: %h", oRed);
    end
end

endmodule