// Name: mult.v
// Module: MULT32 , MULT32_U
//
// Output: HI: 32 higher bits
//         LO: 32 lower bits
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//
// Notes: 32-bit multiplication
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module MULT32(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A;
input [31:0] B;

// TBD

endmodule

module MULT32_U(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A;
input [31:0] B;

assign LO[0] = p1[0];
assign LO[1] = p2[0];
assign LO[2] = p3[0];
assign LO[3] = p4[0];
assign LO[4] = p5[0];
assign LO[5] = p6[0];
assign LO[6] = p7[0];
assign LO[7] = p8[0];
assign LO[8] = p9[0];
assign LO[9] = p10[0];
assign LO[10] = p11[0];
assign LO[11] = p12[0];
assign LO[12] = p13[0];
assign LO[13] = p14[0];
assign LO[14] = p15[0];
assign LO[15] = p16[0];
assign LO[16] = p17[0];
assign LO[17] = p18[0];
assign LO[18] = p19[0];
assign LO[19] = p20[0];
assign LO[20] = p21[0];
assign LO[21] = p22[0];
assign LO[22] = p23[0];
assign LO[23] = p24[0];
assign LO[24] = p25[0];
assign LO[25] = p26[0];
assign LO[26] = p27[0];
assign LO[27] = p28[0];
assign LO[28] = p29[0];
assign LO[29] = p30[0];
assign LO[30] = p31[0];
assign LO[31] = p32[0];
assign HI = p33;

wire [31:0] w1;w2;w3;w4;w5;w6;w7;w8;w9;w10;w11;w12;w13;w14;w15;w16;w17;w18;w19;w20;w21;w22;w23;w24;w25;w26;w27;w28;w29;w30;w31;w32; //wires for and to adder
wire [31:0] p1;p2;p3;p4;p5;p6;p7;p8;p9;p10;p11;p12;p13;p14;p15;p16;p17;p18;p19;p20;p21;p22;p23;p24;p25;p26;p27;p28;p29;p30;p31;p32; //wires for sum to adder
wire [31:0] o1;o2;o3;o4;o5;o6;o7;o8;o9;o10;o11;o12;o13;o14;o15;o16;o17;o18;o19;o20;o21;o22;o23;o24;o25;o26;o27;o28;o29;o30;o31;o32; //wires for carryout to adder

AND32 a1(.Y(w1),.A(A),.B(B[0]));
AND32 a2(.Y(w2),.A(A),.B(B[1]));
AND32 a3(.Y(w3),.A(A),.B(B[2]));
AND32 a4(.Y(w4),.A(A),.B(B[3]));
AND32 a5(.Y(w5),.A(A),.B(B[4]));
AND32 a6(.Y(w6),.A(A),.B(B[5]));
AND32 a7(.Y(w7),.A(A),.B(B[6]));
AND32 a8(.Y(w8),.A(A),.B(B[7]));
AND32 a9(.Y(w9),.A(A),.B(B[8]));
AND32 a10(.Y(w10),.A(A),.B(B[9]));
AND32 a11(.Y(w11),.A(A),.B(B[10]));
AND32 a12(.Y(w12),.A(A),.B(B[11]));
AND32 a13(.Y(w13),.A(A),.B(B[12]));
AND32 a14(.Y(w14),.A(A),.B(B[13]));
AND32 a15(.Y(w15),.A(A),.B(B[14]));
AND32 a16(.Y(w16),.A(A),.B(B[15]));
AND32 a17(.Y(w17),.A(A),.B(B[16]));
AND32 a18(.Y(w18),.A(A),.B(B[17]));
AND32 a19(.Y(w19),.A(A),.B(B[18]));
AND32 a20(.Y(w20),.A(A),.B(B[19]));
AND32 a21(.Y(w21),.A(A),.B(B[20]));
AND32 a22(.Y(w22),.A(A),.B(B[21]));
AND32 a23(.Y(w23),.A(A),.B(B[22]));
AND32 a24(.Y(w24),.A(A),.B(B[23]));
AND32 a25(.Y(w25),.A(A),.B(B[24]));
AND32 a26(.Y(w26),.A(A),.B(B[25]));
AND32 a27(.Y(w27),.A(A),.B(B[26]));
AND32 a28(.Y(w28),.A(A),.B(B[27]));
AND32 a29(.Y(w29),.A(A),.B(B[28]));
AND32 a30(.Y(w30),.A(A),.B(B[29]));
AND32 a31(.Y(w31),.A(A),.B(B[30]));
AND32 a32(.Y(w32),.A(A),.B(B[31]));

AND32 a33(.Y(p1),.A(A),.B(B[0]));

RC_ADD_SUB_32 add1(.Y(p2), .CO(o2), .A(a1), .B({o1,p1[31:1]}), .SnA(0));
RC_ADD_SUB_32 add2(.Y(p3), .CO(o3), .A(a), .B({o2,p2[31:1]}), .SnA(0));
RC_ADD_SUB_32 add3(.Y(p4), .CO(o4), .A(a), .B({o3,p3[31:1]}), .SnA(0));
RC_ADD_SUB_32 add4(.Y(p5), .CO(o5), .A(a), .B({o4,p4[31:1]}), .SnA(0));
RC_ADD_SUB_32 add5(.Y(p6), .CO(o6), .A(a), .B({o5,p5[31:1]}), .SnA(0));
RC_ADD_SUB_32 add6(.Y(p7), .CO(o7), .A(a), .B({o6,p6[31:1]}), .SnA(0));
RC_ADD_SUB_32 add7(.Y(p8), .CO(o8), .A(a), .B({o7,p7[31:1]}), .SnA(0));
RC_ADD_SUB_32 add8(.Y(p9), .CO(o9), .A(a), .B({o8,p8[31:1]}), .SnA(0));
RC_ADD_SUB_32 add9(.Y(p10), .CO(o10), .A(a), .B({o9,p9[31:1]}), .SnA(0));
RC_ADD_SUB_32 add10(.Y(p11), .CO(o11), .A(a), .B({o10,p10[31:1]}), .SnA(0));
RC_ADD_SUB_32 add11(.Y(p12), .CO(o12), .A(a), .B({o11,p11[31:1]}), .SnA(0));
RC_ADD_SUB_32 add12(.Y(p13), .CO(o13), .A(a), .B({o12,p12[31:1]}), .SnA(0));
RC_ADD_SUB_32 add13(.Y(p14), .CO(o14), .A(a), .B({o13,p13[31:1]}), .SnA(0));
RC_ADD_SUB_32 add14(.Y(p15), .CO(o15), .A(a), .B({o14,p14[31:1]}), .SnA(0));
RC_ADD_SUB_32 add15(.Y(p16), .CO(o16), .A(a), .B({o15,p15[31:1]}), .SnA(0));
RC_ADD_SUB_32 add16(.Y(p17), .CO(o17), .A(a), .B({o16,p16[31:1]}), .SnA(0));
RC_ADD_SUB_32 add17(.Y(p18), .CO(o18), .A(a), .B({o17,p17[31:1]}), .SnA(0));
RC_ADD_SUB_32 add18(.Y(p19), .CO(o19), .A(a), .B({o18,p18[31:1]}), .SnA(0));
RC_ADD_SUB_32 add19(.Y(p20), .CO(o20), .A(a), .B({o19,p19[31:1]}), .SnA(0));
RC_ADD_SUB_32 add20(.Y(p21), .CO(o21), .A(a), .B({o20,p20[31:1]}), .SnA(0));
RC_ADD_SUB_32 add21(.Y(p22), .CO(o22), .A(a), .B({o21,p21[31:1]}), .SnA(0));
RC_ADD_SUB_32 add22(.Y(p23), .CO(o23), .A(a), .B({o22,p22[31:1]}), .SnA(0));
RC_ADD_SUB_32 add23(.Y(p24), .CO(o24), .A(a), .B({o23,p23[31:1]}), .SnA(0));
RC_ADD_SUB_32 add24(.Y(p25), .CO(o25), .A(a), .B({o24,p24[31:1]}), .SnA(0));
RC_ADD_SUB_32 add25(.Y(p26), .CO(o26), .A(a), .B({o25,p25[31:1]}), .SnA(0));
RC_ADD_SUB_32 add26(.Y(p27), .CO(o27), .A(a), .B({o26,p26[31:1]}), .SnA(0));
RC_ADD_SUB_32 add27(.Y(p28), .CO(o28), .A(a), .B({o27,p27[31:1]}), .SnA(0));
RC_ADD_SUB_32 add28(.Y(p29), .CO(o29), .A(a), .B({o28,p28[31:1]}), .SnA(0));
RC_ADD_SUB_32 add29(.Y(p30), .CO(o30), .A(a), .B({o29,p29[31:1]}), .SnA(0));
RC_ADD_SUB_32 add30(.Y(p31), .CO(o31), .A(a), .B({o30,p30[31:1]}), .SnA(0));
RC_ADD_SUB_32 add31(.Y(p32), .CO(o32), .A(a), .B({o31,p31[31:1]}), .SnA(0));
RC_ADD_SUB_32 add32(.Y(p33), .CO(o33), .A(a), .B({o32,p32[31:1]}), .SnA(0));




endmodule

module AND32(Y,A,B);
output [31:0] Y;
output [31:0] A;
output [31:0] B;

genvar i;
generate
for
(i=0; i<32; i=i+1)
begin : and32_gen_loop
       and nor_inst(Y[i], A[i], B[i]);    
end
endgenerate
endmodule