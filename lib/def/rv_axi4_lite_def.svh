`ifndef __RV_AXI4_LITE_DEF__
`define __RV_AXI4_LITE_DEF__

/*
 * Write Address Defines
 */

`define RV_AXI4_LITE_AW_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_AW_PORTS(output, input, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_AW_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_AW_PORTS(input, output, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_AW_PORTS(FLOW_DIR, BACKFLOW_DIR, PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    FLOW_DIR wire ``PREFIX``_AWVALID, BACKFLOW_DIR wire ``PREFIX``_AWREADY, \
    FLOW_DIR wire [ADDR_WIDTH-1:0] ``PREFIX``_AWADDR, \
    FLOW_DIR wire [2:0]            ``PREFIX``_AWPROT

`define RV_AXI4_LITE_AW_CONNECT(PREFIX_IN, PREFIX_OUT) \
    assign ``PREFIX_OUT``AWVALID = ``PREFIX_IN``AWVALID; \
    assign ``PREFIX_IN``AWREADY  = ``PREFIX_OUT``AWREADY; \
    assign ``PREFIX_OUT``AWADDR  = ``PREFIX_IN``AWADDR; \
    assign ``PREFIX_OUT``AWPROT  = rv_axi4_lite::rv_axi4_lite_prot'(``PREFIX_IN``AWPROT);

`define RV_AXI4_LITE_AW_CONNECT_PORTS(PREFIX_IN, PREFIX_OUT) \
    .``PREFIX_OUT``AWVALID(``PREFIX_IN``AWVALID), \
    .``PREFIX_OUT``AWREADY(``PREFIX_IN``AWREADY), \
    .``PREFIX_OUT``AWADDR(``PREFIX_IN``AWADDR), \
    .``PREFIX_OUT``AWPROT(``PREFIX_IN``AWPROT)

/*
 * Write Data Defines
 */

`define RV_AXI4_LITE_W_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_W_PORTS(output, input, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_W_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_W_PORTS(input, output, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_W_PORTS(FLOW_DIR, BACKFLOW_DIR, PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    FLOW_DIR wire ``PREFIX``_WVALID, BACKFLOW_DIR wire ``PREFIX``_WREADY, \
    FLOW_DIR wire [DATA_WIDTH-1:0]     ``PREFIX``_WDATA, \
    FLOW_DIR wire [(DATA_WIDTH/8)-1:0] ``PREFIX``_WSTRB

`define RV_AXI4_LITE_W_CONNECT(PREFIX_IN, PREFIX_OUT) \
    assign ``PREFIX_OUT``WVALID = ``PREFIX_IN``WVALID; \
    assign ``PREFIX_IN``WREADY  = ``PREFIX_OUT``WREADY; \
    assign ``PREFIX_OUT``WDATA  = ``PREFIX_IN``WDATA; \
    assign ``PREFIX_OUT``WSTRB  = ``PREFIX_IN``WSTRB;

`define RV_AXI4_LITE_W_CONNECT_PORTS(PREFIX_IN, PREFIX_OUT) \
    .``PREFIX_OUT``WVALID(``PREFIX_IN``WVALID), \
    .``PREFIX_OUT``WREADY(``PREFIX_IN``WREADY), \
    .``PREFIX_OUT``WDATA(``PREFIX_IN``WDATA), \
    .``PREFIX_OUT``WSTRB(``PREFIX_IN``WSTRB)

/*
 * Write Respond Defines
 */

`define RV_AXI4_LITE_B_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_B_PORTS(output, input, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_B_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_B_PORTS(input, output, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_B_PORTS(FLOW_DIR, BACKFLOW_DIR, PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    FLOW_DIR wire ``PREFIX``_BVALID, BACKFLOW_DIR wire ``PREFIX``_BREADY, \
    FLOW_DIR wire [1:0]          ``PREFIX``_BRESP

`define RV_AXI4_LITE_B_CONNECT(PREFIX_IN, PREFIX_OUT) \
    assign ``PREFIX_OUT``BVALID = ``PREFIX_IN``BVALID; \
    assign ``PREFIX_IN``BREADY  = ``PREFIX_OUT``BREADY; \
    assign ``PREFIX_OUT``BRESP  = rv_axi4_lite::rv_axi4_lite_resp'(``PREFIX_IN``BRESP);

`define RV_AXI4_LITE_B_CONNECT_PORTS(PREFIX_IN, PREFIX_OUT) \
    .``PREFIX_OUT``BVALID(``PREFIX_IN``BVALID), \
    .``PREFIX_OUT``BREADY(``PREFIX_IN``BREADY), \
    .``PREFIX_OUT``BRESP(``PREFIX_IN``BRESP)

/*
 * Read Address Defines
 */

`define RV_AXI4_LITE_AR_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_AR_PORTS(output, input, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_AR_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_AR_PORTS(input, output, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_AR_PORTS(FLOW_DIR, BACKFLOW_DIR, PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    FLOW_DIR wire ``PREFIX``_ARVALID, BACKFLOW_DIR wire ``PREFIX``_ARREADY, \
    FLOW_DIR wire [ADDR_WIDTH-1:0] ``PREFIX``_ARADDR, \
    FLOW_DIR wire [2:0]            ``PREFIX``_ARPROT

`define RV_AXI4_LITE_AR_CONNECT(PREFIX_IN, PREFIX_OUT) \
    assign ``PREFIX_OUT``ARVALID = ``PREFIX_IN``ARVALID; \
    assign ``PREFIX_IN``ARREADY  = ``PREFIX_OUT``ARREADY; \
    assign ``PREFIX_OUT``ARADDR  = ``PREFIX_IN``ARADDR; \
    assign ``PREFIX_OUT``ARPROT  = rv_axi4_lite::rv_axi4_lite_prot'(``PREFIX_IN``ARPROT);

`define RV_AXI4_LITE_AR_CONNECT_PORTS(PREFIX_IN, PREFIX_OUT) \
    .``PREFIX_OUT``ARVALID(``PREFIX_IN``ARVALID), \
    .``PREFIX_OUT``ARREADY(``PREFIX_IN``ARREADY), \
    .``PREFIX_OUT``ARADDR(``PREFIX_IN``ARADDR), \
    .``PREFIX_OUT``ARPROT(``PREFIX_IN``ARPROT)

/*
 * Read Data Defines
 */

`define RV_AXI4_LITE_R_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_R_PORTS(output, input, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_R_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_R_PORTS(input, output, PREFIX, ADDR_WIDTH, DATA_WIDTH)
`define RV_AXI4_LITE_R_PORTS(FLOW_DIR, BACKFLOW_DIR, PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    FLOW_DIR wire ``PREFIX``_RVALID, BACKFLOW_DIR wire ``PREFIX``_RREADY, \
    FLOW_DIR wire [DATA_WIDTH-1:0] ``PREFIX``_RDATA, \
    FLOW_DIR wire [1:0]            ``PREFIX``_RRESP

`define RV_AXI4_LITE_R_CONNECT(PREFIX_IN, PREFIX_OUT) \
    assign ``PREFIX_OUT``RVALID = ``PREFIX_IN``RVALID; \
    assign ``PREFIX_IN``RREADY  = ``PREFIX_OUT``RREADY; \
    assign ``PREFIX_OUT``RDATA  = ``PREFIX_IN``RDATA; \
    assign ``PREFIX_OUT``RRESP  = rv_axi4_lite::rv_axi4_lite_resp'(``PREFIX_IN``RRESP);

`define RV_AXI4_LITE_R_CONNECT_PORTS(PREFIX_IN, PREFIX_OUT) \
    .``PREFIX_OUT``RVALID(``PREFIX_IN``RVALID), \
    .``PREFIX_OUT``RREADY(``PREFIX_IN``RREADY), \
    .``PREFIX_OUT``RDATA(``PREFIX_IN``RDATA), \
    .``PREFIX_OUT``RRESP(``PREFIX_IN``RRESP)

/*
 * Entire AXI4 Bus Definitions
 */

`define RV_AXI4_LITE_PORTS_MASTER(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_AW_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH), \
    `RV_AXI4_LITE_W_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH), \
    `RV_AXI4_LITE_B_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH), \
    `RV_AXI4_LITE_AR_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH), \
    `RV_AXI4_LITE_R_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH)

`define RV_AXI4_LITE_PORTS_SLAVE(PREFIX, ADDR_WIDTH, DATA_WIDTH) \
    `RV_AXI4_LITE_AW_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH), \
    `RV_AXI4_LITE_W_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH), \
    `RV_AXI4_LITE_B_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH), \
    `RV_AXI4_LITE_AR_PORTS_IN(PREFIX, ADDR_WIDTH, DATA_WIDTH), \
    `RV_AXI4_LITE_R_PORTS_OUT(PREFIX, ADDR_WIDTH, DATA_WIDTH)

`define RV_AXI4_LITE_INTF_MASTER(PREFIX) \
    rv_axi4_lite_aw_intf.out ``PREFIX``_aw, \
    rv_axi4_lite_w_intf.out ``PREFIX``_w, \
    rv_axi4_lite_b_intf.in ``PREFIX``_b, \
    rv_axi4_lite_ar_intf.out ``PREFIX``_ar, \
    rv_axi4_lite_r_intf.in ``PREFIX``_r

`define RV_AXI4_LITE_INTF_SLAVE(PREFIX) \
    rv_axi4_lite_aw_intf.in ``PREFIX``_aw, \
    rv_axi4_lite_w_intf.in ``PREFIX``_w, \
    rv_axi4_lite_b_intf.out ``PREFIX``_b, \
    rv_axi4_lite_ar_intf.in ``PREFIX``_ar, \
    rv_axi4_lite_r_intf.out ``PREFIX``_r

`define RV_AXI4_LITE_CREATE_INTF(PREFIX, AW, DW) \
    rv_axi4_lite_aw_intf #(.ADDR_WIDTH(AW)) ``PREFIX``_aw (); \
    rv_axi4_lite_w_intf #(.DATA_WIDTH(DW))  ``PREFIX``_w (); \
    rv_axi4_lite_b_intf #()                 ``PREFIX``_b (); \
    rv_axi4_lite_ar_intf #(.ADDR_WIDTH(AW)) ``PREFIX``_ar (); \
    rv_axi4_lite_r_intf #(.DATA_WIDTH(DW))  ``PREFIX``_r ();

`define RV_AXI4_LITE_CONNECT(PREFIX_IN, PREFIX_OUT) \
    `RV_AXI4_LITE_AW_CONNECT(PREFIX_IN, PREFIX_OUT) \
    `RV_AXI4_LITE_W_CONNECT(PREFIX_IN, PREFIX_OUT) \
    `RV_AXI4_LITE_B_CONNECT(PREFIX_OUT, PREFIX_IN) \
    `RV_AXI4_LITE_AR_CONNECT(PREFIX_IN, PREFIX_OUT) \
    `RV_AXI4_LITE_R_CONNECT(PREFIX_OUT, PREFIX_IN)

`define RV_AXI4_LITE_CONNECT_PORTS_TO_INTF(PREFIX_IN, PREFIX_OUT) \
    `RV_AXI4_LITE_AW_CONNECT(``PREFIX_IN``_, ``PREFIX_OUT``_aw.) \
    `RV_AXI4_LITE_W_CONNECT(``PREFIX_IN``_, ``PREFIX_OUT``_w.) \
    `RV_AXI4_LITE_B_CONNECT(``PREFIX_OUT``_b., ``PREFIX_IN``_) \
    `RV_AXI4_LITE_AR_CONNECT(``PREFIX_IN``_, ``PREFIX_OUT``_ar.) \
    `RV_AXI4_LITE_R_CONNECT(``PREFIX_OUT``_r., ``PREFIX_IN``_)

`define RV_AXI4_LITE_CONNECT_INTF_TO_PORTS(PREFIX_IN, PREFIX_OUT) \
    `RV_AXI4_LITE_AW_CONNECT(``PREFIX_IN``_aw., ``PREFIX_OUT``_) \
    `RV_AXI4_LITE_W_CONNECT(``PREFIX_IN``_w., ``PREFIX_OUT``_) \
    `RV_AXI4_LITE_B_CONNECT(``PREFIX_OUT``_, ``PREFIX_IN``_b.) \
    `RV_AXI4_LITE_AR_CONNECT(``PREFIX_IN``_ar., ``PREFIX_OUT``_) \
    `RV_AXI4_LITE_R_CONNECT(``PREFIX_OUT``_, ``PREFIX_IN``_r.)

`define RV_AXI4_LITE_CONNECT_PORTS(PREFIX_IN, PREFIX_OUT) \
    `RV_AXI4_LITE_AW_CONNECT_PORTS(``PREFIX_IN``_, ``PREFIX_OUT``_), \
    `RV_AXI4_LITE_W_CONNECT_PORTS(``PREFIX_IN``_, ``PREFIX_OUT``_), \
    `RV_AXI4_LITE_B_CONNECT_PORTS(``PREFIX_IN``_, ``PREFIX_OUT``_), \
    `RV_AXI4_LITE_AR_CONNECT_PORTS(``PREFIX_IN``_, ``PREFIX_OUT``_), \
    `RV_AXI4_LITE_R_CONNECT_PORTS(``PREFIX_IN``_, ``PREFIX_OUT``_)

`endif
