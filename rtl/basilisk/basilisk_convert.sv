`timescale 1ns/1ps

`ifdef __LINTER__

`include "../../lib/std/std_util.svh"
`include "../../lib/isa/rv.svh"
`include "../../lib/isa/rv32.svh"
`include "../../lib/isa/rv32f.svh"
`include "../../lib/fpu/fpu.svh"
`include "../../lib/basilisk/basilisk.svh"

`else

`include "std_util.svh"
`include "rv.svh"
`include "rv32.svh"
`include "rv32f.svh"
`include "basilisk.svh"
`include "fpu.svh"

`endif

module basilisk_convert
    import rv::*;
    import rv32::*;
    import rv32f::*;
    import fpu::*;
    import basilisk::*;
#(
    parameter int OUTPUT_REGISTER_MODE = 1
)(
    input logic clk, rst,

    std_stream_intf.in convert_command, // basilisk_convert_command_t
    std_stream_intf.out convert_result // basilisk_result_t
);

    std_stream_intf #(.T(basilisk_result_t)) next_convert_result (.clk, .rst);

    logic enable, consume, produce;

    std_flow_lite #(
        .NUM_INPUTS(1),
        .NUM_OUTPUTS(1)
    ) std_flow_lite_inst (
        .clk, .rst,

        .valid_input({convert_command.valid}),
        .ready_input({convert_command.ready}),

        .valid_output({next_convert_result.valid}),
        .ready_output({next_convert_result.ready}),

        .consume, .produce, .enable
    );

    std_flow_stage #(
        .T(basilisk_result_t),
        .MODE(OUTPUT_REGISTER_MODE)
    ) output_stage_inst (
        .clk, .rst,
        .stream_in(next_convert_result), .stream_out(convert_result)
    );

    always_comb begin
        automatic basilisk_convert_command_t cmd = basilisk_convert_command_t'(convert_command.payload);
        automatic logic a_lt_b;
        automatic fpu_result_t result = '{
            sign: 'b0,
            nan: 'b0,
            inf: 'b0,
            zero: 'b0,
            guard: 'b0,
            exponent: 'b0,
            mantissa: 'b0,
            mode: FPU_ROUND_MODE_ZERO
        };

        consume = 'b1;
        produce = 'b1;

        a_lt_b = ({cmd.a.sign, cmd.a.exponent, cmd.a.mantissa} < {cmd.b.sign, cmd.b.exponent, cmd.b.mantissa});

        result.sign = cmd.a.sign;
        result.exponent = cmd.a.exponent;
        result.mantissa = cmd.a.mantissa;

        case (cmd.op)
        BASILISK_CONVERT_OP_MIN: begin
            if (cmd.conditions_a.nan || cmd.conditions_b.nan) begin
                result.nan = 'b1;
            end else if (!a_lt_b) begin
                result.sign = cmd.b.sign;
                result.exponent = cmd.b.exponent;
                result.mantissa = cmd.b.mantissa;
            end
        end
        BASILISK_CONVERT_OP_MAX: begin 
            if (cmd.conditions_a.nan || cmd.conditions_b.nan) begin
                result.nan = 'b1;
            end else if (a_lt_b) begin
                result.sign = cmd.b.sign;
                result.exponent = cmd.b.exponent;
                result.mantissa = cmd.b.mantissa;
            end
        end
        BASILISK_CONVERT_OP_RAW: begin 
        end
        BASILISK_CONVERT_OP_CNV: begin
            result = fpu_int2float({cmd.a.sign, cmd.a.exponent, cmd.a.mantissa}, cmd.signed_integer);
        end
        endcase

        next_convert_result.payload.dest_reg_addr = cmd.dest_reg_addr;
        next_convert_result.payload.dest_offset_addr = cmd.dest_offset_addr;
        next_convert_result.payload.result = result;
    end

endmodule
