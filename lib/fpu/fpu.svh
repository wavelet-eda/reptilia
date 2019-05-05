`ifndef __FPU__
`define __FPU__

`include "fpu_utils.svh"

package fpu;

    import fpu_utils::*;

    typedef logic [31:0] fpu_float_t;
    typedef logic        fpu_float_sign_t;
    typedef logic [7:0]  fpu_float_exponent_t;
    typedef logic [22:0] fpu_float_mantissa_t;
    typedef logic [22:0] fpu_float_mantissa_complete_t;

    typedef logic [63:0] fpu_double_t;
    typedef logic        fpu_double_sign_t;
    typedef logic [10:0] fpu_double_exponent_t;
    typedef logic [51:0] fpu_double_mantissa_t;
    typedef logic [52:0] fpu_double_mantissa_complete_t;

    parameter fpu_float_t FPU_FLOAT_ZERO    = 32'h0000_0000;
    parameter fpu_float_t FPU_FLOAT_NAN     = 32'hFFFF_FFFF;
    parameter fpu_float_t FPU_FLOAT_POS_INF = 32'h7F80_0000;
    parameter fpu_float_t FPU_FLOAT_NEG_INF = 32'hFF80_0000;

    typedef struct packed {
        fpu_float_sign_t sign;
        fpu_float_exponent_t exponent;
        fpu_float_mantissa_t mantissa;
    } fpu_float_fields_t;

    typedef struct packed {
        fpu_double_sign_t sign;
        fpu_double_exponent_t exponent;
        fpu_double_mantissa_t mantissa;
    } fpu_double_fields_t;

    typedef struct packed {
        logic inf;
        logic nan;
        logic norm;
        logic zero;
    } fpu_float_conditions_t;

    typedef struct packed {
        logic [1:0] guard;
        logic       sticky;
    } fpu_guard_bits_t;

    typedef enum logic [1:0] {
        FPU_ROUND_MODE_EVEN = 2'd0,
        FPU_ROUND_MODE_DOWN = 2'd1,
        FPU_ROUND_MODE_UP = 2'd2,
        FPU_ROUND_MODE_ZERO = 2'd3
    } fpu_round_mode_t;

    typedef struct packed {
        logic sign;
        logic nan, inf, zero;
        logic [2:0] guard;
        logic [7:0] exponent;
        logic [23:0] mantissa;
        fpu_round_mode_t mode;
    } fpu_result_t;

    typedef struct packed {
        fpu_float_mantissa_t mantissa;
        fpu_guard_bits_t guard;
    } fpu_float_mantissa_result_t;

    typedef struct packed {
        fpu_double_mantissa_t mantissa;
        fpu_guard_bits_t guard;
    } fpu_double_mantissa_result_t;

    function automatic fpu_float_fields_t fpu_decode_float(
        input fpu_float_t raw
    );
        return '{
            sign: raw[31], 
            exponent: raw[30:23], 
            mantissa: raw[22:0]
        };
    endfunction

    function automatic fpu_float_t fpu_encode_float(
        input fpu_float_fields_t decoded
    );
        return {decoded.sign, decoded.exponent, decoded.mantissa};
    endfunction

    function automatic fpu_double_fields_t fpu_decode_double(
        input fpu_double_t raw
    );
        return '{
            sign: raw[63], 
            exponent: raw[62:52], 
            mantissa: raw[51:0]
        };
    endfunction

    function automatic fpu_double_t fpu_encode_double(
        input fpu_double_fields_t decoded
    );
        return {decoded.sign, decoded.exponent, decoded.mantissa};
    endfunction

    function automatic fpu_float_mantissa_complete_t fpu_float_get_mantissa(
        input fpu_float_fields_t fields
    );
        logic denormalized = (fields.exponent == 8'h00);
        return {~denormalized, fields.mantissa};
    endfunction

    function automatic fpu_float_conditions_t fpu_get_conditions(
        input fpu_float_fields_t a
    );
        return '{
            zero: (a.exponent == 0 && a.mantissa == 0),
            norm: (a.exponent != 0),
            nan: (a == FPU_FLOAT_NAN),
            inf: (a == FPU_FLOAT_POS_INF || a == FPU_FLOAT_NEG_INF)
        };
    endfunction

    function automatic fpu_result_t fpu_int2float(
            input logic [31:0] number,
            input logic is_signed
    );
        logic [31:0] mantissa = 'b0;
        logic [7:0] diff;
        logic [4:0] space;
        logic sign, sticky;
        fpu_result_t result;

        sign = number[31];
        if(sign && is_signed) number = ~number + 1;

        space = get_leading_zeros_47({number, 15'd0});
        if(space < 8) begin
            diff = 8 - space;
            sticky = get_sticky_bit_27(number[26:0], diff);
            mantissa = number >> diff;
            mantissa[0] = sticky;
        end else begin
            diff = space - 8;
            mantissa = number << diff;
        end

        if (number == 0) begin
            return 32'd0;
        end

        result.sign = sign;
        result.exponent = (23 + 127 + 8) - space;
        result.mantissa = mantissa[23:0];
        result.nan = 'b0;
        result.inf = 'b0;
        result.zero = 'b0;
        result.guard = 'b0;
        result.mode = FPU_ROUND_MODE_ZERO;
        return result;
    endfunction

    function automatic logic [31:0] fpu_float2int(
            input fpu_float_fields_t float,
            input logic is_signed 
    );
        logic norm = (float.exponent != 0);
        logic [7:0] exp = float.exponent - 'd127;
        logic [54:0] sig = {31'd0, norm, float.mantissa};
        logic [31:0] y;

        if (float.exponent >= 127) begin // Exponent >= 0
            if (is_signed && exp > 30) begin // Signed Overflow
                return float.sign ? 32'h8000_0000 : 32'h7FFF_FFFF;
            end else if (exp > 31) begin // Unsigned Overflow
                return float.sign ? 32'h0000_0000 : 32'hFFFF_FFFF;
            end else begin
                sig = sig << exp;
                y = sig[54:23];
                return float.sign ? (~y + 1) : (y);
            end
        end else begin // Exponent < 0
            return 'b0;
        end
    endfunction

endpackage

`endif
