`timescale 1ns / 1ns


module tb();
    
    reg [3:0] A;
    reg [3:0] B;
    reg Ci;
    wire [3:0] S;
    wire Co;
    wire PG;
    wire GG;
    integer j;
    integer k;

    CLA4 test (.A(A), .B(B), .Ci(Ci), .S(S), .Co(Co), .PG(PG), .GG(GG));
    
    initial begin

            A = 4'b0000;    
            B = 4'b0000; Ci = 0; #10;
            for(j = 0; j < 16; j = j + 1) begin
                A = A + 1; #10;
                for(k = 0; k < 16; k = k + 1) begin
                    B = B + 1; #10;
                end
            end

    end

endmodule
