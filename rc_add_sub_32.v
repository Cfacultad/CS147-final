A// Name: rc_add_sub_32.v
// Module: RC_ADD_SUB_32
//
// Output: Y : Output 32-bit
//         CO : Carry Out
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//        SnA : if SnA=0 it is add, subtraction otherwise
//
// Notes: 32-bit adder / subtractor implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module RC_ADD_SUB_64(Y, CO, A, B, SnA);
// output list
output [63:0] Y;
output CO;
// input list
input [63:0] A;
input [63:0] B;
input SnA;




endmodule

module RC_ADD_SUB_32(Y, CO, A, B, SnA);
// output list
output [`DATA_INDEX_LIMIT:0] Y;
output CO;
// input list
input [`DATA_INDEX_LIMIT:0] A;
input [`DATA_INDEX_LIMIT:0] B;
input SnA;

//CI to CO wires
wire x1; x2;x3;x4;x5;x6;x7;x8;x9;x10;x11;x12;x13;x14;x15;x16;x17;x18;x19;x20;
wire x21;x22;x23;x24;x25;x26;x27;x28;x29x;x30;x31;x32;
//CO to CI wires
wire y1; y2;y3;y4;y5;y6;y7;y8;y9;y10;y11;y12;y13;y14;y15;y16;y17;y18;y19;y20;
wire y21;y22;y23;y24;y25;y26;y27;y28;y29;y30;y31;

//instantiate full adders
full_adder fa_01(.S(Y[0]), .CO(y1), .A(A[0]), .B(B[0] xor SnA), .CI(SnA));
full_adder fa_02(.S(Y[1]), .CO(y2), .A(A[1]), .B(B[1] xor SnA), .CI(y1));
full_adder fa_03(.S(Y[2]), .CO(y3), .A(A[2]), .B(B[2] xor SnA), .CI(y2));
full_adder fa_04(.S(Y[3]), .CO(y4), .A(A[3]), .B(B[3] xor SnA), .CI(y3));
full_adder fa_05(.S(Y[4]), .CO(y5), .A(A[4]), .B(B[4] xor SnA), .CI(y4));
full_adder fa_06(.S(Y[5]), .CO(y6), .A(A[5]), .B(B[5] xor SnA), .CI(y5));
full_adder fa_07(.S(Y[6]), .CO(y7), .A(A[6]), .B(B[6] xor SnA), .CI(y6));
full_adder fa_08(.S(Y[7]), .CO(y8), .A(A[7]), .B(B[7] xor SnA), .CI(y7));
full_adder fa_09(.S(Y[8]), .CO(y9), .A(A[8]), .B(B[8] xor SnA), .CI(y8));
full_adder fa_10(.S(Y[9]), .CO(y10), .A(A[9]), .B(B[9] xor SnA), .CI(y9));
full_adder fa_11(.S(Y[10]), .CO(y11), .A(A[10]), .B(B[10] xor SnA), .CI(y10));
full_adder fa_12(.S(Y[11]), .CO(y12), .A(A[11]), .B(B[11] xor SnA), .CI(y11));
full_adder fa_13(.S(Y[12]), .CO(y13), .A(A[12]), .B(B[12] xor SnA), .CI(y12));
full_adder fa_14(.S(Y[13]), .CO(y14), .A(A[13]), .B(B[13] xor SnA), .CI(y13));
full_adder fa_15(.S(Y[14]), .CO(y15), .A(A[14]), .B(B[14] xor SnA), .CI(y14));
full_adder fa_16(.S(Y[15]), .CO(y16), .A(A[15]), .B(B[15] xor SnA), .CI(y15));
full_adder fa_17(.S(Y[16]), .CO(y17), .A(A[16]), .B(B[16] xor SnA), .CI(y16));
full_adder fa_18(.S(Y[17]), .CO(y18), .A(A[17]), .B(B[17] xor SnA), .CI(y17));
full_adder fa_19(.S(Y[18]), .CO(y19), .A(A[18]), .B(B[18] xor SnA), .CI(y18));
full_adder fa_20(.S(Y[19]), .CO(y20), .A(A[19]), .B(B[19] xor SnA), .CI(y19));
full_adder fa_21(.S(Y[20]), .CO(y21), .A(A[20]), .B(B[20] xor SnA), .CI(y20));
full_adder fa_22(.S(Y[21]), .CO(y22), .A(A[21]), .B(B[21] xor SnA), .CI(y21));
full_adder fa_23(.S(Y[22]), .CO(y23), .A(A[22]), .B(B[22] xor SnA), .CI(y22));
full_adder fa_24(.S(Y[23]), .CO(y24), .A(A[23]), .B(B[23] xor SnA), .CI(y23));
full_adder fa_25(.S(Y[24]), .CO(y25), .A(A[24]), .B(B[24] xor SnA), .CI(y24));
full_adder fa_26(.S(Y[25]), .CO(y26), .A(A[25]), .B(B[25] xor SnA), .CI(y25));
full_adder fa_27(.S(Y[26]), .CO(y27), .A(A[26]), .B(B[26] xor SnA), .CI(y26));
full_adder fa_28(.S(Y[27]), .CO(y28), .A(A[27]), .B(B[27] xor SnA), .CI(y27));
full_adder fa_29(.S(Y[28]), .CO(y29), .A(A[28]), .B(B[28] xor SnA), .CI(y28));
full_adder fa_30(.S(Y[29]), .CO(y30), .A(A[29]), .B(B[29] xor SnA), .CI(y29));
full_adder fa_31(.S(Y[30]), .CO(y31), .A(A[30]), .B(B[30] xor SnA), .CI(y30));
full_adder fa_32(.S(Y[31]), .CO(CO), .A(A[31]), .B(B[31] xor SnA), .CI(y31));

endmodule

