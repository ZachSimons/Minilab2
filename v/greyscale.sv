module greyscale (
    data_in_1,
    data_in_2, 
    clk, 
    rst, 
    data_out
    );

    input [11:0] shift_in, data_in_1, data_in_2;
    input clk, rst;
    output [11:0] data_out;

    logic [11:0] p1_r1, p2_r1, p1_r2, p2_r2;
    
    assign data_out = (p1_r1 + p1_r2 + p2_r1 + p2_r2) >> 2;

    always_ff @(posedge clk, negedge rst) begin
        if(~rst) begin
            p1_r1 <= '0;
            p1_r2 <= '0;
            p2_r1 <= '0;
            p2_r2 <= '0;
        end
        else begin
            //row 1 shift
            p2_r1 <= p1_r1;
            p1_r1 <= data_in_2; //tap1
            //row 2 shift
            p2_r2 <= p1_r2;
            p1_r2 <= data_in_1; //tap0
        end
    end


endmodule