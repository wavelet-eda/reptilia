`timescale 1ns/1ps

`ifdef __LINTER__

`include "../../lib/std/std_util.svh"
`include "../../lib/isa/rv.svh"
`include "../../lib/isa/rv32.svh"
`include "../../lib/isa/rv32f.svh"
`include "../../lib/fpu/fpu.svh"
`include "../../lib/fpu/fpu_mult.svh"
`include "../../lib/basilisk/basilisk.svh"

`else

`include "std_util.svh"
`include "rv.svh"
`include "rv32.svh"
`include "rv32f.svh"
`include "basilisk.svh"
`include "fpu.svh"
`include "fpu_mult.svh"

`endif

module basilisk_mult_operation
    import rv::*;
    import rv32::*;
    import rv32f::*;
    import fpu::*;
    import fpu_mult::*;
    import basilisk::*;
#(
    parameter int OUTPUT_REGISTER_MODE = 1
)(
    input logic clk, rst,

    std_stream_intf.in mult_exponent_command, // basilisk_mult_exponent_command_t
    std_stream_intf.out mult_operation_command  // basilisk_mult_operation_command_t
);

    std_stream_intf #(.T(basilisk_mult_operation_command_t)) next_mult_operation_command (.clk, .rst);

    logic enable, consume, produce;

    std_flow_lite #(
        .NUM_INPUTS(1),
        .NUM_OUTPUTS(1)
    ) std_flow_lite_inst (
        .clk, .rst,

        .valid_input({mult_exponent_command.valid}),
        .ready_input({mult_exponent_command.ready}),

        .valid_output({next_mult_operation_command.valid}),
        .ready_output({next_mult_operation_command.ready}),

        .consume, .produce, .enable
    );

    std_flow_stage #(
        .T(basilisk_mult_operation_command_t),
        .MODE(OUTPUT_REGISTER_MODE)
    ) output_stage_inst (
        .clk, .rst,
        .stream_in(next_mult_operation_command), .stream_out(mult_operation_command)
    );

    always_comb begin
        consume = 'b1;
        produce = 'b1;

        next_mult_operation_command.payload.result = fpu_float_mult_operation(
                mult_exponent_command.payload.result
        );
        next_mult_operation_command.payload.enable_macc = mult_exponent_command.payload.enable_macc;
        next_mult_operation_command.payload.c = mult_exponent_command.payload.c;
        next_mult_operation_command.payload.conditions_c = mult_exponent_command.payload.conditions_c;

        next_mult_operation_command.payload.dest_reg_addr = mult_exponent_command.payload.dest_reg_addr;
        next_mult_operation_command.payload.dest_offset_addr = mult_exponent_command.payload.dest_offset_addr;
    end

endmodule
