module greyscale ( 
    data_in_1,
    data_in_2, 
    clk, 
    rst, 
    gs_out,
    x,
    y,
    x_out,
    y_out
    );

    input [11:0] data_in_1, data_in_2;
    input [10:0] x,y;
    input clk, rst;
    output [11:0] gs_out;
    output logic [10:0] x_out, y_out;

    parameter XMAX = 1278;
    parameter YMAX = 958;

    logic [11:0] p1_r1, p2_r1, p1_r2, p2_r2;
    logic count;
    
    logic [11:0] data_out_ff, data_out, data_out_even, data_out_odd;

    assign data_out = (p1_r1 + p1_r2 + p2_r1 + p2_r2) >> 2;
    assign data_out_even = (p1_r1*2 + p1_r2 + p2_r1 + p2_r2*2) >> 2;
    assign data_out_odd = (p1_r1 + p1_r2*2 + p2_r1*2 + p2_r2) >> 2;
    assign gs_out = count ? data_out_ff : data_out;

    always_ff @(posedge clk, negedge rst) begin
        if(~rst) begin
            p1_r1 <= '0;
            p1_r2 <= '0;
            p2_r1 <= '0;
            p2_r2 <= '0;
            x_out <= 0;
            y_out <= 0;
            count <= 0;
            data_out_ff <= 0;
        end
        else begin
            //row 1 shift
            p2_r1 <= p1_r1;
            p1_r1 <= data_in_2; //tap1
            //row 2 shift
            p2_r2 <= p1_r2;
            p1_r2 <= data_in_1; //tap0
            data_out_ff <= data_out;

            if(count == 0) begin 
                count <= 1;
            end
            else begin
                count <= 0;
            end


            if(y_out == YMAX && x_out==XMAX) begin
                x_out <= 0;
                y_out <= 0;
            end  
            else if(x_out == XMAX && y>1) begin
                x_out <= 0;
                y_out <= y_out + 1;
            end
            else if(x > 1 && y > 0) begin // start counter for current frame
                x_out <= x_out + 1;
            end
        end
    end


endmodule