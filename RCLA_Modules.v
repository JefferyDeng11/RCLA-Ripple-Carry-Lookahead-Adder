`timescale 1ns / 1ps
module GPFullAdder (input Ai, Bi, Cin, output G, P, Sum);
    
    assign P = Ai ^  Bi;
    assign G = Ai & Bi;
    
    assign Sum = P ^ Cin;
    
endmodule

module CLALogic(input [3:0] G, [3:0] P, input Ci, output [3:0] C, output Co, PG, GG);
    
   
    assign C[0] = G[0] | (P[0] & Ci);
    assign C[1] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Ci);
    assign C[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Ci);

//    genvar i;
    
//    assign C[0] = Ci;
    
//    generate 
//        for (i = 0; i<4; i = i + 1) begin
//            assign C[i+1] = G[i] | (P[i] & C[i]);
//        end
//    endgenerate   
    
    assign PG = P[0] & P[1] & P[2] & P[3];
    assign GG = G[3] | (P[3] & ((G[2] | P[2] & (G[1] | (P[1] & G[0])))));
    assign Co = GG | (PG & Ci);     
    
endmodule

module CLA4(input [3:0] A, [3:0] B, input Ci, output [3:0] S, output  Co, PG, GG);
    
    wire [3:0] C;
    wire [3:0] prop;
    wire [3:0] gen;
    
    GPFullAdder bitOne     (A[0], B[0], Ci,   gen[0], prop[0], S[0]);
    GPFullAdder bitTwo     (A[1], B[1], C[0], gen[1], prop[1], S[1]);
    GPFullAdder bitThree   (A[2], B[2], C[1], gen[2], prop[2], S[2]);
    GPFullAdder bitFour    (A[3], B[3], C[2], gen[3], prop[3], S[3]);
    
    CLALogic   CLA         (gen, prop, Ci, C, Co, PG, GG);
    
endmodule
