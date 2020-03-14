// Name: control_unit.v
// Module: CONTROL_UNIT
// Output: RF_DATA_W  : Data to be written at register file address RF_ADDR_W
//         RF_ADDR_W  : Register file address of the memory location to be written
//         RF_ADDR_R1 : Register file address of the memory location to be read for RF_DATA_R1
//         RF_ADDR_R2 : Registere file address of the memory location to be read for RF_DATA_R2
//         RF_READ    : Register file Read signal
//         RF_WRITE   : Register file Write signal
//         ALU_OP1    : ALU operand 1
//         ALU_OP2    : ALU operand 2
//         ALU_OPRN   : ALU operation code
//         MEM_ADDR   : Memory address to be read in
//         MEM_READ   : Memory read signal
//         MEM_WRITE  : Memory write signal
//         
// Input:  RF_DATA_R1 : Data at ADDR_R1 address
//         RF_DATA_R2 : Data at ADDR_R1 address
//         ALU_RESULT    : ALU output data
//         CLK        : Clock signal
//         RST        : Reset signal
//
// INOUT: MEM_DATA    : Data to be read in from or write to the memory
//
// Notes: - Control unit synchronize operations of a processor
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//  1.1     Oct 19, 2014        Kaushik Patra   kpatra@sjsu.edu         Added ZERO status output
//------------------------------------------------------------------------------------------
`include "prj_definition.v"
module CONTROL_UNIT(MEM_DATA, RF_DATA_W, RF_ADDR_W, RF_ADDR_R1, RF_ADDR_R2, RF_READ, RF_WRITE,
                    ALU_OP1, ALU_OP2, ALU_OPRN, MEM_ADDR, MEM_READ, MEM_WRITE,
                    RF_DATA_R1, RF_DATA_R2, ALU_RESULT, ZERO, CLK, RST); 

// Output signals
// Outputs for register file 
output [`DATA_INDEX_LIMIT:0] RF_DATA_W;
output [`ADDRESS_INDEX_LIMIT:0] RF_ADDR_W, RF_ADDR_R1, RF_ADDR_R2;
output RF_READ, RF_WRITE;
// Outputs for ALU
output [`DATA_INDEX_LIMIT:0]  ALU_OP1, ALU_OP2;
output  [`ALU_OPRN_INDEX_LIMIT:0] ALU_OPRN;
// Outputs for memory
output [`ADDRESS_INDEX_LIMIT:0]  MEM_ADDR;
output MEM_READ, MEM_WRITE;

// Input signals
input [`DATA_INDEX_LIMIT:0] RF_DATA_R1, RF_DATA_R2, ALU_RESULT;
input ZERO, CLK, RST;

// Inout signal
inout [`DATA_INDEX_LIMIT:0] MEM_DATA;

// State nets
wire [2:0] proc_state;

//define register for write data to memory
reg [`DATA_INDEX_LIMIT:0] mem_data;
inout [`DATA_INDEX_LIMIT:0] MEM_DATA;
assign MEM_DATA = mem_data;

reg [`ADDRESS_INDEX_LIMIT:0] mem_addr;
assign MEM_ADDR = mem_addr;

reg mem_read;
assign MEM_READ = mem_read;
reg mem_write;
assign MEM_WRITE= mem_write;


//internal registers and assignments
reg [`DATA_INDEX_LIMIT:0] PC_REG;
reg [`DATA_INDEX_LIMIT:0] INST_REG;
reg [`DATA_INDEX_LIMIT:0] SP_REF;

reg rf_read;
assign RF_READ = rf_read;
reg rf_write;
assign RF_WRITE= rf_write;

reg [`DATA_INDEX_LIMIT:0] rf_dataw;
assign RF_DATA_W = rf_dataw;
reg [`ADDRESS_INDEX_LIMIT:0] rf_dataw_addr;
assign RF_ADDR_W = rf_dataw_addr;
reg [`ADDRESS_INDEX_LIMIT:0] rf_datar_addr1;
assign RF_ADDR_R1= rf_datar_addr1;
reg [`ADDRESS_INDEX_LIMIT:0] rf_datar_addr2;
assign RF_ADDR_R2= rf_datar_addr2;

reg [`DATA_INDEX_LIMIT:0] alu_op1;
assign ALU_OP1 = alu_op1;
reg [`DATA_INDEX_LIMIT:0] alu_op2;
assign ALU_OP2 = alu_op2;
reg [`ALU_OPRN_INDEX_LIMIT:0] alu_oprn;
assign ALU_OPRN = alu_oprn;

//for parsing opcodes
reg [5:0]   opcode; 
reg [4:0]   rs; 
reg [4:0]   rt; 
reg [4:0]   rd; 
reg [4:0]   shamt; 
reg [5:0]   funct; 
reg [15:0]  immediate; 
reg [25:0]  address;
reg [32:0] zero_extend_imm;
reg [32:0] sign_extend_imm;
reg [32:0] lui;
reg [32:0] jump_address;
reg [32:0] branch_address;

PROC_SM state_machine(.STATE(proc_state),.CLK(CLK),.RST(RST));

always @ (proc_state)
begin
case (proc_state)
`PROC_FETCH:
	begin
		//begin with loading instruction from memory using PC
		mem_addr = PC_REG;
		mem_write = 1;
		mem_read = 0;
		//set register file control to hold
		rf_read = 0;
		rf_write = 0;
	end

`PROC_DECODE:
	begin
		//store memory read into instruction reg
		INST_REG = MEM_DATA;
		{opcode, rs, rt, rd, shamt, funct} = INST_REG;
		{opcode, rs, rt, immediate } = INST_REG;
		{opcode, address} = INST_REG;
		//prepare some registers for use by certain instructions
		zero_extend_imm = {6'b0,immediate};
		sign_extend_imm = {$signed(immediate)};
		lui = {immediate,16'b0};
		jump_address = {6'b0,address};
		rf_datar_addr1 = rs;
		rf_datar_addr2 = rt;
	end
`PROC_EXE:
	begin
	case(opcode)
		//R instructions
		6'h0 :
		begin
		alu_op1 = rs;
		alu_op2 = rt;
			case(funct)
			//add
			5'h20 : alu_oprn = `ALU_OPRN_WIDTH'h01 ;
			//sub
			5'h22 : alu_oprn = `ALU_OPRN_WIDTH'h02 ;
			//mul
			5'h2c : alu_oprn = `ALU_OPRN_WIDTH'h03 ;
			//and
			5'h24 : alu_oprn = `ALU_OPRN_WIDTH'h06 ;
			//or
			5'h25 : alu_oprn = `ALU_OPRN_WIDTH'h07 ;
			//nor
			5'h27 : alu_oprn = `ALU_OPRN_WIDTH'h08 ;
			//slt
			5'h2a : alu_oprn = `ALU_OPRN_WIDTH'h09 ;
			//sll
			
			5'h01 : begin alu_op2 = shamt;alu_oprn = `ALU_OPRN_WIDTH'h04 ; end
			//srl
			
			5'h02 : begin alu_op2 = shamt; alu_oprn = `ALU_OPRN_WIDTH'h05 ; end
			//jr
			5'h08 : PC_REG = rs;
			endcase
		end
		// I instructions
		//addi
		6'h08 : begin
			alu_oprn = `ALU_OPRN_WIDTH'h01 ;
			alu_op1 = rs;
			alu_op2 = sign_extend_imm;
			end
		//muli
		6'h1d : begin
			alu_oprn = `ALU_OPRN_WIDTH'h03 ;
			alu_op1 = rs;
			alu_op2 = sign_extend_imm;
			end
		//andi
		6'h1d : begin
			alu_oprn = `ALU_OPRN_WIDTH'h06 ;
			alu_op1 = rs;
			alu_op2 = zero_extend_imm;
			end
			
		//ori
		6'h1d : begin
			alu_oprn = `ALU_OPRN_WIDTH'h07 ;
			alu_op1 = rs;
			alu_op2 = zero_extend_imm;
			end
			
		//lui
		6'h1d : rt = lui;
			
		//slti
		6'h1d : begin
			alu_oprn = `ALU_OPRN_WIDTH'h09 ;
			alu_op1 = rs;
			alu_op2 = sign_extend_imm;
			end
			
		//beq
		//6'h1d : begin
			//TODO
			

		//bne
		//6'h1d : begin
			//TODO
			
		//lw
		//6'h1d : begin
			//TODO
			
		//sw
		//6'h1d : begin
			//TODO
		//J instructions
		//jmp
		//6'02 : PC = jump_address;
		//jal
		//6'03 : 
		//push
		//pop
			
		endcase
					
	end
`PROC_MEM:
	begin
	end
`PROC_WB:
	begin
	PC_REG = PC_REG  + 1;
	mem_write = 0;
	mem_read = 0;
	rf_write = 1;
	rf_read = 0;
	end
endcase
end
endmodule

//------------------------------------------------------------------------------------------
// Module: CONTROL_UNIT
// Output: STATE      : State of the processor
//         
// Input:  CLK        : Clock signal
//         RST        : Reset signal
//
// INOUT: MEM_DATA    : Data to be read in from or write to the memory
//
// Notes: - Processor continuously cycle witnin fetch, decode, execute, 
//          memory, write back state. State values are in the prj_definition.v
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
module PROC_SM(STATE,CLK,RST);
// list of inputs
input CLK, RST;
// list of outputs
output [2:0] STATE;

// reg list
reg OUT;
reg [1:0] state;
reg [1:0] next_state;

// initiation of state
initial
begin
state = 2'bxx;
next_state = `PROC_FETCH;  
end

//
assign STATE = state;

// reset signal handling
always @ (posedge RST)
begin
state = 2'bxx;
next_state = `PROC_FETCH;
end
// state switching
always @(posedge CLK)
begin
state = next_state;
end


// action on state switching
always @(state)
begin
case(state)
	`PROC_FETCH:
			next_state = `PROC_DECODE;
	`PROC_DECODE:
			next_state = `PROC_EXE;
	`PROC_EXE:
			next_state = `PROC_MEM;
	`PROC_MEM:
			next_state = `PROC_WB;
	`PROC_WB:
			next_state = `PROC_FETCH;

endcase
end
endmodule;