module greyscale (  
    data_in_1,
    data_in_2, 
    data_in_3,
    clk, 
    rst_n, 
    gs_out,
    );

    input [11:0] data_in_1, data_in_2, data_in_3;
    input clk, rst_n;
    output [11:0] gs_out;

    logic [11:0] p1_r1, p2_r1, p1_r2, p2_r2;

    // taking average of 2x2 pixel box and dividing by 4 (shift right by 2)
    //assign gs_out = (p1_r1 + p1_r2 + p2_r1 + p2_r2) >> 2;
    assign gs_out = (data_in_1+data_in_2+data_in_3)/3;

    // flop incoming pixels before computing average
    always_ff @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            p1_r1 <= '0;
            p1_r2 <= '0;
            p2_r1 <= '0;
            p2_r2 <= '0;
        end
        else begin
            //row 1 shift
            p2_r1 <= p1_r1;
            p1_r1 <= data_in_2; // previous row
            //row 2 shift
            p2_r2 <= p1_r2;
            p1_r2 <= data_in_1; // imcoming pixel
        end
    end
endmodule