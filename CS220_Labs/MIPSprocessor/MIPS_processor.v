`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:15:46 04/10/2024 
// Design Name: 
// Module Name:    MIPS_processor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define MAX_PC 11
// `define OPCODE [31:25]
`define OUTPUT_REG 4

module MIPS_processor(clk, leds);

    // inputs
    input clk;

    // outputs
    output [7:0] leds;
    reg [7:0] leds;

    // immediates
    reg [31:0] memory [0:10] ; // 32 bits wide memory, having 11 rows
    reg [7:0] data [0:2] ; // 8 bits wide data, having a,b,c
    reg [7:0] counter = 0 ; // 8 bit counter initialized to zero
    reg [2:0] state = 0 ;
    reg [7:0] regFile [0:31] ;
    reg [31:0] inst ;

    reg [7:0] read_data ;
    reg [7:0] read_address ; // 8 bit read address 

    reg [5:0] opcode ;
    reg [4:0] dest_address ;
    reg [4:0] src1_address ;
    reg [4:0] src2_address ;
    reg [4:0] shift ;
    reg [6:0] func ;
    reg [15:0] imdt ;

    reg [7:0] src1 ; 
    reg [7:0] src2 ; 
	 reg [7:0] srcd ; 
    reg [7:0] result ; 
    reg flag = 0 ; 
    initial begin
        // initialize a,b and c 

        data[0] <= 8'b11101100; // - 20
        data[1] <= 8'b00001010; // 10
        data[2] <= 8'b00000010; // 2


        // initialize memory 

        memory[0] <= 32'b100011_00001_00000_0000000000000000; // lw $1, 0($0)
        memory[1] <= 32'b100011_00010_00000_0000000000000001; // lw $2, 1($0)
        memory[2] <= 32'b100011_00011_00000_0000000000000010; // lw $3, 2($0)
        memory[3] <= 32'b001001_00100_00000_0000000000000000; // addiu $4, $0, 0
        memory[4] <= 32'b001001_00101_00001_0000000000000000; // addiu $5, $1, 0
        memory[5] <= 32'b000000_00110_00101_00010_00000_101010; // slt $6, $5, $2
        memory[6] <= 32'b000100_00110_00000_0000000000000101; // beq $6, $0, exit , EXIT : 5
        memory[7] <= 32'b000000_00100_00100_00101_00000_100001; // addu $4, $4, $5 // loop
        memory[8] <= 32'b000000_00101_00101_00011_00000_100001; // addu $5, $5, $3
        memory[9] <= 32'b000000_00110_00101_00010_00000_101010; // slt $6, $5, $2
        memory[10] <= 32'b000101_00110_00000_1111111111111101; // bne $6, $0, loop , LOOP : -3


        // initialise regFile to zero

        regFile[0] <= 8'b00000000;
        regFile[1] <= 8'b00000000;
        regFile[2] <= 8'b00000000;
        regFile[3] <= 8'b00000000;
        regFile[4] <= 8'b00000000;
        regFile[5] <= 8'b00000000;
        regFile[6] <= 8'b00000000;
        regFile[6] <= 8'b00000000;
        regFile[7] <= 8'b00000000;
        regFile[8] <= 8'b00000000;
        regFile[9] <= 8'b00000000;
        regFile[10] <= 8'b00000000;
        regFile[11] <= 8'b00000000;
        regFile[12] <= 8'b00000000;
        regFile[13] <= 8'b00000000;
        regFile[14] <= 8'b00000000;
        regFile[15] <= 8'b00000000;
        regFile[16] <= 8'b00000000;
        regFile[17] <= 8'b00000000;
        regFile[18] <= 8'b00000000;
        regFile[19] <= 8'b00000000;
        regFile[20] <= 8'b00000000;
        regFile[21] <= 8'b00000000;
        regFile[22] <= 8'b00000000;
        regFile[23] <= 8'b00000000;
        regFile[24] <= 8'b00000000;
        regFile[25] <= 8'b00000000;
        regFile[26] <= 8'b00000000;
        regFile[27] <= 8'b00000000;
        regFile[28] <= 8'b00000000;
        regFile[29] <= 8'b00000000;
        regFile[30] <= 8'b00000000;
        regFile[31] <= 8'b00000000;

    end

    always @(posedge clk) begin
        case(state)
            0 : begin
                //  reads the instruction from the instruction memory row pointed to by the program counter
                inst <= memory[counter];
                state <= 1;
            end
            1 : begin
                // finds out the fields of the instruction

                opcode <= inst[31:26];
                dest_address <= inst[25:21];
                src1_address <= inst[20:16];

                // for opcode 0
                src2_address <= inst[15:11];
                shift <= inst[10:6];
                func <= inst[5:0];

                // for other opcodes
                imdt <= inst[15:0];

                state <= 2;
            end
            2 : begin
                //  reads the source register operands of the instruction from the register file
                src1 <= regFile[src1_address];
                src2 <= regFile[src2_address];
                srcd <= regFile[dest_address]; // when beq or bne

                state <= 3;
            end
            3 : begin
                // executes the instruction if the instruction is addiu, addu, slt, beq, or bne; 
                // if the instruction is lw, its address is computed; otherwise marks the instruction
                // as invalid. Sets the program counter of the next instruction appropriately
                state <= 4;

                case(opcode)
                    6'b000000 : begin // ALU
                        if (func == 6'b101010) begin // slt
                            result <= src1 < src2 ;
                        end
                        else if ( func == 6'b100001 ) begin // addu
                            result <= src1 + src2 ;
                        end
                        counter <= counter + 1;
                    end
                    6'b100011 : begin // lw
                        read_address <= imdt[7:0] + src1 ;
                        counter <= counter + 1;
                    end
                    6'b001001 : begin // addiu
                        result <= imdt[7:0] + src1 ;
                        counter <= counter + 1;
                    end
                    6'b000100 : begin // beq
                        if ( srcd == src1 ) begin
                            counter <= imdt[7:0];
                        end
                        else begin
                            counter <= counter + 1;
                        end
                    end
                    6'b000101 : begin // bne
                        if ( srcd != src1 ) begin
                            counter <= imdt[7:0];
                        end
                        else begin
                            counter <= counter + 1;
                        end
                    end
                    default : begin // invalid
                        flag <= 1;
                        counter <= counter + 1;
                        // OR
                        // counter <= `MAX_PC;
                    end
                endcase
            end
            4 : begin
                if ( opcode == 6'b100011) begin // lw
                    read_data <= data[read_address];
                end
                state <= 5;
            end
            5 : begin
                if ( flag == 0 && opcode != 6'b000100 && opcode != 6'b000101 && dest_address != 5'b00000) begin // if valid instruction and not a branching instruction and destination operand is not zero
                    regFile[dest_address] <= result ;
                end
                if (counter < `MAX_PC) begin
						 state <= 0;
					 end
					 else begin
						 state <= 6 ;
					 end
            end
            6 : begin
                leds <= regFile[`OUTPUT_REG];
                state <= 7;
					 // leds[0] <= 1; // 
            end
        endcase 
    end
	 
endmodule