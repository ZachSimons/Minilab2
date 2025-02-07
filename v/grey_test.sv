module grey_tb();

logic clk, rst;
logic [11:0] data_out, data_in_1, data_in_2;

greyscale greyscale(
.data_in_2(data_in_2), 
.data_in_1(data_in_1), 
.clk(clk), 
.rst(rst), 
.data_out(data_out)
);

initial begin 
    clk = 0;
    rst = 0;
    @(negedge clk)
    rst = 1;
end

always begin 
    #5 clk = ~clk;
end

always @(posedge clk or negedge rst) begin
    if (~rst) begin
        data_in_2 <= 0;
        data_in_1 <= 0;
    end
    else begin
        data_in_2 <= data_in_2 + 20;
        data_in_1 <= data_in_1 + 10;
    end
end


endmodule