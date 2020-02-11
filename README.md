# Reptilia
SystemVerilog implementations of pipelined streams, AXI, RISC-V, and other common physical designs.

## Cores

### Gecko
Small RV32I core with flexible memory interfaces and lightweight AXI interfaces

### Basilisk
Gecko core with both integer math, floating point, and vector extensions

### Iguana
Large RV32G core with multiple coherent memory interfaces and full-featured AXI interfaces

### Komodo
Iguana core with supervisor extensions for booting Unix operating systems

## Folder Structure

rtl/
	Systemverilog (\*.sv) files containing modules that are going to be synthesized into logic 

tb/
	Systemverilog (\*.sv) files with testbenches for verifying the synthesizable logic

## Random Notes
1. ABSOLUTELY NEVER put an interface or module definition in a header file, Vivado loses it brainz
2. Use $bit(interface.bus) instead of interface.BUS_WIDTH to parameterize bit widths when possible
3. When referencing a parameter or type passed through an interface port (i.e my_intf.BUS_WIDTH or $bits(my_intf.bus)), make sure that it is assigned to a localparam, not a parameter
4. Always put interfaces in a seperate \*.sv file.
5. Add this to the synthesis additional options ```-verilog_define SYNTHESIS```
