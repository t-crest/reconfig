module MCacheCtrl(input clk, input reset,
    input  io_ena_in,
    output io_fetchEna,
    output io_ctrlrepl_wEna,
    output[31:0] io_ctrlrepl_wData,
    output[31:0] io_ctrlrepl_wAddr,
    output io_ctrlrepl_wTag,
    output[9:0] io_ctrlrepl_addrEven,
    output[9:0] io_ctrlrepl_addrOdd,
    output io_ctrlrepl_instrStall,
    input  io_replctrl_hit,
    input [31:0] io_femcache_addrEven,
    input [31:0] io_femcache_addrOdd,
    input  io_exmcache_doCallRet,
    input [31:0] io_exmcache_callRetBase,
    input [31:0] io_exmcache_callRetAddr,
    output[2:0] io_ocp_port_M_Cmd,
    output[31:0] io_ocp_port_M_Addr,
    output[31:0] io_ocp_port_M_Data,
    output io_ocp_port_M_DataValid,
    output[3:0] io_ocp_port_M_DataByteEn,
    input [1:0] io_ocp_port_S_Resp,
    input [31:0] io_ocp_port_S_Data,
    input  io_ocp_port_S_CmdAccept,
    input  io_ocp_port_S_DataAccept,
    output io_illMem,
    output io_forceHit
);

  wire T0;
  wire T1;
  wire T2;
  wire T3;
  wire T4;
  reg [1:0] burstCntReg;
  wire[1:0] T5;
  wire[1:0] T6;
  wire[1:0] T7;
  wire[1:0] T8;
  wire[1:0] T9;
  wire[1:0] T10;
  wire[1:0] T11;
  wire[1:0] T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  reg [2:0] stateReg;
  wire[2:0] T125;
  wire[2:0] T17;
  wire[2:0] T18;
  wire[2:0] T19;
  wire[2:0] T20;
  wire[2:0] T21;
  wire[2:0] T22;
  wire[2:0] T23;
  wire[2:0] T24;
  wire[2:0] T25;
  wire T26;
  wire T27;
  wire[1:0] T28;
  wire[31:0] msizeAddr;
  reg [31:0] callRetBaseReg;
  wire[31:0] T29;
  wire T30;
  wire T31;
  wire T32;
  wire T33;
  wire T34;
  reg [9:0] transferSizeReg;
  wire[9:0] T126;
  wire[10:0] T35;
  wire[10:0] T127;
  wire[10:0] T36;
  wire[10:0] T37;
  reg [31:0] ocpSlaveReg_Data;
  reg [9:0] fetchCntReg;
  wire[9:0] T38;
  wire[9:0] T39;
  wire[9:0] T40;
  wire T41;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  wire[1:0] T47;
  wire T48;
  wire T49;
  reg [1:0] ocpSlaveReg_Resp;
  wire T50;
  wire T51;
  wire T52;
  wire[1:0] T53;
  wire T54;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire T59;
  wire[1:0] T60;
  wire T61;
  wire T62;
  wire[1:0] T63;
  wire T64;
  wire[1:0] T65;
  wire T66;
  wire T67;
  wire T68;
  wire T69;
  wire T70;
  wire T71;
  wire[31:0] T128;
  wire[33:0] T72;
  wire[33:0] T73;
  wire[33:0] T74;
  wire[33:0] T75;
  reg [31:0] ocpAddrReg;
  wire[31:0] T76;
  wire[31:0] T77;
  wire[31:0] T78;
  wire[31:0] T79;
  wire[29:0] T80;
  wire[31:0] T81;
  wire[31:0] T82;
  wire[31:0] T129;
  wire[33:0] T83;
  wire[29:0] T84;
  wire[33:0] T85;
  wire[33:0] T86;
  wire[31:0] T87;
  wire[31:0] T88;
  wire[31:0] T130;
  wire[2:0] T89;
  wire[2:0] T90;
  wire[2:0] T91;
  wire[2:0] T92;
  reg [2:0] ocpCmdReg;
  wire[2:0] T131;
  wire[2:0] T93;
  wire[2:0] T94;
  wire[2:0] T95;
  wire[2:0] T96;
  wire[2:0] T97;
  wire T98;
  wire T99;
  wire T100;
  wire T101;
  wire T102;
  wire T103;
  wire T104;
  wire T105;
  wire[9:0] T132;
  wire[31:0] addrOdd;
  wire[31:0] T106;
  wire[31:0] T107;
  wire[31:0] T108;
  reg [31:0] addrOddReg;
  wire[31:0] T109;
  wire T110;
  wire[9:0] T133;
  wire[31:0] addrEven;
  wire[31:0] T111;
  wire[31:0] T112;
  wire[31:0] T113;
  reg [31:0] addrEvenReg;
  wire[31:0] T114;
  wire wTag;
  wire[31:0] wAddr;
  wire[31:0] T115;
  wire[31:0] T116;
  wire[31:0] T134;
  wire[31:0] wData;
  wire[31:0] T117;
  wire[31:0] T135;
  wire[10:0] T118;
  wire[10:0] T119;
  wire[10:0] T136;
  wire T120;
  wire wEna;
  wire fetchEna;
  wire T121;
  wire T122;
  wire T123;
  wire T124;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    burstCntReg = {1{$random}};
    stateReg = {1{$random}};
    callRetBaseReg = {1{$random}};
    transferSizeReg = {1{$random}};
    ocpSlaveReg_Data = {1{$random}};
    fetchCntReg = {1{$random}};
    ocpSlaveReg_Resp = {1{$random}};
    ocpAddrReg = {1{$random}};
    ocpCmdReg = {1{$random}};
    addrOddReg = {1{$random}};
    addrEvenReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_forceHit = T0;
  assign T0 = T71 ? 1'h1 : T1;
  assign T1 = T70 ? 1'h1 : T2;
  assign T2 = T69 ? 1'h1 : T3;
  assign T3 = T68 & T4;
  assign T4 = burstCntReg == 2'h3;
  assign T5 = T66 ? T65 : T6;
  assign T6 = T64 ? T63 : T7;
  assign T7 = T61 ? T60 : T8;
  assign T8 = T57 ? 2'h0 : T9;
  assign T9 = T54 ? T53 : T10;
  assign T10 = T51 ? 2'h0 : T11;
  assign T11 = T48 ? T47 : T12;
  assign T12 = T13 ? 2'h0 : burstCntReg;
  assign T13 = T16 & T14;
  assign T14 = T15 ^ 1'h1;
  assign T15 = io_replctrl_hit == 1'h1;
  assign T16 = stateReg == 3'h0;
  assign T125 = reset ? 3'h0 : T17;
  assign T17 = T71 ? 3'h0 : T18;
  assign T18 = T70 ? 3'h6 : T19;
  assign T19 = T69 ? 3'h5 : T20;
  assign T20 = T3 ? 3'h4 : T21;
  assign T21 = T64 ? 3'h3 : T22;
  assign T22 = T41 ? 3'h0 : T23;
  assign T23 = T30 ? 3'h0 : T24;
  assign T24 = T26 ? 3'h2 : T25;
  assign T25 = T13 ? 3'h1 : stateReg;
  assign T26 = T48 & T27;
  assign T27 = burstCntReg == T28;
  assign T28 = msizeAddr[1'h1:1'h0];
  assign msizeAddr = callRetBaseReg - 32'h1;
  assign T29 = io_exmcache_doCallRet ? io_exmcache_callRetBase : callRetBaseReg;
  assign T30 = T32 & T31;
  assign T31 = burstCntReg == 2'h3;
  assign T32 = T54 & T33;
  assign T33 = T34 ^ 1'h1;
  assign T34 = fetchCntReg < transferSizeReg;
  assign T126 = T35[4'h9:1'h0];
  assign T35 = T26 ? T36 : T127;
  assign T127 = {1'h0, transferSizeReg};
  assign T36 = T37 - 11'h1;
  assign T37 = ocpSlaveReg_Data[4'hc:2'h2];
  assign T38 = T54 ? T40 : T39;
  assign T39 = T26 ? 10'h0 : fetchCntReg;
  assign T40 = fetchCntReg + 10'h1;
  assign T41 = T43 & T42;
  assign T42 = burstCntReg == 2'h3;
  assign T43 = T46 & T44;
  assign T44 = T45 ^ 1'h1;
  assign T45 = fetchCntReg <= transferSizeReg;
  assign T46 = stateReg == 3'h2;
  assign T47 = burstCntReg + 2'h1;
  assign T48 = T50 & T49;
  assign T49 = ocpSlaveReg_Resp == 2'h1;
  assign T50 = stateReg == 3'h1;
  assign T51 = T26 & T52;
  assign T52 = burstCntReg == 2'h3;
  assign T53 = burstCntReg + 2'h1;
  assign T54 = T56 & T55;
  assign T55 = ocpSlaveReg_Resp == 2'h1;
  assign T56 = T46 & T45;
  assign T57 = T59 & T58;
  assign T58 = burstCntReg == 2'h3;
  assign T59 = T54 & T34;
  assign T60 = burstCntReg + 2'h1;
  assign T61 = T43 & T62;
  assign T62 = ocpSlaveReg_Resp == 2'h1;
  assign T63 = burstCntReg + 2'h1;
  assign T64 = ocpSlaveReg_Resp == 2'h3;
  assign T65 = burstCntReg + 2'h1;
  assign T66 = T68 & T67;
  assign T67 = ocpSlaveReg_Resp != 2'h0;
  assign T68 = stateReg == 3'h3;
  assign T69 = stateReg == 3'h4;
  assign T70 = stateReg == 3'h5;
  assign T71 = stateReg == 3'h6;
  assign io_illMem = T3;
  assign io_ocp_port_M_DataByteEn = 4'hf;
  assign io_ocp_port_M_DataValid = 1'h0;
  assign io_ocp_port_M_Data = 32'h0;
  assign io_ocp_port_M_Addr = T128;
  assign T128 = T72[5'h1f:1'h0];
  assign T72 = T57 ? T86 : T73;
  assign T73 = T51 ? T85 : T74;
  assign T74 = T13 ? T83 : T75;
  assign T75 = {ocpAddrReg, 2'h0};
  assign T76 = T57 ? T81 : T77;
  assign T77 = T51 ? callRetBaseReg : T78;
  assign T78 = T13 ? T79 : ocpAddrReg;
  assign T79 = {T80, 2'h0};
  assign T80 = msizeAddr[5'h1f:2'h2];
  assign T81 = T82 + 32'h1;
  assign T82 = callRetBaseReg + T129;
  assign T129 = {22'h0, fetchCntReg};
  assign T83 = {T84, 4'h0};
  assign T84 = msizeAddr[5'h1f:2'h2];
  assign T85 = {callRetBaseReg, 2'h0};
  assign T86 = {T87, 2'h0};
  assign T87 = T88 + 32'h1;
  assign T88 = callRetBaseReg + T130;
  assign T130 = {22'h0, fetchCntReg};
  assign io_ocp_port_M_Cmd = T89;
  assign T89 = T64 ? 3'h0 : T90;
  assign T90 = T57 ? 3'h2 : T91;
  assign T91 = T51 ? 3'h2 : T92;
  assign T92 = T13 ? 3'h2 : ocpCmdReg;
  assign T131 = reset ? 3'h0 : T93;
  assign T93 = T64 ? 3'h0 : T94;
  assign T94 = T103 ? 3'h2 : T95;
  assign T95 = T101 ? 3'h2 : T96;
  assign T96 = T99 ? 3'h2 : T97;
  assign T97 = T98 ? 3'h0 : ocpCmdReg;
  assign T98 = io_ocp_port_S_CmdAccept == 1'h1;
  assign T99 = T13 & T100;
  assign T100 = io_ocp_port_S_CmdAccept == 1'h0;
  assign T101 = T51 & T102;
  assign T102 = io_ocp_port_S_CmdAccept == 1'h0;
  assign T103 = T57 & T104;
  assign T104 = io_ocp_port_S_CmdAccept == 1'h0;
  assign io_ctrlrepl_instrStall = T105;
  assign T105 = stateReg != 3'h0;
  assign io_ctrlrepl_addrOdd = T132;
  assign T132 = addrOdd[4'h9:1'h0];
  assign addrOdd = T106;
  assign T106 = T41 ? io_femcache_addrOdd : T107;
  assign T107 = T30 ? io_femcache_addrOdd : T108;
  assign T108 = T110 ? io_femcache_addrOdd : addrOddReg;
  assign T109 = io_exmcache_doCallRet ? io_femcache_addrOdd : addrOddReg;
  assign T110 = T16 & T15;
  assign io_ctrlrepl_addrEven = T133;
  assign T133 = addrEven[4'h9:1'h0];
  assign addrEven = T111;
  assign T111 = T41 ? io_femcache_addrEven : T112;
  assign T112 = T30 ? io_femcache_addrEven : T113;
  assign T113 = T110 ? io_femcache_addrEven : addrEvenReg;
  assign T114 = io_exmcache_doCallRet ? io_femcache_addrEven : addrEvenReg;
  assign io_ctrlrepl_wTag = wTag;
  assign wTag = T26;
  assign io_ctrlrepl_wAddr = wAddr;
  assign wAddr = T115;
  assign T115 = T56 ? T134 : T116;
  assign T116 = T26 ? callRetBaseReg : 32'h0;
  assign T134 = {22'h0, fetchCntReg};
  assign io_ctrlrepl_wData = wData;
  assign wData = T117;
  assign T117 = T54 ? ocpSlaveReg_Data : T135;
  assign T135 = {21'h0, T118};
  assign T118 = T26 ? T119 : 11'h0;
  assign T119 = T37 + T136;
  assign T136 = {10'h0, T120};
  assign T120 = T37[1'h0:1'h0];
  assign io_ctrlrepl_wEna = wEna;
  assign wEna = T54;
  assign io_fetchEna = fetchEna;
  assign fetchEna = T121;
  assign T121 = T41 ? 1'h1 : T122;
  assign T122 = T30 ? 1'h1 : T123;
  assign T123 = T46 ? 1'h0 : T124;
  assign T124 = T50 == 1'h0;

  always @(posedge clk) begin
    if(T66) begin
      burstCntReg <= T65;
    end else if(T64) begin
      burstCntReg <= T63;
    end else if(T61) begin
      burstCntReg <= T60;
    end else if(T57) begin
      burstCntReg <= 2'h0;
    end else if(T54) begin
      burstCntReg <= T53;
    end else if(T51) begin
      burstCntReg <= 2'h0;
    end else if(T48) begin
      burstCntReg <= T47;
    end else if(T13) begin
      burstCntReg <= 2'h0;
    end
    if(reset) begin
      stateReg <= 3'h0;
    end else if(T71) begin
      stateReg <= 3'h0;
    end else if(T70) begin
      stateReg <= 3'h6;
    end else if(T69) begin
      stateReg <= 3'h5;
    end else if(T3) begin
      stateReg <= 3'h4;
    end else if(T64) begin
      stateReg <= 3'h3;
    end else if(T41) begin
      stateReg <= 3'h0;
    end else if(T30) begin
      stateReg <= 3'h0;
    end else if(T26) begin
      stateReg <= 3'h2;
    end else if(T13) begin
      stateReg <= 3'h1;
    end
    if(io_exmcache_doCallRet) begin
      callRetBaseReg <= io_exmcache_callRetBase;
    end
    transferSizeReg <= T126;
    ocpSlaveReg_Data <= io_ocp_port_S_Data;
    if(T54) begin
      fetchCntReg <= T40;
    end else if(T26) begin
      fetchCntReg <= 10'h0;
    end
    ocpSlaveReg_Resp <= io_ocp_port_S_Resp;
    if(T57) begin
      ocpAddrReg <= T81;
    end else if(T51) begin
      ocpAddrReg <= callRetBaseReg;
    end else if(T13) begin
      ocpAddrReg <= T79;
    end
    if(reset) begin
      ocpCmdReg <= 3'h0;
    end else if(T64) begin
      ocpCmdReg <= 3'h0;
    end else if(T103) begin
      ocpCmdReg <= 3'h2;
    end else if(T101) begin
      ocpCmdReg <= 3'h2;
    end else if(T99) begin
      ocpCmdReg <= 3'h2;
    end else if(T98) begin
      ocpCmdReg <= 3'h0;
    end
    if(io_exmcache_doCallRet) begin
      addrOddReg <= io_femcache_addrOdd;
    end
    if(io_exmcache_doCallRet) begin
      addrEvenReg <= io_femcache_addrEven;
    end
  end
endmodule

module MCacheReplFifo(input clk, input reset,
    input  io_ena_in,
    input  io_invalidate,
    output io_hitEna,
    input  io_exmcache_doCallRet,
    input [31:0] io_exmcache_callRetBase,
    input [31:0] io_exmcache_callRetAddr,
    output[31:0] io_mcachefe_instrEven,
    output[31:0] io_mcachefe_instrOdd,
    output[31:0] io_mcachefe_base,
    output[9:0] io_mcachefe_relBase,
    output[10:0] io_mcachefe_relPc,
    output[31:0] io_mcachefe_reloc,
    output[1:0] io_mcachefe_memSel,
    input  io_ctrlrepl_wEna,
    input [31:0] io_ctrlrepl_wData,
    input [31:0] io_ctrlrepl_wAddr,
    input  io_ctrlrepl_wTag,
    input [9:0] io_ctrlrepl_addrEven,
    input [9:0] io_ctrlrepl_addrOdd,
    input  io_ctrlrepl_instrStall,
    output io_replctrl_hit,
    output io_memIn_wEven,
    output io_memIn_wOdd,
    output[31:0] io_memIn_wData,
    output[8:0] io_memIn_wAddr,
    output[8:0] io_memIn_addrEven,
    output[8:0] io_memIn_addrOdd,
    input [31:0] io_memOut_instrEven,
    input [31:0] io_memOut_instrOdd,
    output io_perf_hit,
    output io_perf_miss
);

  wire T0;
  wire T1;
  wire hit;
  wire hitVec_15;
  wire T2;
  reg  validVec_15;
  wire T514;
  wire T3;
  wire T4;
  wire T5;
  wire T6;
  wire T7;
  wire[15:0] T8;
  wire[3:0] T9;
  reg [3:0] nextIndexReg;
  wire[3:0] T515;
  wire[3:0] T10;
  wire[3:0] T11;
  wire[3:0] T12;
  wire T13;
  wire T14;
  wire T15;
  wire[15:0] T16;
  wire[3:0] T17;
  reg [3:0] nextTagReg;
  wire[3:0] T516;
  wire[3:0] T18;
  wire[3:0] T19;
  wire T20;
  wire T21;
  wire[3:0] T22;
  wire[3:0] T23;
  wire T24;
  wire T25;
  reg [11:0] freeSpaceReg;
  wire[11:0] T517;
  wire[11:0] T26;
  wire[11:0] T27;
  wire[11:0] T28;
  wire[11:0] T29;
  wire[11:0] T30;
  wire[10:0] T31;
  wire[10:0] T32;
  wire[10:0] T33;
  wire[10:0] T34;
  reg [10:0] sizeVec_0;
  wire[10:0] T518;
  wire[10:0] T35;
  wire[10:0] T36;
  wire[10:0] T37;
  wire T38;
  wire T39;
  wire[15:0] T40;
  wire[3:0] T41;
  wire T42;
  wire T43;
  wire[15:0] T44;
  wire[3:0] T45;
  reg [10:0] sizeVec_1;
  wire[10:0] T519;
  wire[10:0] T46;
  wire[10:0] T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire T52;
  wire[10:0] T53;
  reg [10:0] sizeVec_2;
  wire[10:0] T520;
  wire[10:0] T54;
  wire[10:0] T55;
  wire T56;
  wire T57;
  wire T58;
  wire T59;
  reg [10:0] sizeVec_3;
  wire[10:0] T521;
  wire[10:0] T60;
  wire[10:0] T61;
  wire T62;
  wire T63;
  wire T64;
  wire T65;
  wire T66;
  wire T67;
  wire[10:0] T68;
  wire[10:0] T69;
  reg [10:0] sizeVec_4;
  wire[10:0] T522;
  wire[10:0] T70;
  wire[10:0] T71;
  wire T72;
  wire T73;
  wire T74;
  wire T75;
  reg [10:0] sizeVec_5;
  wire[10:0] T523;
  wire[10:0] T76;
  wire[10:0] T77;
  wire T78;
  wire T79;
  wire T80;
  wire T81;
  wire T82;
  wire[10:0] T83;
  reg [10:0] sizeVec_6;
  wire[10:0] T524;
  wire[10:0] T84;
  wire[10:0] T85;
  wire T86;
  wire T87;
  wire T88;
  wire T89;
  reg [10:0] sizeVec_7;
  wire[10:0] T525;
  wire[10:0] T90;
  wire[10:0] T91;
  wire T92;
  wire T93;
  wire T94;
  wire T95;
  wire T96;
  wire T97;
  wire T98;
  wire[10:0] T99;
  wire[10:0] T100;
  wire[10:0] T101;
  reg [10:0] sizeVec_8;
  wire[10:0] T526;
  wire[10:0] T102;
  wire[10:0] T103;
  wire T104;
  wire T105;
  wire T106;
  wire T107;
  reg [10:0] sizeVec_9;
  wire[10:0] T527;
  wire[10:0] T108;
  wire[10:0] T109;
  wire T110;
  wire T111;
  wire T112;
  wire T113;
  wire T114;
  wire[10:0] T115;
  reg [10:0] sizeVec_10;
  wire[10:0] T528;
  wire[10:0] T116;
  wire[10:0] T117;
  wire T118;
  wire T119;
  wire T120;
  wire T121;
  reg [10:0] sizeVec_11;
  wire[10:0] T529;
  wire[10:0] T122;
  wire[10:0] T123;
  wire T124;
  wire T125;
  wire T126;
  wire T127;
  wire T128;
  wire T129;
  wire[10:0] T130;
  wire[10:0] T131;
  reg [10:0] sizeVec_12;
  wire[10:0] T530;
  wire[10:0] T132;
  wire[10:0] T133;
  wire T134;
  wire T135;
  wire T136;
  wire T137;
  reg [10:0] sizeVec_13;
  wire[10:0] T531;
  wire[10:0] T138;
  wire[10:0] T139;
  wire T140;
  wire T141;
  wire T142;
  wire T143;
  wire T144;
  wire[10:0] T145;
  reg [10:0] sizeVec_14;
  wire[10:0] T532;
  wire[10:0] T146;
  wire[10:0] T147;
  wire T148;
  wire T149;
  wire T150;
  wire T151;
  reg [10:0] sizeVec_15;
  wire[10:0] T533;
  wire[10:0] T152;
  wire[10:0] T153;
  wire T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;
  wire T159;
  wire T160;
  wire T161;
  wire[11:0] T162;
  wire[11:0] T163;
  wire[11:0] T164;
  wire[10:0] T165;
  wire[11:0] T166;
  wire[11:0] T167;
  wire[11:0] T168;
  wire[10:0] T169;
  wire[10:0] T170;
  wire[10:0] T171;
  wire[10:0] T172;
  wire T173;
  wire[10:0] T174;
  wire T175;
  wire T176;
  wire[10:0] T177;
  wire[10:0] T178;
  wire T179;
  wire[10:0] T180;
  wire T181;
  wire T182;
  wire T183;
  wire[10:0] T184;
  wire[10:0] T185;
  wire[10:0] T186;
  wire T187;
  wire[10:0] T188;
  wire T189;
  wire T190;
  wire[10:0] T191;
  wire[10:0] T192;
  wire T193;
  wire[10:0] T194;
  wire T195;
  wire T196;
  wire T197;
  wire T198;
  wire T199;
  reg [31:0] addrVec_15;
  wire[31:0] T200;
  wire T201;
  wire T202;
  wire[15:0] T203;
  wire[3:0] T204;
  wire T205;
  wire hitVec_14;
  wire T206;
  reg  validVec_14;
  wire T534;
  wire T207;
  wire T208;
  wire T209;
  wire T210;
  wire T211;
  wire T212;
  wire T213;
  wire T214;
  reg [31:0] addrVec_14;
  wire[31:0] T215;
  wire T216;
  wire T217;
  wire T218;
  wire hitVec_13;
  wire T219;
  reg  validVec_13;
  wire T535;
  wire T220;
  wire T221;
  wire T222;
  wire T223;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  reg [31:0] addrVec_13;
  wire[31:0] T228;
  wire T229;
  wire T230;
  wire T231;
  wire hitVec_12;
  wire T232;
  reg  validVec_12;
  wire T536;
  wire T233;
  wire T234;
  wire T235;
  wire T236;
  wire T237;
  wire T238;
  wire T239;
  wire T240;
  reg [31:0] addrVec_12;
  wire[31:0] T241;
  wire T242;
  wire T243;
  wire T244;
  wire hitVec_11;
  wire T245;
  reg  validVec_11;
  wire T537;
  wire T246;
  wire T247;
  wire T248;
  wire T249;
  wire T250;
  wire T251;
  wire T252;
  wire T253;
  reg [31:0] addrVec_11;
  wire[31:0] T254;
  wire T255;
  wire T256;
  wire T257;
  wire hitVec_10;
  wire T258;
  reg  validVec_10;
  wire T538;
  wire T259;
  wire T260;
  wire T261;
  wire T262;
  wire T263;
  wire T264;
  wire T265;
  wire T266;
  reg [31:0] addrVec_10;
  wire[31:0] T267;
  wire T268;
  wire T269;
  wire T270;
  wire hitVec_9;
  wire T271;
  reg  validVec_9;
  wire T539;
  wire T272;
  wire T273;
  wire T274;
  wire T275;
  wire T276;
  wire T277;
  wire T278;
  wire T279;
  reg [31:0] addrVec_9;
  wire[31:0] T280;
  wire T281;
  wire T282;
  wire T283;
  wire hitVec_8;
  wire T284;
  reg  validVec_8;
  wire T540;
  wire T285;
  wire T286;
  wire T287;
  wire T288;
  wire T289;
  wire T290;
  wire T291;
  wire T292;
  reg [31:0] addrVec_8;
  wire[31:0] T293;
  wire T294;
  wire T295;
  wire T296;
  wire hitVec_7;
  wire T297;
  reg  validVec_7;
  wire T541;
  wire T298;
  wire T299;
  wire T300;
  wire T301;
  wire T302;
  wire T303;
  wire T304;
  wire T305;
  reg [31:0] addrVec_7;
  wire[31:0] T306;
  wire T307;
  wire T308;
  wire T309;
  wire hitVec_6;
  wire T310;
  reg  validVec_6;
  wire T542;
  wire T311;
  wire T312;
  wire T313;
  wire T314;
  wire T315;
  wire T316;
  wire T317;
  wire T318;
  reg [31:0] addrVec_6;
  wire[31:0] T319;
  wire T320;
  wire T321;
  wire T322;
  wire hitVec_5;
  wire T323;
  reg  validVec_5;
  wire T543;
  wire T324;
  wire T325;
  wire T326;
  wire T327;
  wire T328;
  wire T329;
  wire T330;
  wire T331;
  reg [31:0] addrVec_5;
  wire[31:0] T332;
  wire T333;
  wire T334;
  wire T335;
  wire hitVec_4;
  wire T336;
  reg  validVec_4;
  wire T544;
  wire T337;
  wire T338;
  wire T339;
  wire T340;
  wire T341;
  wire T342;
  wire T343;
  wire T344;
  reg [31:0] addrVec_4;
  wire[31:0] T345;
  wire T346;
  wire T347;
  wire T348;
  wire hitVec_3;
  wire T349;
  reg  validVec_3;
  wire T545;
  wire T350;
  wire T351;
  wire T352;
  wire T353;
  wire T354;
  wire T355;
  wire T356;
  wire T357;
  reg [31:0] addrVec_3;
  wire[31:0] T358;
  wire T359;
  wire T360;
  wire T361;
  wire hitVec_2;
  wire T362;
  reg  validVec_2;
  wire T546;
  wire T363;
  wire T364;
  wire T365;
  wire T366;
  wire T367;
  wire T368;
  wire T369;
  wire T370;
  reg [31:0] addrVec_2;
  wire[31:0] T371;
  wire T372;
  wire T373;
  wire T374;
  wire hitVec_1;
  wire T375;
  reg  validVec_1;
  wire T547;
  wire T376;
  wire T377;
  wire T378;
  wire T379;
  wire T380;
  wire T381;
  wire T382;
  wire T383;
  reg [31:0] addrVec_1;
  wire[31:0] T384;
  wire T385;
  wire T386;
  wire T387;
  wire hitVec_0;
  wire T388;
  reg  validVec_0;
  wire T548;
  wire T389;
  wire T390;
  wire T391;
  wire T392;
  wire T393;
  wire T394;
  wire T395;
  wire T396;
  reg [31:0] addrVec_0;
  wire[31:0] T397;
  wire T398;
  wire T399;
  wire T400;
  wire T401;
  wire[16:0] T402;
  wire T403;
  wire T404;
  wire[8:0] addrOdd;
  wire[8:0] addrEven;
  wire[8:0] wAddr;
  wire[31:0] T405;
  wire[31:0] T549;
  reg [9:0] wrPosReg;
  wire[9:0] T550;
  wire[9:0] T406;
  reg [9:0] posReg;
  wire[9:0] T551;
  wire[9:0] T407;
  wire[9:0] pos;
  reg [9:0] nextPosReg;
  wire[9:0] T552;
  wire[9:0] T408;
  wire[9:0] T409;
  wire[9:0] T410;
  wire[9:0] T411;
  wire[9:0] mergePosVec_15;
  wire[9:0] T412;
  reg [9:0] posVec_15;
  wire[9:0] T413;
  wire T414;
  wire T415;
  wire[15:0] T416;
  wire[3:0] T417;
  wire[9:0] T418;
  wire[9:0] mergePosVec_14;
  wire[9:0] T419;
  reg [9:0] posVec_14;
  wire[9:0] T420;
  wire T421;
  wire T422;
  wire[9:0] T423;
  wire[9:0] mergePosVec_13;
  wire[9:0] T424;
  reg [9:0] posVec_13;
  wire[9:0] T425;
  wire T426;
  wire T427;
  wire[9:0] T428;
  wire[9:0] mergePosVec_12;
  wire[9:0] T429;
  reg [9:0] posVec_12;
  wire[9:0] T430;
  wire T431;
  wire T432;
  wire[9:0] T433;
  wire[9:0] mergePosVec_11;
  wire[9:0] T434;
  reg [9:0] posVec_11;
  wire[9:0] T435;
  wire T436;
  wire T437;
  wire[9:0] T438;
  wire[9:0] mergePosVec_10;
  wire[9:0] T439;
  reg [9:0] posVec_10;
  wire[9:0] T440;
  wire T441;
  wire T442;
  wire[9:0] T443;
  wire[9:0] mergePosVec_9;
  wire[9:0] T444;
  reg [9:0] posVec_9;
  wire[9:0] T445;
  wire T446;
  wire T447;
  wire[9:0] T448;
  wire[9:0] mergePosVec_8;
  wire[9:0] T449;
  reg [9:0] posVec_8;
  wire[9:0] T450;
  wire T451;
  wire T452;
  wire[9:0] T453;
  wire[9:0] mergePosVec_7;
  wire[9:0] T454;
  reg [9:0] posVec_7;
  wire[9:0] T455;
  wire T456;
  wire T457;
  wire[9:0] T458;
  wire[9:0] mergePosVec_6;
  wire[9:0] T459;
  reg [9:0] posVec_6;
  wire[9:0] T460;
  wire T461;
  wire T462;
  wire[9:0] T463;
  wire[9:0] mergePosVec_5;
  wire[9:0] T464;
  reg [9:0] posVec_5;
  wire[9:0] T465;
  wire T466;
  wire T467;
  wire[9:0] T468;
  wire[9:0] mergePosVec_4;
  wire[9:0] T469;
  reg [9:0] posVec_4;
  wire[9:0] T470;
  wire T471;
  wire T472;
  wire[9:0] T473;
  wire[9:0] mergePosVec_3;
  wire[9:0] T474;
  reg [9:0] posVec_3;
  wire[9:0] T475;
  wire T476;
  wire T477;
  wire[9:0] T478;
  wire[9:0] mergePosVec_2;
  wire[9:0] T479;
  reg [9:0] posVec_2;
  wire[9:0] T480;
  wire T481;
  wire T482;
  wire[9:0] T483;
  wire[9:0] mergePosVec_1;
  wire[9:0] T484;
  reg [9:0] posVec_1;
  wire[9:0] T485;
  wire T486;
  wire T487;
  wire[9:0] T488;
  wire[9:0] mergePosVec_0;
  wire[9:0] T489;
  reg [9:0] posVec_0;
  wire[9:0] T490;
  wire T491;
  wire T492;
  wire T493;
  wire wParity;
  wire T494;
  reg  hitReg;
  wire T553;
  wire T495;
  wire T496;
  wire[1:0] T497;
  reg  selCacheReg;
  wire T554;
  wire T498;
  reg  selSpmReg;
  wire T555;
  wire T499;
  wire T500;
  wire[17:0] T501;
  wire[31:0] reloc;
  wire[31:0] T556;
  wire[14:0] T502;
  wire[31:0] T503;
  wire[31:0] T557;
  wire[9:0] T504;
  reg [31:0] callRetBaseReg;
  wire[31:0] T558;
  wire[31:0] T505;
  wire[10:0] T559;
  wire[31:0] relPc;
  wire[31:0] T560;
  wire[13:0] relBase;
  wire[13:0] T506;
  wire[13:0] T561;
  wire[9:0] T507;
  reg [31:0] callAddrReg;
  wire[31:0] T562;
  wire[31:0] T508;
  wire[9:0] T563;
  wire[31:0] T509;
  reg [31:0] instrOddReg;
  wire[31:0] T510;
  wire T511;
  wire[31:0] T512;
  reg [31:0] instrEvenReg;
  wire[31:0] T513;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    validVec_15 = {1{$random}};
    nextIndexReg = {1{$random}};
    nextTagReg = {1{$random}};
    freeSpaceReg = {1{$random}};
    sizeVec_0 = {1{$random}};
    sizeVec_1 = {1{$random}};
    sizeVec_2 = {1{$random}};
    sizeVec_3 = {1{$random}};
    sizeVec_4 = {1{$random}};
    sizeVec_5 = {1{$random}};
    sizeVec_6 = {1{$random}};
    sizeVec_7 = {1{$random}};
    sizeVec_8 = {1{$random}};
    sizeVec_9 = {1{$random}};
    sizeVec_10 = {1{$random}};
    sizeVec_11 = {1{$random}};
    sizeVec_12 = {1{$random}};
    sizeVec_13 = {1{$random}};
    sizeVec_14 = {1{$random}};
    sizeVec_15 = {1{$random}};
    addrVec_15 = {1{$random}};
    validVec_14 = {1{$random}};
    addrVec_14 = {1{$random}};
    validVec_13 = {1{$random}};
    addrVec_13 = {1{$random}};
    validVec_12 = {1{$random}};
    addrVec_12 = {1{$random}};
    validVec_11 = {1{$random}};
    addrVec_11 = {1{$random}};
    validVec_10 = {1{$random}};
    addrVec_10 = {1{$random}};
    validVec_9 = {1{$random}};
    addrVec_9 = {1{$random}};
    validVec_8 = {1{$random}};
    addrVec_8 = {1{$random}};
    validVec_7 = {1{$random}};
    addrVec_7 = {1{$random}};
    validVec_6 = {1{$random}};
    addrVec_6 = {1{$random}};
    validVec_5 = {1{$random}};
    addrVec_5 = {1{$random}};
    validVec_4 = {1{$random}};
    addrVec_4 = {1{$random}};
    validVec_3 = {1{$random}};
    addrVec_3 = {1{$random}};
    validVec_2 = {1{$random}};
    addrVec_2 = {1{$random}};
    validVec_1 = {1{$random}};
    addrVec_1 = {1{$random}};
    validVec_0 = {1{$random}};
    addrVec_0 = {1{$random}};
    wrPosReg = {1{$random}};
    posReg = {1{$random}};
    nextPosReg = {1{$random}};
    posVec_15 = {1{$random}};
    posVec_14 = {1{$random}};
    posVec_13 = {1{$random}};
    posVec_12 = {1{$random}};
    posVec_11 = {1{$random}};
    posVec_10 = {1{$random}};
    posVec_9 = {1{$random}};
    posVec_8 = {1{$random}};
    posVec_7 = {1{$random}};
    posVec_6 = {1{$random}};
    posVec_5 = {1{$random}};
    posVec_4 = {1{$random}};
    posVec_3 = {1{$random}};
    posVec_2 = {1{$random}};
    posVec_1 = {1{$random}};
    posVec_0 = {1{$random}};
    hitReg = {1{$random}};
    selCacheReg = {1{$random}};
    selSpmReg = {1{$random}};
    callRetBaseReg = {1{$random}};
    callAddrReg = {1{$random}};
    instrOddReg = {1{$random}};
    instrEvenReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_perf_miss = T0;
  assign T0 = T400 & T1;
  assign T1 = hit ^ 1'h1;
  assign hit = T205 | hitVec_15;
  assign hitVec_15 = T2;
  assign T2 = T199 & validVec_15;
  assign T514 = reset ? 1'h0 : T3;
  assign T3 = io_invalidate ? 1'h0 : T4;
  assign T4 = T14 ? 1'h0 : T5;
  assign T5 = T6 ? 1'h1 : validVec_15;
  assign T6 = io_ctrlrepl_wTag & T7;
  assign T7 = T8[4'hf:4'hf];
  assign T8 = 1'h1 << T9;
  assign T9 = nextIndexReg;
  assign T515 = reset ? 4'h0 : T10;
  assign T10 = io_ctrlrepl_wTag ? T11 : nextIndexReg;
  assign T11 = T13 ? 4'h0 : T12;
  assign T12 = nextIndexReg + 4'h1;
  assign T13 = nextIndexReg == 4'hf;
  assign T14 = T25 & T15;
  assign T15 = T16[4'hf:4'hf];
  assign T16 = 1'h1 << T17;
  assign T17 = nextTagReg;
  assign T516 = reset ? 4'h0 : T18;
  assign T18 = T25 ? T22 : T19;
  assign T19 = T20 ? T11 : nextTagReg;
  assign T20 = io_ctrlrepl_wTag & T21;
  assign T21 = nextTagReg == nextIndexReg;
  assign T22 = T24 ? 4'h0 : T23;
  assign T23 = nextTagReg + 4'h1;
  assign T24 = nextTagReg == 4'hf;
  assign T25 = $signed(freeSpaceReg) < $signed(1'h0);
  assign T517 = reset ? 12'h400 : T26;
  assign T26 = T25 ? T166 : T27;
  assign T27 = io_ctrlrepl_wTag ? T28 : freeSpaceReg;
  assign T28 = T162 + T29;
  assign T29 = T30;
  assign T30 = {1'h0, T31};
  assign T31 = T161 ? T99 : T32;
  assign T32 = T98 ? T68 : T33;
  assign T33 = T67 ? T53 : T34;
  assign T34 = T52 ? sizeVec_1 : sizeVec_0;
  assign T518 = reset ? 11'h0 : T35;
  assign T35 = T42 ? 11'h0 : T36;
  assign T36 = T38 ? T37 : sizeVec_0;
  assign T37 = io_ctrlrepl_wData[4'ha:1'h0];
  assign T38 = io_ctrlrepl_wTag & T39;
  assign T39 = T40[1'h0:1'h0];
  assign T40 = 1'h1 << T41;
  assign T41 = nextIndexReg;
  assign T42 = T25 & T43;
  assign T43 = T44[1'h0:1'h0];
  assign T44 = 1'h1 << T45;
  assign T45 = nextTagReg;
  assign T519 = reset ? 11'h0 : T46;
  assign T46 = T50 ? 11'h0 : T47;
  assign T47 = T48 ? T37 : sizeVec_1;
  assign T48 = io_ctrlrepl_wTag & T49;
  assign T49 = T40[1'h1:1'h1];
  assign T50 = T25 & T51;
  assign T51 = T44[1'h1:1'h1];
  assign T52 = T41[1'h0:1'h0];
  assign T53 = T66 ? sizeVec_3 : sizeVec_2;
  assign T520 = reset ? 11'h0 : T54;
  assign T54 = T58 ? 11'h0 : T55;
  assign T55 = T56 ? T37 : sizeVec_2;
  assign T56 = io_ctrlrepl_wTag & T57;
  assign T57 = T40[2'h2:2'h2];
  assign T58 = T25 & T59;
  assign T59 = T44[2'h2:2'h2];
  assign T521 = reset ? 11'h0 : T60;
  assign T60 = T64 ? 11'h0 : T61;
  assign T61 = T62 ? T37 : sizeVec_3;
  assign T62 = io_ctrlrepl_wTag & T63;
  assign T63 = T40[2'h3:2'h3];
  assign T64 = T25 & T65;
  assign T65 = T44[2'h3:2'h3];
  assign T66 = T41[1'h0:1'h0];
  assign T67 = T41[1'h1:1'h1];
  assign T68 = T97 ? T83 : T69;
  assign T69 = T82 ? sizeVec_5 : sizeVec_4;
  assign T522 = reset ? 11'h0 : T70;
  assign T70 = T74 ? 11'h0 : T71;
  assign T71 = T72 ? T37 : sizeVec_4;
  assign T72 = io_ctrlrepl_wTag & T73;
  assign T73 = T40[3'h4:3'h4];
  assign T74 = T25 & T75;
  assign T75 = T44[3'h4:3'h4];
  assign T523 = reset ? 11'h0 : T76;
  assign T76 = T80 ? 11'h0 : T77;
  assign T77 = T78 ? T37 : sizeVec_5;
  assign T78 = io_ctrlrepl_wTag & T79;
  assign T79 = T40[3'h5:3'h5];
  assign T80 = T25 & T81;
  assign T81 = T44[3'h5:3'h5];
  assign T82 = T41[1'h0:1'h0];
  assign T83 = T96 ? sizeVec_7 : sizeVec_6;
  assign T524 = reset ? 11'h0 : T84;
  assign T84 = T88 ? 11'h0 : T85;
  assign T85 = T86 ? T37 : sizeVec_6;
  assign T86 = io_ctrlrepl_wTag & T87;
  assign T87 = T40[3'h6:3'h6];
  assign T88 = T25 & T89;
  assign T89 = T44[3'h6:3'h6];
  assign T525 = reset ? 11'h0 : T90;
  assign T90 = T94 ? 11'h0 : T91;
  assign T91 = T92 ? T37 : sizeVec_7;
  assign T92 = io_ctrlrepl_wTag & T93;
  assign T93 = T40[3'h7:3'h7];
  assign T94 = T25 & T95;
  assign T95 = T44[3'h7:3'h7];
  assign T96 = T41[1'h0:1'h0];
  assign T97 = T41[1'h1:1'h1];
  assign T98 = T41[2'h2:2'h2];
  assign T99 = T160 ? T130 : T100;
  assign T100 = T129 ? T115 : T101;
  assign T101 = T114 ? sizeVec_9 : sizeVec_8;
  assign T526 = reset ? 11'h0 : T102;
  assign T102 = T106 ? 11'h0 : T103;
  assign T103 = T104 ? T37 : sizeVec_8;
  assign T104 = io_ctrlrepl_wTag & T105;
  assign T105 = T40[4'h8:4'h8];
  assign T106 = T25 & T107;
  assign T107 = T44[4'h8:4'h8];
  assign T527 = reset ? 11'h0 : T108;
  assign T108 = T112 ? 11'h0 : T109;
  assign T109 = T110 ? T37 : sizeVec_9;
  assign T110 = io_ctrlrepl_wTag & T111;
  assign T111 = T40[4'h9:4'h9];
  assign T112 = T25 & T113;
  assign T113 = T44[4'h9:4'h9];
  assign T114 = T41[1'h0:1'h0];
  assign T115 = T128 ? sizeVec_11 : sizeVec_10;
  assign T528 = reset ? 11'h0 : T116;
  assign T116 = T120 ? 11'h0 : T117;
  assign T117 = T118 ? T37 : sizeVec_10;
  assign T118 = io_ctrlrepl_wTag & T119;
  assign T119 = T40[4'ha:4'ha];
  assign T120 = T25 & T121;
  assign T121 = T44[4'ha:4'ha];
  assign T529 = reset ? 11'h0 : T122;
  assign T122 = T126 ? 11'h0 : T123;
  assign T123 = T124 ? T37 : sizeVec_11;
  assign T124 = io_ctrlrepl_wTag & T125;
  assign T125 = T40[4'hb:4'hb];
  assign T126 = T25 & T127;
  assign T127 = T44[4'hb:4'hb];
  assign T128 = T41[1'h0:1'h0];
  assign T129 = T41[1'h1:1'h1];
  assign T130 = T159 ? T145 : T131;
  assign T131 = T144 ? sizeVec_13 : sizeVec_12;
  assign T530 = reset ? 11'h0 : T132;
  assign T132 = T136 ? 11'h0 : T133;
  assign T133 = T134 ? T37 : sizeVec_12;
  assign T134 = io_ctrlrepl_wTag & T135;
  assign T135 = T40[4'hc:4'hc];
  assign T136 = T25 & T137;
  assign T137 = T44[4'hc:4'hc];
  assign T531 = reset ? 11'h0 : T138;
  assign T138 = T142 ? 11'h0 : T139;
  assign T139 = T140 ? T37 : sizeVec_13;
  assign T140 = io_ctrlrepl_wTag & T141;
  assign T141 = T40[4'hd:4'hd];
  assign T142 = T25 & T143;
  assign T143 = T44[4'hd:4'hd];
  assign T144 = T41[1'h0:1'h0];
  assign T145 = T158 ? sizeVec_15 : sizeVec_14;
  assign T532 = reset ? 11'h0 : T146;
  assign T146 = T150 ? 11'h0 : T147;
  assign T147 = T148 ? T37 : sizeVec_14;
  assign T148 = io_ctrlrepl_wTag & T149;
  assign T149 = T40[4'he:4'he];
  assign T150 = T25 & T151;
  assign T151 = T44[4'he:4'he];
  assign T533 = reset ? 11'h0 : T152;
  assign T152 = T156 ? 11'h0 : T153;
  assign T153 = T154 ? T37 : sizeVec_15;
  assign T154 = io_ctrlrepl_wTag & T155;
  assign T155 = T40[4'hf:4'hf];
  assign T156 = T25 & T157;
  assign T157 = T44[4'hf:4'hf];
  assign T158 = T41[1'h0:1'h0];
  assign T159 = T41[1'h1:1'h1];
  assign T160 = T41[2'h2:2'h2];
  assign T161 = T41[2'h3:2'h3];
  assign T162 = freeSpaceReg - T163;
  assign T163 = T164;
  assign T164 = {1'h0, T165};
  assign T165 = io_ctrlrepl_wData[4'ha:1'h0];
  assign T166 = freeSpaceReg + T167;
  assign T167 = T168;
  assign T168 = {1'h0, T169};
  assign T169 = T198 ? T184 : T170;
  assign T170 = T183 ? T177 : T171;
  assign T171 = T176 ? T174 : T172;
  assign T172 = T173 ? sizeVec_1 : sizeVec_0;
  assign T173 = T45[1'h0:1'h0];
  assign T174 = T175 ? sizeVec_3 : sizeVec_2;
  assign T175 = T45[1'h0:1'h0];
  assign T176 = T45[1'h1:1'h1];
  assign T177 = T182 ? T180 : T178;
  assign T178 = T179 ? sizeVec_5 : sizeVec_4;
  assign T179 = T45[1'h0:1'h0];
  assign T180 = T181 ? sizeVec_7 : sizeVec_6;
  assign T181 = T45[1'h0:1'h0];
  assign T182 = T45[1'h1:1'h1];
  assign T183 = T45[2'h2:2'h2];
  assign T184 = T197 ? T191 : T185;
  assign T185 = T190 ? T188 : T186;
  assign T186 = T187 ? sizeVec_9 : sizeVec_8;
  assign T187 = T45[1'h0:1'h0];
  assign T188 = T189 ? sizeVec_11 : sizeVec_10;
  assign T189 = T45[1'h0:1'h0];
  assign T190 = T45[1'h1:1'h1];
  assign T191 = T196 ? T194 : T192;
  assign T192 = T193 ? sizeVec_13 : sizeVec_12;
  assign T193 = T45[1'h0:1'h0];
  assign T194 = T195 ? sizeVec_15 : sizeVec_14;
  assign T195 = T45[1'h0:1'h0];
  assign T196 = T45[1'h1:1'h1];
  assign T197 = T45[2'h2:2'h2];
  assign T198 = T45[2'h3:2'h3];
  assign T199 = io_exmcache_callRetBase == addrVec_15;
  assign T200 = T201 ? io_ctrlrepl_wAddr : addrVec_15;
  assign T201 = io_ctrlrepl_wTag & T202;
  assign T202 = T203[4'hf:4'hf];
  assign T203 = 1'h1 << T204;
  assign T204 = nextIndexReg;
  assign T205 = T218 | hitVec_14;
  assign hitVec_14 = T206;
  assign T206 = T214 & validVec_14;
  assign T534 = reset ? 1'h0 : T207;
  assign T207 = io_invalidate ? 1'h0 : T208;
  assign T208 = T212 ? 1'h0 : T209;
  assign T209 = T210 ? 1'h1 : validVec_14;
  assign T210 = io_ctrlrepl_wTag & T211;
  assign T211 = T8[4'he:4'he];
  assign T212 = T25 & T213;
  assign T213 = T16[4'he:4'he];
  assign T214 = io_exmcache_callRetBase == addrVec_14;
  assign T215 = T216 ? io_ctrlrepl_wAddr : addrVec_14;
  assign T216 = io_ctrlrepl_wTag & T217;
  assign T217 = T203[4'he:4'he];
  assign T218 = T231 | hitVec_13;
  assign hitVec_13 = T219;
  assign T219 = T227 & validVec_13;
  assign T535 = reset ? 1'h0 : T220;
  assign T220 = io_invalidate ? 1'h0 : T221;
  assign T221 = T225 ? 1'h0 : T222;
  assign T222 = T223 ? 1'h1 : validVec_13;
  assign T223 = io_ctrlrepl_wTag & T224;
  assign T224 = T8[4'hd:4'hd];
  assign T225 = T25 & T226;
  assign T226 = T16[4'hd:4'hd];
  assign T227 = io_exmcache_callRetBase == addrVec_13;
  assign T228 = T229 ? io_ctrlrepl_wAddr : addrVec_13;
  assign T229 = io_ctrlrepl_wTag & T230;
  assign T230 = T203[4'hd:4'hd];
  assign T231 = T244 | hitVec_12;
  assign hitVec_12 = T232;
  assign T232 = T240 & validVec_12;
  assign T536 = reset ? 1'h0 : T233;
  assign T233 = io_invalidate ? 1'h0 : T234;
  assign T234 = T238 ? 1'h0 : T235;
  assign T235 = T236 ? 1'h1 : validVec_12;
  assign T236 = io_ctrlrepl_wTag & T237;
  assign T237 = T8[4'hc:4'hc];
  assign T238 = T25 & T239;
  assign T239 = T16[4'hc:4'hc];
  assign T240 = io_exmcache_callRetBase == addrVec_12;
  assign T241 = T242 ? io_ctrlrepl_wAddr : addrVec_12;
  assign T242 = io_ctrlrepl_wTag & T243;
  assign T243 = T203[4'hc:4'hc];
  assign T244 = T257 | hitVec_11;
  assign hitVec_11 = T245;
  assign T245 = T253 & validVec_11;
  assign T537 = reset ? 1'h0 : T246;
  assign T246 = io_invalidate ? 1'h0 : T247;
  assign T247 = T251 ? 1'h0 : T248;
  assign T248 = T249 ? 1'h1 : validVec_11;
  assign T249 = io_ctrlrepl_wTag & T250;
  assign T250 = T8[4'hb:4'hb];
  assign T251 = T25 & T252;
  assign T252 = T16[4'hb:4'hb];
  assign T253 = io_exmcache_callRetBase == addrVec_11;
  assign T254 = T255 ? io_ctrlrepl_wAddr : addrVec_11;
  assign T255 = io_ctrlrepl_wTag & T256;
  assign T256 = T203[4'hb:4'hb];
  assign T257 = T270 | hitVec_10;
  assign hitVec_10 = T258;
  assign T258 = T266 & validVec_10;
  assign T538 = reset ? 1'h0 : T259;
  assign T259 = io_invalidate ? 1'h0 : T260;
  assign T260 = T264 ? 1'h0 : T261;
  assign T261 = T262 ? 1'h1 : validVec_10;
  assign T262 = io_ctrlrepl_wTag & T263;
  assign T263 = T8[4'ha:4'ha];
  assign T264 = T25 & T265;
  assign T265 = T16[4'ha:4'ha];
  assign T266 = io_exmcache_callRetBase == addrVec_10;
  assign T267 = T268 ? io_ctrlrepl_wAddr : addrVec_10;
  assign T268 = io_ctrlrepl_wTag & T269;
  assign T269 = T203[4'ha:4'ha];
  assign T270 = T283 | hitVec_9;
  assign hitVec_9 = T271;
  assign T271 = T279 & validVec_9;
  assign T539 = reset ? 1'h0 : T272;
  assign T272 = io_invalidate ? 1'h0 : T273;
  assign T273 = T277 ? 1'h0 : T274;
  assign T274 = T275 ? 1'h1 : validVec_9;
  assign T275 = io_ctrlrepl_wTag & T276;
  assign T276 = T8[4'h9:4'h9];
  assign T277 = T25 & T278;
  assign T278 = T16[4'h9:4'h9];
  assign T279 = io_exmcache_callRetBase == addrVec_9;
  assign T280 = T281 ? io_ctrlrepl_wAddr : addrVec_9;
  assign T281 = io_ctrlrepl_wTag & T282;
  assign T282 = T203[4'h9:4'h9];
  assign T283 = T296 | hitVec_8;
  assign hitVec_8 = T284;
  assign T284 = T292 & validVec_8;
  assign T540 = reset ? 1'h0 : T285;
  assign T285 = io_invalidate ? 1'h0 : T286;
  assign T286 = T290 ? 1'h0 : T287;
  assign T287 = T288 ? 1'h1 : validVec_8;
  assign T288 = io_ctrlrepl_wTag & T289;
  assign T289 = T8[4'h8:4'h8];
  assign T290 = T25 & T291;
  assign T291 = T16[4'h8:4'h8];
  assign T292 = io_exmcache_callRetBase == addrVec_8;
  assign T293 = T294 ? io_ctrlrepl_wAddr : addrVec_8;
  assign T294 = io_ctrlrepl_wTag & T295;
  assign T295 = T203[4'h8:4'h8];
  assign T296 = T309 | hitVec_7;
  assign hitVec_7 = T297;
  assign T297 = T305 & validVec_7;
  assign T541 = reset ? 1'h0 : T298;
  assign T298 = io_invalidate ? 1'h0 : T299;
  assign T299 = T303 ? 1'h0 : T300;
  assign T300 = T301 ? 1'h1 : validVec_7;
  assign T301 = io_ctrlrepl_wTag & T302;
  assign T302 = T8[3'h7:3'h7];
  assign T303 = T25 & T304;
  assign T304 = T16[3'h7:3'h7];
  assign T305 = io_exmcache_callRetBase == addrVec_7;
  assign T306 = T307 ? io_ctrlrepl_wAddr : addrVec_7;
  assign T307 = io_ctrlrepl_wTag & T308;
  assign T308 = T203[3'h7:3'h7];
  assign T309 = T322 | hitVec_6;
  assign hitVec_6 = T310;
  assign T310 = T318 & validVec_6;
  assign T542 = reset ? 1'h0 : T311;
  assign T311 = io_invalidate ? 1'h0 : T312;
  assign T312 = T316 ? 1'h0 : T313;
  assign T313 = T314 ? 1'h1 : validVec_6;
  assign T314 = io_ctrlrepl_wTag & T315;
  assign T315 = T8[3'h6:3'h6];
  assign T316 = T25 & T317;
  assign T317 = T16[3'h6:3'h6];
  assign T318 = io_exmcache_callRetBase == addrVec_6;
  assign T319 = T320 ? io_ctrlrepl_wAddr : addrVec_6;
  assign T320 = io_ctrlrepl_wTag & T321;
  assign T321 = T203[3'h6:3'h6];
  assign T322 = T335 | hitVec_5;
  assign hitVec_5 = T323;
  assign T323 = T331 & validVec_5;
  assign T543 = reset ? 1'h0 : T324;
  assign T324 = io_invalidate ? 1'h0 : T325;
  assign T325 = T329 ? 1'h0 : T326;
  assign T326 = T327 ? 1'h1 : validVec_5;
  assign T327 = io_ctrlrepl_wTag & T328;
  assign T328 = T8[3'h5:3'h5];
  assign T329 = T25 & T330;
  assign T330 = T16[3'h5:3'h5];
  assign T331 = io_exmcache_callRetBase == addrVec_5;
  assign T332 = T333 ? io_ctrlrepl_wAddr : addrVec_5;
  assign T333 = io_ctrlrepl_wTag & T334;
  assign T334 = T203[3'h5:3'h5];
  assign T335 = T348 | hitVec_4;
  assign hitVec_4 = T336;
  assign T336 = T344 & validVec_4;
  assign T544 = reset ? 1'h0 : T337;
  assign T337 = io_invalidate ? 1'h0 : T338;
  assign T338 = T342 ? 1'h0 : T339;
  assign T339 = T340 ? 1'h1 : validVec_4;
  assign T340 = io_ctrlrepl_wTag & T341;
  assign T341 = T8[3'h4:3'h4];
  assign T342 = T25 & T343;
  assign T343 = T16[3'h4:3'h4];
  assign T344 = io_exmcache_callRetBase == addrVec_4;
  assign T345 = T346 ? io_ctrlrepl_wAddr : addrVec_4;
  assign T346 = io_ctrlrepl_wTag & T347;
  assign T347 = T203[3'h4:3'h4];
  assign T348 = T361 | hitVec_3;
  assign hitVec_3 = T349;
  assign T349 = T357 & validVec_3;
  assign T545 = reset ? 1'h0 : T350;
  assign T350 = io_invalidate ? 1'h0 : T351;
  assign T351 = T355 ? 1'h0 : T352;
  assign T352 = T353 ? 1'h1 : validVec_3;
  assign T353 = io_ctrlrepl_wTag & T354;
  assign T354 = T8[2'h3:2'h3];
  assign T355 = T25 & T356;
  assign T356 = T16[2'h3:2'h3];
  assign T357 = io_exmcache_callRetBase == addrVec_3;
  assign T358 = T359 ? io_ctrlrepl_wAddr : addrVec_3;
  assign T359 = io_ctrlrepl_wTag & T360;
  assign T360 = T203[2'h3:2'h3];
  assign T361 = T374 | hitVec_2;
  assign hitVec_2 = T362;
  assign T362 = T370 & validVec_2;
  assign T546 = reset ? 1'h0 : T363;
  assign T363 = io_invalidate ? 1'h0 : T364;
  assign T364 = T368 ? 1'h0 : T365;
  assign T365 = T366 ? 1'h1 : validVec_2;
  assign T366 = io_ctrlrepl_wTag & T367;
  assign T367 = T8[2'h2:2'h2];
  assign T368 = T25 & T369;
  assign T369 = T16[2'h2:2'h2];
  assign T370 = io_exmcache_callRetBase == addrVec_2;
  assign T371 = T372 ? io_ctrlrepl_wAddr : addrVec_2;
  assign T372 = io_ctrlrepl_wTag & T373;
  assign T373 = T203[2'h2:2'h2];
  assign T374 = T387 | hitVec_1;
  assign hitVec_1 = T375;
  assign T375 = T383 & validVec_1;
  assign T547 = reset ? 1'h0 : T376;
  assign T376 = io_invalidate ? 1'h0 : T377;
  assign T377 = T381 ? 1'h0 : T378;
  assign T378 = T379 ? 1'h1 : validVec_1;
  assign T379 = io_ctrlrepl_wTag & T380;
  assign T380 = T8[1'h1:1'h1];
  assign T381 = T25 & T382;
  assign T382 = T16[1'h1:1'h1];
  assign T383 = io_exmcache_callRetBase == addrVec_1;
  assign T384 = T385 ? io_ctrlrepl_wAddr : addrVec_1;
  assign T385 = io_ctrlrepl_wTag & T386;
  assign T386 = T203[1'h1:1'h1];
  assign T387 = 1'h0 | hitVec_0;
  assign hitVec_0 = T388;
  assign T388 = T396 & validVec_0;
  assign T548 = reset ? 1'h0 : T389;
  assign T389 = io_invalidate ? 1'h0 : T390;
  assign T390 = T394 ? 1'h0 : T391;
  assign T391 = T392 ? 1'h1 : validVec_0;
  assign T392 = io_ctrlrepl_wTag & T393;
  assign T393 = T8[1'h0:1'h0];
  assign T394 = T25 & T395;
  assign T395 = T16[1'h0:1'h0];
  assign T396 = io_exmcache_callRetBase == addrVec_0;
  assign T397 = T398 ? io_ctrlrepl_wAddr : addrVec_0;
  assign T398 = io_ctrlrepl_wTag & T399;
  assign T399 = T203[1'h0:1'h0];
  assign T400 = T403 & T401;
  assign T401 = 17'h1 <= T402;
  assign T402 = io_exmcache_callRetBase[5'h1f:4'hf];
  assign T403 = io_exmcache_doCallRet & io_ena_in;
  assign io_perf_hit = T404;
  assign T404 = T400 & hit;
  assign io_memIn_addrOdd = addrOdd;
  assign addrOdd = io_ctrlrepl_addrOdd[4'h9:1'h1];
  assign io_memIn_addrEven = addrEven;
  assign addrEven = io_ctrlrepl_addrEven[4'h9:1'h1];
  assign io_memIn_wAddr = wAddr;
  assign wAddr = T405[4'h9:1'h1];
  assign T405 = T549 + io_ctrlrepl_wAddr;
  assign T549 = {22'h0, wrPosReg};
  assign T550 = reset ? 10'h0 : T406;
  assign T406 = io_ctrlrepl_wTag ? posReg : wrPosReg;
  assign T551 = reset ? 10'h0 : T407;
  assign T407 = T400 ? pos : posReg;
  assign pos = hit ? T411 : nextPosReg;
  assign T552 = reset ? 10'h0 : T408;
  assign T408 = io_ctrlrepl_wTag ? T409 : nextPosReg;
  assign T409 = nextPosReg + T410;
  assign T410 = io_ctrlrepl_wData[4'h9:1'h0];
  assign T411 = T418 | mergePosVec_15;
  assign mergePosVec_15 = T412;
  assign T412 = T2 ? posVec_15 : 10'h0;
  assign T413 = T414 ? nextPosReg : posVec_15;
  assign T414 = io_ctrlrepl_wTag & T415;
  assign T415 = T416[4'hf:4'hf];
  assign T416 = 1'h1 << T417;
  assign T417 = nextIndexReg;
  assign T418 = T423 | mergePosVec_14;
  assign mergePosVec_14 = T419;
  assign T419 = T206 ? posVec_14 : 10'h0;
  assign T420 = T421 ? nextPosReg : posVec_14;
  assign T421 = io_ctrlrepl_wTag & T422;
  assign T422 = T416[4'he:4'he];
  assign T423 = T428 | mergePosVec_13;
  assign mergePosVec_13 = T424;
  assign T424 = T219 ? posVec_13 : 10'h0;
  assign T425 = T426 ? nextPosReg : posVec_13;
  assign T426 = io_ctrlrepl_wTag & T427;
  assign T427 = T416[4'hd:4'hd];
  assign T428 = T433 | mergePosVec_12;
  assign mergePosVec_12 = T429;
  assign T429 = T232 ? posVec_12 : 10'h0;
  assign T430 = T431 ? nextPosReg : posVec_12;
  assign T431 = io_ctrlrepl_wTag & T432;
  assign T432 = T416[4'hc:4'hc];
  assign T433 = T438 | mergePosVec_11;
  assign mergePosVec_11 = T434;
  assign T434 = T245 ? posVec_11 : 10'h0;
  assign T435 = T436 ? nextPosReg : posVec_11;
  assign T436 = io_ctrlrepl_wTag & T437;
  assign T437 = T416[4'hb:4'hb];
  assign T438 = T443 | mergePosVec_10;
  assign mergePosVec_10 = T439;
  assign T439 = T258 ? posVec_10 : 10'h0;
  assign T440 = T441 ? nextPosReg : posVec_10;
  assign T441 = io_ctrlrepl_wTag & T442;
  assign T442 = T416[4'ha:4'ha];
  assign T443 = T448 | mergePosVec_9;
  assign mergePosVec_9 = T444;
  assign T444 = T271 ? posVec_9 : 10'h0;
  assign T445 = T446 ? nextPosReg : posVec_9;
  assign T446 = io_ctrlrepl_wTag & T447;
  assign T447 = T416[4'h9:4'h9];
  assign T448 = T453 | mergePosVec_8;
  assign mergePosVec_8 = T449;
  assign T449 = T284 ? posVec_8 : 10'h0;
  assign T450 = T451 ? nextPosReg : posVec_8;
  assign T451 = io_ctrlrepl_wTag & T452;
  assign T452 = T416[4'h8:4'h8];
  assign T453 = T458 | mergePosVec_7;
  assign mergePosVec_7 = T454;
  assign T454 = T297 ? posVec_7 : 10'h0;
  assign T455 = T456 ? nextPosReg : posVec_7;
  assign T456 = io_ctrlrepl_wTag & T457;
  assign T457 = T416[3'h7:3'h7];
  assign T458 = T463 | mergePosVec_6;
  assign mergePosVec_6 = T459;
  assign T459 = T310 ? posVec_6 : 10'h0;
  assign T460 = T461 ? nextPosReg : posVec_6;
  assign T461 = io_ctrlrepl_wTag & T462;
  assign T462 = T416[3'h6:3'h6];
  assign T463 = T468 | mergePosVec_5;
  assign mergePosVec_5 = T464;
  assign T464 = T323 ? posVec_5 : 10'h0;
  assign T465 = T466 ? nextPosReg : posVec_5;
  assign T466 = io_ctrlrepl_wTag & T467;
  assign T467 = T416[3'h5:3'h5];
  assign T468 = T473 | mergePosVec_4;
  assign mergePosVec_4 = T469;
  assign T469 = T336 ? posVec_4 : 10'h0;
  assign T470 = T471 ? nextPosReg : posVec_4;
  assign T471 = io_ctrlrepl_wTag & T472;
  assign T472 = T416[3'h4:3'h4];
  assign T473 = T478 | mergePosVec_3;
  assign mergePosVec_3 = T474;
  assign T474 = T349 ? posVec_3 : 10'h0;
  assign T475 = T476 ? nextPosReg : posVec_3;
  assign T476 = io_ctrlrepl_wTag & T477;
  assign T477 = T416[2'h3:2'h3];
  assign T478 = T483 | mergePosVec_2;
  assign mergePosVec_2 = T479;
  assign T479 = T362 ? posVec_2 : 10'h0;
  assign T480 = T481 ? nextPosReg : posVec_2;
  assign T481 = io_ctrlrepl_wTag & T482;
  assign T482 = T416[2'h2:2'h2];
  assign T483 = T488 | mergePosVec_1;
  assign mergePosVec_1 = T484;
  assign T484 = T375 ? posVec_1 : 10'h0;
  assign T485 = T486 ? nextPosReg : posVec_1;
  assign T486 = io_ctrlrepl_wTag & T487;
  assign T487 = T416[1'h1:1'h1];
  assign T488 = 10'h0 | mergePosVec_0;
  assign mergePosVec_0 = T489;
  assign T489 = T388 ? posVec_0 : 10'h0;
  assign T490 = T491 ? nextPosReg : posVec_0;
  assign T491 = io_ctrlrepl_wTag & T492;
  assign T492 = T416[1'h0:1'h0];
  assign io_memIn_wData = io_ctrlrepl_wData;
  assign io_memIn_wOdd = T493;
  assign T493 = wParity ? io_ctrlrepl_wEna : 1'h0;
  assign wParity = io_ctrlrepl_wAddr[1'h0:1'h0];
  assign io_memIn_wEven = T494;
  assign T494 = wParity ? 1'h0 : io_ctrlrepl_wEna;
  assign io_replctrl_hit = hitReg;
  assign T553 = reset ? 1'h1 : T495;
  assign T495 = io_ctrlrepl_wTag ? 1'h1 : T496;
  assign T496 = T400 ? hit : hitReg;
  assign io_mcachefe_memSel = T497;
  assign T497 = {selSpmReg, selCacheReg};
  assign T554 = reset ? 1'h0 : T498;
  assign T498 = T403 ? T401 : selCacheReg;
  assign T555 = reset ? 1'h0 : T499;
  assign T499 = T403 ? T500 : selSpmReg;
  assign T500 = T501 == 18'h1;
  assign T501 = io_exmcache_callRetBase[5'h1f:4'he];
  assign io_mcachefe_reloc = reloc;
  assign reloc = selCacheReg ? T503 : T556;
  assign T556 = {17'h0, T502};
  assign T502 = selSpmReg ? 15'h4000 : 15'h0;
  assign T503 = callRetBaseReg - T557;
  assign T557 = {22'h0, T504};
  assign T504 = posReg;
  assign T558 = reset ? 32'h1 : T505;
  assign T505 = T403 ? io_exmcache_callRetBase : callRetBaseReg;
  assign io_mcachefe_relPc = T559;
  assign T559 = relPc[4'ha:1'h0];
  assign relPc = callAddrReg + T560;
  assign T560 = {18'h0, relBase};
  assign relBase = selCacheReg ? T561 : T506;
  assign T506 = callRetBaseReg[4'hd:1'h0];
  assign T561 = {4'h0, T507};
  assign T507 = posReg;
  assign T562 = reset ? 32'h1 : T508;
  assign T508 = T403 ? io_exmcache_callRetAddr : callAddrReg;
  assign io_mcachefe_relBase = T563;
  assign T563 = relBase[4'h9:1'h0];
  assign io_mcachefe_base = callRetBaseReg;
  assign io_mcachefe_instrOdd = T509;
  assign T509 = io_ctrlrepl_instrStall ? instrOddReg : io_memOut_instrOdd;
  assign T510 = T511 ? io_mcachefe_instrOdd : instrOddReg;
  assign T511 = io_ctrlrepl_instrStall ^ 1'h1;
  assign io_mcachefe_instrEven = T512;
  assign T512 = io_ctrlrepl_instrStall ? instrEvenReg : io_memOut_instrEven;
  assign T513 = T511 ? io_mcachefe_instrEven : instrEvenReg;
  assign io_hitEna = hitReg;

  always @(posedge clk) begin
    if(reset) begin
      validVec_15 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_15 <= 1'h0;
    end else if(T14) begin
      validVec_15 <= 1'h0;
    end else if(T6) begin
      validVec_15 <= 1'h1;
    end
    if(reset) begin
      nextIndexReg <= 4'h0;
    end else if(io_ctrlrepl_wTag) begin
      nextIndexReg <= T11;
    end
    if(reset) begin
      nextTagReg <= 4'h0;
    end else if(T25) begin
      nextTagReg <= T22;
    end else if(T20) begin
      nextTagReg <= T11;
    end
    if(reset) begin
      freeSpaceReg <= 12'h400;
    end else if(T25) begin
      freeSpaceReg <= T166;
    end else if(io_ctrlrepl_wTag) begin
      freeSpaceReg <= T28;
    end
    if(reset) begin
      sizeVec_0 <= 11'h0;
    end else if(T42) begin
      sizeVec_0 <= 11'h0;
    end else if(T38) begin
      sizeVec_0 <= T37;
    end
    if(reset) begin
      sizeVec_1 <= 11'h0;
    end else if(T50) begin
      sizeVec_1 <= 11'h0;
    end else if(T48) begin
      sizeVec_1 <= T37;
    end
    if(reset) begin
      sizeVec_2 <= 11'h0;
    end else if(T58) begin
      sizeVec_2 <= 11'h0;
    end else if(T56) begin
      sizeVec_2 <= T37;
    end
    if(reset) begin
      sizeVec_3 <= 11'h0;
    end else if(T64) begin
      sizeVec_3 <= 11'h0;
    end else if(T62) begin
      sizeVec_3 <= T37;
    end
    if(reset) begin
      sizeVec_4 <= 11'h0;
    end else if(T74) begin
      sizeVec_4 <= 11'h0;
    end else if(T72) begin
      sizeVec_4 <= T37;
    end
    if(reset) begin
      sizeVec_5 <= 11'h0;
    end else if(T80) begin
      sizeVec_5 <= 11'h0;
    end else if(T78) begin
      sizeVec_5 <= T37;
    end
    if(reset) begin
      sizeVec_6 <= 11'h0;
    end else if(T88) begin
      sizeVec_6 <= 11'h0;
    end else if(T86) begin
      sizeVec_6 <= T37;
    end
    if(reset) begin
      sizeVec_7 <= 11'h0;
    end else if(T94) begin
      sizeVec_7 <= 11'h0;
    end else if(T92) begin
      sizeVec_7 <= T37;
    end
    if(reset) begin
      sizeVec_8 <= 11'h0;
    end else if(T106) begin
      sizeVec_8 <= 11'h0;
    end else if(T104) begin
      sizeVec_8 <= T37;
    end
    if(reset) begin
      sizeVec_9 <= 11'h0;
    end else if(T112) begin
      sizeVec_9 <= 11'h0;
    end else if(T110) begin
      sizeVec_9 <= T37;
    end
    if(reset) begin
      sizeVec_10 <= 11'h0;
    end else if(T120) begin
      sizeVec_10 <= 11'h0;
    end else if(T118) begin
      sizeVec_10 <= T37;
    end
    if(reset) begin
      sizeVec_11 <= 11'h0;
    end else if(T126) begin
      sizeVec_11 <= 11'h0;
    end else if(T124) begin
      sizeVec_11 <= T37;
    end
    if(reset) begin
      sizeVec_12 <= 11'h0;
    end else if(T136) begin
      sizeVec_12 <= 11'h0;
    end else if(T134) begin
      sizeVec_12 <= T37;
    end
    if(reset) begin
      sizeVec_13 <= 11'h0;
    end else if(T142) begin
      sizeVec_13 <= 11'h0;
    end else if(T140) begin
      sizeVec_13 <= T37;
    end
    if(reset) begin
      sizeVec_14 <= 11'h0;
    end else if(T150) begin
      sizeVec_14 <= 11'h0;
    end else if(T148) begin
      sizeVec_14 <= T37;
    end
    if(reset) begin
      sizeVec_15 <= 11'h0;
    end else if(T156) begin
      sizeVec_15 <= 11'h0;
    end else if(T154) begin
      sizeVec_15 <= T37;
    end
    if(T201) begin
      addrVec_15 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_14 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_14 <= 1'h0;
    end else if(T212) begin
      validVec_14 <= 1'h0;
    end else if(T210) begin
      validVec_14 <= 1'h1;
    end
    if(T216) begin
      addrVec_14 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_13 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_13 <= 1'h0;
    end else if(T225) begin
      validVec_13 <= 1'h0;
    end else if(T223) begin
      validVec_13 <= 1'h1;
    end
    if(T229) begin
      addrVec_13 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_12 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_12 <= 1'h0;
    end else if(T238) begin
      validVec_12 <= 1'h0;
    end else if(T236) begin
      validVec_12 <= 1'h1;
    end
    if(T242) begin
      addrVec_12 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_11 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_11 <= 1'h0;
    end else if(T251) begin
      validVec_11 <= 1'h0;
    end else if(T249) begin
      validVec_11 <= 1'h1;
    end
    if(T255) begin
      addrVec_11 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_10 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_10 <= 1'h0;
    end else if(T264) begin
      validVec_10 <= 1'h0;
    end else if(T262) begin
      validVec_10 <= 1'h1;
    end
    if(T268) begin
      addrVec_10 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_9 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_9 <= 1'h0;
    end else if(T277) begin
      validVec_9 <= 1'h0;
    end else if(T275) begin
      validVec_9 <= 1'h1;
    end
    if(T281) begin
      addrVec_9 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_8 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_8 <= 1'h0;
    end else if(T290) begin
      validVec_8 <= 1'h0;
    end else if(T288) begin
      validVec_8 <= 1'h1;
    end
    if(T294) begin
      addrVec_8 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_7 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_7 <= 1'h0;
    end else if(T303) begin
      validVec_7 <= 1'h0;
    end else if(T301) begin
      validVec_7 <= 1'h1;
    end
    if(T307) begin
      addrVec_7 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_6 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_6 <= 1'h0;
    end else if(T316) begin
      validVec_6 <= 1'h0;
    end else if(T314) begin
      validVec_6 <= 1'h1;
    end
    if(T320) begin
      addrVec_6 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_5 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_5 <= 1'h0;
    end else if(T329) begin
      validVec_5 <= 1'h0;
    end else if(T327) begin
      validVec_5 <= 1'h1;
    end
    if(T333) begin
      addrVec_5 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_4 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_4 <= 1'h0;
    end else if(T342) begin
      validVec_4 <= 1'h0;
    end else if(T340) begin
      validVec_4 <= 1'h1;
    end
    if(T346) begin
      addrVec_4 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_3 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_3 <= 1'h0;
    end else if(T355) begin
      validVec_3 <= 1'h0;
    end else if(T353) begin
      validVec_3 <= 1'h1;
    end
    if(T359) begin
      addrVec_3 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_2 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_2 <= 1'h0;
    end else if(T368) begin
      validVec_2 <= 1'h0;
    end else if(T366) begin
      validVec_2 <= 1'h1;
    end
    if(T372) begin
      addrVec_2 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_1 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_1 <= 1'h0;
    end else if(T381) begin
      validVec_1 <= 1'h0;
    end else if(T379) begin
      validVec_1 <= 1'h1;
    end
    if(T385) begin
      addrVec_1 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      validVec_0 <= 1'h0;
    end else if(io_invalidate) begin
      validVec_0 <= 1'h0;
    end else if(T394) begin
      validVec_0 <= 1'h0;
    end else if(T392) begin
      validVec_0 <= 1'h1;
    end
    if(T398) begin
      addrVec_0 <= io_ctrlrepl_wAddr;
    end
    if(reset) begin
      wrPosReg <= 10'h0;
    end else if(io_ctrlrepl_wTag) begin
      wrPosReg <= posReg;
    end
    if(reset) begin
      posReg <= 10'h0;
    end else if(T400) begin
      posReg <= pos;
    end
    if(reset) begin
      nextPosReg <= 10'h0;
    end else if(io_ctrlrepl_wTag) begin
      nextPosReg <= T409;
    end
    if(T414) begin
      posVec_15 <= nextPosReg;
    end
    if(T421) begin
      posVec_14 <= nextPosReg;
    end
    if(T426) begin
      posVec_13 <= nextPosReg;
    end
    if(T431) begin
      posVec_12 <= nextPosReg;
    end
    if(T436) begin
      posVec_11 <= nextPosReg;
    end
    if(T441) begin
      posVec_10 <= nextPosReg;
    end
    if(T446) begin
      posVec_9 <= nextPosReg;
    end
    if(T451) begin
      posVec_8 <= nextPosReg;
    end
    if(T456) begin
      posVec_7 <= nextPosReg;
    end
    if(T461) begin
      posVec_6 <= nextPosReg;
    end
    if(T466) begin
      posVec_5 <= nextPosReg;
    end
    if(T471) begin
      posVec_4 <= nextPosReg;
    end
    if(T476) begin
      posVec_3 <= nextPosReg;
    end
    if(T481) begin
      posVec_2 <= nextPosReg;
    end
    if(T486) begin
      posVec_1 <= nextPosReg;
    end
    if(T491) begin
      posVec_0 <= nextPosReg;
    end
    if(reset) begin
      hitReg <= 1'h1;
    end else if(io_ctrlrepl_wTag) begin
      hitReg <= 1'h1;
    end else if(T400) begin
      hitReg <= hit;
    end
    if(reset) begin
      selCacheReg <= 1'h0;
    end else if(T403) begin
      selCacheReg <= T401;
    end
    if(reset) begin
      selSpmReg <= 1'h0;
    end else if(T403) begin
      selSpmReg <= T500;
    end
    if(reset) begin
      callRetBaseReg <= 32'h1;
    end else if(T403) begin
      callRetBaseReg <= io_exmcache_callRetBase;
    end
    if(reset) begin
      callAddrReg <= 32'h1;
    end else if(T403) begin
      callAddrReg <= io_exmcache_callRetAddr;
    end
    if(T511) begin
      instrOddReg <= io_mcachefe_instrOdd;
    end
    if(T511) begin
      instrEvenReg <= io_mcachefe_instrEven;
    end
  end
endmodule

module MemBlock_1(input clk,
    input [8:0] io_rdAddr,
    output[31:0] io_rdData,
    input [8:0] io_wrAddr,
    input  io_wrEna,
    input [31:0] io_wrData
);

  wire[31:0] T0;
  wire[31:0] T1;
  reg [31:0] mem [511:0];
  wire[31:0] T2;
  wire T3;
  reg [8:0] rdAddrReg;
  reg [31:0] R4;
  wire T5;
  wire T6;
  reg [8:0] R7;
  wire T8;
  reg  R9;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    for (initvar = 0; initvar < 512; initvar = initvar+1)
      mem[initvar] = {1{$random}};
    rdAddrReg = {1{$random}};
    R4 = {1{$random}};
    R7 = {1{$random}};
    R9 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_rdData = T0;
  assign T0 = T5 ? R4 : T1;
  assign T1 = mem[rdAddrReg];
  assign T3 = io_wrEna == 1'h1;
  assign T5 = T8 & T6;
  assign T6 = R7 == rdAddrReg;
  assign T8 = R9 == 1'h1;

  always @(posedge clk) begin
    if (T3)
      mem[io_wrAddr] <= io_wrData;
    rdAddrReg <= io_rdAddr;
    R4 <= io_wrData;
    R7 <= io_wrAddr;
    R9 <= io_wrEna;
  end
endmodule

module MCacheMem(input clk,
    input  io_memIn_wEven,
    input  io_memIn_wOdd,
    input [31:0] io_memIn_wData,
    input [8:0] io_memIn_wAddr,
    input [8:0] io_memIn_addrEven,
    input [8:0] io_memIn_addrOdd,
    output[31:0] io_memOut_instrEven,
    output[31:0] io_memOut_instrOdd
);

  wire[31:0] mcacheEven_io_rdData;
  wire[31:0] mcacheOdd_io_rdData;


  assign io_memOut_instrOdd = mcacheOdd_io_rdData;
  assign io_memOut_instrEven = mcacheEven_io_rdData;
  MemBlock_1 mcacheEven(.clk(clk),
       .io_rdAddr( io_memIn_addrEven ),
       .io_rdData( mcacheEven_io_rdData ),
       .io_wrAddr( io_memIn_wAddr ),
       .io_wrEna( io_memIn_wEven ),
       .io_wrData( io_memIn_wData )
  );
  MemBlock_1 mcacheOdd(.clk(clk),
       .io_rdAddr( io_memIn_addrOdd ),
       .io_rdData( mcacheOdd_io_rdData ),
       .io_wrAddr( io_memIn_wAddr ),
       .io_wrEna( io_memIn_wOdd ),
       .io_wrData( io_memIn_wData )
  );
endmodule

module MCache(input clk, input reset,
    output io_ena_out,
    input  io_ena_in,
    input  io_invalidate,
    input [31:0] io_feicache_addrEven,
    input [31:0] io_feicache_addrOdd,
    input  io_exicache_doCallRet,
    input [31:0] io_exicache_callRetBase,
    input [31:0] io_exicache_callRetAddr,
    output[31:0] io_icachefe_instrEven,
    output[31:0] io_icachefe_instrOdd,
    output[31:0] io_icachefe_base,
    output[9:0] io_icachefe_relBase,
    output[10:0] io_icachefe_relPc,
    output[31:0] io_icachefe_reloc,
    output[1:0] io_icachefe_memSel,
    output[2:0] io_ocp_port_M_Cmd,
    output[31:0] io_ocp_port_M_Addr,
    output[31:0] io_ocp_port_M_Data,
    output io_ocp_port_M_DataValid,
    output[3:0] io_ocp_port_M_DataByteEn,
    input [1:0] io_ocp_port_S_Resp,
    input [31:0] io_ocp_port_S_Data,
    input  io_ocp_port_S_CmdAccept,
    input  io_ocp_port_S_DataAccept,
    output io_illMem,
    output io_perf_hit,
    output io_perf_miss
);

  wire T0;
  wire T1;
  wire T2;
  wire ctrl_io_fetchEna;
  wire ctrl_io_ctrlrepl_wEna;
  wire[31:0] ctrl_io_ctrlrepl_wData;
  wire[31:0] ctrl_io_ctrlrepl_wAddr;
  wire ctrl_io_ctrlrepl_wTag;
  wire[9:0] ctrl_io_ctrlrepl_addrEven;
  wire[9:0] ctrl_io_ctrlrepl_addrOdd;
  wire ctrl_io_ctrlrepl_instrStall;
  wire[2:0] ctrl_io_ocp_port_M_Cmd;
  wire[31:0] ctrl_io_ocp_port_M_Addr;
  wire[31:0] ctrl_io_ocp_port_M_Data;
  wire ctrl_io_ocp_port_M_DataValid;
  wire[3:0] ctrl_io_ocp_port_M_DataByteEn;
  wire ctrl_io_illMem;
  wire ctrl_io_forceHit;
  wire repl_io_hitEna;
  wire[31:0] repl_io_mcachefe_instrEven;
  wire[31:0] repl_io_mcachefe_instrOdd;
  wire[31:0] repl_io_mcachefe_base;
  wire[9:0] repl_io_mcachefe_relBase;
  wire[10:0] repl_io_mcachefe_relPc;
  wire[31:0] repl_io_mcachefe_reloc;
  wire[1:0] repl_io_mcachefe_memSel;
  wire repl_io_replctrl_hit;
  wire repl_io_memIn_wEven;
  wire repl_io_memIn_wOdd;
  wire[31:0] repl_io_memIn_wData;
  wire[8:0] repl_io_memIn_wAddr;
  wire[8:0] repl_io_memIn_addrEven;
  wire[8:0] repl_io_memIn_addrOdd;
  wire repl_io_perf_hit;
  wire repl_io_perf_miss;
  wire[31:0] mem_io_memOut_instrEven;
  wire[31:0] mem_io_memOut_instrOdd;


  assign T0 = io_invalidate | ctrl_io_illMem;
  assign io_perf_miss = repl_io_perf_miss;
  assign io_perf_hit = repl_io_perf_hit;
  assign io_illMem = ctrl_io_illMem;
  assign io_ocp_port_M_DataByteEn = ctrl_io_ocp_port_M_DataByteEn;
  assign io_ocp_port_M_DataValid = ctrl_io_ocp_port_M_DataValid;
  assign io_ocp_port_M_Data = ctrl_io_ocp_port_M_Data;
  assign io_ocp_port_M_Addr = ctrl_io_ocp_port_M_Addr;
  assign io_ocp_port_M_Cmd = ctrl_io_ocp_port_M_Cmd;
  assign io_icachefe_memSel = repl_io_mcachefe_memSel;
  assign io_icachefe_reloc = repl_io_mcachefe_reloc;
  assign io_icachefe_relPc = repl_io_mcachefe_relPc;
  assign io_icachefe_relBase = repl_io_mcachefe_relBase;
  assign io_icachefe_base = repl_io_mcachefe_base;
  assign io_icachefe_instrOdd = repl_io_mcachefe_instrOdd;
  assign io_icachefe_instrEven = repl_io_mcachefe_instrEven;
  assign io_ena_out = T1;
  assign T1 = ctrl_io_fetchEna & T2;
  assign T2 = repl_io_hitEna | ctrl_io_forceHit;
  MCacheCtrl ctrl(.clk(clk), .reset(reset),
       .io_ena_in( io_ena_in ),
       .io_fetchEna( ctrl_io_fetchEna ),
       .io_ctrlrepl_wEna( ctrl_io_ctrlrepl_wEna ),
       .io_ctrlrepl_wData( ctrl_io_ctrlrepl_wData ),
       .io_ctrlrepl_wAddr( ctrl_io_ctrlrepl_wAddr ),
       .io_ctrlrepl_wTag( ctrl_io_ctrlrepl_wTag ),
       .io_ctrlrepl_addrEven( ctrl_io_ctrlrepl_addrEven ),
       .io_ctrlrepl_addrOdd( ctrl_io_ctrlrepl_addrOdd ),
       .io_ctrlrepl_instrStall( ctrl_io_ctrlrepl_instrStall ),
       .io_replctrl_hit( repl_io_replctrl_hit ),
       .io_femcache_addrEven( io_feicache_addrEven ),
       .io_femcache_addrOdd( io_feicache_addrOdd ),
       .io_exmcache_doCallRet( io_exicache_doCallRet ),
       .io_exmcache_callRetBase( io_exicache_callRetBase ),
       .io_exmcache_callRetAddr( io_exicache_callRetAddr ),
       .io_ocp_port_M_Cmd( ctrl_io_ocp_port_M_Cmd ),
       .io_ocp_port_M_Addr( ctrl_io_ocp_port_M_Addr ),
       .io_ocp_port_M_Data( ctrl_io_ocp_port_M_Data ),
       .io_ocp_port_M_DataValid( ctrl_io_ocp_port_M_DataValid ),
       .io_ocp_port_M_DataByteEn( ctrl_io_ocp_port_M_DataByteEn ),
       .io_ocp_port_S_Resp( io_ocp_port_S_Resp ),
       .io_ocp_port_S_Data( io_ocp_port_S_Data ),
       .io_ocp_port_S_CmdAccept( io_ocp_port_S_CmdAccept ),
       .io_ocp_port_S_DataAccept( io_ocp_port_S_DataAccept ),
       .io_illMem( ctrl_io_illMem ),
       .io_forceHit( ctrl_io_forceHit )
  );
  MCacheReplFifo repl(.clk(clk), .reset(reset),
       .io_ena_in( io_ena_in ),
       .io_invalidate( T0 ),
       .io_hitEna( repl_io_hitEna ),
       .io_exmcache_doCallRet( io_exicache_doCallRet ),
       .io_exmcache_callRetBase( io_exicache_callRetBase ),
       .io_exmcache_callRetAddr( io_exicache_callRetAddr ),
       .io_mcachefe_instrEven( repl_io_mcachefe_instrEven ),
       .io_mcachefe_instrOdd( repl_io_mcachefe_instrOdd ),
       .io_mcachefe_base( repl_io_mcachefe_base ),
       .io_mcachefe_relBase( repl_io_mcachefe_relBase ),
       .io_mcachefe_relPc( repl_io_mcachefe_relPc ),
       .io_mcachefe_reloc( repl_io_mcachefe_reloc ),
       .io_mcachefe_memSel( repl_io_mcachefe_memSel ),
       .io_ctrlrepl_wEna( ctrl_io_ctrlrepl_wEna ),
       .io_ctrlrepl_wData( ctrl_io_ctrlrepl_wData ),
       .io_ctrlrepl_wAddr( ctrl_io_ctrlrepl_wAddr ),
       .io_ctrlrepl_wTag( ctrl_io_ctrlrepl_wTag ),
       .io_ctrlrepl_addrEven( ctrl_io_ctrlrepl_addrEven ),
       .io_ctrlrepl_addrOdd( ctrl_io_ctrlrepl_addrOdd ),
       .io_ctrlrepl_instrStall( ctrl_io_ctrlrepl_instrStall ),
       .io_replctrl_hit( repl_io_replctrl_hit ),
       .io_memIn_wEven( repl_io_memIn_wEven ),
       .io_memIn_wOdd( repl_io_memIn_wOdd ),
       .io_memIn_wData( repl_io_memIn_wData ),
       .io_memIn_wAddr( repl_io_memIn_wAddr ),
       .io_memIn_addrEven( repl_io_memIn_addrEven ),
       .io_memIn_addrOdd( repl_io_memIn_addrOdd ),
       .io_memOut_instrEven( mem_io_memOut_instrEven ),
       .io_memOut_instrOdd( mem_io_memOut_instrOdd ),
       .io_perf_hit( repl_io_perf_hit ),
       .io_perf_miss( repl_io_perf_miss )
  );
  MCacheMem mem(.clk(clk),
       .io_memIn_wEven( repl_io_memIn_wEven ),
       .io_memIn_wOdd( repl_io_memIn_wOdd ),
       .io_memIn_wData( repl_io_memIn_wData ),
       .io_memIn_wAddr( repl_io_memIn_wAddr ),
       .io_memIn_addrEven( repl_io_memIn_addrEven ),
       .io_memIn_addrOdd( repl_io_memIn_addrOdd ),
       .io_memOut_instrEven( mem_io_memOut_instrEven ),
       .io_memOut_instrOdd( mem_io_memOut_instrOdd )
  );
endmodule

module MemBlock_0(input clk,
    input [6:0] io_rdAddr,
    output[31:0] io_rdData,
    input [6:0] io_wrAddr,
    input  io_wrEna,
    input [31:0] io_wrData
);

  wire[31:0] T0;
  reg [31:0] mem [127:0];
  wire[31:0] T1;
  wire T2;
  reg [6:0] rdAddrReg;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    for (initvar = 0; initvar < 128; initvar = initvar+1)
      mem[initvar] = {1{$random}};
    rdAddrReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_rdData = T0;
  assign T0 = mem[rdAddrReg];
  assign T2 = io_wrEna == 1'h1;

  always @(posedge clk) begin
    if (T2)
      mem[io_wrAddr] <= io_wrData;
    rdAddrReg <= io_rdAddr;
  end
endmodule

module Fetch(input clk, input reset,
    input  io_ena,
    output[31:0] io_fedec_instr_a,
    output[31:0] io_fedec_instr_b,
    output[29:0] io_fedec_pc,
    output[29:0] io_fedec_base,
    output[31:0] io_fedec_reloc,
    output[29:0] io_fedec_relPc,
    output[29:0] io_feex_pc,
    input  io_exfe_doBranch,
    input [29:0] io_exfe_branchPc,
    input  io_memfe_doCallRet,
    input [29:0] io_memfe_callRetPc,
    input [29:0] io_memfe_callRetBase,
    input  io_memfe_store,
    input [31:0] io_memfe_addr,
    input [31:0] io_memfe_data,
    output[31:0] io_feicache_addrEven,
    output[31:0] io_feicache_addrOdd,
    input [31:0] io_icachefe_instrEven,
    input [31:0] io_icachefe_instrOdd,
    input [31:0] io_icachefe_base,
    input [9:0] io_icachefe_relBase,
    input [10:0] io_icachefe_relPc,
    input [31:0] io_icachefe_reloc,
    input [1:0] io_icachefe_memSel
);

  wire T0;
  wire T1;
  wire T2;
  wire T3;
  wire T4;
  wire[15:0] T5;
  wire[6:0] T6;
  wire[6:0] T7;
  wire[29:0] addrOdd;
  wire[29:0] T8;
  reg [29:0] addrOddReg;
  wire[29:0] T69;
  wire[29:0] T9;
  wire[29:0] T10;
  wire[28:0] T11;
  wire[29:0] pc_next;
  wire[29:0] T12;
  wire[29:0] pc_cont;
  wire[29:0] T13;
  reg [29:0] pcReg;
  wire[29:0] T70;
  wire[29:0] T14;
  wire[29:0] T15;
  wire b_valid;
  wire T16;
  wire[31:0] instr_a;
  wire[31:0] T17;
  wire[31:0] instr_a_rom;
  reg [31:0] data_odd;
  reg [31:0] T18;
  wire[7:0] T20;
  reg [31:0] data_even;
  reg [31:0] T21;
  wire[7:0] T23;
  wire[29:0] addrEven;
  wire[29:0] T24;
  reg [29:0] addrEvenReg;
  wire[29:0] T71;
  wire[29:0] T25;
  wire[29:0] T26;
  wire[28:0] T27;
  wire[29:0] pc_inc;
  wire[29:0] pc_next2;
  wire[29:0] T28;
  wire[29:0] pc_cont2;
  wire[29:0] T29;
  wire[29:0] T30;
  wire[29:0] T31;
  wire[29:0] T72;
  wire[10:0] T32;
  wire[10:0] T33;
  wire T34;
  wire T35;
  wire T36;
  wire[31:0] instr_a_cache;
  wire T37;
  wire T38;
  reg  selCache;
  wire T73;
  wire T39;
  wire T40;
  wire[31:0] instr_a_ispm;
  wire[31:0] T41;
  wire T42;
  wire T43;
  reg  selSpm;
  wire T74;
  wire T44;
  wire T45;
  wire[29:0] T75;
  wire[10:0] T46;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire[6:0] T52;
  wire[6:0] T53;
  wire[31:0] T76;
  wire[31:0] T77;
  wire[29:0] T54;
  wire[29:0] T55;
  wire[29:0] relPc;
  wire[29:0] T78;
  reg [9:0] relBaseReg;
  wire[9:0] T79;
  wire[9:0] T56;
  wire T57;
  wire[29:0] T58;
  reg [31:0] relocReg;
  wire[31:0] T80;
  wire[31:0] T59;
  wire[29:0] T81;
  reg [31:0] baseReg;
  wire[31:0] T82;
  wire[31:0] T60;
  wire[31:0] instr_b;
  wire[31:0] T61;
  wire[31:0] instr_b_rom;
  wire T62;
  wire T63;
  wire[31:0] instr_b_cache;
  wire T64;
  wire T65;
  wire[31:0] instr_b_ispm;
  wire[31:0] T66;
  wire T67;
  wire T68;
  wire[31:0] MemBlock_io_rdData;
  wire[31:0] MemBlock_1_io_rdData;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    addrOddReg = {1{$random}};
    pcReg = {1{$random}};
    data_odd = {1{$random}};
    data_even = {1{$random}};
    addrEvenReg = {1{$random}};
    selCache = {1{$random}};
    selSpm = {1{$random}};
    relBaseReg = {1{$random}};
    relocReg = {1{$random}};
    baseReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = T3 & T1;
  assign T1 = T2 == 1'h1;
  assign T2 = io_memfe_addr[2'h2:2'h2];
  assign T3 = io_memfe_store & T4;
  assign T4 = T5 == 16'h1;
  assign T5 = io_memfe_addr[5'h1f:5'h10];
  assign T6 = io_memfe_addr[4'h9:2'h3];
  assign T7 = addrOdd[3'h7:1'h1];
  assign addrOdd = T8;
  assign T8 = T47 ? T9 : addrOddReg;
  assign T69 = reset ? 30'h1 : addrOdd;
  assign T9 = T10;
  assign T10 = {T11, 1'h1};
  assign T11 = pc_next[5'h1d:1'h1];
  assign pc_next = io_memfe_doCallRet ? T75 : T12;
  assign T12 = io_exfe_doBranch ? io_exfe_branchPc : pc_cont;
  assign pc_cont = b_valid ? T15 : T13;
  assign T13 = pcReg + 30'h1;
  assign T70 = reset ? 30'h1 : T14;
  assign T14 = T47 ? pc_next : pcReg;
  assign T15 = pcReg + 30'h2;
  assign b_valid = T16 == 1'h1;
  assign T16 = instr_a[5'h1f:5'h1f];
  assign instr_a = selSpm ? instr_a_ispm : T17;
  assign T17 = selCache ? instr_a_cache : instr_a_rom;
  assign instr_a_rom = T35 ? data_even : data_odd;
  always @(*) case (T20)
    0: T18 = 32'h87c20000;
    1: T18 = 32'h87c40000;
    2: T18 = 32'h3e1000;
    3: T18 = 32'h2402026;
    4: T18 = 32'hf0010000;
    5: T18 = 32'h400000;
    6: T18 = 32'hcfc40000;
    7: T18 = 32'hcfc20000;
    8: T18 = 32'h4ac22085;
    9: T18 = 32'h400000;
    10: T18 = 32'h1a8;
    11: T18 = 32'h2520038;
    12: T18 = 32'h2c5fd08;
    13: T18 = 32'h2c5f481;
    14: T18 = 32'h2c5fb04;
    15: T18 = 32'h2c5fc06;
    16: T18 = 32'h2520030;
    17: T18 = 32'h3f000;
    18: T18 = 32'h20000;
    19: T18 = 32'h4000081;
    20: T18 = 32'hf0000000;
    21: T18 = 32'h400000;
    22: T18 = 32'h40000;
    23: T18 = 32'h87c6200d;
    24: T18 = 32'h2883180;
    25: T18 = 32'h2c23200;
    26: T18 = 32'hf0000000;
    27: T18 = 32'h42001;
    28: T18 = 32'h20221b4;
    29: T18 = 32'h400ff;
    30: T18 = 32'hc80001b;
    31: T18 = 32'hf0010000;
    32: T18 = 32'h460001;
    33: T18 = 32'hcfc60000;
    34: T18 = 32'hcfc40000;
    35: T18 = 32'h4ac23105;
    36: T18 = 32'h400000;
    37: T18 = 32'h87c40000;
    38: T18 = 32'h2842085;
    39: T18 = 32'h2022062;
    40: T18 = 32'hf0010000;
    41: T18 = 32'h80000000;
    42: T18 = 32'h1c410ff;
    43: T18 = 32'h400000;
    44: T18 = 32'h20000;
    45: T18 = 32'h400000;
    46: T18 = 32'h87c20000;
    47: T18 = 32'h2821080;
    48: T18 = 32'h2021036;
    49: T18 = 32'h87c20000;
    50: T18 = 32'h2c21001;
    51: T18 = 32'hf0080000;
    52: T18 = 32'h400000;
    53: T18 = 32'h4cbffffb;
    54: T18 = 32'h87c60000;
    55: T18 = 32'h2c23081;
    56: T18 = 32'hf0080000;
    57: T18 = 32'h400000;
    58: T18 = 32'h4cbffffb;
    59: T18 = 32'hf0080000;
    60: T18 = 32'h87c40000;
    61: T18 = 32'h20001;
    62: T18 = 32'h2c22085;
    63: T18 = 32'h2c22085;
    64: T18 = 32'h7ff040;
    65: T18 = 32'h2c5f487;
    66: T18 = 32'h20004;
    67: T18 = 32'h2c5fe0f;
    68: T18 = 32'h2c5f486;
    69: T18 = 32'h2c5f485;
    70: T18 = 32'h2c5fb09;
    71: T18 = 32'h2c5fc0b;
    72: T18 = 32'h2c5fd0d;
    73: T18 = 32'h20000;
    74: T18 = 32'h20008;
    75: T18 = 32'h2d41100;
    76: T18 = 32'h20004;
    77: T18 = 32'h400000;
    78: T18 = 32'h2c42080;
    79: T18 = 32'h2021134;
    80: T18 = 32'h87c40000;
    81: T18 = 32'h2c42080;
    82: T18 = 32'h80000;
    83: T18 = 32'h2c5f003;
    84: T18 = 32'h340000;
    85: T18 = 32'h2c5f002;
    86: T18 = 32'h2c5f001;
    87: T18 = 32'h2040c;
    88: T18 = 32'h420001;
    89: T18 = 32'h40000;
    90: T18 = 32'h381000;
    91: T18 = 32'h2e3000;
    92: T18 = 32'h87c20000;
    93: T18 = 32'h2c21d80;
    94: T18 = 32'h440001;
    95: T18 = 32'hcfffff6;
    96: T18 = 32'h60000;
    97: T18 = 32'h2022b34;
    98: T18 = 32'hc57008;
    99: T18 = 32'h2061106;
    100: T18 = 32'h5c004;
    101: T18 = 32'hc800025;
    102: T18 = 32'h60008;
    103: T18 = 32'h2024036;
    104: T18 = 32'hedb88320;
    105: T18 = 32'h9044001;
    106: T18 = 32'h463001;
    107: T18 = 32'hcbffff7;
    108: T18 = 32'h206300b;
    109: T18 = 32'h28bf103;
    110: T18 = 32'h20a1286;
    111: T18 = 32'h2021db4;
    112: T18 = 32'h289f102;
    113: T18 = 32'h2023261;
    114: T18 = 32'h20004;
    115: T18 = 32'hc800018;
    116: T18 = 32'hf0008010;
    117: T18 = 32'h25000;
    118: T18 = 32'h4c00012;
    119: T18 = 32'h2c5f284;
    120: T18 = 32'h59000;
    121: T18 = 32'h2035c00;
    122: T18 = 32'hfffffffc;
    123: T18 = 32'h4c0000c;
    124: T18 = 32'h400000;
    125: T18 = 32'h4800004;
    126: T18 = 32'h4800002;
    127: T18 = 32'h283f101;
    128: T18 = 32'h37b001;
    129: T18 = 32'h2023230;
    130: T18 = 32'h20220c7;
    131: T18 = 32'h64003;
    132: T18 = 32'hfffffffc;
    133: T18 = 32'hcc0000a;
    134: T18 = 32'h2c5f202;
    135: T18 = 32'h63004;
    136: T18 = 32'hcfffffd;
    137: T18 = 32'hfffffffc;
    138: T18 = 32'h360002;
    139: T18 = 32'h287f100;
    140: T18 = 32'h63001;
    141: T18 = 32'h2c5f202;
    142: T18 = 32'h1c75003;
    143: T18 = 32'h80a0000;
    144: T18 = 32'h2c5f081;
    145: T18 = 32'h3c003;
    146: T18 = 32'hcffff90;
    147: T18 = 32'h3c000;
    148: T18 = 32'hf0080000;
    149: T18 = 32'h400000;
    150: T18 = 32'h4cbffffb;
    151: T18 = 32'h1c410ff;
    152: T18 = 32'hf0080000;
    153: T18 = 32'hcc0000c;
    154: T18 = 32'h20000;
    155: T18 = 32'h285f104;
    156: T18 = 32'h2021131;
    157: T18 = 32'h20000;
    158: T18 = 32'h283f101;
    159: T18 = 32'h2adf109;
    160: T18 = 32'h2b1f10b;
    161: T18 = 32'h2b5f10d;
    162: T18 = 32'h2b9f10f;
    163: T18 = 32'h2abf108;
    164: T18 = 32'h293f106;
    165: T18 = 32'h2409027;
    166: T18 = 32'h6400000;
    167: T18 = 32'h2409020;
    168: T18 = 32'h1a4;
    169: T18 = 32'h20004;
    170: T18 = 32'h20408;
    171: T18 = 32'h2842100;
    172: T18 = 32'h20220b1;
    173: T18 = 32'h87c40000;
    174: T18 = 32'h2822100;
    175: T18 = 32'h1021001;
    176: T18 = 32'hcc00012;
    177: T18 = 32'h2c42080;
    178: T18 = 32'hf0080000;
    179: T18 = 32'h400000;
    180: T18 = 32'h2021060;
    181: T18 = 32'h87c20000;
    182: T18 = 32'h2821081;
    183: T18 = 32'h2040c;
    184: T18 = 32'hff00;
    185: T18 = 32'h1c41001;
    186: T18 = 32'hf0080000;
    187: T18 = 32'h400000;
    188: T18 = 32'h2021060;
    189: T18 = 32'h2022060;
    190: T18 = 32'hf0080000;
    191: T18 = 32'h2821081;
    192: T18 = 32'h87c40000;
    193: T18 = 32'h2862100;
    194: T18 = 32'h87c83000;
    195: T18 = 32'h2d44080;
    196: T18 = 32'h4c00026;
    197: T18 = 32'h2c42080;
    198: T18 = 32'hf0080000;
    199: T18 = 32'h400000;
    200: T18 = 32'h2022060;
    201: T18 = 32'h87c40000;
    202: T18 = 32'h2862081;
    203: T18 = 32'hc43002;
    204: T18 = 32'h2022086;
    205: T18 = 32'h20004;
    206: T18 = 32'h1c6303f;
    207: T18 = 32'h63002;
    208: T18 = 32'h87c84000;
    209: T18 = 32'h2884900;
    210: T18 = 32'h20008;
    211: T18 = 32'h20211b2;
    212: T18 = 32'hcfffff7;
    213: T18 = 32'h1c423ff;
    214: T18 = 32'h20004;
    215: T18 = 32'h87c40000;
    216: T18 = 32'h2862100;
    217: T18 = 32'h87c23000;
    218: T18 = 32'h63001;
    219: T18 = 32'h6400000;
    220: T18 = 32'h2c42180;
    221: T18 = 32'h0;
    222: T18 = 32'h0;
    223: T18 = 32'h0;
    224: T18 = 32'h0;
    225: T18 = 32'h0;
    226: T18 = 32'h0;
    227: T18 = 32'h0;
    228: T18 = 32'h0;
    229: T18 = 32'h0;
    230: T18 = 32'h0;
    231: T18 = 32'h0;
    232: T18 = 32'h0;
    233: T18 = 32'h0;
    234: T18 = 32'h0;
    235: T18 = 32'h0;
    236: T18 = 32'h0;
    237: T18 = 32'h0;
    238: T18 = 32'h0;
    239: T18 = 32'h0;
    240: T18 = 32'h0;
    241: T18 = 32'h0;
    242: T18 = 32'h0;
    243: T18 = 32'h0;
    244: T18 = 32'h0;
    245: T18 = 32'h0;
    246: T18 = 32'h0;
    247: T18 = 32'h0;
    248: T18 = 32'h0;
    249: T18 = 32'h0;
    250: T18 = 32'h0;
    251: T18 = 32'h0;
    252: T18 = 32'h0;
    253: T18 = 32'h0;
    254: T18 = 32'h0;
    255: T18 = 32'h0;
    default: begin
      T18 = 32'bx;
`ifndef SYNTHESIS
// synthesis translate_off
      T18 = {1{$random}};
// synthesis translate_on
`endif
    end
  endcase
  assign T20 = addrOdd[4'h8:1'h1];
  always @(*) case (T23)
    0: T21 = 32'h50;
    1: T21 = 32'h20700;
    2: T21 = 32'h20800;
    3: T21 = 32'h2402025;
    4: T21 = 32'h87c20000;
    5: T21 = 32'h2821085;
    6: T21 = 32'h2021062;
    7: T21 = 32'hf0010000;
    8: T21 = 32'h80000000;
    9: T21 = 32'h400000;
    10: T21 = 32'h4000016;
    11: T21 = 32'h7ff024;
    12: T21 = 32'h2c5f482;
    13: T21 = 32'h2520037;
    14: T21 = 32'h2c5fa83;
    15: T21 = 32'h2c5fb85;
    16: T21 = 32'h2c5fc87;
    17: T21 = 32'h2c5f480;
    18: T21 = 32'h87c40000;
    19: T21 = 32'h2c42080;
    20: T21 = 32'h87c40000;
    21: T21 = 32'h284208c;
    22: T21 = 32'h2022264;
    23: T21 = 32'hc80000d;
    24: T21 = 32'h10000;
    25: T21 = 32'h400000;
    26: T21 = 32'h87c60000;
    27: T21 = 32'h286308c;
    28: T21 = 32'h1063002;
    29: T21 = 32'hcbffff5;
    30: T21 = 32'h2021060;
    31: T21 = 32'h87c40000;
    32: T21 = 32'h2842085;
    33: T21 = 32'h2023132;
    34: T21 = 32'hf0010000;
    35: T21 = 32'h80000000;
    36: T21 = 32'h400000;
    37: T21 = 32'h6001004;
    38: T21 = 32'hf0010000;
    39: T21 = 32'h400000;
    40: T21 = 32'hcfc60000;
    41: T21 = 32'hcfc40000;
    42: T21 = 32'h4ac23105;
    43: T21 = 32'h400000;
    44: T21 = 32'h87c20000;
    45: T21 = 32'h2821100;
    46: T21 = 32'h3e1000;
    47: T21 = 32'hf0080000;
    48: T21 = 32'h400000;
    49: T21 = 32'h4cbffffb;
    50: T21 = 32'hf0080000;
    51: T21 = 32'h87c20000;
    52: T21 = 32'h2821080;
    53: T21 = 32'h2021036;
    54: T21 = 32'h20078;
    55: T21 = 32'hf0080000;
    56: T21 = 32'h87c20000;
    57: T21 = 32'h2821080;
    58: T21 = 32'h2021036;
    59: T21 = 32'h87c20000;
    60: T21 = 32'h2c21101;
    61: T21 = 32'hf0010000;
    62: T21 = 32'h4400001;
    63: T21 = 32'h20002;
    64: T21 = 32'h340;
    65: T21 = 32'h2520038;
    66: T21 = 32'h87c20000;
    67: T21 = 32'h2c41000;
    68: T21 = 32'h2520037;
    69: T21 = 32'h2520030;
    70: T21 = 32'h2c5fa88;
    71: T21 = 32'h2c5fb8a;
    72: T21 = 32'h2c5fc8c;
    73: T21 = 32'h2c5fd8e;
    74: T21 = 32'h87c21000;
    75: T21 = 32'h40020;
    76: T21 = 32'h87c40000;
    77: T21 = 32'h2822100;
    78: T21 = 32'h21001;
    79: T21 = 32'h403be;
    80: T21 = 32'hcbffff4;
    81: T21 = 32'h20408;
    82: T21 = 32'h460001;
    83: T21 = 32'h360000;
    84: T21 = 32'h2a0000;
    85: T21 = 32'h300000;
    86: T21 = 32'h2c5f000;
    87: T21 = 32'h87c20000;
    88: T21 = 32'h2c41000;
    89: T21 = 32'h2c5f084;
    90: T21 = 32'h20000;
    91: T21 = 32'h322000;
    92: T21 = 32'h4400152;
    93: T21 = 32'hf0090000;
    94: T21 = 32'h2c4000;
    95: T21 = 32'h203c060;
    96: T21 = 32'h80000;
    97: T21 = 32'h40003;
    98: T21 = 32'hc800005;
    99: T21 = 32'h4c0005d;
    100: T21 = 32'h59000;
    101: T21 = 32'h2022b35;
    102: T21 = 32'h2081c82;
    103: T21 = 32'h1044001;
    104: T21 = 32'h87c42002;
    105: T21 = 32'h202104a;
    106: T21 = 32'h82000;
    107: T21 = 32'h2023031;
    108: T21 = 32'hc75003;
    109: T21 = 32'h1c63018;
    110: T21 = 32'h2021183;
    111: T21 = 32'h20004;
    112: T21 = 32'hcc00013;
    113: T21 = 32'h75001;
    114: T21 = 32'hc800013;
    115: T21 = 32'h2021db4;
    116: T21 = 32'h87c3b00d;
    117: T21 = 32'h2861100;
    118: T21 = 32'h6003005;
    119: T21 = 32'h400000;
    120: T21 = 32'h4c00033;
    121: T21 = 32'h77000;
    122: T21 = 32'h87c21007;
    123: T21 = 32'h2c61280;
    124: T21 = 32'h283f101;
    125: T21 = 32'h85000;
    126: T21 = 32'h305000;
    127: T21 = 32'h345000;
    128: T21 = 32'h400000;
    129: T21 = 32'h60000;
    130: T21 = 32'h205b2e0;
    131: T21 = 32'h4c800015;
    132: T21 = 32'h87c63007;
    133: T21 = 32'h203a1b5;
    134: T21 = 32'h400000;
    135: T21 = 32'h2098180;
    136: T21 = 32'h2023d34;
    137: T21 = 32'h87c84007;
    138: T21 = 32'h2c64000;
    139: T21 = 32'h2a0000;
    140: T21 = 32'h4c00005;
    141: T21 = 32'h2c5f180;
    142: T21 = 32'h2a3000;
    143: T21 = 32'h2023060;
    144: T21 = 32'h2c5f283;
    145: T21 = 32'h77000;
    146: T21 = 32'h20360b1;
    147: T21 = 32'h96001;
    148: T21 = 32'h87c20000;
    149: T21 = 32'h2821080;
    150: T21 = 32'h2021036;
    151: T21 = 32'h202200b;
    152: T21 = 32'h87ca0000;
    153: T21 = 32'h20230b1;
    154: T21 = 32'h2c25101;
    155: T21 = 32'h283f100;
    156: T21 = 32'h400000;
    157: T21 = 32'hcffff7b;
    158: T21 = 32'h43000;
    159: T21 = 32'h400000;
    160: T21 = 32'h2aff10a;
    161: T21 = 32'h2b3f10c;
    162: T21 = 32'h2b7f10e;
    163: T21 = 32'h293f107;
    164: T21 = 32'h2409028;
    165: T21 = 32'h400000;
    166: T21 = 32'h293f105;
    167: T21 = 32'h400000;
    168: T21 = 32'h3ff040;
    169: T21 = 32'h87c20000;
    170: T21 = 32'h87c40000;
    171: T21 = 32'h2821100;
    172: T21 = 32'h24c0030;
    173: T21 = 32'hc800055;
    174: T21 = 32'h2040c;
    175: T21 = 32'h400000;
    176: T21 = 32'h2021466;
    177: T21 = 32'h400000;
    178: T21 = 32'h87c20000;
    179: T21 = 32'h2821080;
    180: T21 = 32'h1c21002;
    181: T21 = 32'hcbffffa;
    182: T21 = 32'hf0080000;
    183: T21 = 32'h87c40000;
    184: T21 = 32'h87c21006;
    185: T21 = 32'h2c42080;
    186: T21 = 32'h87c20000;
    187: T21 = 32'h2821080;
    188: T21 = 32'h1c21002;
    189: T21 = 32'hcbffffa;
    190: T21 = 32'h87c20000;
    191: T21 = 32'hcc0000e;
    192: T21 = 32'h400000;
    193: T21 = 32'h20004;
    194: T21 = 32'h400000;
    195: T21 = 32'h20008;
    196: T21 = 32'h23001;
    197: T21 = 32'h1c213ff;
    198: T21 = 32'h87c40000;
    199: T21 = 32'h2842080;
    200: T21 = 32'h1c42002;
    201: T21 = 32'hcbffffa;
    202: T21 = 32'hf0080000;
    203: T21 = 32'h400000;
    204: T21 = 32'h1c42300;
    205: T21 = 32'h87c40000;
    206: T21 = 32'h2842100;
    207: T21 = 32'h2063080;
    208: T21 = 32'h1c813ff;
    209: T21 = 32'h20008;
    210: T21 = 32'h87ca2000;
    211: T21 = 32'h2d45200;
    212: T21 = 32'h21001;
    213: T21 = 32'h42001;
    214: T21 = 32'h87c20000;
    215: T21 = 32'h2c41100;
    216: T21 = 32'h20408;
    217: T21 = 32'h400000;
    218: T21 = 32'h20008;
    219: T21 = 32'h1c633ff;
    220: T21 = 32'h2821900;
    221: T21 = 32'h2406020;
    222: T21 = 32'h0;
    223: T21 = 32'h0;
    224: T21 = 32'h0;
    225: T21 = 32'h0;
    226: T21 = 32'h0;
    227: T21 = 32'h0;
    228: T21 = 32'h0;
    229: T21 = 32'h0;
    230: T21 = 32'h0;
    231: T21 = 32'h0;
    232: T21 = 32'h0;
    233: T21 = 32'h0;
    234: T21 = 32'h0;
    235: T21 = 32'h0;
    236: T21 = 32'h0;
    237: T21 = 32'h0;
    238: T21 = 32'h0;
    239: T21 = 32'h0;
    240: T21 = 32'h0;
    241: T21 = 32'h0;
    242: T21 = 32'h0;
    243: T21 = 32'h0;
    244: T21 = 32'h0;
    245: T21 = 32'h0;
    246: T21 = 32'h0;
    247: T21 = 32'h0;
    248: T21 = 32'h0;
    249: T21 = 32'h0;
    250: T21 = 32'h0;
    251: T21 = 32'h0;
    252: T21 = 32'h0;
    253: T21 = 32'h0;
    254: T21 = 32'h0;
    255: T21 = 32'h0;
    default: begin
      T21 = 32'bx;
`ifndef SYNTHESIS
// synthesis translate_off
      T21 = {1{$random}};
// synthesis translate_on
`endif
    end
  endcase
  assign T23 = addrEven[4'h8:1'h1];
  assign addrEven = T24;
  assign T24 = T47 ? T25 : addrEvenReg;
  assign T71 = reset ? 30'h2 : addrEven;
  assign T25 = T26;
  assign T26 = {T27, 1'h0};
  assign T27 = pc_inc[5'h1d:1'h1];
  assign pc_inc = T34 ? pc_next2 : pc_next;
  assign pc_next2 = io_memfe_doCallRet ? T72 : T28;
  assign T28 = io_exfe_doBranch ? T31 : pc_cont2;
  assign pc_cont2 = b_valid ? T30 : T29;
  assign T29 = pcReg + 30'h3;
  assign T30 = pcReg + 30'h4;
  assign T31 = io_exfe_branchPc + 30'h2;
  assign T72 = {19'h0, T32};
  assign T32 = T33 + 11'h2;
  assign T33 = io_icachefe_relPc;
  assign T34 = pc_next[1'h0:1'h0];
  assign T35 = T36 == 1'h0;
  assign T36 = pcReg[1'h0:1'h0];
  assign instr_a_cache = T37 ? io_icachefe_instrEven : io_icachefe_instrOdd;
  assign T37 = T38 == 1'h0;
  assign T38 = pcReg[1'h0:1'h0];
  assign T73 = reset ? 1'h0 : T39;
  assign T39 = io_ena ? T40 : selCache;
  assign T40 = io_icachefe_memSel[1'h0:1'h0];
  assign instr_a_ispm = T41;
  assign T41 = T42 ? MemBlock_io_rdData : MemBlock_1_io_rdData;
  assign T42 = T43 == 1'h0;
  assign T43 = pcReg[1'h0:1'h0];
  assign T74 = reset ? 1'h0 : T44;
  assign T44 = io_ena ? T45 : selSpm;
  assign T45 = io_icachefe_memSel[1'h1:1'h1];
  assign T75 = {19'h0, T46};
  assign T46 = io_icachefe_relPc;
  assign T47 = io_ena & T48;
  assign T48 = reset ^ 1'h1;
  assign T49 = T3 & T50;
  assign T50 = T51 == 1'h0;
  assign T51 = io_memfe_addr[2'h2:2'h2];
  assign T52 = io_memfe_addr[4'h9:2'h3];
  assign T53 = addrEven[3'h7:1'h1];
  assign io_feicache_addrOdd = T76;
  assign T76 = {2'h0, addrOdd};
  assign io_feicache_addrEven = T77;
  assign T77 = {2'h0, addrEven};
  assign io_feex_pc = T54;
  assign T54 = b_valid ? T58 : T55;
  assign T55 = relPc + 30'h1;
  assign relPc = pcReg - T78;
  assign T78 = {20'h0, relBaseReg};
  assign T79 = reset ? 10'h1 : T56;
  assign T56 = T57 ? io_icachefe_relBase : relBaseReg;
  assign T57 = io_ena & io_memfe_doCallRet;
  assign T58 = relPc + 30'h2;
  assign io_fedec_relPc = relPc;
  assign io_fedec_reloc = relocReg;
  assign T80 = reset ? 32'h0 : T59;
  assign T59 = T57 ? io_icachefe_reloc : relocReg;
  assign io_fedec_base = T81;
  assign T81 = baseReg[5'h1d:1'h0];
  assign T82 = reset ? 32'h0 : T60;
  assign T60 = io_ena ? io_icachefe_base : baseReg;
  assign io_fedec_pc = pcReg;
  assign io_fedec_instr_b = instr_b;
  assign instr_b = selSpm ? instr_b_ispm : T61;
  assign T61 = selCache ? instr_b_cache : instr_b_rom;
  assign instr_b_rom = T62 ? data_odd : data_even;
  assign T62 = T63 == 1'h0;
  assign T63 = pcReg[1'h0:1'h0];
  assign instr_b_cache = T64 ? io_icachefe_instrOdd : io_icachefe_instrEven;
  assign T64 = T65 == 1'h0;
  assign T65 = pcReg[1'h0:1'h0];
  assign instr_b_ispm = T66;
  assign T66 = T67 ? MemBlock_1_io_rdData : MemBlock_io_rdData;
  assign T67 = T68 == 1'h0;
  assign T68 = pcReg[1'h0:1'h0];
  assign io_fedec_instr_a = instr_a;
  MemBlock_0 MemBlock(.clk(clk),
       .io_rdAddr( T53 ),
       .io_rdData( MemBlock_io_rdData ),
       .io_wrAddr( T52 ),
       .io_wrEna( T49 ),
       .io_wrData( io_memfe_data )
  );
  MemBlock_0 MemBlock_1(.clk(clk),
       .io_rdAddr( T7 ),
       .io_rdData( MemBlock_1_io_rdData ),
       .io_wrAddr( T6 ),
       .io_wrEna( T0 ),
       .io_wrData( io_memfe_data )
  );

  always @(posedge clk) begin
    if(reset) begin
      addrOddReg <= 30'h1;
    end else begin
      addrOddReg <= addrOdd;
    end
    if(reset) begin
      pcReg <= 30'h1;
    end else if(T47) begin
      pcReg <= pc_next;
    end
    data_odd <= T18;
    data_even <= T21;
    if(reset) begin
      addrEvenReg <= 30'h2;
    end else begin
      addrEvenReg <= addrEven;
    end
    if(reset) begin
      selCache <= 1'h0;
    end else if(io_ena) begin
      selCache <= T40;
    end
    if(reset) begin
      selSpm <= 1'h0;
    end else if(io_ena) begin
      selSpm <= T45;
    end
    if(reset) begin
      relBaseReg <= 10'h1;
    end else if(T57) begin
      relBaseReg <= io_icachefe_relBase;
    end
    if(reset) begin
      relocReg <= 32'h0;
    end else if(T57) begin
      relocReg <= io_icachefe_reloc;
    end
    if(reset) begin
      baseReg <= 32'h0;
    end else if(io_ena) begin
      baseReg <= io_icachefe_base;
    end
  end
endmodule

module RegisterFile(input clk,
    input  io_ena,
    input [4:0] io_rfRead_rsAddr_1,
    input [4:0] io_rfRead_rsAddr_0,
    output[31:0] io_rfRead_rsData_1,
    output[31:0] io_rfRead_rsData_0,
    input [4:0] io_rfWrite_0_addr,
    input [31:0] io_rfWrite_0_data,
    input  io_rfWrite_0_valid
);

  wire[31:0] T0;
  wire[31:0] T1;
  wire[31:0] T2;
  reg [31:0] rf [31:0];
  wire[31:0] T3;
  wire[4:0] T4;
  reg [4:0] addrReg_0;
  wire[4:0] T5;
  reg [31:0] wrReg_0_data;
  wire[31:0] T6;
  reg  fwReg_0_0;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire[31:0] T11;
  wire[31:0] T12;
  wire[31:0] T13;
  reg [4:0] addrReg_1;
  wire[4:0] T14;
  reg  fwReg_1_0;
  wire T15;
  wire T16;
  wire T17;
  wire T18;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    for (initvar = 0; initvar < 32; initvar = initvar+1)
      rf[initvar] = {1{$random}};
    addrReg_0 = {1{$random}};
    wrReg_0_data = {1{$random}};
    fwReg_0_0 = {1{$random}};
    addrReg_1 = {1{$random}};
    fwReg_1_0 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_rfRead_rsData_0 = T0;
  assign T0 = T10 ? 32'h0 : T1;
  assign T1 = fwReg_0_0 ? wrReg_0_data : T2;
  assign T2 = rf[addrReg_0];
  assign T4 = io_rfWrite_0_addr;
  assign T5 = io_ena ? io_rfRead_rsAddr_0 : addrReg_0;
  assign T6 = io_ena ? io_rfWrite_0_data : wrReg_0_data;
  assign T7 = io_ena ? T8 : fwReg_0_0;
  assign T8 = T9 & io_rfWrite_0_valid;
  assign T9 = io_rfRead_rsAddr_0 == io_rfWrite_0_addr;
  assign T10 = addrReg_0 == 5'h0;
  assign io_rfRead_rsData_1 = T11;
  assign T11 = T18 ? 32'h0 : T12;
  assign T12 = fwReg_1_0 ? wrReg_0_data : T13;
  assign T13 = rf[addrReg_1];
  assign T14 = io_ena ? io_rfRead_rsAddr_1 : addrReg_1;
  assign T15 = io_ena ? T16 : fwReg_1_0;
  assign T16 = T17 & io_rfWrite_0_valid;
  assign T17 = io_rfRead_rsAddr_1 == io_rfWrite_0_addr;
  assign T18 = addrReg_1 == 5'h0;

  always @(posedge clk) begin
    if (io_rfWrite_0_valid)
      rf[T4] <= io_rfWrite_0_data;
    if(io_ena) begin
      addrReg_0 <= io_rfRead_rsAddr_0;
    end
    if(io_ena) begin
      wrReg_0_data <= io_rfWrite_0_data;
    end
    if(io_ena) begin
      fwReg_0_0 <= T8;
    end
    if(io_ena) begin
      addrReg_1 <= io_rfRead_rsAddr_1;
    end
    if(io_ena) begin
      fwReg_1_0 <= T16;
    end
  end
endmodule

module Decode(input clk, input reset,
    input  io_ena,
    input  io_flush,
    input [31:0] io_fedec_instr_a,
    input [31:0] io_fedec_instr_b,
    input [29:0] io_fedec_pc,
    input [29:0] io_fedec_base,
    input [31:0] io_fedec_reloc,
    input [29:0] io_fedec_relPc,
    output[29:0] io_decex_pc,
    output[29:0] io_decex_base,
    output[29:0] io_decex_relPc,
    output[3:0] io_decex_pred_0,
    output[3:0] io_decex_aluOp_0_func,
    output io_decex_aluOp_0_isMul,
    output io_decex_aluOp_0_isCmp,
    output io_decex_aluOp_0_isPred,
    output io_decex_aluOp_0_isBCpy,
    output io_decex_aluOp_0_isMTS,
    output io_decex_aluOp_0_isMFS,
    output[1:0] io_decex_predOp_0_func,
    output[2:0] io_decex_predOp_0_dest,
    output[3:0] io_decex_predOp_0_s1Addr,
    output[3:0] io_decex_predOp_0_s2Addr,
    output io_decex_jmpOp_branch,
    output[29:0] io_decex_jmpOp_target,
    output[31:0] io_decex_jmpOp_reloc,
    output io_decex_memOp_load,
    output io_decex_memOp_store,
    output io_decex_memOp_hword,
    output io_decex_memOp_byte,
    output io_decex_memOp_zext,
    output[1:0] io_decex_memOp_typ,
    output[2:0] io_decex_stackOp,
    output[4:0] io_decex_rsAddr_1,
    output[4:0] io_decex_rsAddr_0,
    output[31:0] io_decex_rsData_1,
    output[31:0] io_decex_rsData_0,
    output[4:0] io_decex_rdAddr_0,
    output[31:0] io_decex_immVal_0,
    output io_decex_immOp_0,
    output io_decex_wrRd_0,
    output[31:0] io_decex_callAddr,
    output io_decex_call,
    output io_decex_ret,
    output io_decex_brcf,
    output io_decex_trap,
    output io_decex_xcall,
    output io_decex_xret,
    output[4:0] io_decex_xsrc,
    output io_decex_nonDelayed,
    output io_decex_illOp,
    input [4:0] io_rfWrite_0_addr,
    input [31:0] io_rfWrite_0_data,
    input  io_rfWrite_0_valid,
    input  io_exc_exc,
    input [29:0] io_exc_excBase,
    input [29:0] io_exc_excAddr,
    input  io_exc_intr,
    input [31:0] io_exc_addr,
    input [4:0] io_exc_src,
    input  io_exc_local
);

  wire[4:0] T0;
  wire[4:0] T1;
  wire T2;
  wire T3;
  wire T4;
  wire decoded_0;
  wire T5;
  wire T6;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  wire T26;
  wire T27;
  wire T28;
  wire T29;
  wire T30;
  wire T31;
  wire T32;
  wire[1:0] T33;
  wire[4:0] T34;
  reg [31:0] decReg_instr_a;
  wire[31:0] T35;
  wire[31:0] T36;
  wire[31:0] T37;
  wire T38;
  wire T39;
  wire T40;
  wire[2:0] T41;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire T52;
  wire T53;
  wire T54;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire T59;
  wire T60;
  wire T61;
  wire[2:0] T62;
  wire T63;
  wire[4:0] opcode;
  wire T64;
  wire T65;
  wire[3:0] stcfun;
  wire T66;
  wire T67;
  wire T68;
  wire T69;
  wire T70;
  wire T71;
  wire T72;
  wire T73;
  wire T74;
  wire T75;
  wire T76;
  wire T77;
  wire T78;
  wire T79;
  wire T80;
  wire T81;
  wire T82;
  wire T83;
  wire T84;
  wire T85;
  wire T86;
  wire T87;
  wire T88;
  wire[3:0] func;
  wire T89;
  wire T90;
  wire T91;
  wire T92;
  wire T93;
  wire T94;
  wire T95;
  wire T96;
  wire T97;
  wire T98;
  wire T99;
  wire T100;
  wire T101;
  wire dual;
  wire T102;
  wire[4:0] T103;
  wire T104;
  wire T105;
  wire T106;
  wire T107;
  reg [1:0] inDelaySlot;
  wire[1:0] T108;
  wire[1:0] T109;
  wire[1:0] T110;
  wire[1:0] T111;
  wire[1:0] T112;
  wire[1:0] T113;
  wire[1:0] T114;
  wire T115;
  wire[1:0] T116;
  wire T117;
  wire T118;
  wire T119;
  wire T120;
  wire T121;
  wire T122;
  wire T123;
  wire T124;
  wire T125;
  wire T126;
  wire T127;
  wire T128;
  wire T129;
  wire T130;
  wire[4:0] T131;
  wire[4:0] T132;
  wire[4:0] T133;
  wire[4:0] T134;
  wire T135;
  wire T136;
  wire T137;
  wire T138;
  wire T139;
  wire T140;
  wire T141;
  wire[31:0] T142;
  wire[31:0] T318;
  wire[24:0] T143;
  wire[24:0] T144;
  wire[24:0] T145;
  wire[23:0] T146;
  wire[21:0] T147;
  wire T148;
  wire T149;
  wire T150;
  wire T151;
  wire T152;
  wire T153;
  wire T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;
  wire T159;
  wire T160;
  wire T161;
  wire T162;
  wire T163;
  wire T164;
  wire T165;
  wire T166;
  wire T167;
  wire T168;
  wire[31:0] T169;
  wire[31:0] T170;
  wire[31:0] T319;
  wire[12:0] T171;
  wire[12:0] T172;
  wire[12:0] T173;
  wire[12:0] T174;
  wire[11:0] T175;
  wire[12:0] T320;
  wire[5:0] T176;
  wire[4:0] T177;
  wire[12:0] T321;
  wire[5:0] T178;
  wire[4:0] T179;
  wire[31:0] T180;
  wire[31:0] T181;
  wire[31:0] T182;
  reg [31:0] decReg_instr_b;
  wire[31:0] T183;
  wire[31:0] T184;
  wire[31:0] T185;
  wire[31:0] T322;
  wire[9:0] addrImm;
  wire[9:0] T187;
  wire[9:0] T323;
  wire[8:0] T188;
  wire[8:0] T324;
  wire[7:0] T189;
  wire[6:0] T190;
  wire[8:0] T191;
  wire[7:0] T192;
  wire[6:0] T193;
  wire T194;
  wire[1:0] shamt;
  wire[1:0] T195;
  wire[1:0] T196;
  wire[1:0] T197;
  wire[1:0] T198;
  wire[1:0] T199;
  wire T200;
  wire T201;
  wire[2:0] ldsize;
  wire T202;
  wire T203;
  wire T204;
  wire T205;
  wire T206;
  wire T207;
  wire[2:0] stsize;
  wire T208;
  wire T209;
  wire[9:0] T210;
  wire[8:0] T211;
  wire[6:0] T212;
  wire T213;
  wire isMem;
  wire T186;
  wire[31:0] T325;
  wire isStack;
  wire T214;
  wire T215;
  wire T216;
  wire[1:0] ldtype;
  wire T217;
  wire T218;
  wire[1:0] sttype;
  wire[31:0] T326;
  wire[20:0] stcImm;
  wire[20:0] T219;
  wire[19:0] T220;
  wire[17:0] T221;
  wire isSTC;
  wire T222;
  wire T223;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  wire longImm;
  wire T228;
  wire T229;
  wire[4:0] T230;
  wire[4:0] dest;
  wire[4:0] T231;
  wire[31:0] T232;
  wire[31:0] T233;
  wire[4:0] T234;
  wire[4:0] T235;
  wire[4:0] T236;
  wire[4:0] T237;
  wire[2:0] T238;
  wire[2:0] T239;
  wire[2:0] T240;
  wire[2:0] T241;
  wire[2:0] T242;
  wire[2:0] T243;
  wire[2:0] T244;
  wire[1:0] T245;
  wire[1:0] T246;
  wire[1:0] T247;
  wire[1:0] T248;
  wire[1:0] T249;
  wire T250;
  wire T251;
  wire T252;
  wire T253;
  wire T254;
  wire T255;
  wire T256;
  wire T257;
  wire T258;
  wire T259;
  wire T260;
  wire T261;
  wire T262;
  wire T263;
  wire T264;
  wire T265;
  wire T266;
  wire T267;
  wire T268;
  wire T269;
  wire T270;
  wire T271;
  wire[31:0] T272;
  reg [31:0] decReg_reloc;
  wire[31:0] T273;
  wire[29:0] T274;
  wire[29:0] T275;
  wire[29:0] T276;
  wire[21:0] T277;
  wire[7:0] T278;
  wire[7:0] T327;
  wire T279;
  reg [29:0] decReg_pc;
  wire[29:0] T280;
  wire T281;
  wire T282;
  wire[3:0] T283;
  wire[3:0] T284;
  wire[3:0] T285;
  wire[3:0] T286;
  wire[2:0] T287;
  wire[2:0] T288;
  wire[1:0] T289;
  wire[1:0] T290;
  wire T291;
  wire T292;
  wire T293;
  wire T294;
  wire T295;
  wire T296;
  wire T297;
  wire T298;
  wire T299;
  wire[3:0] T300;
  wire[3:0] T301;
  wire[3:0] T302;
  wire[3:0] T303;
  wire[3:0] T304;
  wire[2:0] T305;
  wire[3:0] T306;
  wire[3:0] T307;
  wire[3:0] T308;
  wire[29:0] T309;
  wire[29:0] T310;
  reg [29:0] decReg_relPc;
  wire[29:0] T311;
  wire[29:0] T312;
  wire[29:0] T313;
  wire[29:0] T314;
  reg [29:0] decReg_base;
  wire[29:0] T315;
  wire[29:0] T316;
  wire[29:0] T317;
  wire[31:0] rf_io_rfRead_rsData_1;
  wire[31:0] rf_io_rfRead_rsData_0;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    decReg_instr_a = {1{$random}};
    inDelaySlot = {1{$random}};
    decReg_instr_b = {1{$random}};
    decReg_reloc = {1{$random}};
    decReg_pc = {1{$random}};
    decReg_relPc = {1{$random}};
    decReg_base = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = io_fedec_instr_a[5'h10:4'hc];
  assign T1 = io_fedec_instr_a[4'hb:3'h7];
  assign io_decex_illOp = T2;
  assign T2 = T105 ? 1'h0 : T3;
  assign T3 = T4 ^ 1'h1;
  assign T4 = dual ? decoded_0 : decoded_0;
  assign decoded_0 = T5;
  assign T5 = T101 ? 1'h1 : T6;
  assign T6 = T100 ? 1'h1 : T7;
  assign T7 = T98 ? 1'h1 : T8;
  assign T8 = T96 ? 1'h1 : T9;
  assign T9 = T94 ? 1'h1 : T10;
  assign T10 = T92 ? 1'h1 : T11;
  assign T11 = T87 ? 1'h1 : T12;
  assign T12 = T84 ? 1'h1 : T13;
  assign T13 = T81 ? 1'h1 : T14;
  assign T14 = T78 ? 1'h1 : T15;
  assign T15 = T77 ? 1'h1 : T16;
  assign T16 = T75 ? 1'h1 : T17;
  assign T17 = T73 ? 1'h1 : T18;
  assign T18 = T71 ? 1'h1 : T19;
  assign T19 = T69 ? 1'h1 : T20;
  assign T20 = T67 ? 1'h1 : T21;
  assign T21 = T64 ? 1'h1 : T22;
  assign T22 = T60 ? 1'h1 : T23;
  assign T23 = T58 ? 1'h1 : T24;
  assign T24 = T55 ? 1'h1 : T25;
  assign T25 = T53 ? 1'h1 : T26;
  assign T26 = T51 ? 1'h1 : T27;
  assign T27 = T49 ? 1'h1 : T28;
  assign T28 = T47 ? 1'h1 : T29;
  assign T29 = T45 ? 1'h1 : T30;
  assign T30 = T43 ? 1'h1 : T31;
  assign T31 = T39 ? 1'h1 : T32;
  assign T32 = T33 == 2'h0;
  assign T33 = T34[3'h4:2'h3];
  assign T34 = decReg_instr_a[5'h1a:5'h16];
  assign T35 = reset ? 32'h0 : T36;
  assign T36 = T38 ? 32'h0 : T37;
  assign T37 = io_ena ? io_fedec_instr_a : decReg_instr_a;
  assign T38 = io_ena & io_flush;
  assign T39 = T42 & T40;
  assign T40 = 3'h0 == T41;
  assign T41 = decReg_instr_a[3'h6:3'h4];
  assign T42 = T34 == 5'h8;
  assign T43 = T42 & T44;
  assign T44 = 3'h1 == T41;
  assign T45 = T42 & T46;
  assign T46 = 3'h2 == T41;
  assign T47 = T42 & T48;
  assign T48 = 3'h3 == T41;
  assign T49 = T42 & T50;
  assign T50 = 3'h6 == T41;
  assign T51 = T42 & T52;
  assign T52 = 3'h4 == T41;
  assign T53 = T42 & T54;
  assign T54 = 3'h5 == T41;
  assign T55 = T57 & T56;
  assign T56 = 3'h2 == T41;
  assign T57 = T34 == 5'h9;
  assign T58 = T57 & T59;
  assign T59 = 3'h3 == T41;
  assign T60 = T63 & T61;
  assign T61 = T62 == 3'h0;
  assign T62 = decReg_instr_a[3'h6:3'h4];
  assign T63 = opcode == 5'h1f;
  assign opcode = decReg_instr_a[5'h1a:5'h16];
  assign T64 = T66 & T65;
  assign T65 = 4'h0 == stcfun;
  assign stcfun = decReg_instr_a[5'h15:5'h12];
  assign T66 = opcode == 5'hc;
  assign T67 = T66 & T68;
  assign T68 = 4'h4 == stcfun;
  assign T69 = T66 & T70;
  assign T70 = 4'h5 == stcfun;
  assign T71 = T66 & T72;
  assign T72 = 4'h8 == stcfun;
  assign T73 = T66 & T74;
  assign T74 = 4'hc == stcfun;
  assign T75 = T66 & T76;
  assign T76 = 4'hd == stcfun;
  assign T77 = opcode == 5'h16;
  assign T78 = T80 | T79;
  assign T79 = opcode == 5'h10;
  assign T80 = opcode == 5'h11;
  assign T81 = T83 | T82;
  assign T82 = opcode == 5'h12;
  assign T83 = opcode == 5'h13;
  assign T84 = T86 | T85;
  assign T85 = opcode == 5'h14;
  assign T86 = opcode == 5'h15;
  assign T87 = T89 & T88;
  assign T88 = 4'h0 == func;
  assign func = decReg_instr_a[2'h3:1'h0];
  assign T89 = T91 | T90;
  assign T90 = opcode == 5'h18;
  assign T91 = opcode == 5'h19;
  assign T92 = T89 & T93;
  assign T93 = 4'h1 == func;
  assign T94 = T89 & T95;
  assign T95 = 4'h4 == func;
  assign T96 = T89 & T97;
  assign T97 = 4'h5 == func;
  assign T98 = T89 & T99;
  assign T99 = 4'ha == func;
  assign T100 = opcode == 5'ha;
  assign T101 = opcode == 5'hb;
  assign dual = T104 & T102;
  assign T102 = T103 != 5'h1f;
  assign T103 = decReg_instr_a[5'h1a:5'h16];
  assign T104 = decReg_instr_a[5'h1f:5'h1f];
  assign T105 = io_exc_exc | T106;
  assign T106 = io_exc_intr & T107;
  assign T107 = inDelaySlot == 2'h0;
  assign T108 = io_ena ? T109 : inDelaySlot;
  assign T109 = io_flush ? 2'h1 : T110;
  assign T110 = T118 ? 2'h3 : T111;
  assign T111 = io_decex_jmpOp_branch ? 2'h2 : T112;
  assign T112 = io_decex_aluOp_0_isMul ? T116 : T113;
  assign T113 = T115 ? T114 : 2'h0;
  assign T114 = inDelaySlot - 2'h1;
  assign T115 = inDelaySlot != 2'h0;
  assign T116 = T117 ? T114 : 2'h1;
  assign T117 = 2'h1 < inDelaySlot;
  assign T118 = T119 | io_decex_xret;
  assign T119 = T120 | io_decex_xcall;
  assign T120 = T121 | io_decex_brcf;
  assign T121 = io_decex_call | io_decex_ret;
  assign io_decex_nonDelayed = T122;
  assign T122 = T105 ? 1'h0 : T123;
  assign T123 = T89 ? T130 : T124;
  assign T124 = T84 ? T129 : T125;
  assign T125 = T81 ? T128 : T126;
  assign T126 = T78 ? T127 : 1'h0;
  assign T127 = opcode == 5'h10;
  assign T128 = opcode == 5'h12;
  assign T129 = opcode == 5'h14;
  assign T130 = opcode == 5'h18;
  assign io_decex_xsrc = T131;
  assign T131 = T105 ? io_exc_src : T132;
  assign T132 = T105 ? 5'h0 : T133;
  assign T133 = T77 ? T134 : 5'h0;
  assign T134 = decReg_instr_a[3'h4:1'h0];
  assign io_decex_xret = T135;
  assign T135 = T105 ? 1'h0 : T92;
  assign io_decex_xcall = T105;
  assign io_decex_trap = T136;
  assign T136 = T105 ? 1'h0 : T77;
  assign io_decex_brcf = T137;
  assign T137 = T105 ? 1'h0 : T138;
  assign T138 = T98 ? 1'h1 : T84;
  assign io_decex_ret = T139;
  assign T139 = T105 ? 1'h0 : T87;
  assign io_decex_call = T140;
  assign T140 = T105 ? 1'h0 : T141;
  assign T141 = T94 ? 1'h1 : T78;
  assign io_decex_callAddr = T142;
  assign T142 = T105 ? io_exc_addr : T318;
  assign T318 = {7'h0, T143};
  assign T143 = T105 ? 25'h0 : T144;
  assign T144 = T145;
  assign T145 = {1'h0, T146};
  assign T146 = {T147, 2'h0};
  assign T147 = decReg_instr_a[5'h15:1'h0];
  assign io_decex_wrRd_0 = T148;
  assign T148 = T105 ? 1'h0 : T149;
  assign T149 = T156 ? 1'h0 : T150;
  assign T150 = T100 ? 1'h1 : T151;
  assign T151 = T60 ? 1'h1 : T152;
  assign T152 = T58 ? 1'h1 : T153;
  assign T153 = T53 ? 1'h1 : T154;
  assign T154 = T43 ? 1'h1 : T155;
  assign T155 = T39 ? 1'h1 : T32;
  assign T156 = io_decex_rdAddr_0 == 5'h0;
  assign io_decex_immOp_0 = T157;
  assign T157 = T105 ? 1'h1 : T158;
  assign T158 = T105 ? 1'h0 : T159;
  assign T159 = T84 ? 1'h1 : T160;
  assign T160 = T81 ? 1'h1 : T161;
  assign T161 = T78 ? 1'h1 : T162;
  assign T162 = T73 ? 1'h1 : T163;
  assign T163 = T71 ? 1'h1 : T164;
  assign T164 = T67 ? 1'h1 : T165;
  assign T165 = T64 ? 1'h1 : T166;
  assign T166 = T60 ? 1'h1 : T167;
  assign T167 = T53 ? 1'h1 : T168;
  assign T168 = T49 ? 1'h1 : T32;
  assign io_decex_immVal_0 = T169;
  assign T169 = T105 ? 32'h0 : T170;
  assign T170 = T227 ? T180 : T319;
  assign T319 = {19'h0, T171};
  assign T171 = T172;
  assign T172 = T53 ? T321 : T173;
  assign T173 = T49 ? T320 : T174;
  assign T174 = {1'h0, T175};
  assign T175 = decReg_instr_a[4'hb:1'h0];
  assign T320 = {7'h0, T176};
  assign T176 = {1'h0, T177};
  assign T177 = decReg_instr_a[4'hb:3'h7];
  assign T321 = {7'h0, T178};
  assign T178 = {1'h0, T179};
  assign T179 = decReg_instr_a[4'hb:3'h7];
  assign T180 = isSTC ? T326 : T181;
  assign T181 = isStack ? T325 : T182;
  assign T182 = isMem ? T322 : decReg_instr_b;
  assign T183 = reset ? 32'h0 : T184;
  assign T184 = T38 ? 32'h0 : T185;
  assign T185 = io_ena ? io_fedec_instr_b : decReg_instr_b;
  assign T322 = {22'h0, addrImm};
  assign addrImm = T187;
  assign T187 = T213 ? T210 : T323;
  assign T323 = {1'h0, T188};
  assign T188 = T194 ? T191 : T324;
  assign T324 = {1'h0, T189};
  assign T189 = {1'h0, T190};
  assign T190 = decReg_instr_a[3'h6:1'h0];
  assign T191 = {1'h0, T192};
  assign T192 = {T193, 1'h0};
  assign T193 = decReg_instr_a[3'h6:1'h0];
  assign T194 = 2'h1 == shamt;
  assign shamt = T195;
  assign T195 = T208 ? 2'h1 : T196;
  assign T196 = T206 ? 2'h2 : T197;
  assign T197 = T204 ? 2'h1 : T198;
  assign T198 = T202 ? 2'h1 : T199;
  assign T199 = T200 ? 2'h2 : 2'h0;
  assign T200 = T100 & T201;
  assign T201 = 3'h0 == ldsize;
  assign ldsize = decReg_instr_a[4'hb:4'h9];
  assign T202 = T100 & T203;
  assign T203 = 3'h1 == ldsize;
  assign T204 = T100 & T205;
  assign T205 = 3'h3 == ldsize;
  assign T206 = T101 & T207;
  assign T207 = 3'h0 == stsize;
  assign stsize = decReg_instr_a[5'h15:5'h13];
  assign T208 = T101 & T209;
  assign T209 = 3'h1 == stsize;
  assign T210 = {1'h0, T211};
  assign T211 = {T212, 2'h0};
  assign T212 = decReg_instr_a[3'h6:1'h0];
  assign T213 = 2'h2 == shamt;
  assign isMem = T186;
  assign T186 = T101 ? 1'h1 : T100;
  assign T325 = {22'h0, addrImm};
  assign isStack = T214;
  assign T214 = T217 ? 1'h1 : T215;
  assign T215 = T100 & T216;
  assign T216 = ldtype == 2'h0;
  assign ldtype = decReg_instr_a[4'h8:3'h7];
  assign T217 = T101 & T218;
  assign T218 = sttype == 2'h0;
  assign sttype = decReg_instr_a[5'h12:5'h11];
  assign T326 = {11'h0, stcImm};
  assign stcImm = T219;
  assign T219 = {1'h0, T220};
  assign T220 = {T221, 2'h0};
  assign T221 = decReg_instr_a[5'h11:1'h0];
  assign isSTC = T222;
  assign T222 = T75 ? 1'h1 : T223;
  assign T223 = T73 ? 1'h1 : T224;
  assign T224 = T71 ? 1'h1 : T225;
  assign T225 = T69 ? 1'h1 : T226;
  assign T226 = T67 ? 1'h1 : T64;
  assign T227 = T228 | longImm;
  assign longImm = T60;
  assign T228 = T229 | isMem;
  assign T229 = isSTC | isStack;
  assign io_decex_rdAddr_0 = T230;
  assign T230 = T105 ? 5'h0 : dest;
  assign dest = T231;
  assign T231 = decReg_instr_a[5'h15:5'h11];
  assign io_decex_rsData_0 = T232;
  assign T232 = T105 ? 32'h0 : rf_io_rfRead_rsData_0;
  assign io_decex_rsData_1 = T233;
  assign T233 = T105 ? 32'h0 : rf_io_rfRead_rsData_1;
  assign io_decex_rsAddr_0 = T234;
  assign T234 = T105 ? 5'h0 : T235;
  assign T235 = decReg_instr_a[5'h10:4'hc];
  assign io_decex_rsAddr_1 = T236;
  assign T236 = T105 ? 5'h0 : T237;
  assign T237 = decReg_instr_a[4'hb:3'h7];
  assign io_decex_stackOp = T238;
  assign T238 = T105 ? 3'h0 : T239;
  assign T239 = T75 ? 3'h6 : T240;
  assign T240 = T73 ? 3'h6 : T241;
  assign T241 = T71 ? 3'h5 : T242;
  assign T242 = T69 ? 3'h4 : T243;
  assign T243 = T67 ? 3'h4 : T244;
  assign T244 = T64 ? 3'h3 : 3'h0;
  assign io_decex_memOp_typ = T245;
  assign T245 = T105 ? 2'h0 : T246;
  assign T246 = T253 ? 2'h1 : T247;
  assign T247 = T101 ? sttype : T248;
  assign T248 = T250 ? 2'h1 : T249;
  assign T249 = T100 ? ldtype : 2'h0;
  assign T250 = T100 & T251;
  assign T251 = T252 & io_exc_local;
  assign T252 = ldtype == 2'h2;
  assign T253 = T101 & T254;
  assign T254 = T255 & io_exc_local;
  assign T255 = sttype == 2'h2;
  assign io_decex_memOp_zext = T256;
  assign T256 = T105 ? 1'h0 : T257;
  assign T257 = T258 ? 1'h1 : T204;
  assign T258 = T100 & T259;
  assign T259 = 3'h4 == ldsize;
  assign io_decex_memOp_byte = T260;
  assign T260 = T105 ? 1'h0 : T261;
  assign T261 = T265 ? 1'h1 : T262;
  assign T262 = T258 ? 1'h1 : T263;
  assign T263 = T100 & T264;
  assign T264 = 3'h2 == ldsize;
  assign T265 = T101 & T266;
  assign T266 = 3'h2 == stsize;
  assign io_decex_memOp_hword = T267;
  assign T267 = T105 ? 1'h0 : T268;
  assign T268 = T208 ? 1'h1 : T269;
  assign T269 = T204 ? 1'h1 : T202;
  assign io_decex_memOp_store = T270;
  assign T270 = T105 ? 1'h0 : T101;
  assign io_decex_memOp_load = T271;
  assign T271 = T105 ? 1'h0 : T100;
  assign io_decex_jmpOp_reloc = T272;
  assign T272 = T105 ? 32'h0 : decReg_reloc;
  assign T273 = io_ena ? io_fedec_reloc : decReg_reloc;
  assign io_decex_jmpOp_target = T274;
  assign T274 = T105 ? 30'h0 : T275;
  assign T275 = decReg_pc + T276;
  assign T276 = {T278, T277};
  assign T277 = decReg_instr_a[5'h15:1'h0];
  assign T278 = 8'h0 - T327;
  assign T327 = {7'h0, T279};
  assign T279 = decReg_instr_a[5'h15:5'h15];
  assign T280 = io_ena ? io_fedec_pc : decReg_pc;
  assign io_decex_jmpOp_branch = T281;
  assign T281 = T105 ? 1'h0 : T282;
  assign T282 = T96 ? 1'h1 : T81;
  assign io_decex_predOp_0_s2Addr = T283;
  assign T283 = T105 ? 4'h0 : T284;
  assign T284 = decReg_instr_a[4'ha:3'h7];
  assign io_decex_predOp_0_s1Addr = T285;
  assign T285 = T105 ? 4'h0 : T286;
  assign T286 = decReg_instr_a[4'hf:4'hc];
  assign io_decex_predOp_0_dest = T287;
  assign T287 = T105 ? 3'h0 : T288;
  assign T288 = decReg_instr_a[5'h13:5'h11];
  assign io_decex_predOp_0_func = T289;
  assign T289 = T105 ? 2'h0 : T290;
  assign T290 = {T292, T291};
  assign T291 = decReg_instr_a[1'h0:1'h0];
  assign T292 = decReg_instr_a[2'h3:2'h3];
  assign io_decex_aluOp_0_isMFS = T293;
  assign T293 = T105 ? 1'h0 : T58;
  assign io_decex_aluOp_0_isMTS = T294;
  assign T294 = T105 ? 1'h0 : T55;
  assign io_decex_aluOp_0_isBCpy = T295;
  assign T295 = T105 ? 1'h0 : T53;
  assign io_decex_aluOp_0_isPred = T296;
  assign T296 = T105 ? 1'h0 : T51;
  assign io_decex_aluOp_0_isCmp = T297;
  assign T297 = T105 ? 1'h0 : T298;
  assign T298 = T49 ? 1'h1 : T47;
  assign io_decex_aluOp_0_isMul = T299;
  assign T299 = T105 ? 1'h0 : T45;
  assign io_decex_aluOp_0_func = T300;
  assign T300 = T105 ? 4'h0 : T301;
  assign T301 = T60 ? func : T302;
  assign T302 = T32 ? T304 : T303;
  assign T303 = decReg_instr_a[2'h3:1'h0];
  assign T304 = {1'h0, T305};
  assign T305 = decReg_instr_a[5'h18:5'h16];
  assign io_decex_pred_0 = T306;
  assign T306 = T105 ? 4'h0 : T307;
  assign T307 = T105 ? 4'h8 : T308;
  assign T308 = decReg_instr_a[5'h1e:5'h1b];
  assign io_decex_relPc = T309;
  assign T309 = T105 ? T313 : T310;
  assign T310 = T105 ? 30'h0 : decReg_relPc;
  assign T311 = T38 ? io_fedec_relPc : T312;
  assign T312 = io_ena ? io_fedec_relPc : decReg_relPc;
  assign T313 = io_exc_exc ? io_exc_excAddr : decReg_relPc;
  assign io_decex_base = T314;
  assign T314 = T105 ? T316 : decReg_base;
  assign T315 = io_ena ? io_fedec_base : decReg_base;
  assign T316 = io_exc_exc ? io_exc_excBase : decReg_base;
  assign io_decex_pc = T317;
  assign T317 = T105 ? 30'h0 : decReg_pc;
  RegisterFile rf(.clk(clk),
       .io_ena( io_ena ),
       .io_rfRead_rsAddr_1( T1 ),
       .io_rfRead_rsAddr_0( T0 ),
       .io_rfRead_rsData_1( rf_io_rfRead_rsData_1 ),
       .io_rfRead_rsData_0( rf_io_rfRead_rsData_0 ),
       .io_rfWrite_0_addr( io_rfWrite_0_addr ),
       .io_rfWrite_0_data( io_rfWrite_0_data ),
       .io_rfWrite_0_valid( io_rfWrite_0_valid )
  );

  always @(posedge clk) begin
    if(reset) begin
      decReg_instr_a <= 32'h0;
    end else if(T38) begin
      decReg_instr_a <= 32'h0;
    end else if(io_ena) begin
      decReg_instr_a <= io_fedec_instr_a;
    end
    if(io_ena) begin
      inDelaySlot <= T109;
    end
    if(reset) begin
      decReg_instr_b <= 32'h0;
    end else if(T38) begin
      decReg_instr_b <= 32'h0;
    end else if(io_ena) begin
      decReg_instr_b <= io_fedec_instr_b;
    end
    if(io_ena) begin
      decReg_reloc <= io_fedec_reloc;
    end
    if(io_ena) begin
      decReg_pc <= io_fedec_pc;
    end
    if(T38) begin
      decReg_relPc <= io_fedec_relPc;
    end else if(io_ena) begin
      decReg_relPc <= io_fedec_relPc;
    end
    if(io_ena) begin
      decReg_base <= io_fedec_base;
    end
  end
endmodule

module Execute(input clk, input reset,
    input  io_ena,
    input  io_flush,
    output io_brflush,
    input [29:0] io_decex_pc,
    input [29:0] io_decex_base,
    input [29:0] io_decex_relPc,
    input [3:0] io_decex_pred_0,
    input [3:0] io_decex_aluOp_0_func,
    input  io_decex_aluOp_0_isMul,
    input  io_decex_aluOp_0_isCmp,
    input  io_decex_aluOp_0_isPred,
    input  io_decex_aluOp_0_isBCpy,
    input  io_decex_aluOp_0_isMTS,
    input  io_decex_aluOp_0_isMFS,
    input [1:0] io_decex_predOp_0_func,
    input [2:0] io_decex_predOp_0_dest,
    input [3:0] io_decex_predOp_0_s1Addr,
    input [3:0] io_decex_predOp_0_s2Addr,
    input  io_decex_jmpOp_branch,
    input [29:0] io_decex_jmpOp_target,
    input [31:0] io_decex_jmpOp_reloc,
    input  io_decex_memOp_load,
    input  io_decex_memOp_store,
    input  io_decex_memOp_hword,
    input  io_decex_memOp_byte,
    input  io_decex_memOp_zext,
    input [1:0] io_decex_memOp_typ,
    input [2:0] io_decex_stackOp,
    input [4:0] io_decex_rsAddr_1,
    input [4:0] io_decex_rsAddr_0,
    input [31:0] io_decex_rsData_1,
    input [31:0] io_decex_rsData_0,
    input [4:0] io_decex_rdAddr_0,
    input [31:0] io_decex_immVal_0,
    input  io_decex_immOp_0,
    input  io_decex_wrRd_0,
    input [31:0] io_decex_callAddr,
    input  io_decex_call,
    input  io_decex_ret,
    input  io_decex_brcf,
    input  io_decex_trap,
    input  io_decex_xcall,
    input  io_decex_xret,
    input [4:0] io_decex_xsrc,
    input  io_decex_nonDelayed,
    input  io_decex_illOp,
    output[4:0] io_exmem_rd_0_addr,
    output[31:0] io_exmem_rd_0_data,
    output io_exmem_rd_0_valid,
    output io_exmem_mem_load,
    output io_exmem_mem_store,
    output io_exmem_mem_hword,
    output io_exmem_mem_byte,
    output io_exmem_mem_zext,
    output[1:0] io_exmem_mem_typ,
    output[31:0] io_exmem_mem_addr,
    output[31:0] io_exmem_mem_data,
    output io_exmem_mem_call,
    output io_exmem_mem_ret,
    output io_exmem_mem_brcf,
    output io_exmem_mem_trap,
    output io_exmem_mem_xcall,
    output io_exmem_mem_xret,
    output[4:0] io_exmem_mem_xsrc,
    output io_exmem_mem_illOp,
    output[31:0] io_exmem_mem_callRetAddr,
    output[31:0] io_exmem_mem_callRetBase,
    output io_exmem_mem_nonDelayed,
    output[29:0] io_exmem_pc,
    output[29:0] io_exmem_base,
    output[29:0] io_exmem_relPc,
    output io_exicache_doCallRet,
    output[31:0] io_exicache_callRetBase,
    output[31:0] io_exicache_callRetAddr,
    input [29:0] io_feex_pc,
    input [4:0] io_exResult_0_addr,
    input [31:0] io_exResult_0_data,
    input  io_exResult_0_valid,
    input [4:0] io_memResult_0_addr,
    input [31:0] io_memResult_0_data,
    input  io_memResult_0_valid,
    output io_exfe_doBranch,
    output[29:0] io_exfe_branchPc,
    output[2:0] io_exsc_op,
    output[31:0] io_exsc_opData,
    output[31:0] io_exsc_opOff,
    input [31:0] io_scex_stackTop,
    input [31:0] io_scex_memTop
);

  wire[31:0] T0;
  wire[31:0] op_0;
  wire[31:0] T1;
  wire[31:0] T2;
  reg [31:0] exReg_rsData_0;
  wire[31:0] T3;
  reg [31:0] memResultDataReg_0;
  wire[31:0] T4;
  wire T5;
  reg [2:0] fwReg_0;
  wire[2:0] T6;
  wire[2:0] T7;
  wire[2:0] T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  reg [31:0] exResultDataReg_0;
  wire[31:0] T14;
  wire T15;
  reg [31:0] exReg_immVal_0;
  wire[31:0] T16;
  reg  exReg_immOp_0;
  wire T17;
  wire[31:0] T18;
  wire[31:0] T19;
  wire T20;
  wire doExecute_0;
  wire T21;
  wire T22;
  wire T23;
  reg [3:0] exReg_pred_0;
  wire[3:0] T24;
  wire[3:0] T25;
  wire[3:0] T26;
  wire T27;
  wire T28;
  wire T29;
  wire T30;
  wire T31;
  reg  predReg_0;
  wire T32;
  wire T33;
  wire T34;
  wire T35;
  wire T36;
  wire[7:0] T37;
  wire T38;
  wire T39;
  reg [3:0] exReg_aluOp_0_func;
  wire[3:0] T40;
  wire T41;
  reg  predReg_1;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire T52;
  wire T53;
  reg [3:0] exReg_predOp_0_s2Addr;
  wire[3:0] T54;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire[2:0] T59;
  wire[2:0] T60;
  wire T61;
  reg  predReg_2;
  wire T62;
  wire T63;
  wire T64;
  wire T65;
  wire T66;
  wire[7:0] T67;
  wire[2:0] T68;
  reg [2:0] exReg_predOp_0_dest;
  wire[2:0] T69;
  wire T70;
  wire T71;
  reg  exReg_aluOp_0_isPred;
  wire T72;
  wire T73;
  reg  predReg_3;
  wire T74;
  wire T75;
  wire T76;
  wire T77;
  wire T78;
  wire T79;
  wire T80;
  wire T81;
  wire T82;
  wire T83;
  reg  predReg_4;
  wire T84;
  wire T85;
  wire T86;
  wire T87;
  wire T88;
  wire T89;
  reg  predReg_5;
  wire T90;
  wire T91;
  wire T92;
  wire T93;
  wire T94;
  wire T95;
  wire T96;
  wire T97;
  reg  predReg_6;
  wire T98;
  wire T99;
  wire T100;
  wire T101;
  wire T102;
  wire T103;
  reg  predReg_7;
  wire T104;
  wire T105;
  wire T106;
  wire T107;
  wire T108;
  wire T109;
  wire T110;
  wire T111;
  wire T112;
  wire T113;
  wire T114;
  reg [3:0] exReg_predOp_0_s1Addr;
  wire[3:0] T115;
  wire T116;
  wire T117;
  wire T118;
  wire T119;
  wire[2:0] T120;
  wire[2:0] T121;
  wire T122;
  wire T123;
  wire T124;
  wire T125;
  wire T126;
  wire T127;
  wire T128;
  wire T129;
  wire T130;
  wire T131;
  wire T132;
  wire[1:0] T133;
  reg [1:0] exReg_predOp_0_func;
  wire[1:0] T134;
  wire T135;
  wire T136;
  wire T137;
  wire T138;
  wire T139;
  wire T140;
  wire T141;
  wire T142;
  wire T143;
  wire T144;
  wire T145;
  wire T146;
  wire T147;
  wire T148;
  wire[31:0] T149;
  wire[31:0] T150;
  wire[4:0] T151;
  wire[4:0] T152;
  wire[31:0] op_1;
  wire[31:0] T153;
  wire[31:0] T154;
  wire[31:0] T155;
  reg [31:0] exReg_rsData_1;
  wire[31:0] T156;
  wire T157;
  reg [2:0] fwReg_1;
  wire[2:0] T158;
  wire[2:0] T159;
  wire[2:0] T160;
  wire[2:0] T161;
  wire T162;
  wire T163;
  wire T164;
  wire T165;
  wire T166;
  wire T167;
  wire T168;
  wire[3:0] T169;
  wire T170;
  wire T171;
  wire T172;
  wire T173;
  wire T174;
  wire T175;
  wire T176;
  wire[31:0] T177;
  wire[31:0] T178;
  wire T179;
  wire T180;
  wire T181;
  wire T182;
  wire T183;
  reg  exReg_aluOp_0_isCmp;
  wire T184;
  wire T185;
  wire T186;
  wire T187;
  wire T188;
  wire[2:0] T189;
  wire[2:0] T190;
  wire T191;
  wire T192;
  wire T193;
  wire T194;
  wire T195;
  wire T196;
  wire T197;
  wire T198;
  wire T199;
  wire T200;
  reg  exReg_aluOp_0_isMTS;
  wire T201;
  wire[2:0] T202;
  wire[2:0] T203;
  wire[2:0] T204;
  reg [2:0] exReg_stackOp;
  wire[2:0] T205;
  wire T206;
  wire T207;
  wire T208;
  wire T209;
  wire T210;
  wire T211;
  wire[29:0] T469;
  wire[31:0] target;
  wire[31:0] T212;
  reg [31:0] exReg_jmpOp_reloc;
  wire[31:0] T213;
  wire[31:0] T470;
  wire[29:0] T214;
  wire[29:0] T215;
  wire[31:0] T471;
  reg [29:0] exReg_jmpOp_target;
  wire[29:0] T216;
  wire T217;
  reg  exReg_jmpOp_branch;
  wire T218;
  wire[31:0] T472;
  wire[29:0] T219;
  wire[31:0] callRetAddr;
  wire[31:0] T220;
  wire[31:0] T221;
  reg [31:0] retOffReg;
  wire[31:0] T222;
  wire[31:0] T223;
  wire[31:0] T224;
  wire[31:0] T225;
  wire T226;
  wire T227;
  wire[31:0] T228;
  wire[1:0] T229;
  wire[29:0] T230;
  reg [29:0] exReg_relPc;
  wire[29:0] T231;
  wire[29:0] T232;
  reg  saveND;
  reg  exReg_nonDelayed;
  wire T233;
  reg  saveRetOff;
  wire T234;
  wire T235;
  reg  exReg_call;
  wire T236;
  reg [31:0] excOffReg;
  wire[31:0] T237;
  wire[31:0] T238;
  wire[31:0] T239;
  wire[31:0] T240;
  wire T241;
  wire T242;
  wire[31:0] T243;
  wire[1:0] T244;
  wire T245;
  reg  exReg_xcall;
  wire T246;
  reg  exReg_xret;
  wire T247;
  wire[31:0] brcfOff;
  wire[31:0] T248;
  reg  exReg_brcf;
  wire T249;
  wire T250;
  wire[31:0] T473;
  wire[29:0] T251;
  wire[31:0] callRetBase;
  wire[31:0] T252;
  reg [31:0] retBaseReg;
  wire[31:0] T253;
  wire[31:0] T254;
  wire[31:0] T255;
  wire[31:0] T256;
  wire T257;
  wire T258;
  wire[31:0] T259;
  wire[1:0] T260;
  reg [29:0] exReg_base;
  wire[29:0] T261;
  wire T262;
  reg [31:0] excBaseReg;
  wire[31:0] T263;
  wire[31:0] T264;
  wire[31:0] T265;
  wire[31:0] T266;
  wire T267;
  wire T268;
  wire[31:0] T269;
  wire[1:0] T270;
  wire[31:0] callBase;
  wire[31:0] T271;
  reg [31:0] exReg_callAddr;
  wire[31:0] T272;
  wire T273;
  wire T274;
  wire doCallRet;
  wire T275;
  wire T276;
  wire T277;
  wire T278;
  reg  exReg_ret;
  wire T279;
  reg [29:0] exReg_pc;
  wire[29:0] T280;
  reg  exReg_illOp;
  wire T281;
  wire T282;
  wire T283;
  reg [4:0] exReg_xsrc;
  wire[4:0] T284;
  wire T285;
  wire T286;
  wire T287;
  reg  exReg_trap;
  wire T288;
  wire T289;
  wire T290;
  wire T291;
  wire[31:0] T292;
  reg [1:0] exReg_memOp_typ;
  wire[1:0] T293;
  reg  exReg_memOp_zext;
  wire T294;
  reg  exReg_memOp_byte;
  wire T295;
  reg  exReg_memOp_hword;
  wire T296;
  wire T297;
  reg  exReg_memOp_store;
  wire T298;
  wire T299;
  reg  exReg_memOp_load;
  wire T300;
  wire T301;
  reg  exReg_wrRd_0;
  wire T302;
  wire[31:0] T303;
  wire[31:0] T304;
  wire[31:0] T305;
  wire[31:0] T474;
  wire[34:0] T306;
  wire[34:0] T307;
  wire[34:0] T308;
  wire[34:0] T309;
  wire[34:0] T310;
  wire[34:0] T311;
  wire[34:0] T312;
  wire[34:0] T313;
  wire[34:0] T314;
  wire[34:0] T315;
  wire T316;
  wire[34:0] T475;
  wire[31:0] T317;
  wire T318;
  wire[34:0] T476;
  wire[31:0] T319;
  wire[31:0] T320;
  wire T321;
  wire[34:0] T477;
  wire[31:0] T322;
  wire[31:0] T323;
  wire[62:0] T324;
  wire[4:0] T325;
  wire[4:0] T326;
  wire T327;
  wire[34:0] T478;
  wire[32:0] T328;
  wire[32:0] T329;
  wire[32:0] T330;
  wire[32:0] T331;
  wire T332;
  wire T333;
  wire T334;
  wire T335;
  wire T336;
  wire T337;
  wire[34:0] T479;
  wire[31:0] T338;
  wire[31:0] T339;
  wire T340;
  wire[34:0] T480;
  wire[31:0] T341;
  wire[31:0] T342;
  wire T343;
  wire[34:0] T481;
  wire[31:0] T344;
  wire[31:0] T345;
  wire[31:0] T346;
  wire T347;
  wire T348;
  wire[34:0] T349;
  wire[34:0] T482;
  wire[34:0] T350;
  wire[1:0] T351;
  wire[1:0] T483;
  wire T352;
  wire T353;
  wire T354;
  wire[31:0] T355;
  wire[31:0] T356;
  wire[62:0] T357;
  wire[4:0] T358;
  wire[31:0] T359;
  wire T360;
  wire T361;
  wire T362;
  wire T363;
  wire T364;
  wire T365;
  wire[2:0] T366;
  wire[2:0] T367;
  wire T368;
  wire T369;
  wire T370;
  wire T371;
  wire T372;
  wire T373;
  wire T374;
  wire T375;
  wire T376;
  wire T377;
  wire[31:0] T378;
  wire[31:0] T379;
  wire[31:0] T380;
  wire[62:0] T381;
  wire[4:0] T382;
  reg  exReg_aluOp_0_isBCpy;
  wire T383;
  wire[31:0] T384;
  wire[31:0] T385;
  wire[31:0] T386;
  wire[31:0] T387;
  wire[31:0] T388;
  wire[31:0] T389;
  wire[31:0] T390;
  wire[31:0] T391;
  wire[31:0] T392;
  wire[31:0] T393;
  wire[31:0] T394;
  wire[31:0] T395;
  wire[7:0] T396;
  wire[7:0] T397;
  wire[3:0] T398;
  wire[1:0] T399;
  wire[1:0] T400;
  wire[3:0] T401;
  wire[1:0] T402;
  wire[1:0] T403;
  wire T404;
  reg [31:0] mulLoReg;
  wire[31:0] T405;
  wire[31:0] T406;
  wire[31:0] T407;
  wire[31:0] T408;
  wire[64:0] T409;
  wire[64:0] T484;
  wire[48:0] T410;
  wire[48:0] T411;
  reg [32:0] mulLHReg;
  wire[32:0] T412;
  wire[32:0] T413;
  wire[16:0] T414;
  wire[16:0] T415;
  wire[15:0] T416;
  wire[16:0] T417;
  wire[16:0] T418;
  wire[15:0] T419;
  wire T420;
  wire T421;
  wire T422;
  wire[15:0] T485;
  wire T486;
  wire[64:0] T423;
  wire[64:0] T424;
  wire[64:0] T425;
  wire[63:0] T426;
  reg [31:0] mulLLReg;
  wire[31:0] T427;
  wire[31:0] T428;
  wire[15:0] T429;
  reg [31:0] mulHHReg;
  wire[31:0] T487;
  wire[33:0] T430;
  wire[33:0] T488;
  wire[33:0] T431;
  wire[16:0] T432;
  wire[16:0] T433;
  wire[15:0] T434;
  wire T435;
  wire T436;
  wire[64:0] T489;
  wire[48:0] T437;
  wire[48:0] T438;
  reg [32:0] mulHLReg;
  wire[32:0] T439;
  wire[32:0] T440;
  wire[16:0] T441;
  wire[16:0] T442;
  wire[15:0] T490;
  wire T491;
  wire T443;
  reg  mulPipeReg;
  wire T444;
  wire T445;
  reg  exReg_aluOp_0_isMul;
  wire T446;
  wire[31:0] T447;
  wire T448;
  wire T449;
  wire T450;
  reg [31:0] mulHiReg;
  wire[31:0] T451;
  wire[31:0] T452;
  wire[31:0] T453;
  wire[31:0] T454;
  wire[31:0] T455;
  wire T456;
  wire T457;
  wire T458;
  wire T459;
  wire T460;
  wire T461;
  wire T462;
  wire T463;
  wire T464;
  reg  exReg_aluOp_0_isMFS;
  wire T465;
  reg [4:0] exReg_rdAddr_0;
  wire[4:0] T466;
  wire T467;
  wire T468;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    exReg_rsData_0 = {1{$random}};
    memResultDataReg_0 = {1{$random}};
    fwReg_0 = {1{$random}};
    exResultDataReg_0 = {1{$random}};
    exReg_immVal_0 = {1{$random}};
    exReg_immOp_0 = {1{$random}};
    exReg_pred_0 = {1{$random}};
    predReg_0 = {1{$random}};
    exReg_aluOp_0_func = {1{$random}};
    predReg_1 = {1{$random}};
    exReg_predOp_0_s2Addr = {1{$random}};
    predReg_2 = {1{$random}};
    exReg_predOp_0_dest = {1{$random}};
    exReg_aluOp_0_isPred = {1{$random}};
    predReg_3 = {1{$random}};
    predReg_4 = {1{$random}};
    predReg_5 = {1{$random}};
    predReg_6 = {1{$random}};
    predReg_7 = {1{$random}};
    exReg_predOp_0_s1Addr = {1{$random}};
    exReg_predOp_0_func = {1{$random}};
    exReg_rsData_1 = {1{$random}};
    fwReg_1 = {1{$random}};
    exReg_aluOp_0_isCmp = {1{$random}};
    exReg_aluOp_0_isMTS = {1{$random}};
    exReg_stackOp = {1{$random}};
    exReg_jmpOp_reloc = {1{$random}};
    exReg_jmpOp_target = {1{$random}};
    exReg_jmpOp_branch = {1{$random}};
    retOffReg = {1{$random}};
    exReg_relPc = {1{$random}};
    saveND = {1{$random}};
    exReg_nonDelayed = {1{$random}};
    saveRetOff = {1{$random}};
    exReg_call = {1{$random}};
    excOffReg = {1{$random}};
    exReg_xcall = {1{$random}};
    exReg_xret = {1{$random}};
    exReg_brcf = {1{$random}};
    retBaseReg = {1{$random}};
    exReg_base = {1{$random}};
    excBaseReg = {1{$random}};
    exReg_callAddr = {1{$random}};
    exReg_ret = {1{$random}};
    exReg_pc = {1{$random}};
    exReg_illOp = {1{$random}};
    exReg_xsrc = {1{$random}};
    exReg_trap = {1{$random}};
    exReg_memOp_typ = {1{$random}};
    exReg_memOp_zext = {1{$random}};
    exReg_memOp_byte = {1{$random}};
    exReg_memOp_hword = {1{$random}};
    exReg_memOp_store = {1{$random}};
    exReg_memOp_load = {1{$random}};
    exReg_wrRd_0 = {1{$random}};
    exReg_aluOp_0_isBCpy = {1{$random}};
    mulLoReg = {1{$random}};
    mulLHReg = {2{$random}};
    mulLLReg = {1{$random}};
    mulHHReg = {1{$random}};
    mulHLReg = {2{$random}};
    mulPipeReg = {1{$random}};
    exReg_aluOp_0_isMul = {1{$random}};
    mulHiReg = {1{$random}};
    exReg_aluOp_0_isMFS = {1{$random}};
    exReg_rdAddr_0 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_exsc_opOff = T0;
  assign T0 = exReg_immOp_0 ? exReg_immVal_0 : op_0;
  assign op_0 = T1;
  assign T1 = T15 ? exResultDataReg_0 : T2;
  assign T2 = T5 ? memResultDataReg_0 : exReg_rsData_0;
  assign T3 = io_ena ? io_decex_rsData_0 : exReg_rsData_0;
  assign T4 = io_ena ? io_memResult_0_data : memResultDataReg_0;
  assign T5 = fwReg_0[1'h1:1'h1];
  assign T6 = T13 ? fwReg_0 : T7;
  assign T7 = T11 ? 3'h1 : T8;
  assign T8 = T9 ? 3'h2 : 3'h0;
  assign T9 = T10 & io_memResult_0_valid;
  assign T10 = io_decex_rsAddr_0 == io_memResult_0_addr;
  assign T11 = T12 & io_exResult_0_valid;
  assign T12 = io_decex_rsAddr_0 == io_exResult_0_addr;
  assign T13 = io_ena ^ 1'h1;
  assign T14 = io_ena ? io_exResult_0_data : exResultDataReg_0;
  assign T15 = fwReg_0[1'h0:1'h0];
  assign T16 = io_ena ? io_decex_immVal_0 : exReg_immVal_0;
  assign T17 = io_ena ? io_decex_immOp_0 : exReg_immOp_0;
  assign io_exsc_opData = T18;
  assign T18 = T20 ? T19 : 32'h0;
  assign T19 = op_0;
  assign T20 = exReg_aluOp_0_isMTS & doExecute_0;
  assign doExecute_0 = T21;
  assign T21 = io_flush ? 1'h0 : T22;
  assign T22 = T29 ^ T23;
  assign T23 = exReg_pred_0[2'h3:2'h3];
  assign T24 = reset ? 4'h8 : T25;
  assign T25 = T27 ? 4'h8 : T26;
  assign T26 = io_ena ? io_decex_pred_0 : exReg_pred_0;
  assign T27 = io_ena & T28;
  assign T28 = io_flush | io_brflush;
  assign T29 = T200 ? T194 : T30;
  assign T30 = T193 ? T191 : T31;
  assign T31 = T188 ? predReg_1 : predReg_0;
  assign T32 = reset ? 1'h1 : T33;
  assign T33 = T41 ? predReg_0 : T34;
  assign T34 = T38 ? 1'h1 : T35;
  assign T35 = T38 ? T36 : 1'h1;
  assign T36 = T37[1'h0:1'h0];
  assign T37 = op_0[3'h7:1'h0];
  assign T38 = T20 & T39;
  assign T39 = 4'h0 == exReg_aluOp_0_func;
  assign T40 = io_ena ? io_decex_aluOp_0_func : exReg_aluOp_0_func;
  assign T41 = io_ena ^ 1'h1;
  assign T42 = T41 ? predReg_1 : T43;
  assign T43 = T38 ? T187 : T44;
  assign T44 = T185 ? T45 : predReg_1;
  assign T45 = exReg_aluOp_0_isCmp ? T141 : T46;
  assign T46 = T140 ? T139 : T47;
  assign T47 = T138 ? T137 : T48;
  assign T48 = T136 ? T135 : T49;
  assign T49 = T132 ? T50 : 1'h0;
  assign T50 = ~ T51;
  assign T51 = T113 | T52;
  assign T52 = T55 ^ T53;
  assign T53 = exReg_predOp_0_s2Addr[2'h3:2'h3];
  assign T54 = io_ena ? io_decex_predOp_0_s2Addr : exReg_predOp_0_s2Addr;
  assign T55 = T112 ? T82 : T56;
  assign T56 = T81 ? T61 : T57;
  assign T57 = T58 ? predReg_1 : predReg_0;
  assign T58 = T59[1'h0:1'h0];
  assign T59 = T60;
  assign T60 = exReg_predOp_0_s2Addr[2'h2:1'h0];
  assign T61 = T80 ? predReg_3 : predReg_2;
  assign T62 = T41 ? predReg_2 : T63;
  assign T63 = T38 ? T73 : T64;
  assign T64 = T65 ? T45 : predReg_2;
  assign T65 = T70 & T66;
  assign T66 = T67[2'h2:2'h2];
  assign T67 = 1'h1 << T68;
  assign T68 = exReg_predOp_0_dest;
  assign T69 = io_ena ? io_decex_predOp_0_dest : exReg_predOp_0_dest;
  assign T70 = T71 & doExecute_0;
  assign T71 = exReg_aluOp_0_isCmp | exReg_aluOp_0_isPred;
  assign T72 = io_ena ? io_decex_aluOp_0_isPred : exReg_aluOp_0_isPred;
  assign T73 = T37[2'h2:2'h2];
  assign T74 = T41 ? predReg_3 : T75;
  assign T75 = T38 ? T79 : T76;
  assign T76 = T77 ? T45 : predReg_3;
  assign T77 = T70 & T78;
  assign T78 = T67[2'h3:2'h3];
  assign T79 = T37[2'h3:2'h3];
  assign T80 = T59[1'h0:1'h0];
  assign T81 = T59[1'h1:1'h1];
  assign T82 = T111 ? T97 : T83;
  assign T83 = T96 ? predReg_5 : predReg_4;
  assign T84 = T41 ? predReg_4 : T85;
  assign T85 = T38 ? T89 : T86;
  assign T86 = T87 ? T45 : predReg_4;
  assign T87 = T70 & T88;
  assign T88 = T67[3'h4:3'h4];
  assign T89 = T37[3'h4:3'h4];
  assign T90 = T41 ? predReg_5 : T91;
  assign T91 = T38 ? T95 : T92;
  assign T92 = T93 ? T45 : predReg_5;
  assign T93 = T70 & T94;
  assign T94 = T67[3'h5:3'h5];
  assign T95 = T37[3'h5:3'h5];
  assign T96 = T59[1'h0:1'h0];
  assign T97 = T110 ? predReg_7 : predReg_6;
  assign T98 = T41 ? predReg_6 : T99;
  assign T99 = T38 ? T103 : T100;
  assign T100 = T101 ? T45 : predReg_6;
  assign T101 = T70 & T102;
  assign T102 = T67[3'h6:3'h6];
  assign T103 = T37[3'h6:3'h6];
  assign T104 = T41 ? predReg_7 : T105;
  assign T105 = T38 ? T109 : T106;
  assign T106 = T107 ? T45 : predReg_7;
  assign T107 = T70 & T108;
  assign T108 = T67[3'h7:3'h7];
  assign T109 = T37[3'h7:3'h7];
  assign T110 = T59[1'h0:1'h0];
  assign T111 = T59[1'h1:1'h1];
  assign T112 = T59[2'h2:2'h2];
  assign T113 = T116 ^ T114;
  assign T114 = exReg_predOp_0_s1Addr[2'h3:2'h3];
  assign T115 = io_ena ? io_decex_predOp_0_s1Addr : exReg_predOp_0_s1Addr;
  assign T116 = T131 ? T125 : T117;
  assign T117 = T124 ? T122 : T118;
  assign T118 = T119 ? predReg_1 : predReg_0;
  assign T119 = T120[1'h0:1'h0];
  assign T120 = T121;
  assign T121 = exReg_predOp_0_s1Addr[2'h2:1'h0];
  assign T122 = T123 ? predReg_3 : predReg_2;
  assign T123 = T120[1'h0:1'h0];
  assign T124 = T120[1'h1:1'h1];
  assign T125 = T130 ? T128 : T126;
  assign T126 = T127 ? predReg_5 : predReg_4;
  assign T127 = T120[1'h0:1'h0];
  assign T128 = T129 ? predReg_7 : predReg_6;
  assign T129 = T120[1'h0:1'h0];
  assign T130 = T120[1'h1:1'h1];
  assign T131 = T120[2'h2:2'h2];
  assign T132 = T133 == 2'h3;
  assign T133 = exReg_predOp_0_func;
  assign T134 = io_ena ? io_decex_predOp_0_func : exReg_predOp_0_func;
  assign T135 = T113 ^ T52;
  assign T136 = T133 == 2'h2;
  assign T137 = T113 & T52;
  assign T138 = T133 == 2'h1;
  assign T139 = T113 | T52;
  assign T140 = T133 == 2'h0;
  assign T141 = T183 ? T182 : T142;
  assign T142 = T181 ? T180 : T143;
  assign T143 = T179 ? T176 : T144;
  assign T144 = T175 ? T174 : T145;
  assign T145 = T173 ? T172 : T146;
  assign T146 = T171 ? T170 : T147;
  assign T147 = T168 ? T148 : 1'h0;
  assign T148 = T149 != 32'h0;
  assign T149 = op_0 & T150;
  assign T150 = 1'h1 << T151;
  assign T151 = T152;
  assign T152 = op_1[3'h4:1'h0];
  assign op_1 = T153;
  assign T153 = T167 ? exResultDataReg_0 : T154;
  assign T154 = T166 ? memResultDataReg_0 : T155;
  assign T155 = T157 ? exReg_immVal_0 : exReg_rsData_1;
  assign T156 = io_ena ? io_decex_rsData_1 : exReg_rsData_1;
  assign T157 = fwReg_1[2'h2:2'h2];
  assign T158 = T13 ? fwReg_1 : T159;
  assign T159 = io_decex_immOp_0 ? 3'h4 : T160;
  assign T160 = T164 ? 3'h1 : T161;
  assign T161 = T162 ? 3'h2 : 3'h0;
  assign T162 = T163 & io_memResult_0_valid;
  assign T163 = io_decex_rsAddr_1 == io_memResult_0_addr;
  assign T164 = T165 & io_exResult_0_valid;
  assign T165 = io_decex_rsAddr_1 == io_exResult_0_addr;
  assign T166 = fwReg_1[1'h1:1'h1];
  assign T167 = fwReg_1[1'h0:1'h0];
  assign T168 = T169 == 4'h6;
  assign T169 = exReg_aluOp_0_func;
  assign T170 = T172 | T182;
  assign T171 = T169 == 4'h5;
  assign T172 = op_0 < op_1;
  assign T173 = T169 == 4'h4;
  assign T174 = T176 | T182;
  assign T175 = T169 == 4'h3;
  assign T176 = $signed(T178) < $signed(T177);
  assign T177 = op_1;
  assign T178 = op_0;
  assign T179 = T169 == 4'h2;
  assign T180 = T182 ^ 1'h1;
  assign T181 = T169 == 4'h1;
  assign T182 = op_0 == op_1;
  assign T183 = T169 == 4'h0;
  assign T184 = io_ena ? io_decex_aluOp_0_isCmp : exReg_aluOp_0_isCmp;
  assign T185 = T70 & T186;
  assign T186 = T67[1'h1:1'h1];
  assign T187 = T37[1'h1:1'h1];
  assign T188 = T189[1'h0:1'h0];
  assign T189 = T190;
  assign T190 = exReg_pred_0[2'h2:1'h0];
  assign T191 = T192 ? predReg_3 : predReg_2;
  assign T192 = T189[1'h0:1'h0];
  assign T193 = T189[1'h1:1'h1];
  assign T194 = T199 ? T197 : T195;
  assign T195 = T196 ? predReg_5 : predReg_4;
  assign T196 = T189[1'h0:1'h0];
  assign T197 = T198 ? predReg_7 : predReg_6;
  assign T198 = T189[1'h0:1'h0];
  assign T199 = T189[1'h1:1'h1];
  assign T200 = T189[2'h2:2'h2];
  assign T201 = io_ena ? io_decex_aluOp_0_isMTS : exReg_aluOp_0_isMTS;
  assign io_exsc_op = T202;
  assign T202 = T210 ? 3'h2 : T203;
  assign T203 = T208 ? 3'h1 : T204;
  assign T204 = T206 ? exReg_stackOp : 3'h0;
  assign T205 = io_ena ? io_decex_stackOp : exReg_stackOp;
  assign T206 = T207 & doExecute_0;
  assign T207 = io_brflush ^ 1'h1;
  assign T208 = T20 & T209;
  assign T209 = 4'h6 == exReg_aluOp_0_func;
  assign T210 = T20 & T211;
  assign T211 = 4'h5 == exReg_aluOp_0_func;
  assign io_exfe_branchPc = T469;
  assign T469 = target[5'h1d:1'h0];
  assign target = exReg_immOp_0 ? T471 : T212;
  assign T212 = T470 - exReg_jmpOp_reloc;
  assign T213 = io_ena ? io_decex_jmpOp_reloc : exReg_jmpOp_reloc;
  assign T470 = {2'h0, T214};
  assign T214 = T215;
  assign T215 = op_0[5'h1f:2'h2];
  assign T471 = {2'h0, exReg_jmpOp_target};
  assign T216 = io_ena ? io_decex_jmpOp_target : exReg_jmpOp_target;
  assign io_exfe_doBranch = T217;
  assign T217 = exReg_jmpOp_branch & doExecute_0;
  assign T218 = io_ena ? io_decex_jmpOp_branch : exReg_jmpOp_branch;
  assign io_exicache_callRetAddr = T472;
  assign T472 = {2'h0, T219};
  assign T219 = callRetAddr[5'h1f:2'h2];
  assign callRetAddr = T250 ? 32'h0 : T220;
  assign T220 = exReg_brcf ? brcfOff : T221;
  assign T221 = exReg_xret ? excOffReg : retOffReg;
  assign T222 = saveRetOff ? T228 : T223;
  assign T223 = T41 ? retOffReg : T224;
  assign T224 = T226 ? T225 : retOffReg;
  assign T225 = op_0;
  assign T226 = T20 & T227;
  assign T227 = 4'h8 == exReg_aluOp_0_func;
  assign T228 = {T230, T229};
  assign T229 = 2'h0;
  assign T230 = saveND ? exReg_relPc : io_feex_pc;
  assign T231 = T27 ? io_decex_relPc : T232;
  assign T232 = io_ena ? io_decex_relPc : exReg_relPc;
  assign T233 = io_ena ? io_decex_nonDelayed : exReg_nonDelayed;
  assign T234 = T235 & io_ena;
  assign T235 = exReg_call & doExecute_0;
  assign T236 = io_ena ? io_decex_call : exReg_call;
  assign T237 = T41 ? excOffReg : T238;
  assign T238 = T245 ? T243 : T239;
  assign T239 = T241 ? T240 : excOffReg;
  assign T240 = op_0;
  assign T241 = T20 & T242;
  assign T242 = 4'ha == exReg_aluOp_0_func;
  assign T243 = {exReg_relPc, T244};
  assign T244 = 2'h0;
  assign T245 = exReg_xcall & doExecute_0;
  assign T246 = io_ena ? io_decex_xcall : exReg_xcall;
  assign T247 = io_ena ? io_decex_xret : exReg_xret;
  assign brcfOff = exReg_immOp_0 ? 32'h0 : T248;
  assign T248 = op_1;
  assign T249 = io_ena ? io_decex_brcf : exReg_brcf;
  assign T250 = exReg_call | exReg_xcall;
  assign io_exicache_callRetBase = T473;
  assign T473 = {2'h0, T251};
  assign T251 = callRetBase[5'h1f:2'h2];
  assign callRetBase = T273 ? callBase : T252;
  assign T252 = exReg_xret ? excBaseReg : retBaseReg;
  assign T253 = T41 ? retBaseReg : T254;
  assign T254 = T262 ? T259 : T255;
  assign T255 = T257 ? T256 : retBaseReg;
  assign T256 = op_0;
  assign T257 = T20 & T258;
  assign T258 = 4'h7 == exReg_aluOp_0_func;
  assign T259 = {exReg_base, T260};
  assign T260 = 2'h0;
  assign T261 = io_ena ? io_decex_base : exReg_base;
  assign T262 = exReg_call & doExecute_0;
  assign T263 = T41 ? excBaseReg : T264;
  assign T264 = T245 ? T269 : T265;
  assign T265 = T267 ? T266 : excBaseReg;
  assign T266 = op_0;
  assign T267 = T20 & T268;
  assign T268 = 4'h9 == exReg_aluOp_0_func;
  assign T269 = {exReg_base, T270};
  assign T270 = 2'h0;
  assign callBase = exReg_immOp_0 ? exReg_callAddr : T271;
  assign T271 = op_0;
  assign T272 = io_ena ? io_decex_callAddr : exReg_callAddr;
  assign T273 = T274 | exReg_brcf;
  assign T274 = exReg_call | exReg_xcall;
  assign io_exicache_doCallRet = doCallRet;
  assign doCallRet = T275 & doExecute_0;
  assign T275 = T276 | exReg_xret;
  assign T276 = T277 | exReg_xcall;
  assign T277 = T278 | exReg_brcf;
  assign T278 = exReg_call | exReg_ret;
  assign T279 = io_ena ? io_decex_ret : exReg_ret;
  assign io_exmem_relPc = exReg_relPc;
  assign io_exmem_base = exReg_base;
  assign io_exmem_pc = exReg_pc;
  assign T280 = io_ena ? io_decex_pc : exReg_pc;
  assign io_exmem_mem_nonDelayed = exReg_nonDelayed;
  assign io_exmem_mem_callRetBase = callRetBase;
  assign io_exmem_mem_callRetAddr = callRetAddr;
  assign io_exmem_mem_illOp = exReg_illOp;
  assign T281 = reset ? 1'h0 : T282;
  assign T282 = T27 ? 1'h0 : T283;
  assign T283 = io_ena ? io_decex_illOp : exReg_illOp;
  assign io_exmem_mem_xsrc = exReg_xsrc;
  assign T284 = io_ena ? io_decex_xsrc : exReg_xsrc;
  assign io_exmem_mem_xret = T285;
  assign T285 = exReg_xret & doExecute_0;
  assign io_exmem_mem_xcall = T286;
  assign T286 = exReg_xcall & doExecute_0;
  assign io_exmem_mem_trap = T287;
  assign T287 = exReg_trap & doExecute_0;
  assign T288 = io_ena ? io_decex_trap : exReg_trap;
  assign io_exmem_mem_brcf = T289;
  assign T289 = exReg_brcf & doExecute_0;
  assign io_exmem_mem_ret = T290;
  assign T290 = exReg_ret & doExecute_0;
  assign io_exmem_mem_call = T291;
  assign T291 = exReg_call & doExecute_0;
  assign io_exmem_mem_data = op_1;
  assign io_exmem_mem_addr = T292;
  assign T292 = op_0 + exReg_immVal_0;
  assign io_exmem_mem_typ = exReg_memOp_typ;
  assign T293 = io_ena ? io_decex_memOp_typ : exReg_memOp_typ;
  assign io_exmem_mem_zext = exReg_memOp_zext;
  assign T294 = io_ena ? io_decex_memOp_zext : exReg_memOp_zext;
  assign io_exmem_mem_byte = exReg_memOp_byte;
  assign T295 = io_ena ? io_decex_memOp_byte : exReg_memOp_byte;
  assign io_exmem_mem_hword = exReg_memOp_hword;
  assign T296 = io_ena ? io_decex_memOp_hword : exReg_memOp_hword;
  assign io_exmem_mem_store = T297;
  assign T297 = exReg_memOp_store & doExecute_0;
  assign T298 = io_ena ? io_decex_memOp_store : exReg_memOp_store;
  assign io_exmem_mem_load = T299;
  assign T299 = exReg_memOp_load & doExecute_0;
  assign T300 = io_ena ? io_decex_memOp_load : exReg_memOp_load;
  assign io_exmem_rd_0_valid = T301;
  assign T301 = exReg_wrRd_0 & doExecute_0;
  assign T302 = io_ena ? io_decex_wrRd_0 : exReg_wrRd_0;
  assign io_exmem_rd_0_data = T303;
  assign T303 = exReg_aluOp_0_isMFS ? T384 : T304;
  assign T304 = exReg_aluOp_0_isBCpy ? T355 : T305;
  assign T305 = T474;
  assign T474 = T306[5'h1f:1'h0];
  assign T306 = T354 ? T349 : T307;
  assign T307 = T348 ? T349 : T308;
  assign T308 = T347 ? T481 : T309;
  assign T309 = T343 ? T480 : T310;
  assign T310 = T340 ? T479 : T311;
  assign T311 = T335 ? T478 : T312;
  assign T312 = T327 ? T477 : T313;
  assign T313 = T321 ? T476 : T314;
  assign T314 = T318 ? T475 : T315;
  assign T315 = T316 ? T349 : T349;
  assign T316 = 4'h0 == exReg_aluOp_0_func;
  assign T475 = {3'h0, T317};
  assign T317 = op_0 - op_1;
  assign T318 = 4'h1 == exReg_aluOp_0_func;
  assign T476 = {3'h0, T319};
  assign T319 = T320;
  assign T320 = op_0 ^ op_1;
  assign T321 = 4'h2 == exReg_aluOp_0_func;
  assign T477 = {3'h0, T322};
  assign T322 = T323;
  assign T323 = T324[5'h1f:1'h0];
  assign T324 = op_0 << T325;
  assign T325 = T326;
  assign T326 = op_1[3'h4:1'h0];
  assign T327 = 4'h3 == exReg_aluOp_0_func;
  assign T478 = {2'h0, T328};
  assign T328 = T329;
  assign T329 = $signed(T330) >>> T325;
  assign T330 = T331;
  assign T331 = {T332, op_0};
  assign T332 = T334 ? T333 : 1'h0;
  assign T333 = op_0[5'h1f:5'h1f];
  assign T334 = exReg_aluOp_0_func == 4'h5;
  assign T335 = T337 | T336;
  assign T336 = 4'h5 == exReg_aluOp_0_func;
  assign T337 = 4'h4 == exReg_aluOp_0_func;
  assign T479 = {3'h0, T338};
  assign T338 = T339;
  assign T339 = op_0 | op_1;
  assign T340 = 4'h6 == exReg_aluOp_0_func;
  assign T480 = {3'h0, T341};
  assign T341 = T342;
  assign T342 = op_0 & op_1;
  assign T343 = 4'h7 == exReg_aluOp_0_func;
  assign T481 = {3'h0, T344};
  assign T344 = T345;
  assign T345 = ~ T346;
  assign T346 = op_0 | op_1;
  assign T347 = 4'hb == exReg_aluOp_0_func;
  assign T348 = 4'hc == exReg_aluOp_0_func;
  assign T349 = T350 + T482;
  assign T482 = {3'h0, op_1};
  assign T350 = op_0 << T351;
  assign T351 = T353 ? 2'h2 : T483;
  assign T483 = {1'h0, T352};
  assign T352 = exReg_aluOp_0_func == 4'hc;
  assign T353 = exReg_aluOp_0_func == 4'hd;
  assign T354 = 4'hd == exReg_aluOp_0_func;
  assign T355 = T378 | T356;
  assign T356 = T357[5'h1f:1'h0];
  assign T357 = T359 << T358;
  assign T358 = op_1[3'h4:1'h0];
  assign T359 = {31'h0, T360};
  assign T360 = T362 ^ T361;
  assign T361 = exReg_aluOp_0_func[2'h3:2'h3];
  assign T362 = T377 ? T371 : T363;
  assign T363 = T370 ? T368 : T364;
  assign T364 = T365 ? predReg_1 : predReg_0;
  assign T365 = T366[1'h0:1'h0];
  assign T366 = T367;
  assign T367 = exReg_aluOp_0_func[2'h2:1'h0];
  assign T368 = T369 ? predReg_3 : predReg_2;
  assign T369 = T366[1'h0:1'h0];
  assign T370 = T366[1'h1:1'h1];
  assign T371 = T376 ? T374 : T372;
  assign T372 = T373 ? predReg_5 : predReg_4;
  assign T373 = T366[1'h0:1'h0];
  assign T374 = T375 ? predReg_7 : predReg_6;
  assign T375 = T366[1'h0:1'h0];
  assign T376 = T366[1'h1:1'h1];
  assign T377 = T366[2'h2:2'h2];
  assign T378 = op_0 & T379;
  assign T379 = ~ T380;
  assign T380 = T381[5'h1f:1'h0];
  assign T381 = 32'h1 << T382;
  assign T382 = op_1[3'h4:1'h0];
  assign T383 = io_ena ? io_decex_aluOp_0_isBCpy : exReg_aluOp_0_isBCpy;
  assign T384 = T385;
  assign T385 = T464 ? excOffReg : T386;
  assign T386 = T463 ? excBaseReg : T387;
  assign T387 = T462 ? retOffReg : T388;
  assign T388 = T461 ? retBaseReg : T389;
  assign T389 = T460 ? io_scex_memTop : T390;
  assign T390 = T459 ? io_scex_stackTop : T391;
  assign T391 = T458 ? mulHiReg : T392;
  assign T392 = T450 ? mulLoReg : T393;
  assign T393 = T404 ? T394 : 32'h0;
  assign T394 = T395;
  assign T395 = {24'h0, T396};
  assign T396 = T397;
  assign T397 = {T401, T398};
  assign T398 = {T400, T399};
  assign T399 = {predReg_1, predReg_0};
  assign T400 = {predReg_3, predReg_2};
  assign T401 = {T403, T402};
  assign T402 = {predReg_5, predReg_4};
  assign T403 = {predReg_7, predReg_6};
  assign T404 = 4'h0 == exReg_aluOp_0_func;
  assign T405 = T41 ? mulLoReg : T406;
  assign T406 = T448 ? T447 : T407;
  assign T407 = T443 ? T408 : mulLoReg;
  assign T408 = T409[5'h1f:1'h0];
  assign T409 = T423 + T484;
  assign T484 = {T485, T410};
  assign T410 = T411;
  assign T411 = {mulLHReg, 16'h0};
  assign T412 = io_ena ? T413 : mulLHReg;
  assign T413 = $signed(T417) * $signed(T414);
  assign T414 = T415;
  assign T415 = {1'h0, T416};
  assign T416 = op_0[4'hf:1'h0];
  assign T417 = T418;
  assign T418 = {T420, T419};
  assign T419 = op_1[5'h1f:5'h10];
  assign T420 = T422 ? T421 : 1'h0;
  assign T421 = op_1[5'h1f:5'h1f];
  assign T422 = exReg_aluOp_0_func == 4'h0;
  assign T485 = T486 ? 16'hffff : 16'h0;
  assign T486 = T410[6'h30:6'h30];
  assign T423 = T489 + T424;
  assign T424 = T425;
  assign T425 = {1'h0, T426};
  assign T426 = {mulHHReg, mulLLReg};
  assign T427 = io_ena ? T428 : mulLLReg;
  assign T428 = T416 * T429;
  assign T429 = op_1[4'hf:1'h0];
  assign T487 = T430[5'h1f:1'h0];
  assign T430 = io_ena ? T431 : T488;
  assign T488 = {2'h0, mulHHReg};
  assign T431 = $signed(T432) * $signed(T417);
  assign T432 = T433;
  assign T433 = {T435, T434};
  assign T434 = op_0[5'h1f:5'h10];
  assign T435 = T422 ? T436 : 1'h0;
  assign T436 = op_0[5'h1f:5'h1f];
  assign T489 = {T490, T437};
  assign T437 = T438;
  assign T438 = {mulHLReg, 16'h0};
  assign T439 = io_ena ? T440 : mulHLReg;
  assign T440 = $signed(T432) * $signed(T441);
  assign T441 = T442;
  assign T442 = {1'h0, T429};
  assign T490 = T491 ? 16'hffff : 16'h0;
  assign T491 = T437[6'h30:6'h30];
  assign T443 = io_ena & mulPipeReg;
  assign T444 = io_ena ? T445 : mulPipeReg;
  assign T445 = exReg_aluOp_0_isMul & doExecute_0;
  assign T446 = io_ena ? io_decex_aluOp_0_isMul : exReg_aluOp_0_isMul;
  assign T447 = op_0;
  assign T448 = T20 & T449;
  assign T449 = 4'h2 == exReg_aluOp_0_func;
  assign T450 = 4'h2 == exReg_aluOp_0_func;
  assign T451 = T41 ? mulHiReg : T452;
  assign T452 = T456 ? T455 : T453;
  assign T453 = T443 ? T454 : mulHiReg;
  assign T454 = T409[6'h3f:6'h20];
  assign T455 = op_0;
  assign T456 = T20 & T457;
  assign T457 = 4'h3 == exReg_aluOp_0_func;
  assign T458 = 4'h3 == exReg_aluOp_0_func;
  assign T459 = 4'h6 == exReg_aluOp_0_func;
  assign T460 = 4'h5 == exReg_aluOp_0_func;
  assign T461 = 4'h7 == exReg_aluOp_0_func;
  assign T462 = 4'h8 == exReg_aluOp_0_func;
  assign T463 = 4'h9 == exReg_aluOp_0_func;
  assign T464 = 4'ha == exReg_aluOp_0_func;
  assign T465 = io_ena ? io_decex_aluOp_0_isMFS : exReg_aluOp_0_isMFS;
  assign io_exmem_rd_0_addr = exReg_rdAddr_0;
  assign T466 = io_ena ? io_decex_rdAddr_0 : exReg_rdAddr_0;
  assign io_brflush = T467;
  assign T467 = T468 & doExecute_0;
  assign T468 = exReg_nonDelayed & exReg_jmpOp_branch;

  always @(posedge clk) begin
    if(io_ena) begin
      exReg_rsData_0 <= io_decex_rsData_0;
    end
    if(io_ena) begin
      memResultDataReg_0 <= io_memResult_0_data;
    end
    if(T13) begin
      fwReg_0 <= fwReg_0;
    end else if(T11) begin
      fwReg_0 <= 3'h1;
    end else if(T9) begin
      fwReg_0 <= 3'h2;
    end else begin
      fwReg_0 <= 3'h0;
    end
    if(io_ena) begin
      exResultDataReg_0 <= io_exResult_0_data;
    end
    if(io_ena) begin
      exReg_immVal_0 <= io_decex_immVal_0;
    end
    if(io_ena) begin
      exReg_immOp_0 <= io_decex_immOp_0;
    end
    if(reset) begin
      exReg_pred_0 <= 4'h8;
    end else if(T27) begin
      exReg_pred_0 <= 4'h8;
    end else if(io_ena) begin
      exReg_pred_0 <= io_decex_pred_0;
    end
    if(reset) begin
      predReg_0 <= 1'h1;
    end else if(T41) begin
      predReg_0 <= predReg_0;
    end else if(T38) begin
      predReg_0 <= 1'h1;
    end else if(T38) begin
      predReg_0 <= T36;
    end else begin
      predReg_0 <= 1'h1;
    end
    if(io_ena) begin
      exReg_aluOp_0_func <= io_decex_aluOp_0_func;
    end
    if(T41) begin
      predReg_1 <= predReg_1;
    end else if(T38) begin
      predReg_1 <= T187;
    end else if(T185) begin
      predReg_1 <= T45;
    end
    if(io_ena) begin
      exReg_predOp_0_s2Addr <= io_decex_predOp_0_s2Addr;
    end
    if(T41) begin
      predReg_2 <= predReg_2;
    end else if(T38) begin
      predReg_2 <= T73;
    end else if(T65) begin
      predReg_2 <= T45;
    end
    if(io_ena) begin
      exReg_predOp_0_dest <= io_decex_predOp_0_dest;
    end
    if(io_ena) begin
      exReg_aluOp_0_isPred <= io_decex_aluOp_0_isPred;
    end
    if(T41) begin
      predReg_3 <= predReg_3;
    end else if(T38) begin
      predReg_3 <= T79;
    end else if(T77) begin
      predReg_3 <= T45;
    end
    if(T41) begin
      predReg_4 <= predReg_4;
    end else if(T38) begin
      predReg_4 <= T89;
    end else if(T87) begin
      predReg_4 <= T45;
    end
    if(T41) begin
      predReg_5 <= predReg_5;
    end else if(T38) begin
      predReg_5 <= T95;
    end else if(T93) begin
      predReg_5 <= T45;
    end
    if(T41) begin
      predReg_6 <= predReg_6;
    end else if(T38) begin
      predReg_6 <= T103;
    end else if(T101) begin
      predReg_6 <= T45;
    end
    if(T41) begin
      predReg_7 <= predReg_7;
    end else if(T38) begin
      predReg_7 <= T109;
    end else if(T107) begin
      predReg_7 <= T45;
    end
    if(io_ena) begin
      exReg_predOp_0_s1Addr <= io_decex_predOp_0_s1Addr;
    end
    if(io_ena) begin
      exReg_predOp_0_func <= io_decex_predOp_0_func;
    end
    if(io_ena) begin
      exReg_rsData_1 <= io_decex_rsData_1;
    end
    if(T13) begin
      fwReg_1 <= fwReg_1;
    end else if(io_decex_immOp_0) begin
      fwReg_1 <= 3'h4;
    end else if(T164) begin
      fwReg_1 <= 3'h1;
    end else if(T162) begin
      fwReg_1 <= 3'h2;
    end else begin
      fwReg_1 <= 3'h0;
    end
    if(io_ena) begin
      exReg_aluOp_0_isCmp <= io_decex_aluOp_0_isCmp;
    end
    if(io_ena) begin
      exReg_aluOp_0_isMTS <= io_decex_aluOp_0_isMTS;
    end
    if(io_ena) begin
      exReg_stackOp <= io_decex_stackOp;
    end
    if(io_ena) begin
      exReg_jmpOp_reloc <= io_decex_jmpOp_reloc;
    end
    if(io_ena) begin
      exReg_jmpOp_target <= io_decex_jmpOp_target;
    end
    if(io_ena) begin
      exReg_jmpOp_branch <= io_decex_jmpOp_branch;
    end
    if(saveRetOff) begin
      retOffReg <= T228;
    end else if(T41) begin
      retOffReg <= retOffReg;
    end else if(T226) begin
      retOffReg <= T225;
    end
    if(T27) begin
      exReg_relPc <= io_decex_relPc;
    end else if(io_ena) begin
      exReg_relPc <= io_decex_relPc;
    end
    saveND <= exReg_nonDelayed;
    if(io_ena) begin
      exReg_nonDelayed <= io_decex_nonDelayed;
    end
    saveRetOff <= T234;
    if(io_ena) begin
      exReg_call <= io_decex_call;
    end
    if(T41) begin
      excOffReg <= excOffReg;
    end else if(T245) begin
      excOffReg <= T243;
    end else if(T241) begin
      excOffReg <= T240;
    end
    if(io_ena) begin
      exReg_xcall <= io_decex_xcall;
    end
    if(io_ena) begin
      exReg_xret <= io_decex_xret;
    end
    if(io_ena) begin
      exReg_brcf <= io_decex_brcf;
    end
    if(T41) begin
      retBaseReg <= retBaseReg;
    end else if(T262) begin
      retBaseReg <= T259;
    end else if(T257) begin
      retBaseReg <= T256;
    end
    if(io_ena) begin
      exReg_base <= io_decex_base;
    end
    if(T41) begin
      excBaseReg <= excBaseReg;
    end else if(T245) begin
      excBaseReg <= T269;
    end else if(T267) begin
      excBaseReg <= T266;
    end
    if(io_ena) begin
      exReg_callAddr <= io_decex_callAddr;
    end
    if(io_ena) begin
      exReg_ret <= io_decex_ret;
    end
    if(io_ena) begin
      exReg_pc <= io_decex_pc;
    end
    if(reset) begin
      exReg_illOp <= 1'h0;
    end else if(T27) begin
      exReg_illOp <= 1'h0;
    end else if(io_ena) begin
      exReg_illOp <= io_decex_illOp;
    end
    if(io_ena) begin
      exReg_xsrc <= io_decex_xsrc;
    end
    if(io_ena) begin
      exReg_trap <= io_decex_trap;
    end
    if(io_ena) begin
      exReg_memOp_typ <= io_decex_memOp_typ;
    end
    if(io_ena) begin
      exReg_memOp_zext <= io_decex_memOp_zext;
    end
    if(io_ena) begin
      exReg_memOp_byte <= io_decex_memOp_byte;
    end
    if(io_ena) begin
      exReg_memOp_hword <= io_decex_memOp_hword;
    end
    if(io_ena) begin
      exReg_memOp_store <= io_decex_memOp_store;
    end
    if(io_ena) begin
      exReg_memOp_load <= io_decex_memOp_load;
    end
    if(io_ena) begin
      exReg_wrRd_0 <= io_decex_wrRd_0;
    end
    if(io_ena) begin
      exReg_aluOp_0_isBCpy <= io_decex_aluOp_0_isBCpy;
    end
    if(T41) begin
      mulLoReg <= mulLoReg;
    end else if(T448) begin
      mulLoReg <= T447;
    end else if(T443) begin
      mulLoReg <= T408;
    end
    if(io_ena) begin
      mulLHReg <= T413;
    end
    if(io_ena) begin
      mulLLReg <= T428;
    end
    mulHHReg <= T487;
    if(io_ena) begin
      mulHLReg <= T440;
    end
    if(io_ena) begin
      mulPipeReg <= T445;
    end
    if(io_ena) begin
      exReg_aluOp_0_isMul <= io_decex_aluOp_0_isMul;
    end
    if(T41) begin
      mulHiReg <= mulHiReg;
    end else if(T456) begin
      mulHiReg <= T455;
    end else if(T443) begin
      mulHiReg <= T454;
    end
    if(io_ena) begin
      exReg_aluOp_0_isMFS <= io_decex_aluOp_0_isMFS;
    end
    if(io_ena) begin
      exReg_rdAddr_0 <= io_decex_rdAddr_0;
    end
  end
endmodule

module Memory(input clk, input reset,
    output io_ena_out,
    input  io_ena_in,
    output io_flush,
    input [4:0] io_exmem_rd_0_addr,
    input [31:0] io_exmem_rd_0_data,
    input  io_exmem_rd_0_valid,
    input  io_exmem_mem_load,
    input  io_exmem_mem_store,
    input  io_exmem_mem_hword,
    input  io_exmem_mem_byte,
    input  io_exmem_mem_zext,
    input [1:0] io_exmem_mem_typ,
    input [31:0] io_exmem_mem_addr,
    input [31:0] io_exmem_mem_data,
    input  io_exmem_mem_call,
    input  io_exmem_mem_ret,
    input  io_exmem_mem_brcf,
    input  io_exmem_mem_trap,
    input  io_exmem_mem_xcall,
    input  io_exmem_mem_xret,
    input [4:0] io_exmem_mem_xsrc,
    input  io_exmem_mem_illOp,
    input [31:0] io_exmem_mem_callRetAddr,
    input [31:0] io_exmem_mem_callRetBase,
    input  io_exmem_mem_nonDelayed,
    input [29:0] io_exmem_pc,
    input [29:0] io_exmem_base,
    input [29:0] io_exmem_relPc,
    output[4:0] io_memwb_rd_0_addr,
    output[31:0] io_memwb_rd_0_data,
    output io_memwb_rd_0_valid,
    output[29:0] io_memwb_pc,
    output io_memfe_doCallRet,
    output[29:0] io_memfe_callRetPc,
    output[29:0] io_memfe_callRetBase,
    output io_memfe_store,
    output[31:0] io_memfe_addr,
    output[31:0] io_memfe_data,
    output[4:0] io_exResult_0_addr,
    output[31:0] io_exResult_0_data,
    output io_exResult_0_valid,
    output[2:0] io_localInOut_M_Cmd,
    output[31:0] io_localInOut_M_Addr,
    output[31:0] io_localInOut_M_Data,
    output[3:0] io_localInOut_M_ByteEn,
    input [1:0] io_localInOut_S_Resp,
    input [31:0] io_localInOut_S_Data,
    output[2:0] io_globalInOut_M_Cmd,
    output[31:0] io_globalInOut_M_Addr,
    output[31:0] io_globalInOut_M_Data,
    output[3:0] io_globalInOut_M_ByteEn,
    output[1:0] io_globalInOut_M_AddrSpace,
    input [1:0] io_globalInOut_S_Resp,
    input [31:0] io_globalInOut_S_Data,
    input  io_icacheIllMem,
    input  io_scacheIllMem,
    output io_exc_call,
    output io_exc_ret,
    output[4:0] io_exc_src,
    output io_exc_exc,
    output[29:0] io_exc_excBase,
    output[29:0] io_exc_excAddr
);

  reg [29:0] memReg_pc;
  wire[29:0] T0;
  wire T1;
  wire enable;
  wire T2;
  reg  mayStallReg;
  wire T179;
  wire T3;
  wire T4;
  wire T5;
  wire T6;
  wire T7;
  wire T8;
  wire flush;
  reg  illMemReg;
  wire T9;
  reg  memReg_mem_illOp;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  reg  memReg_mem_nonDelayed;
  wire T15;
  wire T16;
  reg  memReg_mem_xret;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  reg  memReg_mem_brcf;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  reg  memReg_mem_ret;
  wire T25;
  wire T26;
  wire T27;
  reg  memReg_mem_call;
  wire T28;
  wire T29;
  wire T30;
  wire T31;
  reg  memReg_mem_trap;
  wire T32;
  wire T33;
  wire T34;
  reg  memReg_mem_xcall;
  wire T35;
  wire T36;
  wire T37;
  wire illMem;
  wire T38;
  wire T39;
  wire T40;
  wire T41;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  wire T47;
  wire T48;
  wire T49;
  wire[29:0] T50;
  reg [29:0] memReg_relPc;
  wire[29:0] T51;
  wire[29:0] T52;
  reg [29:0] memReg_base;
  wire[29:0] T53;
  wire T54;
  wire T55;
  wire[4:0] T56;
  wire[4:0] T57;
  reg [4:0] memReg_mem_xsrc;
  wire[4:0] T58;
  wire[1:0] T59;
  wire[1:0] T60;
  wire T61;
  wire T62;
  wire[3:0] byteEn;
  wire[3:0] T63;
  wire[3:0] T64;
  wire[3:0] T65;
  wire[3:0] T66;
  wire[3:0] T67;
  wire[3:0] T68;
  wire T69;
  wire T70;
  wire T71;
  wire T72;
  wire T73;
  wire T74;
  wire T75;
  wire[1:0] T76;
  wire T77;
  wire T78;
  wire T79;
  wire T80;
  wire T81;
  wire T82;
  wire[31:0] T83;
  wire[15:0] T84;
  wire[7:0] wrData_0;
  wire[7:0] T85;
  wire[7:0] T86;
  wire[7:0] T87;
  wire[7:0] T88;
  wire[7:0] T89;
  wire[7:0] wrData_1;
  wire[7:0] T90;
  wire[7:0] T91;
  wire[7:0] T92;
  wire[7:0] T93;
  wire[7:0] T94;
  wire[15:0] T95;
  wire[7:0] wrData_2;
  wire[7:0] T96;
  wire[7:0] T97;
  wire[7:0] T98;
  wire[7:0] T99;
  wire[7:0] T100;
  wire[7:0] wrData_3;
  wire[7:0] T101;
  wire[7:0] T102;
  wire[7:0] T103;
  wire[7:0] T104;
  wire[7:0] T105;
  wire[31:0] T106;
  wire[29:0] T107;
  wire[2:0] T108;
  wire[2:0] cmd;
  wire[2:0] T109;
  wire[1:0] T110;
  wire T111;
  wire T112;
  wire T113;
  wire T114;
  wire[31:0] T115;
  wire[15:0] T116;
  wire[15:0] T117;
  wire[31:0] T118;
  wire[29:0] T119;
  wire[2:0] T120;
  wire T121;
  wire[31:0] T122;
  wire[15:0] T123;
  wire[15:0] T124;
  wire T125;
  wire[29:0] T126;
  reg [31:0] memReg_mem_callRetBase;
  wire[31:0] T127;
  wire[29:0] T128;
  reg [31:0] memReg_mem_callRetAddr;
  wire[31:0] T129;
  wire T130;
  wire T131;
  wire T132;
  wire T133;
  reg  memReg_rd_0_valid;
  wire T134;
  wire T135;
  wire T136;
  wire[31:0] T137;
  reg [31:0] memReg_rd_0_data;
  wire[31:0] T138;
  wire[31:0] dout;
  wire[31:0] T139;
  wire[31:0] T140;
  wire[31:0] T141;
  wire[15:0] T142;
  wire[7:0] rdData_0;
  wire[7:0] T143;
  wire[31:0] T144;
  wire T145;
  reg [1:0] memReg_mem_typ;
  wire[1:0] T146;
  wire[7:0] rdData_1;
  wire[7:0] T147;
  wire[15:0] T148;
  wire[7:0] rdData_2;
  wire[7:0] T149;
  wire[7:0] rdData_3;
  wire[7:0] T150;
  wire[31:0] T151;
  wire[7:0] bval;
  wire[7:0] T152;
  wire[7:0] T153;
  wire[7:0] T154;
  wire T155;
  wire[1:0] T156;
  reg [31:0] memReg_mem_addr;
  wire[31:0] T157;
  wire T158;
  wire T159;
  wire T160;
  wire[23:0] T161;
  wire[23:0] T162;
  wire[23:0] T180;
  wire T163;
  reg  memReg_mem_zext;
  wire T164;
  reg  memReg_mem_byte;
  wire T165;
  wire[31:0] T166;
  wire[15:0] hval;
  wire[15:0] T167;
  wire[15:0] T168;
  wire T169;
  wire T170;
  wire[15:0] T171;
  wire[15:0] T172;
  wire[15:0] T181;
  wire T173;
  reg  memReg_mem_hword;
  wire T174;
  reg  memReg_mem_load;
  wire T175;
  wire T176;
  wire T177;
  reg [4:0] memReg_rd_0_addr;
  wire[4:0] T178;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    memReg_pc = {1{$random}};
    mayStallReg = {1{$random}};
    illMemReg = {1{$random}};
    memReg_mem_illOp = {1{$random}};
    memReg_mem_nonDelayed = {1{$random}};
    memReg_mem_xret = {1{$random}};
    memReg_mem_brcf = {1{$random}};
    memReg_mem_ret = {1{$random}};
    memReg_mem_call = {1{$random}};
    memReg_mem_trap = {1{$random}};
    memReg_mem_xcall = {1{$random}};
    memReg_relPc = {1{$random}};
    memReg_base = {1{$random}};
    memReg_mem_xsrc = {1{$random}};
    memReg_mem_callRetBase = {1{$random}};
    memReg_mem_callRetAddr = {1{$random}};
    memReg_rd_0_valid = {1{$random}};
    memReg_rd_0_data = {1{$random}};
    memReg_mem_typ = {1{$random}};
    memReg_mem_addr = {1{$random}};
    memReg_mem_zext = {1{$random}};
    memReg_mem_byte = {1{$random}};
    memReg_mem_hword = {1{$random}};
    memReg_mem_load = {1{$random}};
    memReg_rd_0_addr = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_memwb_pc = memReg_pc;
  assign T0 = T1 ? io_exmem_pc : memReg_pc;
  assign T1 = enable & io_ena_in;
  assign enable = T47 | T2;
  assign T2 = mayStallReg ^ 1'h1;
  assign T179 = reset ? 1'h0 : T3;
  assign T3 = T42 ? 1'h0 : T4;
  assign T4 = illMem ? 1'h0 : T5;
  assign T5 = T8 ? 1'h0 : T6;
  assign T6 = T1 ? T7 : mayStallReg;
  assign T7 = io_exmem_mem_load | io_exmem_mem_store;
  assign T8 = T1 & flush;
  assign flush = T9 | illMemReg;
  assign T9 = T13 | memReg_mem_illOp;
  assign T10 = reset ? 1'h0 : T11;
  assign T11 = T8 ? 1'h0 : T12;
  assign T12 = T1 ? io_exmem_mem_illOp : memReg_mem_illOp;
  assign T13 = T31 | T14;
  assign T14 = T16 & memReg_mem_nonDelayed;
  assign T15 = T1 ? io_exmem_mem_nonDelayed : memReg_mem_nonDelayed;
  assign T16 = T20 | memReg_mem_xret;
  assign T17 = reset ? 1'h0 : T18;
  assign T18 = T8 ? 1'h0 : T19;
  assign T19 = T1 ? io_exmem_mem_xret : memReg_mem_xret;
  assign T20 = T24 | memReg_mem_brcf;
  assign T21 = reset ? 1'h0 : T22;
  assign T22 = T8 ? 1'h0 : T23;
  assign T23 = T1 ? io_exmem_mem_brcf : memReg_mem_brcf;
  assign T24 = memReg_mem_call | memReg_mem_ret;
  assign T25 = reset ? 1'h0 : T26;
  assign T26 = T8 ? 1'h0 : T27;
  assign T27 = T1 ? io_exmem_mem_ret : memReg_mem_ret;
  assign T28 = reset ? 1'h0 : T29;
  assign T29 = T8 ? 1'h0 : T30;
  assign T30 = T1 ? io_exmem_mem_call : memReg_mem_call;
  assign T31 = memReg_mem_xcall | memReg_mem_trap;
  assign T32 = reset ? 1'h0 : T33;
  assign T33 = T8 ? 1'h0 : T34;
  assign T34 = T1 ? io_exmem_mem_trap : memReg_mem_trap;
  assign T35 = reset ? 1'h0 : T36;
  assign T36 = T8 ? 1'h0 : T37;
  assign T37 = T1 ? io_exmem_mem_xcall : memReg_mem_xcall;
  assign illMem = T38 | io_scacheIllMem;
  assign T38 = T39 | io_icacheIllMem;
  assign T39 = T41 | T40;
  assign T40 = io_globalInOut_S_Resp == 2'h3;
  assign T41 = io_localInOut_S_Resp == 2'h3;
  assign T42 = T46 & T43;
  assign T43 = T45 | T44;
  assign T44 = io_globalInOut_S_Resp != 2'h0;
  assign T45 = io_localInOut_S_Resp != 2'h0;
  assign T46 = io_ena_in ^ 1'h1;
  assign T47 = T49 | T48;
  assign T48 = io_globalInOut_S_Resp == 2'h1;
  assign T49 = io_localInOut_S_Resp == 2'h1;
  assign io_exc_excAddr = T50;
  assign T50 = memReg_mem_trap ? T52 : memReg_relPc;
  assign T51 = T1 ? io_exmem_relPc : memReg_relPc;
  assign T52 = memReg_relPc + 30'h1;
  assign io_exc_excBase = memReg_base;
  assign T53 = T1 ? io_exmem_base : memReg_base;
  assign io_exc_exc = T54;
  assign T54 = T55 | illMemReg;
  assign T55 = memReg_mem_trap | memReg_mem_illOp;
  assign io_exc_src = T56;
  assign T56 = memReg_mem_illOp ? 5'h0 : T57;
  assign T57 = illMemReg ? 5'h1 : memReg_mem_xsrc;
  assign T58 = T1 ? io_exmem_mem_xsrc : memReg_mem_xsrc;
  assign io_exc_ret = memReg_mem_xret;
  assign io_exc_call = memReg_mem_xcall;
  assign io_globalInOut_M_AddrSpace = T59;
  assign T59 = T62 ? 2'h0 : T60;
  assign T60 = T61 ? 2'h2 : 2'h3;
  assign T61 = io_exmem_mem_typ == 2'h2;
  assign T62 = io_exmem_mem_typ == 2'h0;
  assign io_globalInOut_M_ByteEn = byteEn;
  assign byteEn = T63;
  assign T63 = T81 ? 4'h1 : T64;
  assign T64 = T79 ? 4'h2 : T65;
  assign T65 = T77 ? 4'h4 : T66;
  assign T66 = T74 ? 4'h8 : T67;
  assign T67 = T72 ? 4'h3 : T68;
  assign T68 = T69 ? 4'hc : 4'hf;
  assign T69 = io_exmem_mem_hword & T70;
  assign T70 = 1'h0 == T71;
  assign T71 = io_exmem_mem_addr[1'h1:1'h1];
  assign T72 = io_exmem_mem_hword & T73;
  assign T73 = 1'h1 == T71;
  assign T74 = io_exmem_mem_byte & T75;
  assign T75 = 2'h0 == T76;
  assign T76 = io_exmem_mem_addr[1'h1:1'h0];
  assign T77 = io_exmem_mem_byte & T78;
  assign T78 = 2'h1 == T76;
  assign T79 = io_exmem_mem_byte & T80;
  assign T80 = 2'h2 == T76;
  assign T81 = io_exmem_mem_byte & T82;
  assign T82 = 2'h3 == T76;
  assign io_globalInOut_M_Data = T83;
  assign T83 = {T95, T84};
  assign T84 = {wrData_1, wrData_0};
  assign wrData_0 = T85;
  assign T85 = T81 ? T89 : T86;
  assign T86 = T72 ? T88 : T87;
  assign T87 = io_exmem_mem_data[3'h7:1'h0];
  assign T88 = io_exmem_mem_data[3'h7:1'h0];
  assign T89 = io_exmem_mem_data[3'h7:1'h0];
  assign wrData_1 = T90;
  assign T90 = T79 ? T94 : T91;
  assign T91 = T72 ? T93 : T92;
  assign T92 = io_exmem_mem_data[4'hf:4'h8];
  assign T93 = io_exmem_mem_data[4'hf:4'h8];
  assign T94 = io_exmem_mem_data[3'h7:1'h0];
  assign T95 = {wrData_3, wrData_2};
  assign wrData_2 = T96;
  assign T96 = T77 ? T100 : T97;
  assign T97 = T69 ? T99 : T98;
  assign T98 = io_exmem_mem_data[5'h17:5'h10];
  assign T99 = io_exmem_mem_data[3'h7:1'h0];
  assign T100 = io_exmem_mem_data[3'h7:1'h0];
  assign wrData_3 = T101;
  assign T101 = T74 ? T105 : T102;
  assign T102 = T69 ? T104 : T103;
  assign T103 = io_exmem_mem_data[5'h1f:5'h18];
  assign T104 = io_exmem_mem_data[4'hf:4'h8];
  assign T105 = io_exmem_mem_data[3'h7:1'h0];
  assign io_globalInOut_M_Addr = T106;
  assign T106 = {T107, 2'h0};
  assign T107 = io_exmem_mem_addr[5'h1f:2'h2];
  assign io_globalInOut_M_Cmd = T108;
  assign T108 = T114 ? cmd : 3'h0;
  assign cmd = T111 ? T109 : 3'h0;
  assign T109 = {T110, io_exmem_mem_store};
  assign T110 = {1'h0, io_exmem_mem_load};
  assign T111 = T113 & T112;
  assign T112 = flush ^ 1'h1;
  assign T113 = enable & io_ena_in;
  assign T114 = io_exmem_mem_typ != 2'h1;
  assign io_localInOut_M_ByteEn = byteEn;
  assign io_localInOut_M_Data = T115;
  assign T115 = {T117, T116};
  assign T116 = {wrData_1, wrData_0};
  assign T117 = {wrData_3, wrData_2};
  assign io_localInOut_M_Addr = T118;
  assign T118 = {T119, 2'h0};
  assign T119 = io_exmem_mem_addr[5'h1f:2'h2];
  assign io_localInOut_M_Cmd = T120;
  assign T120 = T121 ? cmd : 3'h0;
  assign T121 = io_exmem_mem_typ == 2'h1;
  assign io_exResult_0_valid = io_exmem_rd_0_valid;
  assign io_exResult_0_data = io_exmem_rd_0_data;
  assign io_exResult_0_addr = io_exmem_rd_0_addr;
  assign io_memfe_data = T122;
  assign T122 = {T124, T123};
  assign T123 = {wrData_1, wrData_0};
  assign T124 = {wrData_3, wrData_2};
  assign io_memfe_addr = io_exmem_mem_addr;
  assign io_memfe_store = T125;
  assign T125 = io_localInOut_M_Cmd == 3'h1;
  assign io_memfe_callRetBase = T126;
  assign T126 = memReg_mem_callRetBase[5'h1f:2'h2];
  assign T127 = T1 ? io_exmem_mem_callRetBase : memReg_mem_callRetBase;
  assign io_memfe_callRetPc = T128;
  assign T128 = memReg_mem_callRetAddr[5'h1f:2'h2];
  assign T129 = T1 ? io_exmem_mem_callRetAddr : memReg_mem_callRetAddr;
  assign io_memfe_doCallRet = T130;
  assign T130 = T131 | memReg_mem_xret;
  assign T131 = T132 | memReg_mem_xcall;
  assign T132 = T133 | memReg_mem_brcf;
  assign T133 = memReg_mem_call | memReg_mem_ret;
  assign io_memwb_rd_0_valid = memReg_rd_0_valid;
  assign T134 = reset ? 1'h0 : T135;
  assign T135 = T8 ? 1'h0 : T136;
  assign T136 = T1 ? io_exmem_rd_0_valid : memReg_rd_0_valid;
  assign io_memwb_rd_0_data = T137;
  assign T137 = memReg_mem_load ? dout : memReg_rd_0_data;
  assign T138 = T1 ? io_exmem_rd_0_data : memReg_rd_0_data;
  assign dout = T139;
  assign T139 = memReg_mem_hword ? T166 : T140;
  assign T140 = memReg_mem_byte ? T151 : T141;
  assign T141 = {T148, T142};
  assign T142 = {rdData_1, rdData_0};
  assign rdData_0 = T143;
  assign T143 = T144[3'h7:1'h0];
  assign T144 = T145 ? io_localInOut_S_Data : io_globalInOut_S_Data;
  assign T145 = memReg_mem_typ == 2'h1;
  assign T146 = T1 ? io_exmem_mem_typ : memReg_mem_typ;
  assign rdData_1 = T147;
  assign T147 = T144[4'hf:4'h8];
  assign T148 = {rdData_3, rdData_2};
  assign rdData_2 = T149;
  assign T149 = T144[5'h17:5'h10];
  assign rdData_3 = T150;
  assign T150 = T144[5'h1f:5'h18];
  assign T151 = {T161, bval};
  assign bval = T160 ? rdData_3 : T152;
  assign T152 = T159 ? rdData_2 : T153;
  assign T153 = T158 ? rdData_1 : T154;
  assign T154 = T155 ? rdData_0 : rdData_0;
  assign T155 = T156 == 2'h3;
  assign T156 = memReg_mem_addr[1'h1:1'h0];
  assign T157 = T1 ? io_exmem_mem_addr : memReg_mem_addr;
  assign T158 = T156 == 2'h2;
  assign T159 = T156 == 2'h1;
  assign T160 = T156 == 2'h0;
  assign T161 = memReg_mem_zext ? 24'h0 : T162;
  assign T162 = 24'h0 - T180;
  assign T180 = {23'h0, T163};
  assign T163 = bval[3'h7:3'h7];
  assign T164 = T1 ? io_exmem_mem_zext : memReg_mem_zext;
  assign T165 = T1 ? io_exmem_mem_byte : memReg_mem_byte;
  assign T166 = {T171, hval};
  assign hval = T169 ? T168 : T167;
  assign T167 = {rdData_1, rdData_0};
  assign T168 = {rdData_3, rdData_2};
  assign T169 = T170 == 1'h0;
  assign T170 = memReg_mem_addr[1'h1:1'h1];
  assign T171 = memReg_mem_zext ? 16'h0 : T172;
  assign T172 = 16'h0 - T181;
  assign T181 = {15'h0, T173};
  assign T173 = hval[4'hf:4'hf];
  assign T174 = T1 ? io_exmem_mem_hword : memReg_mem_hword;
  assign T175 = reset ? 1'h0 : T176;
  assign T176 = T8 ? 1'h0 : T177;
  assign T177 = T1 ? io_exmem_mem_load : memReg_mem_load;
  assign io_memwb_rd_0_addr = memReg_rd_0_addr;
  assign T178 = T1 ? io_exmem_rd_0_addr : memReg_rd_0_addr;
  assign io_flush = flush;
  assign io_ena_out = enable;

  always @(posedge clk) begin
    if(T1) begin
      memReg_pc <= io_exmem_pc;
    end
    if(reset) begin
      mayStallReg <= 1'h0;
    end else if(T42) begin
      mayStallReg <= 1'h0;
    end else if(illMem) begin
      mayStallReg <= 1'h0;
    end else if(T8) begin
      mayStallReg <= 1'h0;
    end else if(T1) begin
      mayStallReg <= T7;
    end
    illMemReg <= illMem;
    if(reset) begin
      memReg_mem_illOp <= 1'h0;
    end else if(T8) begin
      memReg_mem_illOp <= 1'h0;
    end else if(T1) begin
      memReg_mem_illOp <= io_exmem_mem_illOp;
    end
    if(T1) begin
      memReg_mem_nonDelayed <= io_exmem_mem_nonDelayed;
    end
    if(reset) begin
      memReg_mem_xret <= 1'h0;
    end else if(T8) begin
      memReg_mem_xret <= 1'h0;
    end else if(T1) begin
      memReg_mem_xret <= io_exmem_mem_xret;
    end
    if(reset) begin
      memReg_mem_brcf <= 1'h0;
    end else if(T8) begin
      memReg_mem_brcf <= 1'h0;
    end else if(T1) begin
      memReg_mem_brcf <= io_exmem_mem_brcf;
    end
    if(reset) begin
      memReg_mem_ret <= 1'h0;
    end else if(T8) begin
      memReg_mem_ret <= 1'h0;
    end else if(T1) begin
      memReg_mem_ret <= io_exmem_mem_ret;
    end
    if(reset) begin
      memReg_mem_call <= 1'h0;
    end else if(T8) begin
      memReg_mem_call <= 1'h0;
    end else if(T1) begin
      memReg_mem_call <= io_exmem_mem_call;
    end
    if(reset) begin
      memReg_mem_trap <= 1'h0;
    end else if(T8) begin
      memReg_mem_trap <= 1'h0;
    end else if(T1) begin
      memReg_mem_trap <= io_exmem_mem_trap;
    end
    if(reset) begin
      memReg_mem_xcall <= 1'h0;
    end else if(T8) begin
      memReg_mem_xcall <= 1'h0;
    end else if(T1) begin
      memReg_mem_xcall <= io_exmem_mem_xcall;
    end
    if(T1) begin
      memReg_relPc <= io_exmem_relPc;
    end
    if(T1) begin
      memReg_base <= io_exmem_base;
    end
    if(T1) begin
      memReg_mem_xsrc <= io_exmem_mem_xsrc;
    end
    if(T1) begin
      memReg_mem_callRetBase <= io_exmem_mem_callRetBase;
    end
    if(T1) begin
      memReg_mem_callRetAddr <= io_exmem_mem_callRetAddr;
    end
    if(reset) begin
      memReg_rd_0_valid <= 1'h0;
    end else if(T8) begin
      memReg_rd_0_valid <= 1'h0;
    end else if(T1) begin
      memReg_rd_0_valid <= io_exmem_rd_0_valid;
    end
    if(T1) begin
      memReg_rd_0_data <= io_exmem_rd_0_data;
    end
    if(T1) begin
      memReg_mem_typ <= io_exmem_mem_typ;
    end
    if(T1) begin
      memReg_mem_addr <= io_exmem_mem_addr;
    end
    if(T1) begin
      memReg_mem_zext <= io_exmem_mem_zext;
    end
    if(T1) begin
      memReg_mem_byte <= io_exmem_mem_byte;
    end
    if(T1) begin
      memReg_mem_hword <= io_exmem_mem_hword;
    end
    if(reset) begin
      memReg_mem_load <= 1'h0;
    end else if(T8) begin
      memReg_mem_load <= 1'h0;
    end else if(T1) begin
      memReg_mem_load <= io_exmem_mem_load;
    end
    if(T1) begin
      memReg_rd_0_addr <= io_exmem_rd_0_addr;
    end
  end
endmodule

module WriteBack(
    input  io_ena,
    input [4:0] io_memwb_rd_0_addr,
    input [31:0] io_memwb_rd_0_data,
    input  io_memwb_rd_0_valid,
    input [29:0] io_memwb_pc,
    output[4:0] io_rfWrite_0_addr,
    output[31:0] io_rfWrite_0_data,
    output io_rfWrite_0_valid,
    output[4:0] io_memResult_0_addr,
    output[31:0] io_memResult_0_data,
    output io_memResult_0_valid
);



  assign io_memResult_0_valid = io_memwb_rd_0_valid;
  assign io_memResult_0_data = io_memwb_rd_0_data;
  assign io_memResult_0_addr = io_memwb_rd_0_addr;
  assign io_rfWrite_0_valid = io_memwb_rd_0_valid;
  assign io_rfWrite_0_data = io_memwb_rd_0_data;
  assign io_rfWrite_0_addr = io_memwb_rd_0_addr;
endmodule

module Exceptions(input clk, input reset,
    input  io_ena,
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input [3:0] io_ocp_M_ByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    input  io_intrs_15,
    input  io_intrs_14,
    input  io_intrs_13,
    input  io_intrs_12,
    input  io_intrs_11,
    input  io_intrs_10,
    input  io_intrs_9,
    input  io_intrs_8,
    input  io_intrs_7,
    input  io_intrs_6,
    input  io_intrs_5,
    input  io_intrs_4,
    input  io_intrs_3,
    input  io_intrs_2,
    input  io_intrs_1,
    input  io_intrs_0,
    output io_excdec_exc,
    output[29:0] io_excdec_excBase,
    output[29:0] io_excdec_excAddr,
    output io_excdec_intr,
    output[31:0] io_excdec_addr,
    output[4:0] io_excdec_src,
    output io_excdec_local,
    input  io_memexc_call,
    input  io_memexc_ret,
    input [4:0] io_memexc_src,
    input  io_memexc_exc,
    input [29:0] io_memexc_excBase,
    input [29:0] io_memexc_excAddr,
    output io_superMode,
    output io_invalICache,
    output io_invalDCache
);

  wire T0;
  wire T1;
  reg [31:0] masterReg_Data;
  wire T2;
  wire superMode;
  wire T3;
  reg [31:0] statusReg;
  wire[31:0] T756;
  wire[33:0] T757;
  wire[33:0] T4;
  wire[33:0] T5;
  wire[33:0] T758;
  wire[31:0] T6;
  wire T7;
  wire T8;
  wire T9;
  wire[5:0] T10;
  reg [31:0] masterReg_Addr;
  wire T11;
  reg [2:0] masterReg_Cmd;
  wire[33:0] T12;
  wire[33:0] T13;
  wire T14;
  wire[33:0] T759;
  wire[29:0] T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  reg  localModeReg;
  wire T760;
  wire T21;
  wire T22;
  wire T23;
  reg [4:0] srcReg;
  wire[4:0] src;
  wire[4:0] T24;
  wire[4:0] T25;
  wire[4:0] T26;
  wire[4:0] T27;
  wire[4:0] T28;
  wire[4:0] T29;
  wire[4:0] T30;
  wire[4:0] T31;
  wire[4:0] T32;
  wire[4:0] T33;
  wire[4:0] T34;
  wire[4:0] T35;
  wire[4:0] T36;
  wire[4:0] T37;
  wire[4:0] T38;
  wire[4:0] T39;
  wire[4:0] T40;
  wire[4:0] T41;
  wire[4:0] T42;
  wire[4:0] T43;
  wire[4:0] T44;
  wire[4:0] T45;
  wire[4:0] T46;
  wire[4:0] T47;
  wire[4:0] T48;
  wire[4:0] T49;
  wire[4:0] T50;
  wire[4:0] T51;
  wire[4:0] T52;
  wire[4:0] T53;
  wire[4:0] T54;
  wire[4:0] T55;
  wire[4:0] T56;
  wire[4:0] T57;
  wire[4:0] T58;
  wire[4:0] T59;
  wire[4:0] T60;
  wire[4:0] T61;
  wire[4:0] T62;
  wire[4:0] T63;
  wire[4:0] T64;
  wire[4:0] T65;
  wire[4:0] T66;
  wire[4:0] T67;
  wire[4:0] T68;
  wire[4:0] T69;
  wire[4:0] T70;
  wire[4:0] T71;
  wire[4:0] T72;
  wire[4:0] T73;
  wire[4:0] T74;
  wire[4:0] T75;
  wire[4:0] T76;
  wire[4:0] T77;
  wire[4:0] T78;
  wire[4:0] T79;
  wire[4:0] T80;
  wire[4:0] T81;
  wire[4:0] T82;
  wire[4:0] T83;
  wire[4:0] T84;
  wire[4:0] T85;
  wire[4:0] T86;
  wire[4:0] T87;
  wire T88;
  wire T89;
  wire T90;
  reg [31:0] maskReg;
  wire[31:0] T91;
  wire T92;
  wire T93;
  wire T94;
  wire intrPend_31;
  wire T95;
  wire T96;
  wire T97;
  reg  intrPendReg_31;
  wire T761;
  wire T98;
  wire T99;
  wire T100;
  wire T101;
  wire T102;
  wire T103;
  wire T104;
  wire[31:0] T105;
  wire[4:0] T106;
  reg  R107;
  wire T108;
  wire T109;
  wire T110;
  wire intrPend_30;
  wire T111;
  wire T112;
  wire T113;
  reg  intrPendReg_30;
  wire T762;
  wire T114;
  wire T115;
  wire T116;
  wire T117;
  reg  R118;
  wire T119;
  wire T120;
  wire T121;
  wire intrPend_29;
  wire T122;
  wire T123;
  wire T124;
  reg  intrPendReg_29;
  wire T763;
  wire T125;
  wire T126;
  wire T127;
  wire T128;
  reg  R129;
  wire T130;
  wire T131;
  wire T132;
  wire intrPend_28;
  wire T133;
  wire T134;
  wire T135;
  reg  intrPendReg_28;
  wire T764;
  wire T136;
  wire T137;
  wire T138;
  wire T139;
  reg  R140;
  wire T141;
  wire T142;
  wire T143;
  wire intrPend_27;
  wire T144;
  wire T145;
  wire T146;
  reg  intrPendReg_27;
  wire T765;
  wire T147;
  wire T148;
  wire T149;
  wire T150;
  reg  R151;
  wire T152;
  wire T153;
  wire T154;
  wire intrPend_26;
  wire T155;
  wire T156;
  wire T157;
  reg  intrPendReg_26;
  wire T766;
  wire T158;
  wire T159;
  wire T160;
  wire T161;
  reg  R162;
  wire T163;
  wire T164;
  wire T165;
  wire intrPend_25;
  wire T166;
  wire T167;
  wire T168;
  reg  intrPendReg_25;
  wire T767;
  wire T169;
  wire T170;
  wire T171;
  wire T172;
  reg  R173;
  wire T174;
  wire T175;
  wire T176;
  wire intrPend_24;
  wire T177;
  wire T178;
  wire T179;
  reg  intrPendReg_24;
  wire T768;
  wire T180;
  wire T181;
  wire T182;
  wire T183;
  reg  R184;
  wire T185;
  wire T186;
  wire T187;
  wire intrPend_23;
  wire T188;
  wire T189;
  wire T190;
  reg  intrPendReg_23;
  wire T769;
  wire T191;
  wire T192;
  wire T193;
  wire T194;
  reg  R195;
  wire T196;
  wire T197;
  wire T198;
  wire intrPend_22;
  wire T199;
  wire T200;
  wire T201;
  reg  intrPendReg_22;
  wire T770;
  wire T202;
  wire T203;
  wire T204;
  wire T205;
  reg  R206;
  wire T207;
  wire T208;
  wire T209;
  wire intrPend_21;
  wire T210;
  wire T211;
  wire T212;
  reg  intrPendReg_21;
  wire T771;
  wire T213;
  wire T214;
  wire T215;
  wire T216;
  reg  R217;
  wire T218;
  wire T219;
  wire T220;
  wire intrPend_20;
  wire T221;
  wire T222;
  wire T223;
  reg  intrPendReg_20;
  wire T772;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  reg  R228;
  wire T229;
  wire T230;
  wire T231;
  wire intrPend_19;
  wire T232;
  wire T233;
  wire T234;
  reg  intrPendReg_19;
  wire T773;
  wire T235;
  wire T236;
  wire T237;
  wire T238;
  reg  R239;
  wire T240;
  wire T241;
  wire T242;
  wire intrPend_18;
  wire T243;
  wire T244;
  wire T245;
  reg  intrPendReg_18;
  wire T774;
  wire T246;
  wire T247;
  wire T248;
  wire T249;
  reg  R250;
  wire T251;
  wire T252;
  wire T253;
  wire intrPend_17;
  wire T254;
  wire T255;
  wire T256;
  reg  intrPendReg_17;
  wire T775;
  wire T257;
  wire T258;
  wire T259;
  wire T260;
  reg  R261;
  wire T262;
  wire T263;
  wire T264;
  wire intrPend_16;
  wire T265;
  wire T266;
  wire T267;
  reg  intrPendReg_16;
  wire T776;
  wire T268;
  wire T269;
  wire T270;
  wire T271;
  reg  R272;
  wire T273;
  wire T274;
  wire T275;
  wire intrPend_15;
  wire T276;
  wire T277;
  reg  intrPendReg_15;
  wire T777;
  wire T278;
  wire T279;
  wire T280;
  wire T281;
  wire T282;
  wire T283;
  wire T284;
  wire intrPend_14;
  wire T285;
  wire T286;
  reg  intrPendReg_14;
  wire T778;
  wire T287;
  wire T288;
  wire T289;
  wire T290;
  wire T291;
  wire T292;
  wire T293;
  wire intrPend_13;
  wire T294;
  wire T295;
  reg  intrPendReg_13;
  wire T779;
  wire T296;
  wire T297;
  wire T298;
  wire T299;
  wire T300;
  wire T301;
  wire T302;
  wire intrPend_12;
  wire T303;
  wire T304;
  reg  intrPendReg_12;
  wire T780;
  wire T305;
  wire T306;
  wire T307;
  wire T308;
  wire T309;
  wire T310;
  wire T311;
  wire intrPend_11;
  wire T312;
  wire T313;
  reg  intrPendReg_11;
  wire T781;
  wire T314;
  wire T315;
  wire T316;
  wire T317;
  wire T318;
  wire T319;
  wire T320;
  wire intrPend_10;
  wire T321;
  wire T322;
  reg  intrPendReg_10;
  wire T782;
  wire T323;
  wire T324;
  wire T325;
  wire T326;
  wire T327;
  wire T328;
  wire T329;
  wire intrPend_9;
  wire T330;
  wire T331;
  reg  intrPendReg_9;
  wire T783;
  wire T332;
  wire T333;
  wire T334;
  wire T335;
  wire T336;
  wire T337;
  wire T338;
  wire intrPend_8;
  wire T339;
  wire T340;
  reg  intrPendReg_8;
  wire T784;
  wire T341;
  wire T342;
  wire T343;
  wire T344;
  wire T345;
  wire T346;
  wire T347;
  wire intrPend_7;
  wire T348;
  wire T349;
  reg  intrPendReg_7;
  wire T785;
  wire T350;
  wire T351;
  wire T352;
  wire T353;
  wire T354;
  wire T355;
  wire T356;
  wire intrPend_6;
  wire T357;
  wire T358;
  reg  intrPendReg_6;
  wire T786;
  wire T359;
  wire T360;
  wire T361;
  wire T362;
  wire T363;
  wire T364;
  wire T365;
  wire intrPend_5;
  wire T366;
  wire T367;
  reg  intrPendReg_5;
  wire T787;
  wire T368;
  wire T369;
  wire T370;
  wire T371;
  wire T372;
  wire T373;
  wire T374;
  wire intrPend_4;
  wire T375;
  wire T376;
  reg  intrPendReg_4;
  wire T788;
  wire T377;
  wire T378;
  wire T379;
  wire T380;
  wire T381;
  wire T382;
  wire T383;
  wire intrPend_3;
  wire T384;
  wire T385;
  reg  intrPendReg_3;
  wire T789;
  wire T386;
  wire T387;
  wire T388;
  wire T389;
  wire T390;
  wire T391;
  wire T392;
  wire intrPend_2;
  wire T393;
  wire T394;
  reg  intrPendReg_2;
  wire T790;
  wire T395;
  wire T396;
  wire T397;
  wire T398;
  wire T399;
  wire T400;
  wire T401;
  wire intrPend_1;
  wire T402;
  wire T403;
  reg  intrPendReg_1;
  wire T791;
  wire T404;
  wire T405;
  wire T406;
  wire T407;
  wire T408;
  wire T409;
  wire T410;
  wire intrPend_0;
  wire T411;
  wire T412;
  reg  intrPendReg_0;
  wire T792;
  wire T413;
  wire T414;
  wire T415;
  wire T416;
  wire excPend_31;
  wire T417;
  wire T418;
  reg  excPendReg_31;
  wire T793;
  wire T419;
  wire T420;
  wire[31:0] T421;
  wire[4:0] T422;
  wire T423;
  wire excPend_30;
  wire T424;
  wire T425;
  reg  excPendReg_30;
  wire T794;
  wire T426;
  wire T427;
  wire T428;
  wire excPend_29;
  wire T429;
  wire T430;
  reg  excPendReg_29;
  wire T795;
  wire T431;
  wire T432;
  wire T433;
  wire excPend_28;
  wire T434;
  wire T435;
  reg  excPendReg_28;
  wire T796;
  wire T436;
  wire T437;
  wire T438;
  wire excPend_27;
  wire T439;
  wire T440;
  reg  excPendReg_27;
  wire T797;
  wire T441;
  wire T442;
  wire T443;
  wire excPend_26;
  wire T444;
  wire T445;
  reg  excPendReg_26;
  wire T798;
  wire T446;
  wire T447;
  wire T448;
  wire excPend_25;
  wire T449;
  wire T450;
  reg  excPendReg_25;
  wire T799;
  wire T451;
  wire T452;
  wire T453;
  wire excPend_24;
  wire T454;
  wire T455;
  reg  excPendReg_24;
  wire T800;
  wire T456;
  wire T457;
  wire T458;
  wire excPend_23;
  wire T459;
  wire T460;
  reg  excPendReg_23;
  wire T801;
  wire T461;
  wire T462;
  wire T463;
  wire excPend_22;
  wire T464;
  wire T465;
  reg  excPendReg_22;
  wire T802;
  wire T466;
  wire T467;
  wire T468;
  wire excPend_21;
  wire T469;
  wire T470;
  reg  excPendReg_21;
  wire T803;
  wire T471;
  wire T472;
  wire T473;
  wire excPend_20;
  wire T474;
  wire T475;
  reg  excPendReg_20;
  wire T804;
  wire T476;
  wire T477;
  wire T478;
  wire excPend_19;
  wire T479;
  wire T480;
  reg  excPendReg_19;
  wire T805;
  wire T481;
  wire T482;
  wire T483;
  wire excPend_18;
  wire T484;
  wire T485;
  reg  excPendReg_18;
  wire T806;
  wire T486;
  wire T487;
  wire T488;
  wire excPend_17;
  wire T489;
  wire T490;
  reg  excPendReg_17;
  wire T807;
  wire T491;
  wire T492;
  wire T493;
  wire excPend_16;
  wire T494;
  wire T495;
  reg  excPendReg_16;
  wire T808;
  wire T496;
  wire T497;
  wire T498;
  wire excPend_15;
  wire T499;
  wire T500;
  reg  excPendReg_15;
  wire T809;
  wire T501;
  wire T502;
  wire T503;
  wire excPend_14;
  wire T504;
  wire T505;
  reg  excPendReg_14;
  wire T810;
  wire T506;
  wire T507;
  wire T508;
  wire excPend_13;
  wire T509;
  wire T510;
  reg  excPendReg_13;
  wire T811;
  wire T511;
  wire T512;
  wire T513;
  wire excPend_12;
  wire T514;
  wire T515;
  reg  excPendReg_12;
  wire T812;
  wire T516;
  wire T517;
  wire T518;
  wire excPend_11;
  wire T519;
  wire T520;
  reg  excPendReg_11;
  wire T813;
  wire T521;
  wire T522;
  wire T523;
  wire excPend_10;
  wire T524;
  wire T525;
  reg  excPendReg_10;
  wire T814;
  wire T526;
  wire T527;
  wire T528;
  wire excPend_9;
  wire T529;
  wire T530;
  reg  excPendReg_9;
  wire T815;
  wire T531;
  wire T532;
  wire T533;
  wire excPend_8;
  wire T534;
  wire T535;
  reg  excPendReg_8;
  wire T816;
  wire T536;
  wire T537;
  wire T538;
  wire excPend_7;
  wire T539;
  wire T540;
  reg  excPendReg_7;
  wire T817;
  wire T541;
  wire T542;
  wire T543;
  wire excPend_6;
  wire T544;
  wire T545;
  reg  excPendReg_6;
  wire T818;
  wire T546;
  wire T547;
  wire T548;
  wire excPend_5;
  wire T549;
  wire T550;
  reg  excPendReg_5;
  wire T819;
  wire T551;
  wire T552;
  wire T553;
  wire excPend_4;
  wire T554;
  wire T555;
  reg  excPendReg_4;
  wire T820;
  wire T556;
  wire T557;
  wire T558;
  wire excPend_3;
  wire T559;
  wire T560;
  reg  excPendReg_3;
  wire T821;
  wire T561;
  wire T562;
  wire T563;
  wire excPend_2;
  wire T564;
  wire T565;
  reg  excPendReg_2;
  wire T822;
  wire T566;
  wire T567;
  wire T568;
  wire excPend_1;
  wire T569;
  wire T570;
  reg  excPendReg_1;
  wire T823;
  wire T571;
  wire T572;
  wire T573;
  wire excPend_0;
  wire T574;
  wire T575;
  reg  excPendReg_0;
  wire T824;
  wire T576;
  wire T577;
  wire T578;
  wire[31:0] T579;
  reg [31:0] vecDup [31:0];
  wire[31:0] T580;
  wire[31:0] T581;
  wire T582;
  wire T583;
  wire T584;
  wire T585;
  wire[4:0] T586;
  wire T587;
  wire intrEna;
  wire T588;
  reg  intr;
  wire T589;
  wire[31:0] T590;
  wire[31:0] T591;
  wire[31:0] T592;
  wire[15:0] T593;
  wire[7:0] T594;
  wire[3:0] T595;
  wire[1:0] T596;
  wire[1:0] T597;
  wire[3:0] T598;
  wire[1:0] T599;
  wire[1:0] T600;
  wire[7:0] T601;
  wire[3:0] T602;
  wire[1:0] T603;
  wire[1:0] T604;
  wire[3:0] T605;
  wire[1:0] T606;
  wire[1:0] T607;
  wire[15:0] T608;
  wire[7:0] T609;
  wire[3:0] T610;
  wire[1:0] T611;
  wire[1:0] T612;
  wire[3:0] T613;
  wire[1:0] T614;
  wire[1:0] T615;
  wire[7:0] T616;
  wire[3:0] T617;
  wire[1:0] T618;
  wire[1:0] T619;
  wire[3:0] T620;
  wire[1:0] T621;
  wire[1:0] T622;
  reg [29:0] excAddrReg;
  wire[29:0] T623;
  reg [29:0] excBaseReg;
  wire[29:0] T624;
  reg  exc;
  wire T625;
  wire[31:0] T626;
  wire[31:0] T627;
  wire[15:0] T628;
  wire[7:0] T629;
  wire[3:0] T630;
  wire[1:0] T631;
  wire[1:0] T632;
  wire[3:0] T633;
  wire[1:0] T634;
  wire[1:0] T635;
  wire[7:0] T636;
  wire[3:0] T637;
  wire[1:0] T638;
  wire[1:0] T639;
  wire[3:0] T640;
  wire[1:0] T641;
  wire[1:0] T642;
  wire[15:0] T643;
  wire[7:0] T644;
  wire[3:0] T645;
  wire[1:0] T646;
  wire[1:0] T647;
  wire[3:0] T648;
  wire[1:0] T649;
  wire[1:0] T650;
  wire[7:0] T651;
  wire[3:0] T652;
  wire[1:0] T653;
  wire[1:0] T654;
  wire[3:0] T655;
  wire[1:0] T656;
  wire[1:0] T657;
  wire[31:0] T658;
  wire[31:0] T659;
  wire[31:0] T660;
  wire[31:0] T661;
  wire[31:0] T662;
  wire[31:0] T663;
  wire T664;
  wire T665;
  wire[5:0] T666;
  wire T667;
  wire T668;
  wire T669;
  reg [31:0] sourceReg;
  wire[31:0] T670;
  wire[31:0] T671;
  wire T672;
  wire T673;
  wire T674;
  wire[31:0] T825;
  wire T675;
  wire T676;
  wire[31:0] T677;
  wire[31:0] T678;
  wire[15:0] T679;
  wire[7:0] T680;
  wire[3:0] T681;
  wire[1:0] T682;
  wire[1:0] T683;
  wire[3:0] T684;
  wire[1:0] T685;
  wire[1:0] T686;
  wire[7:0] T687;
  wire[3:0] T688;
  wire[1:0] T689;
  wire[1:0] T690;
  wire[3:0] T691;
  wire[1:0] T692;
  wire[1:0] T693;
  wire[15:0] T694;
  wire[7:0] T695;
  wire[3:0] T696;
  wire[1:0] T697;
  wire[1:0] T698;
  wire[3:0] T699;
  wire[1:0] T700;
  wire[1:0] T701;
  wire[7:0] T702;
  wire[3:0] T703;
  wire[1:0] T704;
  wire[1:0] T705;
  wire[3:0] T706;
  wire[1:0] T707;
  wire[1:0] T708;
  wire T709;
  wire T710;
  wire[31:0] T711;
  wire T712;
  wire T713;
  wire[31:0] T714;
  reg [31:0] vec [31:0];
  wire[31:0] T715;
  wire[31:0] T716;
  wire[4:0] T717;
  wire[4:0] T718;
  wire T719;
  wire T720;
  wire T721;
  wire[1:0] T722;
  wire[1:0] T723;
  wire[1:0] T724;
  wire[1:0] T725;
  wire[1:0] T726;
  wire[1:0] T727;
  wire[1:0] T728;
  wire[1:0] T729;
  wire[1:0] T730;
  wire[1:0] T731;
  wire[1:0] T732;
  wire T733;
  wire T734;
  wire T735;
  wire T736;
  wire T737;
  wire T738;
  wire T739;
  wire T740;
  wire T741;
  wire T742;
  wire T743;
  wire T744;
  wire T745;
  wire T746;
  wire T747;
  wire T748;
  wire T749;
  wire T750;
  wire T751;
  wire T752;
  wire T753;
  reg  sleepReg;
  wire T826;
  wire T754;
  wire T755;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    masterReg_Data = {1{$random}};
    statusReg = {1{$random}};
    masterReg_Addr = {1{$random}};
    masterReg_Cmd = {1{$random}};
    localModeReg = {1{$random}};
    srcReg = {1{$random}};
    maskReg = {1{$random}};
    intrPendReg_31 = {1{$random}};
    R107 = {1{$random}};
    intrPendReg_30 = {1{$random}};
    R118 = {1{$random}};
    intrPendReg_29 = {1{$random}};
    R129 = {1{$random}};
    intrPendReg_28 = {1{$random}};
    R140 = {1{$random}};
    intrPendReg_27 = {1{$random}};
    R151 = {1{$random}};
    intrPendReg_26 = {1{$random}};
    R162 = {1{$random}};
    intrPendReg_25 = {1{$random}};
    R173 = {1{$random}};
    intrPendReg_24 = {1{$random}};
    R184 = {1{$random}};
    intrPendReg_23 = {1{$random}};
    R195 = {1{$random}};
    intrPendReg_22 = {1{$random}};
    R206 = {1{$random}};
    intrPendReg_21 = {1{$random}};
    R217 = {1{$random}};
    intrPendReg_20 = {1{$random}};
    R228 = {1{$random}};
    intrPendReg_19 = {1{$random}};
    R239 = {1{$random}};
    intrPendReg_18 = {1{$random}};
    R250 = {1{$random}};
    intrPendReg_17 = {1{$random}};
    R261 = {1{$random}};
    intrPendReg_16 = {1{$random}};
    R272 = {1{$random}};
    intrPendReg_15 = {1{$random}};
    intrPendReg_14 = {1{$random}};
    intrPendReg_13 = {1{$random}};
    intrPendReg_12 = {1{$random}};
    intrPendReg_11 = {1{$random}};
    intrPendReg_10 = {1{$random}};
    intrPendReg_9 = {1{$random}};
    intrPendReg_8 = {1{$random}};
    intrPendReg_7 = {1{$random}};
    intrPendReg_6 = {1{$random}};
    intrPendReg_5 = {1{$random}};
    intrPendReg_4 = {1{$random}};
    intrPendReg_3 = {1{$random}};
    intrPendReg_2 = {1{$random}};
    intrPendReg_1 = {1{$random}};
    intrPendReg_0 = {1{$random}};
    excPendReg_31 = {1{$random}};
    excPendReg_30 = {1{$random}};
    excPendReg_29 = {1{$random}};
    excPendReg_28 = {1{$random}};
    excPendReg_27 = {1{$random}};
    excPendReg_26 = {1{$random}};
    excPendReg_25 = {1{$random}};
    excPendReg_24 = {1{$random}};
    excPendReg_23 = {1{$random}};
    excPendReg_22 = {1{$random}};
    excPendReg_21 = {1{$random}};
    excPendReg_20 = {1{$random}};
    excPendReg_19 = {1{$random}};
    excPendReg_18 = {1{$random}};
    excPendReg_17 = {1{$random}};
    excPendReg_16 = {1{$random}};
    excPendReg_15 = {1{$random}};
    excPendReg_14 = {1{$random}};
    excPendReg_13 = {1{$random}};
    excPendReg_12 = {1{$random}};
    excPendReg_11 = {1{$random}};
    excPendReg_10 = {1{$random}};
    excPendReg_9 = {1{$random}};
    excPendReg_8 = {1{$random}};
    excPendReg_7 = {1{$random}};
    excPendReg_6 = {1{$random}};
    excPendReg_5 = {1{$random}};
    excPendReg_4 = {1{$random}};
    excPendReg_3 = {1{$random}};
    excPendReg_2 = {1{$random}};
    excPendReg_1 = {1{$random}};
    excPendReg_0 = {1{$random}};
    for (initvar = 0; initvar < 32; initvar = initvar+1)
      vecDup[initvar] = {1{$random}};
    intr = {1{$random}};
    excAddrReg = {1{$random}};
    excBaseReg = {1{$random}};
    exc = {1{$random}};
    sourceReg = {1{$random}};
    for (initvar = 0; initvar < 32; initvar = initvar+1)
      vec[initvar] = {1{$random}};
    sleepReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_invalDCache = T0;
  assign T0 = T2 ? T1 : 1'h0;
  assign T1 = masterReg_Data[1'h0:1'h0];
  assign T2 = T17 & superMode;
  assign superMode = T3 == 1'h1;
  assign T3 = statusReg[1'h1:1'h1];
  assign T756 = T757[5'h1f:1'h0];
  assign T757 = reset ? 34'h2 : T4;
  assign T4 = T16 ? T759 : T5;
  assign T5 = T14 ? T12 : T758;
  assign T758 = {2'h0, T6};
  assign T6 = T7 ? masterReg_Data : statusReg;
  assign T7 = T8 & superMode;
  assign T8 = T11 & T9;
  assign T9 = 6'h0 == T10;
  assign T10 = masterReg_Addr[3'h7:2'h2];
  assign T11 = masterReg_Cmd == 3'h1;
  assign T12 = T13 | 34'h2;
  assign T13 = statusReg << 2'h2;
  assign T14 = io_memexc_call & io_ena;
  assign T759 = {4'h0, T15};
  assign T15 = statusReg >> 2'h2;
  assign T16 = io_memexc_ret & io_ena;
  assign T17 = T11 & T18;
  assign T18 = 6'h5 == T10;
  assign io_invalICache = T19;
  assign T19 = T2 ? T20 : 1'h0;
  assign T20 = masterReg_Data[1'h1:1'h1];
  assign io_superMode = superMode;
  assign io_excdec_local = localModeReg;
  assign T760 = reset ? 1'h0 : T21;
  assign T21 = T2 ? T22 : localModeReg;
  assign T22 = localModeReg ^ T23;
  assign T23 = masterReg_Data[5'h1f:5'h1f];
  assign io_excdec_src = srcReg;
  assign src = T24;
  assign T24 = excPend_0 ? 5'h0 : T25;
  assign T25 = excPend_1 ? 5'h1 : T26;
  assign T26 = excPend_2 ? 5'h2 : T27;
  assign T27 = excPend_3 ? 5'h3 : T28;
  assign T28 = excPend_4 ? 5'h4 : T29;
  assign T29 = excPend_5 ? 5'h5 : T30;
  assign T30 = excPend_6 ? 5'h6 : T31;
  assign T31 = excPend_7 ? 5'h7 : T32;
  assign T32 = excPend_8 ? 5'h8 : T33;
  assign T33 = excPend_9 ? 5'h9 : T34;
  assign T34 = excPend_10 ? 5'ha : T35;
  assign T35 = excPend_11 ? 5'hb : T36;
  assign T36 = excPend_12 ? 5'hc : T37;
  assign T37 = excPend_13 ? 5'hd : T38;
  assign T38 = excPend_14 ? 5'he : T39;
  assign T39 = excPend_15 ? 5'hf : T40;
  assign T40 = excPend_16 ? 5'h10 : T41;
  assign T41 = excPend_17 ? 5'h11 : T42;
  assign T42 = excPend_18 ? 5'h12 : T43;
  assign T43 = excPend_19 ? 5'h13 : T44;
  assign T44 = excPend_20 ? 5'h14 : T45;
  assign T45 = excPend_21 ? 5'h15 : T46;
  assign T46 = excPend_22 ? 5'h16 : T47;
  assign T47 = excPend_23 ? 5'h17 : T48;
  assign T48 = excPend_24 ? 5'h18 : T49;
  assign T49 = excPend_25 ? 5'h19 : T50;
  assign T50 = excPend_26 ? 5'h1a : T51;
  assign T51 = excPend_27 ? 5'h1b : T52;
  assign T52 = excPend_28 ? 5'h1c : T53;
  assign T53 = excPend_29 ? 5'h1d : T54;
  assign T54 = excPend_30 ? 5'h1e : T55;
  assign T55 = excPend_31 ? 5'h1f : T56;
  assign T56 = T408 ? 5'h0 : T57;
  assign T57 = T399 ? 5'h1 : T58;
  assign T58 = T390 ? 5'h2 : T59;
  assign T59 = T381 ? 5'h3 : T60;
  assign T60 = T372 ? 5'h4 : T61;
  assign T61 = T363 ? 5'h5 : T62;
  assign T62 = T354 ? 5'h6 : T63;
  assign T63 = T345 ? 5'h7 : T64;
  assign T64 = T336 ? 5'h8 : T65;
  assign T65 = T327 ? 5'h9 : T66;
  assign T66 = T318 ? 5'ha : T67;
  assign T67 = T309 ? 5'hb : T68;
  assign T68 = T300 ? 5'hc : T69;
  assign T69 = T291 ? 5'hd : T70;
  assign T70 = T282 ? 5'he : T71;
  assign T71 = T273 ? 5'hf : T72;
  assign T72 = T262 ? 5'h10 : T73;
  assign T73 = T251 ? 5'h11 : T74;
  assign T74 = T240 ? 5'h12 : T75;
  assign T75 = T229 ? 5'h13 : T76;
  assign T76 = T218 ? 5'h14 : T77;
  assign T77 = T207 ? 5'h15 : T78;
  assign T78 = T196 ? 5'h16 : T79;
  assign T79 = T185 ? 5'h17 : T80;
  assign T80 = T174 ? 5'h18 : T81;
  assign T81 = T163 ? 5'h19 : T82;
  assign T82 = T152 ? 5'h1a : T83;
  assign T83 = T141 ? 5'h1b : T84;
  assign T84 = T130 ? 5'h1c : T85;
  assign T85 = T119 ? 5'h1d : T86;
  assign T86 = T108 ? 5'h1e : T87;
  assign T87 = T88 ? 5'h1f : 5'h0;
  assign T88 = intrPend_31 & T89;
  assign T89 = T90 == 1'h1;
  assign T90 = maskReg[5'h1f:5'h1f];
  assign T91 = T92 ? masterReg_Data : maskReg;
  assign T92 = T93 & superMode;
  assign T93 = T11 & T94;
  assign T94 = 6'h1 == T10;
  assign intrPend_31 = T95;
  assign T95 = R107 ? 1'h1 : T96;
  assign T96 = T103 ? 1'h0 : T97;
  assign T97 = T100 ? T98 : intrPendReg_31;
  assign T761 = reset ? 1'h0 : intrPend_31;
  assign T98 = intrPendReg_31 & T99;
  assign T99 = masterReg_Data[5'h1f:5'h1f];
  assign T100 = T101 & superMode;
  assign T101 = T11 & T102;
  assign T102 = 6'h2 == T10;
  assign T103 = io_memexc_call & T104;
  assign T104 = T105[5'h1f:5'h1f];
  assign T105 = 1'h1 << T106;
  assign T106 = io_memexc_src;
  assign T108 = intrPend_30 & T109;
  assign T109 = T110 == 1'h1;
  assign T110 = maskReg[5'h1e:5'h1e];
  assign intrPend_30 = T111;
  assign T111 = R118 ? 1'h1 : T112;
  assign T112 = T116 ? 1'h0 : T113;
  assign T113 = T100 ? T114 : intrPendReg_30;
  assign T762 = reset ? 1'h0 : intrPend_30;
  assign T114 = intrPendReg_30 & T115;
  assign T115 = masterReg_Data[5'h1e:5'h1e];
  assign T116 = io_memexc_call & T117;
  assign T117 = T105[5'h1e:5'h1e];
  assign T119 = intrPend_29 & T120;
  assign T120 = T121 == 1'h1;
  assign T121 = maskReg[5'h1d:5'h1d];
  assign intrPend_29 = T122;
  assign T122 = R129 ? 1'h1 : T123;
  assign T123 = T127 ? 1'h0 : T124;
  assign T124 = T100 ? T125 : intrPendReg_29;
  assign T763 = reset ? 1'h0 : intrPend_29;
  assign T125 = intrPendReg_29 & T126;
  assign T126 = masterReg_Data[5'h1d:5'h1d];
  assign T127 = io_memexc_call & T128;
  assign T128 = T105[5'h1d:5'h1d];
  assign T130 = intrPend_28 & T131;
  assign T131 = T132 == 1'h1;
  assign T132 = maskReg[5'h1c:5'h1c];
  assign intrPend_28 = T133;
  assign T133 = R140 ? 1'h1 : T134;
  assign T134 = T138 ? 1'h0 : T135;
  assign T135 = T100 ? T136 : intrPendReg_28;
  assign T764 = reset ? 1'h0 : intrPend_28;
  assign T136 = intrPendReg_28 & T137;
  assign T137 = masterReg_Data[5'h1c:5'h1c];
  assign T138 = io_memexc_call & T139;
  assign T139 = T105[5'h1c:5'h1c];
  assign T141 = intrPend_27 & T142;
  assign T142 = T143 == 1'h1;
  assign T143 = maskReg[5'h1b:5'h1b];
  assign intrPend_27 = T144;
  assign T144 = R151 ? 1'h1 : T145;
  assign T145 = T149 ? 1'h0 : T146;
  assign T146 = T100 ? T147 : intrPendReg_27;
  assign T765 = reset ? 1'h0 : intrPend_27;
  assign T147 = intrPendReg_27 & T148;
  assign T148 = masterReg_Data[5'h1b:5'h1b];
  assign T149 = io_memexc_call & T150;
  assign T150 = T105[5'h1b:5'h1b];
  assign T152 = intrPend_26 & T153;
  assign T153 = T154 == 1'h1;
  assign T154 = maskReg[5'h1a:5'h1a];
  assign intrPend_26 = T155;
  assign T155 = R162 ? 1'h1 : T156;
  assign T156 = T160 ? 1'h0 : T157;
  assign T157 = T100 ? T158 : intrPendReg_26;
  assign T766 = reset ? 1'h0 : intrPend_26;
  assign T158 = intrPendReg_26 & T159;
  assign T159 = masterReg_Data[5'h1a:5'h1a];
  assign T160 = io_memexc_call & T161;
  assign T161 = T105[5'h1a:5'h1a];
  assign T163 = intrPend_25 & T164;
  assign T164 = T165 == 1'h1;
  assign T165 = maskReg[5'h19:5'h19];
  assign intrPend_25 = T166;
  assign T166 = R173 ? 1'h1 : T167;
  assign T167 = T171 ? 1'h0 : T168;
  assign T168 = T100 ? T169 : intrPendReg_25;
  assign T767 = reset ? 1'h0 : intrPend_25;
  assign T169 = intrPendReg_25 & T170;
  assign T170 = masterReg_Data[5'h19:5'h19];
  assign T171 = io_memexc_call & T172;
  assign T172 = T105[5'h19:5'h19];
  assign T174 = intrPend_24 & T175;
  assign T175 = T176 == 1'h1;
  assign T176 = maskReg[5'h18:5'h18];
  assign intrPend_24 = T177;
  assign T177 = R184 ? 1'h1 : T178;
  assign T178 = T182 ? 1'h0 : T179;
  assign T179 = T100 ? T180 : intrPendReg_24;
  assign T768 = reset ? 1'h0 : intrPend_24;
  assign T180 = intrPendReg_24 & T181;
  assign T181 = masterReg_Data[5'h18:5'h18];
  assign T182 = io_memexc_call & T183;
  assign T183 = T105[5'h18:5'h18];
  assign T185 = intrPend_23 & T186;
  assign T186 = T187 == 1'h1;
  assign T187 = maskReg[5'h17:5'h17];
  assign intrPend_23 = T188;
  assign T188 = R195 ? 1'h1 : T189;
  assign T189 = T193 ? 1'h0 : T190;
  assign T190 = T100 ? T191 : intrPendReg_23;
  assign T769 = reset ? 1'h0 : intrPend_23;
  assign T191 = intrPendReg_23 & T192;
  assign T192 = masterReg_Data[5'h17:5'h17];
  assign T193 = io_memexc_call & T194;
  assign T194 = T105[5'h17:5'h17];
  assign T196 = intrPend_22 & T197;
  assign T197 = T198 == 1'h1;
  assign T198 = maskReg[5'h16:5'h16];
  assign intrPend_22 = T199;
  assign T199 = R206 ? 1'h1 : T200;
  assign T200 = T204 ? 1'h0 : T201;
  assign T201 = T100 ? T202 : intrPendReg_22;
  assign T770 = reset ? 1'h0 : intrPend_22;
  assign T202 = intrPendReg_22 & T203;
  assign T203 = masterReg_Data[5'h16:5'h16];
  assign T204 = io_memexc_call & T205;
  assign T205 = T105[5'h16:5'h16];
  assign T207 = intrPend_21 & T208;
  assign T208 = T209 == 1'h1;
  assign T209 = maskReg[5'h15:5'h15];
  assign intrPend_21 = T210;
  assign T210 = R217 ? 1'h1 : T211;
  assign T211 = T215 ? 1'h0 : T212;
  assign T212 = T100 ? T213 : intrPendReg_21;
  assign T771 = reset ? 1'h0 : intrPend_21;
  assign T213 = intrPendReg_21 & T214;
  assign T214 = masterReg_Data[5'h15:5'h15];
  assign T215 = io_memexc_call & T216;
  assign T216 = T105[5'h15:5'h15];
  assign T218 = intrPend_20 & T219;
  assign T219 = T220 == 1'h1;
  assign T220 = maskReg[5'h14:5'h14];
  assign intrPend_20 = T221;
  assign T221 = R228 ? 1'h1 : T222;
  assign T222 = T226 ? 1'h0 : T223;
  assign T223 = T100 ? T224 : intrPendReg_20;
  assign T772 = reset ? 1'h0 : intrPend_20;
  assign T224 = intrPendReg_20 & T225;
  assign T225 = masterReg_Data[5'h14:5'h14];
  assign T226 = io_memexc_call & T227;
  assign T227 = T105[5'h14:5'h14];
  assign T229 = intrPend_19 & T230;
  assign T230 = T231 == 1'h1;
  assign T231 = maskReg[5'h13:5'h13];
  assign intrPend_19 = T232;
  assign T232 = R239 ? 1'h1 : T233;
  assign T233 = T237 ? 1'h0 : T234;
  assign T234 = T100 ? T235 : intrPendReg_19;
  assign T773 = reset ? 1'h0 : intrPend_19;
  assign T235 = intrPendReg_19 & T236;
  assign T236 = masterReg_Data[5'h13:5'h13];
  assign T237 = io_memexc_call & T238;
  assign T238 = T105[5'h13:5'h13];
  assign T240 = intrPend_18 & T241;
  assign T241 = T242 == 1'h1;
  assign T242 = maskReg[5'h12:5'h12];
  assign intrPend_18 = T243;
  assign T243 = R250 ? 1'h1 : T244;
  assign T244 = T248 ? 1'h0 : T245;
  assign T245 = T100 ? T246 : intrPendReg_18;
  assign T774 = reset ? 1'h0 : intrPend_18;
  assign T246 = intrPendReg_18 & T247;
  assign T247 = masterReg_Data[5'h12:5'h12];
  assign T248 = io_memexc_call & T249;
  assign T249 = T105[5'h12:5'h12];
  assign T251 = intrPend_17 & T252;
  assign T252 = T253 == 1'h1;
  assign T253 = maskReg[5'h11:5'h11];
  assign intrPend_17 = T254;
  assign T254 = R261 ? 1'h1 : T255;
  assign T255 = T259 ? 1'h0 : T256;
  assign T256 = T100 ? T257 : intrPendReg_17;
  assign T775 = reset ? 1'h0 : intrPend_17;
  assign T257 = intrPendReg_17 & T258;
  assign T258 = masterReg_Data[5'h11:5'h11];
  assign T259 = io_memexc_call & T260;
  assign T260 = T105[5'h11:5'h11];
  assign T262 = intrPend_16 & T263;
  assign T263 = T264 == 1'h1;
  assign T264 = maskReg[5'h10:5'h10];
  assign intrPend_16 = T265;
  assign T265 = R272 ? 1'h1 : T266;
  assign T266 = T270 ? 1'h0 : T267;
  assign T267 = T100 ? T268 : intrPendReg_16;
  assign T776 = reset ? 1'h0 : intrPend_16;
  assign T268 = intrPendReg_16 & T269;
  assign T269 = masterReg_Data[5'h10:5'h10];
  assign T270 = io_memexc_call & T271;
  assign T271 = T105[5'h10:5'h10];
  assign T273 = intrPend_15 & T274;
  assign T274 = T275 == 1'h1;
  assign T275 = maskReg[4'hf:4'hf];
  assign intrPend_15 = T276;
  assign T276 = T280 ? 1'h0 : T277;
  assign T277 = T100 ? T278 : intrPendReg_15;
  assign T777 = reset ? 1'h0 : intrPend_15;
  assign T278 = intrPendReg_15 & T279;
  assign T279 = masterReg_Data[4'hf:4'hf];
  assign T280 = io_memexc_call & T281;
  assign T281 = T105[4'hf:4'hf];
  assign T282 = intrPend_14 & T283;
  assign T283 = T284 == 1'h1;
  assign T284 = maskReg[4'he:4'he];
  assign intrPend_14 = T285;
  assign T285 = T289 ? 1'h0 : T286;
  assign T286 = T100 ? T287 : intrPendReg_14;
  assign T778 = reset ? 1'h0 : intrPend_14;
  assign T287 = intrPendReg_14 & T288;
  assign T288 = masterReg_Data[4'he:4'he];
  assign T289 = io_memexc_call & T290;
  assign T290 = T105[4'he:4'he];
  assign T291 = intrPend_13 & T292;
  assign T292 = T293 == 1'h1;
  assign T293 = maskReg[4'hd:4'hd];
  assign intrPend_13 = T294;
  assign T294 = T298 ? 1'h0 : T295;
  assign T295 = T100 ? T296 : intrPendReg_13;
  assign T779 = reset ? 1'h0 : intrPend_13;
  assign T296 = intrPendReg_13 & T297;
  assign T297 = masterReg_Data[4'hd:4'hd];
  assign T298 = io_memexc_call & T299;
  assign T299 = T105[4'hd:4'hd];
  assign T300 = intrPend_12 & T301;
  assign T301 = T302 == 1'h1;
  assign T302 = maskReg[4'hc:4'hc];
  assign intrPend_12 = T303;
  assign T303 = T307 ? 1'h0 : T304;
  assign T304 = T100 ? T305 : intrPendReg_12;
  assign T780 = reset ? 1'h0 : intrPend_12;
  assign T305 = intrPendReg_12 & T306;
  assign T306 = masterReg_Data[4'hc:4'hc];
  assign T307 = io_memexc_call & T308;
  assign T308 = T105[4'hc:4'hc];
  assign T309 = intrPend_11 & T310;
  assign T310 = T311 == 1'h1;
  assign T311 = maskReg[4'hb:4'hb];
  assign intrPend_11 = T312;
  assign T312 = T316 ? 1'h0 : T313;
  assign T313 = T100 ? T314 : intrPendReg_11;
  assign T781 = reset ? 1'h0 : intrPend_11;
  assign T314 = intrPendReg_11 & T315;
  assign T315 = masterReg_Data[4'hb:4'hb];
  assign T316 = io_memexc_call & T317;
  assign T317 = T105[4'hb:4'hb];
  assign T318 = intrPend_10 & T319;
  assign T319 = T320 == 1'h1;
  assign T320 = maskReg[4'ha:4'ha];
  assign intrPend_10 = T321;
  assign T321 = T325 ? 1'h0 : T322;
  assign T322 = T100 ? T323 : intrPendReg_10;
  assign T782 = reset ? 1'h0 : intrPend_10;
  assign T323 = intrPendReg_10 & T324;
  assign T324 = masterReg_Data[4'ha:4'ha];
  assign T325 = io_memexc_call & T326;
  assign T326 = T105[4'ha:4'ha];
  assign T327 = intrPend_9 & T328;
  assign T328 = T329 == 1'h1;
  assign T329 = maskReg[4'h9:4'h9];
  assign intrPend_9 = T330;
  assign T330 = T334 ? 1'h0 : T331;
  assign T331 = T100 ? T332 : intrPendReg_9;
  assign T783 = reset ? 1'h0 : intrPend_9;
  assign T332 = intrPendReg_9 & T333;
  assign T333 = masterReg_Data[4'h9:4'h9];
  assign T334 = io_memexc_call & T335;
  assign T335 = T105[4'h9:4'h9];
  assign T336 = intrPend_8 & T337;
  assign T337 = T338 == 1'h1;
  assign T338 = maskReg[4'h8:4'h8];
  assign intrPend_8 = T339;
  assign T339 = T343 ? 1'h0 : T340;
  assign T340 = T100 ? T341 : intrPendReg_8;
  assign T784 = reset ? 1'h0 : intrPend_8;
  assign T341 = intrPendReg_8 & T342;
  assign T342 = masterReg_Data[4'h8:4'h8];
  assign T343 = io_memexc_call & T344;
  assign T344 = T105[4'h8:4'h8];
  assign T345 = intrPend_7 & T346;
  assign T346 = T347 == 1'h1;
  assign T347 = maskReg[3'h7:3'h7];
  assign intrPend_7 = T348;
  assign T348 = T352 ? 1'h0 : T349;
  assign T349 = T100 ? T350 : intrPendReg_7;
  assign T785 = reset ? 1'h0 : intrPend_7;
  assign T350 = intrPendReg_7 & T351;
  assign T351 = masterReg_Data[3'h7:3'h7];
  assign T352 = io_memexc_call & T353;
  assign T353 = T105[3'h7:3'h7];
  assign T354 = intrPend_6 & T355;
  assign T355 = T356 == 1'h1;
  assign T356 = maskReg[3'h6:3'h6];
  assign intrPend_6 = T357;
  assign T357 = T361 ? 1'h0 : T358;
  assign T358 = T100 ? T359 : intrPendReg_6;
  assign T786 = reset ? 1'h0 : intrPend_6;
  assign T359 = intrPendReg_6 & T360;
  assign T360 = masterReg_Data[3'h6:3'h6];
  assign T361 = io_memexc_call & T362;
  assign T362 = T105[3'h6:3'h6];
  assign T363 = intrPend_5 & T364;
  assign T364 = T365 == 1'h1;
  assign T365 = maskReg[3'h5:3'h5];
  assign intrPend_5 = T366;
  assign T366 = T370 ? 1'h0 : T367;
  assign T367 = T100 ? T368 : intrPendReg_5;
  assign T787 = reset ? 1'h0 : intrPend_5;
  assign T368 = intrPendReg_5 & T369;
  assign T369 = masterReg_Data[3'h5:3'h5];
  assign T370 = io_memexc_call & T371;
  assign T371 = T105[3'h5:3'h5];
  assign T372 = intrPend_4 & T373;
  assign T373 = T374 == 1'h1;
  assign T374 = maskReg[3'h4:3'h4];
  assign intrPend_4 = T375;
  assign T375 = T379 ? 1'h0 : T376;
  assign T376 = T100 ? T377 : intrPendReg_4;
  assign T788 = reset ? 1'h0 : intrPend_4;
  assign T377 = intrPendReg_4 & T378;
  assign T378 = masterReg_Data[3'h4:3'h4];
  assign T379 = io_memexc_call & T380;
  assign T380 = T105[3'h4:3'h4];
  assign T381 = intrPend_3 & T382;
  assign T382 = T383 == 1'h1;
  assign T383 = maskReg[2'h3:2'h3];
  assign intrPend_3 = T384;
  assign T384 = T388 ? 1'h0 : T385;
  assign T385 = T100 ? T386 : intrPendReg_3;
  assign T789 = reset ? 1'h0 : intrPend_3;
  assign T386 = intrPendReg_3 & T387;
  assign T387 = masterReg_Data[2'h3:2'h3];
  assign T388 = io_memexc_call & T389;
  assign T389 = T105[2'h3:2'h3];
  assign T390 = intrPend_2 & T391;
  assign T391 = T392 == 1'h1;
  assign T392 = maskReg[2'h2:2'h2];
  assign intrPend_2 = T393;
  assign T393 = T397 ? 1'h0 : T394;
  assign T394 = T100 ? T395 : intrPendReg_2;
  assign T790 = reset ? 1'h0 : intrPend_2;
  assign T395 = intrPendReg_2 & T396;
  assign T396 = masterReg_Data[2'h2:2'h2];
  assign T397 = io_memexc_call & T398;
  assign T398 = T105[2'h2:2'h2];
  assign T399 = intrPend_1 & T400;
  assign T400 = T401 == 1'h1;
  assign T401 = maskReg[1'h1:1'h1];
  assign intrPend_1 = T402;
  assign T402 = T406 ? 1'h0 : T403;
  assign T403 = T100 ? T404 : intrPendReg_1;
  assign T791 = reset ? 1'h0 : intrPend_1;
  assign T404 = intrPendReg_1 & T405;
  assign T405 = masterReg_Data[1'h1:1'h1];
  assign T406 = io_memexc_call & T407;
  assign T407 = T105[1'h1:1'h1];
  assign T408 = intrPend_0 & T409;
  assign T409 = T410 == 1'h1;
  assign T410 = maskReg[1'h0:1'h0];
  assign intrPend_0 = T411;
  assign T411 = T415 ? 1'h0 : T412;
  assign T412 = T100 ? T413 : intrPendReg_0;
  assign T792 = reset ? 1'h0 : intrPend_0;
  assign T413 = intrPendReg_0 & T414;
  assign T414 = masterReg_Data[1'h0:1'h0];
  assign T415 = io_memexc_call & T416;
  assign T416 = T105[1'h0:1'h0];
  assign excPend_31 = T417;
  assign T417 = T423 ? 1'h1 : T418;
  assign T418 = T419 ? 1'h0 : excPendReg_31;
  assign T793 = reset ? 1'h0 : excPend_31;
  assign T419 = io_memexc_call & T420;
  assign T420 = T421[5'h1f:5'h1f];
  assign T421 = 1'h1 << T422;
  assign T422 = io_memexc_src;
  assign T423 = io_memexc_exc & T420;
  assign excPend_30 = T424;
  assign T424 = T428 ? 1'h1 : T425;
  assign T425 = T426 ? 1'h0 : excPendReg_30;
  assign T794 = reset ? 1'h0 : excPend_30;
  assign T426 = io_memexc_call & T427;
  assign T427 = T421[5'h1e:5'h1e];
  assign T428 = io_memexc_exc & T427;
  assign excPend_29 = T429;
  assign T429 = T433 ? 1'h1 : T430;
  assign T430 = T431 ? 1'h0 : excPendReg_29;
  assign T795 = reset ? 1'h0 : excPend_29;
  assign T431 = io_memexc_call & T432;
  assign T432 = T421[5'h1d:5'h1d];
  assign T433 = io_memexc_exc & T432;
  assign excPend_28 = T434;
  assign T434 = T438 ? 1'h1 : T435;
  assign T435 = T436 ? 1'h0 : excPendReg_28;
  assign T796 = reset ? 1'h0 : excPend_28;
  assign T436 = io_memexc_call & T437;
  assign T437 = T421[5'h1c:5'h1c];
  assign T438 = io_memexc_exc & T437;
  assign excPend_27 = T439;
  assign T439 = T443 ? 1'h1 : T440;
  assign T440 = T441 ? 1'h0 : excPendReg_27;
  assign T797 = reset ? 1'h0 : excPend_27;
  assign T441 = io_memexc_call & T442;
  assign T442 = T421[5'h1b:5'h1b];
  assign T443 = io_memexc_exc & T442;
  assign excPend_26 = T444;
  assign T444 = T448 ? 1'h1 : T445;
  assign T445 = T446 ? 1'h0 : excPendReg_26;
  assign T798 = reset ? 1'h0 : excPend_26;
  assign T446 = io_memexc_call & T447;
  assign T447 = T421[5'h1a:5'h1a];
  assign T448 = io_memexc_exc & T447;
  assign excPend_25 = T449;
  assign T449 = T453 ? 1'h1 : T450;
  assign T450 = T451 ? 1'h0 : excPendReg_25;
  assign T799 = reset ? 1'h0 : excPend_25;
  assign T451 = io_memexc_call & T452;
  assign T452 = T421[5'h19:5'h19];
  assign T453 = io_memexc_exc & T452;
  assign excPend_24 = T454;
  assign T454 = T458 ? 1'h1 : T455;
  assign T455 = T456 ? 1'h0 : excPendReg_24;
  assign T800 = reset ? 1'h0 : excPend_24;
  assign T456 = io_memexc_call & T457;
  assign T457 = T421[5'h18:5'h18];
  assign T458 = io_memexc_exc & T457;
  assign excPend_23 = T459;
  assign T459 = T463 ? 1'h1 : T460;
  assign T460 = T461 ? 1'h0 : excPendReg_23;
  assign T801 = reset ? 1'h0 : excPend_23;
  assign T461 = io_memexc_call & T462;
  assign T462 = T421[5'h17:5'h17];
  assign T463 = io_memexc_exc & T462;
  assign excPend_22 = T464;
  assign T464 = T468 ? 1'h1 : T465;
  assign T465 = T466 ? 1'h0 : excPendReg_22;
  assign T802 = reset ? 1'h0 : excPend_22;
  assign T466 = io_memexc_call & T467;
  assign T467 = T421[5'h16:5'h16];
  assign T468 = io_memexc_exc & T467;
  assign excPend_21 = T469;
  assign T469 = T473 ? 1'h1 : T470;
  assign T470 = T471 ? 1'h0 : excPendReg_21;
  assign T803 = reset ? 1'h0 : excPend_21;
  assign T471 = io_memexc_call & T472;
  assign T472 = T421[5'h15:5'h15];
  assign T473 = io_memexc_exc & T472;
  assign excPend_20 = T474;
  assign T474 = T478 ? 1'h1 : T475;
  assign T475 = T476 ? 1'h0 : excPendReg_20;
  assign T804 = reset ? 1'h0 : excPend_20;
  assign T476 = io_memexc_call & T477;
  assign T477 = T421[5'h14:5'h14];
  assign T478 = io_memexc_exc & T477;
  assign excPend_19 = T479;
  assign T479 = T483 ? 1'h1 : T480;
  assign T480 = T481 ? 1'h0 : excPendReg_19;
  assign T805 = reset ? 1'h0 : excPend_19;
  assign T481 = io_memexc_call & T482;
  assign T482 = T421[5'h13:5'h13];
  assign T483 = io_memexc_exc & T482;
  assign excPend_18 = T484;
  assign T484 = T488 ? 1'h1 : T485;
  assign T485 = T486 ? 1'h0 : excPendReg_18;
  assign T806 = reset ? 1'h0 : excPend_18;
  assign T486 = io_memexc_call & T487;
  assign T487 = T421[5'h12:5'h12];
  assign T488 = io_memexc_exc & T487;
  assign excPend_17 = T489;
  assign T489 = T493 ? 1'h1 : T490;
  assign T490 = T491 ? 1'h0 : excPendReg_17;
  assign T807 = reset ? 1'h0 : excPend_17;
  assign T491 = io_memexc_call & T492;
  assign T492 = T421[5'h11:5'h11];
  assign T493 = io_memexc_exc & T492;
  assign excPend_16 = T494;
  assign T494 = T498 ? 1'h1 : T495;
  assign T495 = T496 ? 1'h0 : excPendReg_16;
  assign T808 = reset ? 1'h0 : excPend_16;
  assign T496 = io_memexc_call & T497;
  assign T497 = T421[5'h10:5'h10];
  assign T498 = io_memexc_exc & T497;
  assign excPend_15 = T499;
  assign T499 = T503 ? 1'h1 : T500;
  assign T500 = T501 ? 1'h0 : excPendReg_15;
  assign T809 = reset ? 1'h0 : excPend_15;
  assign T501 = io_memexc_call & T502;
  assign T502 = T421[4'hf:4'hf];
  assign T503 = io_memexc_exc & T502;
  assign excPend_14 = T504;
  assign T504 = T508 ? 1'h1 : T505;
  assign T505 = T506 ? 1'h0 : excPendReg_14;
  assign T810 = reset ? 1'h0 : excPend_14;
  assign T506 = io_memexc_call & T507;
  assign T507 = T421[4'he:4'he];
  assign T508 = io_memexc_exc & T507;
  assign excPend_13 = T509;
  assign T509 = T513 ? 1'h1 : T510;
  assign T510 = T511 ? 1'h0 : excPendReg_13;
  assign T811 = reset ? 1'h0 : excPend_13;
  assign T511 = io_memexc_call & T512;
  assign T512 = T421[4'hd:4'hd];
  assign T513 = io_memexc_exc & T512;
  assign excPend_12 = T514;
  assign T514 = T518 ? 1'h1 : T515;
  assign T515 = T516 ? 1'h0 : excPendReg_12;
  assign T812 = reset ? 1'h0 : excPend_12;
  assign T516 = io_memexc_call & T517;
  assign T517 = T421[4'hc:4'hc];
  assign T518 = io_memexc_exc & T517;
  assign excPend_11 = T519;
  assign T519 = T523 ? 1'h1 : T520;
  assign T520 = T521 ? 1'h0 : excPendReg_11;
  assign T813 = reset ? 1'h0 : excPend_11;
  assign T521 = io_memexc_call & T522;
  assign T522 = T421[4'hb:4'hb];
  assign T523 = io_memexc_exc & T522;
  assign excPend_10 = T524;
  assign T524 = T528 ? 1'h1 : T525;
  assign T525 = T526 ? 1'h0 : excPendReg_10;
  assign T814 = reset ? 1'h0 : excPend_10;
  assign T526 = io_memexc_call & T527;
  assign T527 = T421[4'ha:4'ha];
  assign T528 = io_memexc_exc & T527;
  assign excPend_9 = T529;
  assign T529 = T533 ? 1'h1 : T530;
  assign T530 = T531 ? 1'h0 : excPendReg_9;
  assign T815 = reset ? 1'h0 : excPend_9;
  assign T531 = io_memexc_call & T532;
  assign T532 = T421[4'h9:4'h9];
  assign T533 = io_memexc_exc & T532;
  assign excPend_8 = T534;
  assign T534 = T538 ? 1'h1 : T535;
  assign T535 = T536 ? 1'h0 : excPendReg_8;
  assign T816 = reset ? 1'h0 : excPend_8;
  assign T536 = io_memexc_call & T537;
  assign T537 = T421[4'h8:4'h8];
  assign T538 = io_memexc_exc & T537;
  assign excPend_7 = T539;
  assign T539 = T543 ? 1'h1 : T540;
  assign T540 = T541 ? 1'h0 : excPendReg_7;
  assign T817 = reset ? 1'h0 : excPend_7;
  assign T541 = io_memexc_call & T542;
  assign T542 = T421[3'h7:3'h7];
  assign T543 = io_memexc_exc & T542;
  assign excPend_6 = T544;
  assign T544 = T548 ? 1'h1 : T545;
  assign T545 = T546 ? 1'h0 : excPendReg_6;
  assign T818 = reset ? 1'h0 : excPend_6;
  assign T546 = io_memexc_call & T547;
  assign T547 = T421[3'h6:3'h6];
  assign T548 = io_memexc_exc & T547;
  assign excPend_5 = T549;
  assign T549 = T553 ? 1'h1 : T550;
  assign T550 = T551 ? 1'h0 : excPendReg_5;
  assign T819 = reset ? 1'h0 : excPend_5;
  assign T551 = io_memexc_call & T552;
  assign T552 = T421[3'h5:3'h5];
  assign T553 = io_memexc_exc & T552;
  assign excPend_4 = T554;
  assign T554 = T558 ? 1'h1 : T555;
  assign T555 = T556 ? 1'h0 : excPendReg_4;
  assign T820 = reset ? 1'h0 : excPend_4;
  assign T556 = io_memexc_call & T557;
  assign T557 = T421[3'h4:3'h4];
  assign T558 = io_memexc_exc & T557;
  assign excPend_3 = T559;
  assign T559 = T563 ? 1'h1 : T560;
  assign T560 = T561 ? 1'h0 : excPendReg_3;
  assign T821 = reset ? 1'h0 : excPend_3;
  assign T561 = io_memexc_call & T562;
  assign T562 = T421[2'h3:2'h3];
  assign T563 = io_memexc_exc & T562;
  assign excPend_2 = T564;
  assign T564 = T568 ? 1'h1 : T565;
  assign T565 = T566 ? 1'h0 : excPendReg_2;
  assign T822 = reset ? 1'h0 : excPend_2;
  assign T566 = io_memexc_call & T567;
  assign T567 = T421[2'h2:2'h2];
  assign T568 = io_memexc_exc & T567;
  assign excPend_1 = T569;
  assign T569 = T573 ? 1'h1 : T570;
  assign T570 = T571 ? 1'h0 : excPendReg_1;
  assign T823 = reset ? 1'h0 : excPend_1;
  assign T571 = io_memexc_call & T572;
  assign T572 = T421[1'h1:1'h1];
  assign T573 = io_memexc_exc & T572;
  assign excPend_0 = T574;
  assign T574 = T578 ? 1'h1 : T575;
  assign T575 = T576 ? 1'h0 : excPendReg_0;
  assign T824 = reset ? 1'h0 : excPend_0;
  assign T576 = io_memexc_call & T577;
  assign T577 = T421[1'h0:1'h0];
  assign T578 = io_memexc_exc & T577;
  assign io_excdec_addr = T579;
  assign T579 = vecDup[srcReg];
  assign T581 = masterReg_Data;
  assign T582 = T583 & superMode;
  assign T583 = T11 & T584;
  assign T584 = T585 == 1'h1;
  assign T585 = masterReg_Addr[3'h7:3'h7];
  assign T586 = masterReg_Addr[3'h6:2'h2];
  assign io_excdec_intr = T587;
  assign T587 = intr & intrEna;
  assign intrEna = T588 == 1'h1;
  assign T588 = statusReg[1'h0:1'h0];
  assign T589 = T590 != 32'h0;
  assign T590 = T591 & maskReg;
  assign T591 = T592;
  assign T592 = {T608, T593};
  assign T593 = {T601, T594};
  assign T594 = {T598, T595};
  assign T595 = {T597, T596};
  assign T596 = {intrPend_1, intrPend_0};
  assign T597 = {intrPend_3, intrPend_2};
  assign T598 = {T600, T599};
  assign T599 = {intrPend_5, intrPend_4};
  assign T600 = {intrPend_7, intrPend_6};
  assign T601 = {T605, T602};
  assign T602 = {T604, T603};
  assign T603 = {intrPend_9, intrPend_8};
  assign T604 = {intrPend_11, intrPend_10};
  assign T605 = {T607, T606};
  assign T606 = {intrPend_13, intrPend_12};
  assign T607 = {intrPend_15, intrPend_14};
  assign T608 = {T616, T609};
  assign T609 = {T613, T610};
  assign T610 = {T612, T611};
  assign T611 = {intrPend_17, intrPend_16};
  assign T612 = {intrPend_19, intrPend_18};
  assign T613 = {T615, T614};
  assign T614 = {intrPend_21, intrPend_20};
  assign T615 = {intrPend_23, intrPend_22};
  assign T616 = {T620, T617};
  assign T617 = {T619, T618};
  assign T618 = {intrPend_25, intrPend_24};
  assign T619 = {intrPend_27, intrPend_26};
  assign T620 = {T622, T621};
  assign T621 = {intrPend_29, intrPend_28};
  assign T622 = {intrPend_31, intrPend_30};
  assign io_excdec_excAddr = excAddrReg;
  assign T623 = io_memexc_exc ? io_memexc_excAddr : excAddrReg;
  assign io_excdec_excBase = excBaseReg;
  assign T624 = io_memexc_exc ? io_memexc_excBase : excBaseReg;
  assign io_excdec_exc = exc;
  assign T625 = T626 != 32'h0;
  assign T626 = T627;
  assign T627 = {T643, T628};
  assign T628 = {T636, T629};
  assign T629 = {T633, T630};
  assign T630 = {T632, T631};
  assign T631 = {excPend_1, excPend_0};
  assign T632 = {excPend_3, excPend_2};
  assign T633 = {T635, T634};
  assign T634 = {excPend_5, excPend_4};
  assign T635 = {excPend_7, excPend_6};
  assign T636 = {T640, T637};
  assign T637 = {T639, T638};
  assign T638 = {excPend_9, excPend_8};
  assign T639 = {excPend_11, excPend_10};
  assign T640 = {T642, T641};
  assign T641 = {excPend_13, excPend_12};
  assign T642 = {excPend_15, excPend_14};
  assign T643 = {T651, T644};
  assign T644 = {T648, T645};
  assign T645 = {T647, T646};
  assign T646 = {excPend_17, excPend_16};
  assign T647 = {excPend_19, excPend_18};
  assign T648 = {T650, T649};
  assign T649 = {excPend_21, excPend_20};
  assign T650 = {excPend_23, excPend_22};
  assign T651 = {T655, T652};
  assign T652 = {T654, T653};
  assign T653 = {excPend_25, excPend_24};
  assign T654 = {excPend_27, excPend_26};
  assign T655 = {T657, T656};
  assign T656 = {excPend_29, excPend_28};
  assign T657 = {excPend_31, excPend_30};
  assign io_ocp_S_Data = T658;
  assign T658 = T719 ? T714 : T659;
  assign T659 = T712 ? T711 : T660;
  assign T660 = T709 ? T677 : T661;
  assign T661 = T675 ? sourceReg : T662;
  assign T662 = T668 ? maskReg : T663;
  assign T663 = T664 ? statusReg : 32'h0;
  assign T664 = T667 & T665;
  assign T665 = 6'h0 == T666;
  assign T666 = masterReg_Addr[3'h7:2'h2];
  assign T667 = masterReg_Cmd == 3'h2;
  assign T668 = T667 & T669;
  assign T669 = 6'h1 == T666;
  assign T670 = T14 ? T825 : T671;
  assign T671 = T672 ? masterReg_Data : sourceReg;
  assign T672 = T673 & superMode;
  assign T673 = T11 & T674;
  assign T674 = 6'h3 == T10;
  assign T825 = {27'h0, io_memexc_src};
  assign T675 = T667 & T676;
  assign T676 = 6'h3 == T666;
  assign T677 = T678;
  assign T678 = {T694, T679};
  assign T679 = {T687, T680};
  assign T680 = {T684, T681};
  assign T681 = {T683, T682};
  assign T682 = {intrPendReg_1, intrPendReg_0};
  assign T683 = {intrPendReg_3, intrPendReg_2};
  assign T684 = {T686, T685};
  assign T685 = {intrPendReg_5, intrPendReg_4};
  assign T686 = {intrPendReg_7, intrPendReg_6};
  assign T687 = {T691, T688};
  assign T688 = {T690, T689};
  assign T689 = {intrPendReg_9, intrPendReg_8};
  assign T690 = {intrPendReg_11, intrPendReg_10};
  assign T691 = {T693, T692};
  assign T692 = {intrPendReg_13, intrPendReg_12};
  assign T693 = {intrPendReg_15, intrPendReg_14};
  assign T694 = {T702, T695};
  assign T695 = {T699, T696};
  assign T696 = {T698, T697};
  assign T697 = {intrPendReg_17, intrPendReg_16};
  assign T698 = {intrPendReg_19, intrPendReg_18};
  assign T699 = {T701, T700};
  assign T700 = {intrPendReg_21, intrPendReg_20};
  assign T701 = {intrPendReg_23, intrPendReg_22};
  assign T702 = {T706, T703};
  assign T703 = {T705, T704};
  assign T704 = {intrPendReg_25, intrPendReg_24};
  assign T705 = {intrPendReg_27, intrPendReg_26};
  assign T706 = {T708, T707};
  assign T707 = {intrPendReg_29, intrPendReg_28};
  assign T708 = {intrPendReg_31, intrPendReg_30};
  assign T709 = T667 & T710;
  assign T710 = 6'h2 == T666;
  assign T711 = {localModeReg, 31'h0};
  assign T712 = T667 & T713;
  assign T713 = 6'h5 == T666;
  assign T714 = vec[T718];
  assign T716 = masterReg_Data;
  assign T717 = masterReg_Addr[3'h6:2'h2];
  assign T718 = masterReg_Addr[3'h6:2'h2];
  assign T719 = T667 & T720;
  assign T720 = T721 == 1'h1;
  assign T721 = masterReg_Addr[3'h7:3'h7];
  assign io_ocp_S_Resp = T722;
  assign T722 = T750 ? 2'h1 : T723;
  assign T723 = T748 ? 2'h3 : T724;
  assign T724 = T746 ? 2'h3 : T725;
  assign T725 = T744 ? 2'h3 : T726;
  assign T726 = T741 ? 2'h0 : T727;
  assign T727 = T739 ? 2'h3 : T728;
  assign T728 = T737 ? 2'h3 : T729;
  assign T729 = T735 ? 2'h3 : T730;
  assign T730 = T733 ? 2'h3 : T731;
  assign T731 = T11 ? 2'h1 : T732;
  assign T732 = T667 ? 2'h1 : 2'h0;
  assign T733 = T8 & T734;
  assign T734 = superMode ^ 1'h1;
  assign T735 = T93 & T736;
  assign T736 = superMode ^ 1'h1;
  assign T737 = T673 & T738;
  assign T738 = superMode ^ 1'h1;
  assign T739 = T101 & T740;
  assign T740 = superMode ^ 1'h1;
  assign T741 = T742 & superMode;
  assign T742 = T11 & T743;
  assign T743 = 6'h4 == T10;
  assign T744 = T742 & T745;
  assign T745 = superMode ^ 1'h1;
  assign T746 = T17 & T747;
  assign T747 = superMode ^ 1'h1;
  assign T748 = T583 & T749;
  assign T749 = superMode ^ 1'h1;
  assign T750 = sleepReg & T751;
  assign T751 = T753 | T752;
  assign T752 = intr & intrEna;
  assign T753 = exc == 1'h1;
  assign T826 = reset ? 1'h0 : T754;
  assign T754 = T750 ? 1'h0 : T755;
  assign T755 = T741 ? 1'h1 : sleepReg;

  always @(posedge clk) begin
    masterReg_Data <= io_ocp_M_Data;
    statusReg <= T756;
    masterReg_Addr <= io_ocp_M_Addr;
    masterReg_Cmd <= io_ocp_M_Cmd;
    if(reset) begin
      localModeReg <= 1'h0;
    end else if(T2) begin
      localModeReg <= T22;
    end
    srcReg <= src;
    if(T92) begin
      maskReg <= masterReg_Data;
    end
    if(reset) begin
      intrPendReg_31 <= 1'h0;
    end else begin
      intrPendReg_31 <= intrPend_31;
    end
    R107 <= io_intrs_15;
    if(reset) begin
      intrPendReg_30 <= 1'h0;
    end else begin
      intrPendReg_30 <= intrPend_30;
    end
    R118 <= io_intrs_14;
    if(reset) begin
      intrPendReg_29 <= 1'h0;
    end else begin
      intrPendReg_29 <= intrPend_29;
    end
    R129 <= io_intrs_13;
    if(reset) begin
      intrPendReg_28 <= 1'h0;
    end else begin
      intrPendReg_28 <= intrPend_28;
    end
    R140 <= io_intrs_12;
    if(reset) begin
      intrPendReg_27 <= 1'h0;
    end else begin
      intrPendReg_27 <= intrPend_27;
    end
    R151 <= io_intrs_11;
    if(reset) begin
      intrPendReg_26 <= 1'h0;
    end else begin
      intrPendReg_26 <= intrPend_26;
    end
    R162 <= io_intrs_10;
    if(reset) begin
      intrPendReg_25 <= 1'h0;
    end else begin
      intrPendReg_25 <= intrPend_25;
    end
    R173 <= io_intrs_9;
    if(reset) begin
      intrPendReg_24 <= 1'h0;
    end else begin
      intrPendReg_24 <= intrPend_24;
    end
    R184 <= io_intrs_8;
    if(reset) begin
      intrPendReg_23 <= 1'h0;
    end else begin
      intrPendReg_23 <= intrPend_23;
    end
    R195 <= io_intrs_7;
    if(reset) begin
      intrPendReg_22 <= 1'h0;
    end else begin
      intrPendReg_22 <= intrPend_22;
    end
    R206 <= io_intrs_6;
    if(reset) begin
      intrPendReg_21 <= 1'h0;
    end else begin
      intrPendReg_21 <= intrPend_21;
    end
    R217 <= io_intrs_5;
    if(reset) begin
      intrPendReg_20 <= 1'h0;
    end else begin
      intrPendReg_20 <= intrPend_20;
    end
    R228 <= io_intrs_4;
    if(reset) begin
      intrPendReg_19 <= 1'h0;
    end else begin
      intrPendReg_19 <= intrPend_19;
    end
    R239 <= io_intrs_3;
    if(reset) begin
      intrPendReg_18 <= 1'h0;
    end else begin
      intrPendReg_18 <= intrPend_18;
    end
    R250 <= io_intrs_2;
    if(reset) begin
      intrPendReg_17 <= 1'h0;
    end else begin
      intrPendReg_17 <= intrPend_17;
    end
    R261 <= io_intrs_1;
    if(reset) begin
      intrPendReg_16 <= 1'h0;
    end else begin
      intrPendReg_16 <= intrPend_16;
    end
    R272 <= io_intrs_0;
    if(reset) begin
      intrPendReg_15 <= 1'h0;
    end else begin
      intrPendReg_15 <= intrPend_15;
    end
    if(reset) begin
      intrPendReg_14 <= 1'h0;
    end else begin
      intrPendReg_14 <= intrPend_14;
    end
    if(reset) begin
      intrPendReg_13 <= 1'h0;
    end else begin
      intrPendReg_13 <= intrPend_13;
    end
    if(reset) begin
      intrPendReg_12 <= 1'h0;
    end else begin
      intrPendReg_12 <= intrPend_12;
    end
    if(reset) begin
      intrPendReg_11 <= 1'h0;
    end else begin
      intrPendReg_11 <= intrPend_11;
    end
    if(reset) begin
      intrPendReg_10 <= 1'h0;
    end else begin
      intrPendReg_10 <= intrPend_10;
    end
    if(reset) begin
      intrPendReg_9 <= 1'h0;
    end else begin
      intrPendReg_9 <= intrPend_9;
    end
    if(reset) begin
      intrPendReg_8 <= 1'h0;
    end else begin
      intrPendReg_8 <= intrPend_8;
    end
    if(reset) begin
      intrPendReg_7 <= 1'h0;
    end else begin
      intrPendReg_7 <= intrPend_7;
    end
    if(reset) begin
      intrPendReg_6 <= 1'h0;
    end else begin
      intrPendReg_6 <= intrPend_6;
    end
    if(reset) begin
      intrPendReg_5 <= 1'h0;
    end else begin
      intrPendReg_5 <= intrPend_5;
    end
    if(reset) begin
      intrPendReg_4 <= 1'h0;
    end else begin
      intrPendReg_4 <= intrPend_4;
    end
    if(reset) begin
      intrPendReg_3 <= 1'h0;
    end else begin
      intrPendReg_3 <= intrPend_3;
    end
    if(reset) begin
      intrPendReg_2 <= 1'h0;
    end else begin
      intrPendReg_2 <= intrPend_2;
    end
    if(reset) begin
      intrPendReg_1 <= 1'h0;
    end else begin
      intrPendReg_1 <= intrPend_1;
    end
    if(reset) begin
      intrPendReg_0 <= 1'h0;
    end else begin
      intrPendReg_0 <= intrPend_0;
    end
    if(reset) begin
      excPendReg_31 <= 1'h0;
    end else begin
      excPendReg_31 <= excPend_31;
    end
    if(reset) begin
      excPendReg_30 <= 1'h0;
    end else begin
      excPendReg_30 <= excPend_30;
    end
    if(reset) begin
      excPendReg_29 <= 1'h0;
    end else begin
      excPendReg_29 <= excPend_29;
    end
    if(reset) begin
      excPendReg_28 <= 1'h0;
    end else begin
      excPendReg_28 <= excPend_28;
    end
    if(reset) begin
      excPendReg_27 <= 1'h0;
    end else begin
      excPendReg_27 <= excPend_27;
    end
    if(reset) begin
      excPendReg_26 <= 1'h0;
    end else begin
      excPendReg_26 <= excPend_26;
    end
    if(reset) begin
      excPendReg_25 <= 1'h0;
    end else begin
      excPendReg_25 <= excPend_25;
    end
    if(reset) begin
      excPendReg_24 <= 1'h0;
    end else begin
      excPendReg_24 <= excPend_24;
    end
    if(reset) begin
      excPendReg_23 <= 1'h0;
    end else begin
      excPendReg_23 <= excPend_23;
    end
    if(reset) begin
      excPendReg_22 <= 1'h0;
    end else begin
      excPendReg_22 <= excPend_22;
    end
    if(reset) begin
      excPendReg_21 <= 1'h0;
    end else begin
      excPendReg_21 <= excPend_21;
    end
    if(reset) begin
      excPendReg_20 <= 1'h0;
    end else begin
      excPendReg_20 <= excPend_20;
    end
    if(reset) begin
      excPendReg_19 <= 1'h0;
    end else begin
      excPendReg_19 <= excPend_19;
    end
    if(reset) begin
      excPendReg_18 <= 1'h0;
    end else begin
      excPendReg_18 <= excPend_18;
    end
    if(reset) begin
      excPendReg_17 <= 1'h0;
    end else begin
      excPendReg_17 <= excPend_17;
    end
    if(reset) begin
      excPendReg_16 <= 1'h0;
    end else begin
      excPendReg_16 <= excPend_16;
    end
    if(reset) begin
      excPendReg_15 <= 1'h0;
    end else begin
      excPendReg_15 <= excPend_15;
    end
    if(reset) begin
      excPendReg_14 <= 1'h0;
    end else begin
      excPendReg_14 <= excPend_14;
    end
    if(reset) begin
      excPendReg_13 <= 1'h0;
    end else begin
      excPendReg_13 <= excPend_13;
    end
    if(reset) begin
      excPendReg_12 <= 1'h0;
    end else begin
      excPendReg_12 <= excPend_12;
    end
    if(reset) begin
      excPendReg_11 <= 1'h0;
    end else begin
      excPendReg_11 <= excPend_11;
    end
    if(reset) begin
      excPendReg_10 <= 1'h0;
    end else begin
      excPendReg_10 <= excPend_10;
    end
    if(reset) begin
      excPendReg_9 <= 1'h0;
    end else begin
      excPendReg_9 <= excPend_9;
    end
    if(reset) begin
      excPendReg_8 <= 1'h0;
    end else begin
      excPendReg_8 <= excPend_8;
    end
    if(reset) begin
      excPendReg_7 <= 1'h0;
    end else begin
      excPendReg_7 <= excPend_7;
    end
    if(reset) begin
      excPendReg_6 <= 1'h0;
    end else begin
      excPendReg_6 <= excPend_6;
    end
    if(reset) begin
      excPendReg_5 <= 1'h0;
    end else begin
      excPendReg_5 <= excPend_5;
    end
    if(reset) begin
      excPendReg_4 <= 1'h0;
    end else begin
      excPendReg_4 <= excPend_4;
    end
    if(reset) begin
      excPendReg_3 <= 1'h0;
    end else begin
      excPendReg_3 <= excPend_3;
    end
    if(reset) begin
      excPendReg_2 <= 1'h0;
    end else begin
      excPendReg_2 <= excPend_2;
    end
    if(reset) begin
      excPendReg_1 <= 1'h0;
    end else begin
      excPendReg_1 <= excPend_1;
    end
    if(reset) begin
      excPendReg_0 <= 1'h0;
    end else begin
      excPendReg_0 <= excPend_0;
    end
    if (T582)
      vecDup[T586] <= T581;
    intr <= T589;
    if(io_memexc_exc) begin
      excAddrReg <= io_memexc_excAddr;
    end
    if(io_memexc_exc) begin
      excBaseReg <= io_memexc_excBase;
    end
    exc <= T625;
    if(T14) begin
      sourceReg <= T825;
    end else if(T672) begin
      sourceReg <= masterReg_Data;
    end
    if (T582)
      vec[T717] <= T716;
    if(reset) begin
      sleepReg <= 1'h0;
    end else if(T750) begin
      sleepReg <= 1'h0;
    end else if(T741) begin
      sleepReg <= 1'h1;
    end
  end
endmodule

module MemBlock_2(input clk,
    input [8:0] io_rdAddr,
    output[7:0] io_rdData,
    input [8:0] io_wrAddr,
    input  io_wrEna,
    input [7:0] io_wrData
);

  wire[7:0] T0;
  reg [7:0] mem [511:0];
  wire[7:0] T1;
  wire T2;
  reg [8:0] rdAddrReg;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    for (initvar = 0; initvar < 512; initvar = initvar+1)
      mem[initvar] = {1{$random}};
    rdAddrReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_rdData = T0;
  assign T0 = mem[rdAddrReg];
  assign T2 = io_wrEna == 1'h1;

  always @(posedge clk) begin
    if (T2)
      mem[io_wrAddr] <= io_wrData;
    rdAddrReg <= io_rdAddr;
  end
endmodule

module Spm(input clk,
    input [2:0] io_M_Cmd,
    input [10:0] io_M_Addr,
    input [31:0] io_M_Data,
    input [3:0] io_M_ByteEn,
    output[1:0] io_S_Resp,
    output[31:0] io_S_Data
);

  wire[7:0] T0;
  wire T1;
  wire[3:0] T2;
  wire T3;
  wire[8:0] T4;
  wire[8:0] T5;
  wire[7:0] T6;
  wire T7;
  wire[8:0] T8;
  wire[8:0] T9;
  wire[7:0] T10;
  wire T11;
  wire[8:0] T12;
  wire[8:0] T13;
  wire[7:0] T14;
  wire T15;
  wire[8:0] T16;
  wire[8:0] T17;
  wire[31:0] T18;
  wire[23:0] T19;
  wire[15:0] T20;
  wire[1:0] T21;
  wire T22;
  wire T23;
  reg [2:0] cmdReg;
  wire T24;
  wire[7:0] MemBlock_io_rdData;
  wire[7:0] MemBlock_1_io_rdData;
  wire[7:0] MemBlock_2_io_rdData;
  wire[7:0] MemBlock_3_io_rdData;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    cmdReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = io_M_Data[5'h1f:5'h18];
  assign T1 = T2[2'h3:2'h3];
  assign T2 = T3 ? io_M_ByteEn : 4'h0;
  assign T3 = io_M_Cmd == 3'h1;
  assign T4 = io_M_Addr[4'ha:2'h2];
  assign T5 = io_M_Addr[4'ha:2'h2];
  assign T6 = io_M_Data[5'h17:5'h10];
  assign T7 = T2[2'h2:2'h2];
  assign T8 = io_M_Addr[4'ha:2'h2];
  assign T9 = io_M_Addr[4'ha:2'h2];
  assign T10 = io_M_Data[4'hf:4'h8];
  assign T11 = T2[1'h1:1'h1];
  assign T12 = io_M_Addr[4'ha:2'h2];
  assign T13 = io_M_Addr[4'ha:2'h2];
  assign T14 = io_M_Data[3'h7:1'h0];
  assign T15 = T2[1'h0:1'h0];
  assign T16 = io_M_Addr[4'ha:2'h2];
  assign T17 = io_M_Addr[4'ha:2'h2];
  assign io_S_Data = T18;
  assign T18 = {MemBlock_3_io_rdData, T19};
  assign T19 = {MemBlock_2_io_rdData, T20};
  assign T20 = {MemBlock_1_io_rdData, MemBlock_io_rdData};
  assign io_S_Resp = T21;
  assign T21 = T22 ? 2'h1 : 2'h0;
  assign T22 = T24 | T23;
  assign T23 = cmdReg == 3'h2;
  assign T24 = cmdReg == 3'h1;
  MemBlock_2 MemBlock(.clk(clk),
       .io_rdAddr( T17 ),
       .io_rdData( MemBlock_io_rdData ),
       .io_wrAddr( T16 ),
       .io_wrEna( T15 ),
       .io_wrData( T14 )
  );
  MemBlock_2 MemBlock_1(.clk(clk),
       .io_rdAddr( T13 ),
       .io_rdData( MemBlock_1_io_rdData ),
       .io_wrAddr( T12 ),
       .io_wrEna( T11 ),
       .io_wrData( T10 )
  );
  MemBlock_2 MemBlock_2(.clk(clk),
       .io_rdAddr( T9 ),
       .io_rdData( MemBlock_2_io_rdData ),
       .io_wrAddr( T8 ),
       .io_wrEna( T7 ),
       .io_wrData( T6 )
  );
  MemBlock_2 MemBlock_3(.clk(clk),
       .io_rdAddr( T5 ),
       .io_rdData( MemBlock_3_io_rdData ),
       .io_wrAddr( T4 ),
       .io_wrEna( T1 ),
       .io_wrData( T0 )
  );

  always @(posedge clk) begin
    cmdReg <= io_M_Cmd;
  end
endmodule

module OcpCoreBus(
    input [2:0] io_slave_M_Cmd,
    input [31:0] io_slave_M_Addr,
    input [31:0] io_slave_M_Data,
    input [3:0] io_slave_M_ByteEn,
    output[1:0] io_slave_S_Resp,
    output[31:0] io_slave_S_Data,
    output[2:0] io_master_M_Cmd,
    output[31:0] io_master_M_Addr,
    output[31:0] io_master_M_Data,
    output[3:0] io_master_M_ByteEn,
    input [1:0] io_master_S_Resp,
    input [31:0] io_master_S_Data
);



  assign io_master_M_ByteEn = io_slave_M_ByteEn;
  assign io_master_M_Data = io_slave_M_Data;
  assign io_master_M_Addr = io_slave_M_Addr;
  assign io_master_M_Cmd = io_slave_M_Cmd;
  assign io_slave_S_Data = io_master_S_Data;
  assign io_slave_S_Resp = io_master_S_Resp;
endmodule

module OcpIOBus(
    input [2:0] io_slave_M_Cmd,
    input [31:0] io_slave_M_Addr,
    input [31:0] io_slave_M_Data,
    input [3:0] io_slave_M_ByteEn,
    input  io_slave_M_RespAccept,
    output[1:0] io_slave_S_Resp,
    output[31:0] io_slave_S_Data,
    output io_slave_S_CmdAccept,
    output[2:0] io_master_M_Cmd,
    output[31:0] io_master_M_Addr,
    output[31:0] io_master_M_Data,
    output[3:0] io_master_M_ByteEn,
    output io_master_M_RespAccept,
    input [1:0] io_master_S_Resp,
    input [31:0] io_master_S_Data,
    input  io_master_S_CmdAccept
);



  assign io_master_M_RespAccept = io_slave_M_RespAccept;
  assign io_master_M_ByteEn = io_slave_M_ByteEn;
  assign io_master_M_Data = io_slave_M_Data;
  assign io_master_M_Addr = io_slave_M_Addr;
  assign io_master_M_Cmd = io_slave_M_Cmd;
  assign io_slave_S_CmdAccept = io_master_S_CmdAccept;
  assign io_slave_S_Data = io_master_S_Data;
  assign io_slave_S_Resp = io_master_S_Resp;
endmodule

module Queue(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input [7:0] io_enq_bits,
    input  io_deq_ready,
    output io_deq_valid,
    output[7:0] io_deq_bits,
    output[4:0] io_count
);

  wire[4:0] T0;
  wire[3:0] ptr_diff;
  reg [3:0] R1;
  wire[3:0] T15;
  wire[3:0] T2;
  wire[3:0] T3;
  wire do_deq;
  reg [3:0] R4;
  wire[3:0] T16;
  wire[3:0] T5;
  wire[3:0] T6;
  wire do_enq;
  wire T7;
  wire ptr_match;
  reg  maybe_full;
  wire T17;
  wire T8;
  wire T9;
  wire[7:0] T10;
  reg [7:0] ram [15:0];
  wire[7:0] T11;
  wire T12;
  wire empty;
  wire T13;
  wire T14;
  wire full;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    R1 = {1{$random}};
    R4 = {1{$random}};
    maybe_full = {1{$random}};
    for (initvar = 0; initvar < 16; initvar = initvar+1)
      ram[initvar] = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_count = T0;
  assign T0 = {T7, ptr_diff};
  assign ptr_diff = R4 - R1;
  assign T15 = reset ? 4'h0 : T2;
  assign T2 = do_deq ? T3 : R1;
  assign T3 = R1 + 4'h1;
  assign do_deq = io_deq_ready & io_deq_valid;
  assign T16 = reset ? 4'h0 : T5;
  assign T5 = do_enq ? T6 : R4;
  assign T6 = R4 + 4'h1;
  assign do_enq = io_enq_ready & io_enq_valid;
  assign T7 = maybe_full & ptr_match;
  assign ptr_match = R4 == R1;
  assign T17 = reset ? 1'h0 : T8;
  assign T8 = T9 ? do_enq : maybe_full;
  assign T9 = do_enq != do_deq;
  assign io_deq_bits = T10;
  assign T10 = ram[R1];
  assign io_deq_valid = T12;
  assign T12 = empty ^ 1'h1;
  assign empty = ptr_match & T13;
  assign T13 = maybe_full ^ 1'h1;
  assign io_enq_ready = T14;
  assign T14 = full ^ 1'h1;
  assign full = ptr_match & maybe_full;

  always @(posedge clk) begin
    if(reset) begin
      R1 <= 4'h0;
    end else if(do_deq) begin
      R1 <= T3;
    end
    if(reset) begin
      R4 <= 4'h0;
    end else if(do_enq) begin
      R4 <= T6;
    end
    if(reset) begin
      maybe_full <= 1'h0;
    end else if(T9) begin
      maybe_full <= do_enq;
    end
    if (do_enq)
      ram[R4] <= io_enq_bits;
  end
endmodule

module Uart(input clk, input reset,
    input  io_superMode,
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input [3:0] io_ocp_M_ByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    output io_uartPins_tx,
    input  io_uartPins_rx
);

  wire T0;
  wire T1;
  wire T2;
  wire T3;
  wire[7:0] T4;
  reg [7:0] rx_buff;
  wire[7:0] T103;
  wire[7:0] T5;
  wire[7:0] T6;
  wire[6:0] T7;
  reg  rxd_reg2;
  wire T104;
  reg  rxd_reg1;
  wire T105;
  reg  rxd_reg0;
  wire T106;
  wire T8;
  wire T9;
  reg  rx_baud_tick;
  wire T107;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  reg [8:0] rx_baud_counter;
  wire[8:0] T108;
  wire[8:0] T14;
  wire[8:0] T15;
  wire[8:0] T16;
  wire[8:0] T17;
  wire[8:0] T18;
  wire T19;
  wire T20;
  wire T21;
  reg [1:0] rx_state;
  wire[1:0] T109;
  wire[1:0] T22;
  wire[1:0] T23;
  wire[1:0] T24;
  wire[1:0] T25;
  wire[1:0] T26;
  wire[1:0] T27;
  wire T28;
  wire T29;
  wire T30;
  wire T31;
  wire T32;
  wire T33;
  wire T34;
  wire[1:0] T35;
  wire T36;
  reg [2:0] rx_counter;
  wire[2:0] T110;
  wire[2:0] T37;
  wire[2:0] T38;
  wire[2:0] T39;
  wire T40;
  wire T41;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  reg  rx_enable;
  wire T111;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire T52;
  wire T53;
  wire T54;
  wire T55;
  wire T56;
  reg  tx_state;
  wire T112;
  wire T57;
  wire T58;
  wire T59;
  wire T60;
  wire T61;
  wire T62;
  reg [3:0] tx_counter;
  wire[3:0] T113;
  wire[3:0] T63;
  wire[3:0] T64;
  wire[3:0] T65;
  wire[3:0] T66;
  wire[3:0] T67;
  wire T68;
  wire T69;
  wire T70;
  reg  tx_baud_tick;
  wire T114;
  wire T71;
  wire T72;
  wire T73;
  reg [8:0] tx_baud_counter;
  wire[8:0] T115;
  wire[8:0] T74;
  wire[8:0] T75;
  wire[8:0] T76;
  wire T77;
  wire T78;
  wire T79;
  wire[7:0] T80;
  wire[7:0] T81;
  wire[7:0] T82;
  wire T83;
  reg  tx_reg;
  wire T116;
  wire T84;
  wire T85;
  wire T86;
  wire T87;
  reg [9:0] tx_buff;
  wire[9:0] T117;
  wire[9:0] T88;
  wire[9:0] T89;
  wire[9:0] T90;
  wire[9:0] T91;
  wire[8:0] T92;
  wire[9:0] T93;
  wire[8:0] T94;
  wire[9:0] T118;
  wire[8:0] T95;
  wire[31:0] T119;
  reg [7:0] rdDataReg;
  wire[7:0] T120;
  wire[7:0] T96;
  wire[7:0] T97;
  wire[1:0] T98;
  wire T99;
  wire T100;
  reg [1:0] respReg;
  wire[1:0] T121;
  wire[1:0] T101;
  wire[1:0] T102;
  wire txQueue_io_enq_ready;
  wire txQueue_io_deq_valid;
  wire[7:0] txQueue_io_deq_bits;
  wire rxQueue_io_deq_valid;
  wire[7:0] rxQueue_io_deq_bits;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    rx_buff = {1{$random}};
    rxd_reg2 = {1{$random}};
    rxd_reg1 = {1{$random}};
    rxd_reg0 = {1{$random}};
    rx_baud_tick = {1{$random}};
    rx_baud_counter = {1{$random}};
    rx_state = {1{$random}};
    rx_counter = {1{$random}};
    rx_enable = {1{$random}};
    tx_state = {1{$random}};
    tx_counter = {1{$random}};
    tx_baud_tick = {1{$random}};
    tx_baud_counter = {1{$random}};
    tx_reg = {1{$random}};
    tx_buff = {1{$random}};
    rdDataReg = {1{$random}};
    respReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = T3 ? T1 : 1'h0;
  assign T1 = T2 != 1'h0;
  assign T2 = io_ocp_M_Addr[2'h2:2'h2];
  assign T3 = io_ocp_M_Cmd == 3'h2;
  assign T4 = T53 ? rx_buff : rx_buff;
  assign T103 = reset ? 8'h0 : T5;
  assign T5 = T8 ? T6 : rx_buff;
  assign T6 = {rxd_reg2, T7};
  assign T7 = rx_buff[3'h7:1'h1];
  assign T104 = reset ? 1'h1 : rxd_reg1;
  assign T105 = reset ? 1'h1 : rxd_reg0;
  assign T106 = reset ? 1'h1 : io_uartPins_rx;
  assign T8 = T52 & T9;
  assign T9 = rx_baud_tick == 1'h1;
  assign T107 = reset ? 1'h0 : T10;
  assign T10 = T50 ? 1'h0 : T11;
  assign T11 = T12 ? 1'h1 : rx_baud_tick;
  assign T12 = rx_enable & T13;
  assign T13 = rx_baud_counter == 9'h1b2;
  assign T108 = reset ? 9'h0 : T14;
  assign T14 = T19 ? T18 : T15;
  assign T15 = T50 ? T17 : T16;
  assign T16 = T12 ? 9'h0 : rx_baud_counter;
  assign T17 = rx_baud_counter + 9'h1;
  assign T18 = 9'h1b2 / 2'h2;
  assign T19 = T21 & T20;
  assign T20 = rxd_reg2 == 1'h0;
  assign T21 = rx_state == 2'h0;
  assign T109 = reset ? 2'h0 : T22;
  assign T22 = T41 ? 2'h0 : T23;
  assign T23 = T53 ? 2'h0 : T24;
  assign T24 = T8 ? T35 : T25;
  assign T25 = T33 ? 2'h0 : T26;
  assign T26 = T28 ? 2'h2 : T27;
  assign T27 = T19 ? 2'h1 : rx_state;
  assign T28 = T30 & T29;
  assign T29 = rxd_reg2 == 1'h0;
  assign T30 = T32 & T31;
  assign T31 = rx_baud_tick == 1'h1;
  assign T32 = rx_state == 2'h1;
  assign T33 = T30 & T34;
  assign T34 = T29 ^ 1'h1;
  assign T35 = T36 ? 2'h3 : 2'h2;
  assign T36 = rx_counter == 3'h7;
  assign T110 = reset ? 3'h0 : T37;
  assign T37 = T8 ? T38 : rx_counter;
  assign T38 = T40 ? 3'h0 : T39;
  assign T39 = rx_counter + 3'h1;
  assign T40 = rx_counter == 3'h7;
  assign T41 = T44 & T42;
  assign T42 = T43 ^ 1'h1;
  assign T43 = rxd_reg2 == 1'h1;
  assign T44 = T46 & T45;
  assign T45 = rx_baud_tick == 1'h1;
  assign T46 = rx_state == 2'h3;
  assign T111 = reset ? 1'h0 : T47;
  assign T47 = T41 ? 1'h0 : T48;
  assign T48 = T53 ? 1'h0 : T49;
  assign T49 = T19 ? 1'h1 : rx_enable;
  assign T50 = rx_enable & T51;
  assign T51 = T13 ^ 1'h1;
  assign T52 = rx_state == 2'h2;
  assign T53 = T44 & T43;
  assign T54 = T79 ? 1'h1 : T55;
  assign T55 = T56 & txQueue_io_deq_valid;
  assign T56 = tx_state == 1'h0;
  assign T112 = reset ? 1'h0 : T57;
  assign T57 = T59 ? 1'h0 : T58;
  assign T58 = T55 ? 1'h1 : tx_state;
  assign T59 = T61 & T60;
  assign T60 = txQueue_io_deq_valid ^ 1'h1;
  assign T61 = T69 & T62;
  assign T62 = tx_counter == 4'ha;
  assign T113 = reset ? 4'h0 : T63;
  assign T63 = T59 ? 4'h0 : T64;
  assign T64 = T79 ? 4'h1 : T65;
  assign T65 = T69 ? T66 : tx_counter;
  assign T66 = T68 ? 4'h0 : T67;
  assign T67 = tx_counter + 4'h1;
  assign T68 = tx_counter == 4'ha;
  assign T69 = T78 & T70;
  assign T70 = tx_baud_tick == 1'h1;
  assign T114 = reset ? 1'h0 : T71;
  assign T71 = T77 ? 1'h0 : T72;
  assign T72 = T73 ? 1'h1 : tx_baud_tick;
  assign T73 = tx_baud_counter == 9'h1b2;
  assign T115 = reset ? 9'h0 : T74;
  assign T74 = T77 ? T76 : T75;
  assign T75 = T73 ? 9'h0 : tx_baud_counter;
  assign T76 = tx_baud_counter + 9'h1;
  assign T77 = T73 ^ 1'h1;
  assign T78 = tx_state == 1'h1;
  assign T79 = T61 & txQueue_io_deq_valid;
  assign T80 = T83 ? T82 : T81;
  assign T81 = io_ocp_M_Data[3'h7:1'h0];
  assign T82 = io_ocp_M_Data[3'h7:1'h0];
  assign T83 = io_ocp_M_Cmd == 3'h1;
  assign io_uartPins_tx = tx_reg;
  assign T116 = reset ? 1'h1 : T84;
  assign T84 = T59 ? 1'h1 : T85;
  assign T85 = T79 ? 1'h0 : T86;
  assign T86 = T69 ? T87 : tx_reg;
  assign T87 = tx_buff[1'h0:1'h0];
  assign T117 = reset ? 10'h0 : T88;
  assign T88 = T79 ? T118 : T89;
  assign T89 = T69 ? T93 : T90;
  assign T90 = T55 ? T91 : tx_buff;
  assign T91 = {1'h1, T92};
  assign T92 = {txQueue_io_deq_bits, 1'h0};
  assign T93 = {1'h0, T94};
  assign T94 = tx_buff[4'h9:1'h1];
  assign T118 = {1'h0, T95};
  assign T95 = {1'h1, txQueue_io_deq_bits};
  assign io_ocp_S_Data = T119;
  assign T119 = {24'h0, rdDataReg};
  assign T120 = reset ? 8'h0 : T96;
  assign T96 = T99 ? T97 : rxQueue_io_deq_bits;
  assign T97 = {6'h0, T98};
  assign T98 = {rxQueue_io_deq_valid, txQueue_io_enq_ready};
  assign T99 = T100 == 1'h0;
  assign T100 = io_ocp_M_Addr[2'h2:2'h2];
  assign io_ocp_S_Resp = respReg;
  assign T121 = reset ? 2'h0 : T101;
  assign T101 = T3 ? 2'h1 : T102;
  assign T102 = T83 ? 2'h1 : 2'h0;
  Queue txQueue(.clk(clk), .reset(reset),
       .io_enq_ready( txQueue_io_enq_ready ),
       .io_enq_valid( T83 ),
       .io_enq_bits( T80 ),
       .io_deq_ready( T54 ),
       .io_deq_valid( txQueue_io_deq_valid ),
       .io_deq_bits( txQueue_io_deq_bits )
       //.io_count(  )
  );
  Queue rxQueue(.clk(clk), .reset(reset),
       //.io_enq_ready(  )
       .io_enq_valid( T53 ),
       .io_enq_bits( T4 ),
       .io_deq_ready( T0 ),
       .io_deq_valid( rxQueue_io_deq_valid ),
       .io_deq_bits( rxQueue_io_deq_bits )
       //.io_count(  )
  );

  always @(posedge clk) begin
    if(reset) begin
      rx_buff <= 8'h0;
    end else if(T8) begin
      rx_buff <= T6;
    end
    if(reset) begin
      rxd_reg2 <= 1'h1;
    end else begin
      rxd_reg2 <= rxd_reg1;
    end
    if(reset) begin
      rxd_reg1 <= 1'h1;
    end else begin
      rxd_reg1 <= rxd_reg0;
    end
    if(reset) begin
      rxd_reg0 <= 1'h1;
    end else begin
      rxd_reg0 <= io_uartPins_rx;
    end
    if(reset) begin
      rx_baud_tick <= 1'h0;
    end else if(T50) begin
      rx_baud_tick <= 1'h0;
    end else if(T12) begin
      rx_baud_tick <= 1'h1;
    end
    if(reset) begin
      rx_baud_counter <= 9'h0;
    end else if(T19) begin
      rx_baud_counter <= T18;
    end else if(T50) begin
      rx_baud_counter <= T17;
    end else if(T12) begin
      rx_baud_counter <= 9'h0;
    end
    if(reset) begin
      rx_state <= 2'h0;
    end else if(T41) begin
      rx_state <= 2'h0;
    end else if(T53) begin
      rx_state <= 2'h0;
    end else if(T8) begin
      rx_state <= T35;
    end else if(T33) begin
      rx_state <= 2'h0;
    end else if(T28) begin
      rx_state <= 2'h2;
    end else if(T19) begin
      rx_state <= 2'h1;
    end
    if(reset) begin
      rx_counter <= 3'h0;
    end else if(T8) begin
      rx_counter <= T38;
    end
    if(reset) begin
      rx_enable <= 1'h0;
    end else if(T41) begin
      rx_enable <= 1'h0;
    end else if(T53) begin
      rx_enable <= 1'h0;
    end else if(T19) begin
      rx_enable <= 1'h1;
    end
    if(reset) begin
      tx_state <= 1'h0;
    end else if(T59) begin
      tx_state <= 1'h0;
    end else if(T55) begin
      tx_state <= 1'h1;
    end
    if(reset) begin
      tx_counter <= 4'h0;
    end else if(T59) begin
      tx_counter <= 4'h0;
    end else if(T79) begin
      tx_counter <= 4'h1;
    end else if(T69) begin
      tx_counter <= T66;
    end
    if(reset) begin
      tx_baud_tick <= 1'h0;
    end else if(T77) begin
      tx_baud_tick <= 1'h0;
    end else if(T73) begin
      tx_baud_tick <= 1'h1;
    end
    if(reset) begin
      tx_baud_counter <= 9'h0;
    end else if(T77) begin
      tx_baud_counter <= T76;
    end else if(T73) begin
      tx_baud_counter <= 9'h0;
    end
    if(reset) begin
      tx_reg <= 1'h1;
    end else if(T59) begin
      tx_reg <= 1'h1;
    end else if(T79) begin
      tx_reg <= 1'h0;
    end else if(T69) begin
      tx_reg <= T87;
    end
    if(reset) begin
      tx_buff <= 10'h0;
    end else if(T79) begin
      tx_buff <= T118;
    end else if(T69) begin
      tx_buff <= T93;
    end else if(T55) begin
      tx_buff <= T91;
    end
    if(reset) begin
      rdDataReg <= 8'h0;
    end else if(T99) begin
      rdDataReg <= T97;
    end else begin
      rdDataReg <= rxQueue_io_deq_bits;
    end
    if(reset) begin
      respReg <= 2'h0;
    end else if(T3) begin
      respReg <= 2'h1;
    end else if(T83) begin
      respReg <= 2'h1;
    end else begin
      respReg <= 2'h0;
    end
  end
endmodule

module Nexys4DDRIO(
    input  io_superMode,
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input [3:0] io_ocp_M_ByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    output[2:0] io_nexys4DDRIOPins_MCmd,
    output[15:0] io_nexys4DDRIOPins_MAddr,
    output[31:0] io_nexys4DDRIOPins_MData,
    output[3:0] io_nexys4DDRIOPins_MByteEn,
    input [1:0] io_nexys4DDRIOPins_SResp,
    input [31:0] io_nexys4DDRIOPins_SData
);

  wire[15:0] T0;


  assign io_nexys4DDRIOPins_MByteEn = io_ocp_M_ByteEn;
  assign io_nexys4DDRIOPins_MData = io_ocp_M_Data;
  assign io_nexys4DDRIOPins_MAddr = T0;
  assign T0 = io_ocp_M_Addr[4'hf:1'h0];
  assign io_nexys4DDRIOPins_MCmd = io_ocp_M_Cmd;
  assign io_ocp_S_Data = io_nexys4DDRIOPins_SData;
  assign io_ocp_S_Resp = io_nexys4DDRIOPins_SResp;
endmodule

module FpuCtrl(
    input  io_superMode,
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input [3:0] io_ocp_M_ByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    output[2:0] io_fpuCtrlPins_MCmd,
    output[15:0] io_fpuCtrlPins_MAddr,
    output[31:0] io_fpuCtrlPins_MData,
    output[3:0] io_fpuCtrlPins_MByteEn,
    input [1:0] io_fpuCtrlPins_SResp,
    input [31:0] io_fpuCtrlPins_SData
);

  wire[15:0] T0;


  assign io_fpuCtrlPins_MByteEn = io_ocp_M_ByteEn;
  assign io_fpuCtrlPins_MData = io_ocp_M_Data;
  assign io_fpuCtrlPins_MAddr = T0;
  assign T0 = io_ocp_M_Addr[4'hf:1'h0];
  assign io_fpuCtrlPins_MCmd = io_ocp_M_Cmd;
  assign io_ocp_S_Data = io_fpuCtrlPins_SData;
  assign io_ocp_S_Resp = io_fpuCtrlPins_SResp;
endmodule

module BRamCtrl(
    input  io_superMode,
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input [3:0] io_ocp_M_ByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    output[2:0] io_bRamCtrlPins_MCmd,
    output[15:0] io_bRamCtrlPins_MAddr,
    output[31:0] io_bRamCtrlPins_MData,
    output[3:0] io_bRamCtrlPins_MByteEn,
    input [1:0] io_bRamCtrlPins_SResp,
    input [31:0] io_bRamCtrlPins_SData
);

  wire[15:0] T0;


  assign io_bRamCtrlPins_MByteEn = io_ocp_M_ByteEn;
  assign io_bRamCtrlPins_MData = io_ocp_M_Data;
  assign io_bRamCtrlPins_MAddr = T0;
  assign T0 = io_ocp_M_Addr[4'hf:1'h0];
  assign io_bRamCtrlPins_MCmd = io_ocp_M_Cmd;
  assign io_ocp_S_Data = io_bRamCtrlPins_SData;
  assign io_ocp_S_Resp = io_bRamCtrlPins_SResp;
endmodule

module IcapCtrl(
    input  io_superMode,
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input [3:0] io_ocp_M_ByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    output[2:0] io_icapCtrlPins_MCmd,
    output[15:0] io_icapCtrlPins_MAddr,
    output[31:0] io_icapCtrlPins_MData,
    output[3:0] io_icapCtrlPins_MByteEn,
    input [1:0] io_icapCtrlPins_SResp,
    input [31:0] io_icapCtrlPins_SData
);

  wire[15:0] T0;


  assign io_icapCtrlPins_MByteEn = io_ocp_M_ByteEn;
  assign io_icapCtrlPins_MData = io_ocp_M_Data;
  assign io_icapCtrlPins_MAddr = T0;
  assign T0 = io_ocp_M_Addr[4'hf:1'h0];
  assign io_icapCtrlPins_MCmd = io_ocp_M_Cmd;
  assign io_ocp_S_Data = io_icapCtrlPins_SData;
  assign io_ocp_S_Resp = io_icapCtrlPins_SResp;
endmodule

module CpuInfo(input clk,
    input  io_superMode,
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input [3:0] io_ocp_M_ByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    input [31:0] io_cpuInfoPins_id,
    input [31:0] io_cpuInfoPins_cnt
);

  wire[31:0] data;
  wire[31:0] T0;
  wire[31:0] T1;
  wire[31:0] T2;
  wire[31:0] T3;
  wire[31:0] T4;
  wire[31:0] T5;
  wire[31:0] T6;
  wire[31:0] T7;
  wire[31:0] T8;
  wire[31:0] T9;
  wire[31:0] T10;
  wire[31:0] T11;
  wire[31:0] T12;
  wire[31:0] T13;
  wire[31:0] T14;
  wire T15;
  wire[3:0] T16;
  reg [31:0] masterReg_Addr;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  wire T26;
  wire T27;
  wire T28;
  wire T29;
  reg [31:0] romData;
  wire[3:0] T31;
  wire T32;
  wire T33;
  wire[1:0] resp;
  wire[1:0] T34;
  wire[1:0] T35;
  wire T36;
  reg [2:0] masterReg_Cmd;
  wire T37;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    masterReg_Addr = {1{$random}};
    masterReg_Cmd = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_ocp_S_Data = data;
  assign data = T0;
  assign T0 = T32 ? romData : T1;
  assign T1 = T29 ? 32'h800 : T2;
  assign T2 = T28 ? 32'h400 : T3;
  assign T3 = T27 ? 32'h0 : T4;
  assign T4 = T26 ? 32'h800 : T5;
  assign T5 = T25 ? 32'h1000001 : T6;
  assign T6 = T24 ? 32'h800 : T7;
  assign T7 = T23 ? 32'h1020010 : T8;
  assign T8 = T22 ? 32'h1000 : T9;
  assign T9 = T21 ? 32'h400 : T10;
  assign T10 = T20 ? 32'h8000000 : T11;
  assign T11 = T19 ? 32'h1 : T12;
  assign T12 = T18 ? io_cpuInfoPins_cnt : T13;
  assign T13 = T17 ? 32'h2faf080 : T14;
  assign T14 = T15 ? io_cpuInfoPins_id : 32'h0;
  assign T15 = 4'h0 == T16;
  assign T16 = masterReg_Addr[3'h5:2'h2];
  assign T17 = 4'h1 == T16;
  assign T18 = 4'h2 == T16;
  assign T19 = 4'h3 == T16;
  assign T20 = 4'h4 == T16;
  assign T21 = 4'h5 == T16;
  assign T22 = 4'h6 == T16;
  assign T23 = 4'h7 == T16;
  assign T24 = 4'h8 == T16;
  assign T25 = 4'h9 == T16;
  assign T26 = 4'ha == T16;
  assign T27 = 4'hb == T16;
  assign T28 = 4'hc == T16;
  assign T29 = 4'hd == T16;
  always @(*) case (T31)
    0: romData = 32'hf0008024;
    1: romData = 32'h0;
    2: romData = 32'h20000;
    3: romData = 32'h410;
    4: romData = 32'h404;
    5: romData = 32'h3b4;
    6: romData = 32'h3e8;
    7: romData = 32'h3f0;
    8: romData = 32'h3f8;
    default: begin
      romData = 32'bx;
`ifndef SYNTHESIS
// synthesis translate_off
      romData = {1{$random}};
// synthesis translate_on
`endif
    end
  endcase
  assign T31 = masterReg_Addr[3'h5:2'h2];
  assign T32 = T33 == 1'h1;
  assign T33 = masterReg_Addr[4'hf:4'hf];
  assign io_ocp_S_Resp = resp;
  assign resp = T34;
  assign T34 = T37 ? 2'h1 : T35;
  assign T35 = T36 ? 2'h1 : 2'h0;
  assign T36 = masterReg_Cmd == 3'h1;
  assign T37 = masterReg_Cmd == 3'h2;

  always @(posedge clk) begin
    masterReg_Addr <= io_ocp_M_Addr;
    masterReg_Cmd <= io_ocp_M_Cmd;
  end
endmodule

module Timer(input clk, input reset,
    input  io_superMode,
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input [3:0] io_ocp_M_ByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    output io_timerIntrs_1,
    output io_timerIntrs_0
);

  wire T0;
  reg [63:0] cycleIntrReg;
  wire[63:0] T55;
  wire[63:0] T1;
  wire[63:0] T2;
  reg [31:0] cycleLoReg;
  wire[31:0] T3;
  wire T4;
  wire T5;
  wire[1:0] T6;
  reg [31:0] masterReg_Addr;
  wire T7;
  reg [2:0] masterReg_Cmd;
  reg [31:0] masterReg_Data;
  wire T8;
  wire T9;
  wire[1:0] T10;
  wire[63:0] T11;
  reg [63:0] cycleReg;
  wire[63:0] T56;
  wire[63:0] T12;
  wire T13;
  wire T14;
  reg [63:0] usecIntrReg;
  wire[63:0] T57;
  wire[63:0] T15;
  wire[63:0] T16;
  reg [31:0] usecLoReg;
  wire[31:0] T17;
  wire T18;
  wire T19;
  wire[1:0] T20;
  wire T21;
  wire T22;
  wire[1:0] T23;
  wire[63:0] T24;
  reg [63:0] usecReg;
  wire[63:0] T58;
  wire[63:0] T25;
  wire[63:0] T26;
  wire T27;
  reg [5:0] usecSubReg;
  wire[5:0] T59;
  wire[5:0] T28;
  wire[5:0] T29;
  wire[31:0] data;
  wire[31:0] T30;
  wire[31:0] T31;
  wire[31:0] T32;
  wire[31:0] T33;
  wire[31:0] T34;
  wire T35;
  wire T36;
  wire[1:0] T37;
  wire T38;
  reg [31:0] cycleHiReg;
  wire[31:0] T39;
  wire[31:0] T40;
  wire T41;
  wire T42;
  wire[1:0] T43;
  wire[31:0] T44;
  wire T45;
  wire T46;
  wire[1:0] T47;
  reg [31:0] usecHiReg;
  wire[31:0] T48;
  wire[31:0] T49;
  wire T50;
  wire T51;
  wire[1:0] T52;
  wire[1:0] resp;
  wire[1:0] T53;
  wire[1:0] T54;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    cycleIntrReg = {2{$random}};
    cycleLoReg = {1{$random}};
    masterReg_Addr = {1{$random}};
    masterReg_Cmd = {1{$random}};
    masterReg_Data = {1{$random}};
    cycleReg = {2{$random}};
    usecIntrReg = {2{$random}};
    usecLoReg = {1{$random}};
    usecReg = {2{$random}};
    usecSubReg = {1{$random}};
    cycleHiReg = {1{$random}};
    usecHiReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_timerIntrs_0 = T0;
  assign T0 = T11 == cycleIntrReg;
  assign T55 = reset ? 64'h0 : T1;
  assign T1 = T8 ? T2 : cycleIntrReg;
  assign T2 = {masterReg_Data, cycleLoReg};
  assign T3 = T4 ? masterReg_Data : cycleLoReg;
  assign T4 = T7 & T5;
  assign T5 = T6 == 2'h1;
  assign T6 = masterReg_Addr[2'h3:2'h2];
  assign T7 = masterReg_Cmd == 3'h1;
  assign T8 = T7 & T9;
  assign T9 = T10 == 2'h0;
  assign T10 = masterReg_Addr[2'h3:2'h2];
  assign T11 = cycleReg + 64'h1;
  assign T56 = reset ? 64'h0 : T12;
  assign T12 = cycleReg + 64'h1;
  assign io_timerIntrs_1 = T13;
  assign T13 = T27 & T14;
  assign T14 = T24 == usecIntrReg;
  assign T57 = reset ? 64'h0 : T15;
  assign T15 = T21 ? T16 : usecIntrReg;
  assign T16 = {masterReg_Data, usecLoReg};
  assign T17 = T18 ? masterReg_Data : usecLoReg;
  assign T18 = T7 & T19;
  assign T19 = T20 == 2'h3;
  assign T20 = masterReg_Addr[2'h3:2'h2];
  assign T21 = T7 & T22;
  assign T22 = T23 == 2'h2;
  assign T23 = masterReg_Addr[2'h3:2'h2];
  assign T24 = usecReg + 64'h1;
  assign T58 = reset ? 64'h0 : T25;
  assign T25 = T27 ? T26 : usecReg;
  assign T26 = usecReg + 64'h1;
  assign T27 = usecSubReg == 6'h31;
  assign T59 = reset ? 6'h0 : T28;
  assign T28 = T27 ? 6'h0 : T29;
  assign T29 = usecSubReg + 6'h1;
  assign io_ocp_S_Data = data;
  assign data = T30;
  assign T30 = T50 ? usecHiReg : T31;
  assign T31 = T45 ? T44 : T32;
  assign T32 = T41 ? cycleHiReg : T33;
  assign T33 = T35 ? T34 : 32'h0;
  assign T34 = cycleReg[5'h1f:1'h0];
  assign T35 = T38 & T36;
  assign T36 = T37 == 2'h1;
  assign T37 = masterReg_Addr[2'h3:2'h2];
  assign T38 = masterReg_Cmd == 3'h2;
  assign T39 = T35 ? T40 : cycleHiReg;
  assign T40 = cycleReg[6'h3f:6'h20];
  assign T41 = T38 & T42;
  assign T42 = T43 == 2'h0;
  assign T43 = masterReg_Addr[2'h3:2'h2];
  assign T44 = usecReg[5'h1f:1'h0];
  assign T45 = T38 & T46;
  assign T46 = T47 == 2'h3;
  assign T47 = masterReg_Addr[2'h3:2'h2];
  assign T48 = T45 ? T49 : usecHiReg;
  assign T49 = usecReg[6'h3f:6'h20];
  assign T50 = T38 & T51;
  assign T51 = T52 == 2'h2;
  assign T52 = masterReg_Addr[2'h3:2'h2];
  assign io_ocp_S_Resp = resp;
  assign resp = T53;
  assign T53 = T7 ? 2'h1 : T54;
  assign T54 = T38 ? 2'h1 : 2'h0;

  always @(posedge clk) begin
    if(reset) begin
      cycleIntrReg <= 64'h0;
    end else if(T8) begin
      cycleIntrReg <= T2;
    end
    if(T4) begin
      cycleLoReg <= masterReg_Data;
    end
    masterReg_Addr <= io_ocp_M_Addr;
    masterReg_Cmd <= io_ocp_M_Cmd;
    masterReg_Data <= io_ocp_M_Data;
    if(reset) begin
      cycleReg <= 64'h0;
    end else begin
      cycleReg <= T12;
    end
    if(reset) begin
      usecIntrReg <= 64'h0;
    end else if(T21) begin
      usecIntrReg <= T16;
    end
    if(T18) begin
      usecLoReg <= masterReg_Data;
    end
    if(reset) begin
      usecReg <= 64'h0;
    end else if(T27) begin
      usecReg <= T26;
    end
    if(reset) begin
      usecSubReg <= 6'h0;
    end else if(T27) begin
      usecSubReg <= 6'h0;
    end else begin
      usecSubReg <= T29;
    end
    if(T35) begin
      cycleHiReg <= T40;
    end
    if(T45) begin
      usecHiReg <= T49;
    end
  end
endmodule

module InOut(input clk, input reset,
    input [2:0] io_memInOut_M_Cmd,
    input [31:0] io_memInOut_M_Addr,
    input [31:0] io_memInOut_M_Data,
    input [3:0] io_memInOut_M_ByteEn,
    output[1:0] io_memInOut_S_Resp,
    output[31:0] io_memInOut_S_Data,
    output[2:0] io_comConf_M_Cmd,
    output[31:0] io_comConf_M_Addr,
    output[31:0] io_comConf_M_Data,
    output[3:0] io_comConf_M_ByteEn,
    output io_comConf_M_RespAccept,
    input [1:0] io_comConf_S_Resp,
    input [31:0] io_comConf_S_Data,
    input  io_comConf_S_CmdAccept,
    input  io_comConf_S_Reset_n,
    input [1:0] io_comConf_S_Flag,
    output[2:0] io_comSpm_M_Cmd,
    output[31:0] io_comSpm_M_Addr,
    output[31:0] io_comSpm_M_Data,
    output[3:0] io_comSpm_M_ByteEn,
    input [1:0] io_comSpm_S_Resp,
    input [31:0] io_comSpm_S_Data,
    output[2:0] io_excInOut_M_Cmd,
    output[31:0] io_excInOut_M_Addr,
    output[31:0] io_excInOut_M_Data,
    output[3:0] io_excInOut_M_ByteEn,
    input [1:0] io_excInOut_S_Resp,
    input [31:0] io_excInOut_S_Data,
    //output[2:0] io_mmuInOut_M_Cmd
    //output[31:0] io_mmuInOut_M_Addr
    //output[31:0] io_mmuInOut_M_Data
    //output[3:0] io_mmuInOut_M_ByteEn
    //input [1:0] io_mmuInOut_S_Resp
    //input [31:0] io_mmuInOut_S_Data
    output io_intrs_15,
    output io_intrs_14,
    output io_intrs_13,
    output io_intrs_12,
    output io_intrs_11,
    output io_intrs_10,
    output io_intrs_9,
    output io_intrs_8,
    output io_intrs_7,
    output io_intrs_6,
    output io_intrs_5,
    output io_intrs_4,
    output io_intrs_3,
    output io_intrs_2,
    output io_intrs_1,
    output io_intrs_0,
    input  io_superMode,
    input  io_internalIO_perf_ic_hit,
    input  io_internalIO_perf_ic_miss,
    input  io_internalIO_perf_dc_hit,
    input  io_internalIO_perf_dc_miss,
    input  io_internalIO_perf_sc_spill,
    input  io_internalIO_perf_sc_fill,
    input  io_internalIO_perf_wc_hit,
    input  io_internalIO_perf_wc_miss,
    input  io_internalIO_perf_mem_read,
    input  io_internalIO_perf_mem_write,
    output io_uartPins_tx,
    input  io_uartPins_rx,
    output[2:0] io_nexys4DDRIOPins_MCmd,
    output[15:0] io_nexys4DDRIOPins_MAddr,
    output[31:0] io_nexys4DDRIOPins_MData,
    output[3:0] io_nexys4DDRIOPins_MByteEn,
    input [1:0] io_nexys4DDRIOPins_SResp,
    input [31:0] io_nexys4DDRIOPins_SData,
    output[2:0] io_fpuCtrlPins_MCmd,
    output[15:0] io_fpuCtrlPins_MAddr,
    output[31:0] io_fpuCtrlPins_MData,
    output[3:0] io_fpuCtrlPins_MByteEn,
    input [1:0] io_fpuCtrlPins_SResp,
    input [31:0] io_fpuCtrlPins_SData,
    output[2:0] io_bRamCtrlPins_MCmd,
    output[15:0] io_bRamCtrlPins_MAddr,
    output[31:0] io_bRamCtrlPins_MData,
    output[3:0] io_bRamCtrlPins_MByteEn,
    input [1:0] io_bRamCtrlPins_SResp,
    input [31:0] io_bRamCtrlPins_SData,
    output[2:0] io_icapCtrlPins_MCmd,
    output[15:0] io_icapCtrlPins_MAddr,
    output[31:0] io_icapCtrlPins_MData,
    output[3:0] io_icapCtrlPins_MByteEn,
    input [1:0] io_icapCtrlPins_SResp,
    input [31:0] io_icapCtrlPins_SData,
    input [31:0] io_cpuInfoPins_id,
    input [31:0] io_cpuInfoPins_cnt
);

  reg  T0;
  wire[2:0] T1;
  wire selDeviceVec_2;
  wire T2;
  wire T3;
  wire[3:0] T4;
  wire selIO;
  wire[3:0] T5;
  wire[2:0] T6;
  wire selDeviceVec_0;
  wire T7;
  wire T8;
  wire[3:0] T9;
  wire[2:0] T10;
  wire selDeviceVec_12;
  wire T11;
  wire T12;
  wire[3:0] T13;
  wire[2:0] T14;
  wire selDeviceVec_11;
  wire T15;
  wire T16;
  wire[3:0] T17;
  wire[2:0] T18;
  wire selDeviceVec_10;
  wire T19;
  wire T20;
  wire[3:0] T21;
  wire[2:0] T22;
  wire selDeviceVec_9;
  wire T23;
  wire T24;
  wire[3:0] T25;
  wire[2:0] T26;
  wire selDeviceVec_8;
  wire T27;
  wire T28;
  wire[3:0] T29;
  reg [3:0] R30;
  wire[3:0] T169;
  wire[3:0] T31;
  wire T32;
  wire T33;
  wire T34;
  reg [2:0] R35;
  wire[2:0] T170;
  wire[2:0] T36;
  reg [31:0] R37;
  wire[31:0] T171;
  wire[31:0] T38;
  reg [31:0] R39;
  wire[31:0] T172;
  wire[31:0] T40;
  wire[2:0] T41;
  wire selComConf;
  wire T42;
  wire T43;
  wire selNI;
  wire[3:0] T44;
  wire[10:0] T173;
  wire[2:0] T45;
  wire selSpm;
  wire T46;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire T52;
  wire[2:0] T53;
  wire selDeviceVec_1;
  wire T54;
  wire T55;
  wire[3:0] T56;
  wire[2:0] T57;
  wire selComSpm;
  wire T58;
  wire T59;
  wire[31:0] T60;
  wire[31:0] T61;
  wire[31:0] T62;
  wire[31:0] T63;
  wire[31:0] T64;
  wire[31:0] T65;
  wire[31:0] T66;
  wire[31:0] T67;
  wire[31:0] T68;
  wire[31:0] T69;
  wire[31:0] T70;
  wire[31:0] T71;
  wire[31:0] T72;
  wire[31:0] T73;
  wire[31:0] T74;
  wire[31:0] T75;
  wire[31:0] T76;
  wire[31:0] T77;
  reg  selComConfReg;
  wire T78;
  wire T79;
  reg  selComSpmReg;
  wire T80;
  wire[31:0] deviceSVec_0_Data;
  reg  selDeviceReg_0;
  wire T81;
  wire[31:0] deviceSVec_1_Data;
  reg  selDeviceReg_1;
  wire T82;
  wire[31:0] deviceSVec_2_Data;
  reg  selDeviceReg_2;
  wire T83;
  wire[31:0] deviceSVec_3_Data;
  reg  selDeviceReg_3;
  wire T84;
  wire selDeviceVec_3;
  wire T85;
  wire T86;
  wire[3:0] T87;
  wire[31:0] deviceSVec_4_Data;
  reg  selDeviceReg_4;
  wire T88;
  wire selDeviceVec_4;
  wire T89;
  wire T90;
  wire[3:0] T91;
  wire[31:0] deviceSVec_5_Data;
  reg  selDeviceReg_5;
  wire T92;
  wire selDeviceVec_5;
  wire T93;
  wire T94;
  wire[3:0] T95;
  wire[31:0] deviceSVec_6_Data;
  reg  selDeviceReg_6;
  wire T96;
  wire selDeviceVec_6;
  wire T97;
  wire T98;
  wire[3:0] T99;
  wire[31:0] deviceSVec_7_Data;
  reg  selDeviceReg_7;
  wire T100;
  wire selDeviceVec_7;
  wire T101;
  wire T102;
  wire[3:0] T103;
  wire[31:0] deviceSVec_8_Data;
  reg  selDeviceReg_8;
  wire T104;
  wire[31:0] deviceSVec_9_Data;
  reg  selDeviceReg_9;
  wire T105;
  wire[31:0] deviceSVec_10_Data;
  reg  selDeviceReg_10;
  wire T106;
  wire[31:0] deviceSVec_11_Data;
  reg  selDeviceReg_11;
  wire T107;
  wire[31:0] deviceSVec_12_Data;
  reg  selDeviceReg_12;
  wire T108;
  wire[31:0] deviceSVec_13_Data;
  reg  selDeviceReg_13;
  wire T109;
  wire selDeviceVec_13;
  wire T110;
  wire T111;
  wire[3:0] T112;
  wire[31:0] deviceSVec_14_Data;
  reg  selDeviceReg_14;
  wire T113;
  wire selDeviceVec_14;
  wire T114;
  wire T115;
  wire[3:0] T116;
  wire[31:0] deviceSVec_15_Data;
  reg  selDeviceReg_15;
  wire T117;
  wire selDeviceVec_15;
  wire T118;
  wire T119;
  wire[3:0] T120;
  wire[1:0] T121;
  wire[1:0] T122;
  wire[1:0] deviceSVec_15_Resp;
  wire[1:0] T123;
  wire[1:0] deviceSVec_14_Resp;
  wire[1:0] T124;
  wire[1:0] deviceSVec_13_Resp;
  wire[1:0] T125;
  wire[1:0] deviceSVec_12_Resp;
  wire[1:0] T126;
  wire[1:0] deviceSVec_11_Resp;
  wire[1:0] T127;
  wire[1:0] deviceSVec_10_Resp;
  wire[1:0] T128;
  wire[1:0] deviceSVec_9_Resp;
  wire[1:0] T129;
  wire[1:0] deviceSVec_8_Resp;
  wire[1:0] T130;
  wire[1:0] deviceSVec_7_Resp;
  wire[1:0] T131;
  wire[1:0] deviceSVec_6_Resp;
  wire[1:0] T132;
  wire[1:0] deviceSVec_5_Resp;
  wire[1:0] T133;
  wire[1:0] deviceSVec_4_Resp;
  wire[1:0] T134;
  wire[1:0] deviceSVec_3_Resp;
  wire[1:0] T135;
  wire[1:0] deviceSVec_2_Resp;
  wire[1:0] T136;
  wire[1:0] deviceSVec_1_Resp;
  wire[1:0] T137;
  wire[1:0] deviceSVec_0_Resp;
  wire[1:0] T138;
  wire[1:0] T139;
  wire[1:0] T140;
  wire[1:0] T141;
  wire[1:0] ispmResp;
  wire T142;
  reg [2:0] ispmCmdReg;
  wire[2:0] T143;
  wire selISpm;
  wire T144;
  wire T145;
  wire T146;
  wire T147;
  wire T148;
  reg [1:0] errResp;
  wire[1:0] T174;
  wire[1:0] T149;
  wire T150;
  wire T151;
  wire validSel;
  wire validSelVec_15;
  wire validDeviceVec_15;
  wire T152;
  wire validSelVec_14;
  wire validDeviceVec_14;
  wire T153;
  wire validSelVec_13;
  wire validDeviceVec_13;
  wire T154;
  wire validSelVec_12;
  wire validDeviceVec_12;
  wire T155;
  wire validSelVec_11;
  wire validDeviceVec_11;
  wire T156;
  wire validSelVec_10;
  wire validDeviceVec_10;
  wire T157;
  wire validSelVec_9;
  wire validDeviceVec_9;
  wire T158;
  wire validSelVec_8;
  wire validDeviceVec_8;
  wire T159;
  wire validSelVec_7;
  wire validDeviceVec_7;
  wire T160;
  wire validSelVec_6;
  wire validDeviceVec_6;
  wire T161;
  wire validSelVec_5;
  wire validDeviceVec_5;
  wire T162;
  wire validSelVec_4;
  wire validDeviceVec_4;
  wire T163;
  wire validSelVec_3;
  wire validDeviceVec_3;
  wire T164;
  wire validSelVec_2;
  wire validDeviceVec_2;
  wire T165;
  wire validSelVec_1;
  wire validDeviceVec_1;
  wire T166;
  wire validSelVec_0;
  wire validDeviceVec_0;
  wire T167;
  wire T168;
  wire[1:0] comConf_io_slave_S_Resp;
  wire[31:0] comConf_io_slave_S_Data;
  wire[2:0] comConf_io_master_M_Cmd;
  wire[31:0] comConf_io_master_M_Addr;
  wire[31:0] comConf_io_master_M_Data;
  wire[3:0] comConf_io_master_M_ByteEn;
  wire[1:0] comConfIO_io_slave_S_Resp;
  wire[31:0] comConfIO_io_slave_S_Data;
  wire comConfIO_io_slave_S_CmdAccept;
  wire[2:0] comConfIO_io_master_M_Cmd;
  wire[31:0] comConfIO_io_master_M_Addr;
  wire[31:0] comConfIO_io_master_M_Data;
  wire[3:0] comConfIO_io_master_M_ByteEn;
  wire comConfIO_io_master_M_RespAccept;
  wire[1:0] Nexys4DDRIO_io_ocp_S_Resp;
  wire[31:0] Nexys4DDRIO_io_ocp_S_Data;
  wire[2:0] Nexys4DDRIO_io_nexys4DDRIOPins_MCmd;
  wire[15:0] Nexys4DDRIO_io_nexys4DDRIOPins_MAddr;
  wire[31:0] Nexys4DDRIO_io_nexys4DDRIOPins_MData;
  wire[3:0] Nexys4DDRIO_io_nexys4DDRIOPins_MByteEn;
  wire[1:0] FpuCtrl_io_ocp_S_Resp;
  wire[31:0] FpuCtrl_io_ocp_S_Data;
  wire[2:0] FpuCtrl_io_fpuCtrlPins_MCmd;
  wire[15:0] FpuCtrl_io_fpuCtrlPins_MAddr;
  wire[31:0] FpuCtrl_io_fpuCtrlPins_MData;
  wire[3:0] FpuCtrl_io_fpuCtrlPins_MByteEn;
  wire[1:0] BRamCtrl_io_ocp_S_Resp;
  wire[31:0] BRamCtrl_io_ocp_S_Data;
  wire[2:0] BRamCtrl_io_bRamCtrlPins_MCmd;
  wire[15:0] BRamCtrl_io_bRamCtrlPins_MAddr;
  wire[31:0] BRamCtrl_io_bRamCtrlPins_MData;
  wire[3:0] BRamCtrl_io_bRamCtrlPins_MByteEn;
  wire[1:0] IcapCtrl_io_ocp_S_Resp;
  wire[31:0] IcapCtrl_io_ocp_S_Data;
  wire[2:0] IcapCtrl_io_icapCtrlPins_MCmd;
  wire[15:0] IcapCtrl_io_icapCtrlPins_MAddr;
  wire[31:0] IcapCtrl_io_icapCtrlPins_MData;
  wire[3:0] IcapCtrl_io_icapCtrlPins_MByteEn;
  wire[1:0] CpuInfo_io_ocp_S_Resp;
  wire[31:0] CpuInfo_io_ocp_S_Data;
  wire[1:0] Timer_io_ocp_S_Resp;
  wire[31:0] Timer_io_ocp_S_Data;
  wire Timer_io_timerIntrs_1;
  wire Timer_io_timerIntrs_0;
  wire[1:0] spm_io_S_Resp;
  wire[31:0] spm_io_S_Data;
  wire[1:0] Uart_io_ocp_S_Resp;
  wire[31:0] Uart_io_ocp_S_Data;
  wire Uart_io_uartPins_tx;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    T0 = 1'b0;
    R30 = {1{$random}};
    R35 = {1{$random}};
    R37 = {1{$random}};
    R39 = {1{$random}};
    selComConfReg = {1{$random}};
    selComSpmReg = {1{$random}};
    selDeviceReg_0 = {1{$random}};
    selDeviceReg_1 = {1{$random}};
    selDeviceReg_2 = {1{$random}};
    selDeviceReg_3 = {1{$random}};
    selDeviceReg_4 = {1{$random}};
    selDeviceReg_5 = {1{$random}};
    selDeviceReg_6 = {1{$random}};
    selDeviceReg_7 = {1{$random}};
    selDeviceReg_8 = {1{$random}};
    selDeviceReg_9 = {1{$random}};
    selDeviceReg_10 = {1{$random}};
    selDeviceReg_11 = {1{$random}};
    selDeviceReg_12 = {1{$random}};
    selDeviceReg_13 = {1{$random}};
    selDeviceReg_14 = {1{$random}};
    selDeviceReg_15 = {1{$random}};
    ispmCmdReg = {1{$random}};
    errResp = {1{$random}};
  end
// synthesis translate_on
`endif

`ifndef SYNTHESIS
// synthesis translate_off
//  assign io_mmuInOut_M_ByteEn = {1{$random}};
//  assign io_mmuInOut_M_Data = {1{$random}};
//  assign io_mmuInOut_M_Addr = {1{$random}};
//  assign io_mmuInOut_M_Cmd = {1{$random}};
// synthesis translate_on
`endif
  assign T1 = selDeviceVec_2 ? io_memInOut_M_Cmd : 3'h0;
  assign selDeviceVec_2 = T2;
  assign T2 = selIO & T3;
  assign T3 = T4 == 4'h2;
  assign T4 = io_memInOut_M_Addr[5'h13:5'h10];
  assign selIO = T5 == 4'hf;
  assign T5 = io_memInOut_M_Addr[5'h1f:5'h1c];
  assign T6 = selDeviceVec_0 ? io_memInOut_M_Cmd : 3'h0;
  assign selDeviceVec_0 = T7;
  assign T7 = selIO & T8;
  assign T8 = T9 == 4'h0;
  assign T9 = io_memInOut_M_Addr[5'h13:5'h10];
  assign T10 = selDeviceVec_12 ? io_memInOut_M_Cmd : 3'h0;
  assign selDeviceVec_12 = T11;
  assign T11 = selIO & T12;
  assign T12 = T13 == 4'hc;
  assign T13 = io_memInOut_M_Addr[5'h13:5'h10];
  assign T14 = selDeviceVec_11 ? io_memInOut_M_Cmd : 3'h0;
  assign selDeviceVec_11 = T15;
  assign T15 = selIO & T16;
  assign T16 = T17 == 4'hb;
  assign T17 = io_memInOut_M_Addr[5'h13:5'h10];
  assign T18 = selDeviceVec_10 ? io_memInOut_M_Cmd : 3'h0;
  assign selDeviceVec_10 = T19;
  assign T19 = selIO & T20;
  assign T20 = T21 == 4'ha;
  assign T21 = io_memInOut_M_Addr[5'h13:5'h10];
  assign T22 = selDeviceVec_9 ? io_memInOut_M_Cmd : 3'h0;
  assign selDeviceVec_9 = T23;
  assign T23 = selIO & T24;
  assign T24 = T25 == 4'h9;
  assign T25 = io_memInOut_M_Addr[5'h13:5'h10];
  assign T26 = selDeviceVec_8 ? io_memInOut_M_Cmd : 3'h0;
  assign selDeviceVec_8 = T27;
  assign T27 = selIO & T28;
  assign T28 = T29 == 4'h8;
  assign T29 = io_memInOut_M_Addr[5'h13:5'h10];
  assign T169 = reset ? comConf_io_master_M_ByteEn : T31;
  assign T31 = T32 ? comConf_io_master_M_ByteEn : R30;
  assign T32 = T34 | T33;
  assign T33 = comConfIO_io_slave_S_CmdAccept == 1'h1;
  assign T34 = R35 == 3'h0;
  assign T170 = reset ? comConf_io_master_M_Cmd : T36;
  assign T36 = T32 ? comConf_io_master_M_Cmd : R35;
  assign T171 = reset ? comConf_io_master_M_Data : T38;
  assign T38 = T32 ? comConf_io_master_M_Data : R37;
  assign T172 = reset ? comConf_io_master_M_Addr : T40;
  assign T40 = T32 ? comConf_io_master_M_Addr : R39;
  assign T41 = selComConf ? io_memInOut_M_Cmd : 3'h0;
  assign selComConf = selNI & T42;
  assign T42 = T43 == 1'h0;
  assign T43 = io_memInOut_M_Addr[5'h1b:5'h1b];
  assign selNI = T44 == 4'he;
  assign T44 = io_memInOut_M_Addr[5'h1f:5'h1c];
  assign T173 = io_memInOut_M_Addr[4'ha:1'h0];
  assign T45 = selSpm ? io_memInOut_M_Cmd : 3'h0;
  assign selSpm = T48 & T46;
  assign T46 = T47 == 1'h0;
  assign T47 = io_memInOut_M_Addr[5'h10:5'h10];
  assign T48 = T50 & T49;
  assign T49 = selNI ^ 1'h1;
  assign T50 = selIO ^ 1'h1;
  assign io_icapCtrlPins_MByteEn = IcapCtrl_io_icapCtrlPins_MByteEn;
  assign io_icapCtrlPins_MData = IcapCtrl_io_icapCtrlPins_MData;
  assign io_icapCtrlPins_MAddr = IcapCtrl_io_icapCtrlPins_MAddr;
  assign io_icapCtrlPins_MCmd = IcapCtrl_io_icapCtrlPins_MCmd;
  assign io_bRamCtrlPins_MByteEn = BRamCtrl_io_bRamCtrlPins_MByteEn;
  assign io_bRamCtrlPins_MData = BRamCtrl_io_bRamCtrlPins_MData;
  assign io_bRamCtrlPins_MAddr = BRamCtrl_io_bRamCtrlPins_MAddr;
  assign io_bRamCtrlPins_MCmd = BRamCtrl_io_bRamCtrlPins_MCmd;
  assign io_fpuCtrlPins_MByteEn = FpuCtrl_io_fpuCtrlPins_MByteEn;
  assign io_fpuCtrlPins_MData = FpuCtrl_io_fpuCtrlPins_MData;
  assign io_fpuCtrlPins_MAddr = FpuCtrl_io_fpuCtrlPins_MAddr;
  assign io_fpuCtrlPins_MCmd = FpuCtrl_io_fpuCtrlPins_MCmd;
  assign io_nexys4DDRIOPins_MByteEn = Nexys4DDRIO_io_nexys4DDRIOPins_MByteEn;
  assign io_nexys4DDRIOPins_MData = Nexys4DDRIO_io_nexys4DDRIOPins_MData;
  assign io_nexys4DDRIOPins_MAddr = Nexys4DDRIO_io_nexys4DDRIOPins_MAddr;
  assign io_nexys4DDRIOPins_MCmd = Nexys4DDRIO_io_nexys4DDRIOPins_MCmd;
  assign io_uartPins_tx = Uart_io_uartPins_tx;
  assign io_intrs_0 = Timer_io_timerIntrs_0;
  assign io_intrs_1 = Timer_io_timerIntrs_1;
  assign io_intrs_2 = T51;
  assign T51 = io_comConf_S_Flag[1'h0:1'h0];
  assign io_intrs_3 = T52;
  assign T52 = io_comConf_S_Flag[1'h1:1'h1];
  assign io_intrs_4 = 1'h0;
  assign io_intrs_5 = 1'h0;
  assign io_intrs_6 = 1'h0;
  assign io_intrs_7 = 1'h0;
  assign io_intrs_8 = 1'h0;
  assign io_intrs_9 = 1'h0;
  assign io_intrs_10 = 1'h0;
  assign io_intrs_11 = 1'h0;
  assign io_intrs_12 = 1'h0;
  assign io_intrs_13 = 1'h0;
  assign io_intrs_14 = 1'h0;
  assign io_intrs_15 = 1'h0;
  assign io_excInOut_M_ByteEn = io_memInOut_M_ByteEn;
  assign io_excInOut_M_Data = io_memInOut_M_Data;
  assign io_excInOut_M_Addr = io_memInOut_M_Addr;
  assign io_excInOut_M_Cmd = T53;
  assign T53 = selDeviceVec_1 ? io_memInOut_M_Cmd : 3'h0;
  assign selDeviceVec_1 = T54;
  assign T54 = selIO & T55;
  assign T55 = T56 == 4'h1;
  assign T56 = io_memInOut_M_Addr[5'h13:5'h10];
  assign io_comSpm_M_ByteEn = io_memInOut_M_ByteEn;
  assign io_comSpm_M_Data = io_memInOut_M_Data;
  assign io_comSpm_M_Addr = io_memInOut_M_Addr;
  assign io_comSpm_M_Cmd = T57;
  assign T57 = selComSpm ? io_memInOut_M_Cmd : 3'h0;
  assign selComSpm = selNI & T58;
  assign T58 = T59 == 1'h1;
  assign T59 = io_memInOut_M_Addr[5'h1b:5'h1b];
  assign io_comConf_M_RespAccept = comConfIO_io_master_M_RespAccept;
  assign io_comConf_M_ByteEn = comConfIO_io_master_M_ByteEn;
  assign io_comConf_M_Data = comConfIO_io_master_M_Data;
  assign io_comConf_M_Addr = comConfIO_io_master_M_Addr;
  assign io_comConf_M_Cmd = comConfIO_io_master_M_Cmd;
  assign io_memInOut_S_Data = T60;
  assign T60 = selDeviceReg_15 ? deviceSVec_15_Data : T61;
  assign T61 = selDeviceReg_14 ? deviceSVec_14_Data : T62;
  assign T62 = selDeviceReg_13 ? deviceSVec_13_Data : T63;
  assign T63 = selDeviceReg_12 ? deviceSVec_12_Data : T64;
  assign T64 = selDeviceReg_11 ? deviceSVec_11_Data : T65;
  assign T65 = selDeviceReg_10 ? deviceSVec_10_Data : T66;
  assign T66 = selDeviceReg_9 ? deviceSVec_9_Data : T67;
  assign T67 = selDeviceReg_8 ? deviceSVec_8_Data : T68;
  assign T68 = selDeviceReg_7 ? deviceSVec_7_Data : T69;
  assign T69 = selDeviceReg_6 ? deviceSVec_6_Data : T70;
  assign T70 = selDeviceReg_5 ? deviceSVec_5_Data : T71;
  assign T71 = selDeviceReg_4 ? deviceSVec_4_Data : T72;
  assign T72 = selDeviceReg_3 ? deviceSVec_3_Data : T73;
  assign T73 = selDeviceReg_2 ? deviceSVec_2_Data : T74;
  assign T74 = selDeviceReg_1 ? deviceSVec_1_Data : T75;
  assign T75 = selDeviceReg_0 ? deviceSVec_0_Data : T76;
  assign T76 = selComSpmReg ? io_comSpm_S_Data : T77;
  assign T77 = selComConfReg ? comConf_io_slave_S_Data : spm_io_S_Data;
  assign T78 = T79 ? selComConf : selComConfReg;
  assign T79 = io_memInOut_M_Cmd != 3'h0;
  assign T80 = T79 ? selComSpm : selComSpmReg;
  assign deviceSVec_0_Data = CpuInfo_io_ocp_S_Data;
  assign T81 = T79 ? selDeviceVec_0 : selDeviceReg_0;
  assign deviceSVec_1_Data = io_excInOut_S_Data;
  assign T82 = T79 ? selDeviceVec_1 : selDeviceReg_1;
  assign deviceSVec_2_Data = Timer_io_ocp_S_Data;
  assign T83 = T79 ? selDeviceVec_2 : selDeviceReg_2;
  assign deviceSVec_3_Data = 32'h0;
  assign T84 = T79 ? selDeviceVec_3 : selDeviceReg_3;
  assign selDeviceVec_3 = T85;
  assign T85 = selIO & T86;
  assign T86 = T87 == 4'h3;
  assign T87 = io_memInOut_M_Addr[5'h13:5'h10];
  assign deviceSVec_4_Data = 32'h0;
  assign T88 = T79 ? selDeviceVec_4 : selDeviceReg_4;
  assign selDeviceVec_4 = T89;
  assign T89 = selIO & T90;
  assign T90 = T91 == 4'h4;
  assign T91 = io_memInOut_M_Addr[5'h13:5'h10];
  assign deviceSVec_5_Data = 32'h0;
  assign T92 = T79 ? selDeviceVec_5 : selDeviceReg_5;
  assign selDeviceVec_5 = T93;
  assign T93 = selIO & T94;
  assign T94 = T95 == 4'h5;
  assign T95 = io_memInOut_M_Addr[5'h13:5'h10];
  assign deviceSVec_6_Data = 32'h0;
  assign T96 = T79 ? selDeviceVec_6 : selDeviceReg_6;
  assign selDeviceVec_6 = T97;
  assign T97 = selIO & T98;
  assign T98 = T99 == 4'h6;
  assign T99 = io_memInOut_M_Addr[5'h13:5'h10];
  assign deviceSVec_7_Data = 32'h0;
  assign T100 = T79 ? selDeviceVec_7 : selDeviceReg_7;
  assign selDeviceVec_7 = T101;
  assign T101 = selIO & T102;
  assign T102 = T103 == 4'h7;
  assign T103 = io_memInOut_M_Addr[5'h13:5'h10];
  assign deviceSVec_8_Data = Uart_io_ocp_S_Data;
  assign T104 = T79 ? selDeviceVec_8 : selDeviceReg_8;
  assign deviceSVec_9_Data = Nexys4DDRIO_io_ocp_S_Data;
  assign T105 = T79 ? selDeviceVec_9 : selDeviceReg_9;
  assign deviceSVec_10_Data = FpuCtrl_io_ocp_S_Data;
  assign T106 = T79 ? selDeviceVec_10 : selDeviceReg_10;
  assign deviceSVec_11_Data = BRamCtrl_io_ocp_S_Data;
  assign T107 = T79 ? selDeviceVec_11 : selDeviceReg_11;
  assign deviceSVec_12_Data = IcapCtrl_io_ocp_S_Data;
  assign T108 = T79 ? selDeviceVec_12 : selDeviceReg_12;
  assign deviceSVec_13_Data = 32'h0;
  assign T109 = T79 ? selDeviceVec_13 : selDeviceReg_13;
  assign selDeviceVec_13 = T110;
  assign T110 = selIO & T111;
  assign T111 = T112 == 4'hd;
  assign T112 = io_memInOut_M_Addr[5'h13:5'h10];
  assign deviceSVec_14_Data = 32'h0;
  assign T113 = T79 ? selDeviceVec_14 : selDeviceReg_14;
  assign selDeviceVec_14 = T114;
  assign T114 = selIO & T115;
  assign T115 = T116 == 4'he;
  assign T116 = io_memInOut_M_Addr[5'h13:5'h10];
  assign deviceSVec_15_Data = 32'h0;
  assign T117 = T79 ? selDeviceVec_15 : selDeviceReg_15;
  assign selDeviceVec_15 = T118;
  assign T118 = selIO & T119;
  assign T119 = T120 == 4'hf;
  assign T120 = io_memInOut_M_Addr[5'h13:5'h10];
  assign io_memInOut_S_Resp = T121;
  assign T121 = T138 | T122;
  assign T122 = T123 | deviceSVec_15_Resp;
  assign deviceSVec_15_Resp = 2'h0;
  assign T123 = T124 | deviceSVec_14_Resp;
  assign deviceSVec_14_Resp = 2'h0;
  assign T124 = T125 | deviceSVec_13_Resp;
  assign deviceSVec_13_Resp = 2'h0;
  assign T125 = T126 | deviceSVec_12_Resp;
  assign deviceSVec_12_Resp = IcapCtrl_io_ocp_S_Resp;
  assign T126 = T127 | deviceSVec_11_Resp;
  assign deviceSVec_11_Resp = BRamCtrl_io_ocp_S_Resp;
  assign T127 = T128 | deviceSVec_10_Resp;
  assign deviceSVec_10_Resp = FpuCtrl_io_ocp_S_Resp;
  assign T128 = T129 | deviceSVec_9_Resp;
  assign deviceSVec_9_Resp = Nexys4DDRIO_io_ocp_S_Resp;
  assign T129 = T130 | deviceSVec_8_Resp;
  assign deviceSVec_8_Resp = Uart_io_ocp_S_Resp;
  assign T130 = T131 | deviceSVec_7_Resp;
  assign deviceSVec_7_Resp = 2'h0;
  assign T131 = T132 | deviceSVec_6_Resp;
  assign deviceSVec_6_Resp = 2'h0;
  assign T132 = T133 | deviceSVec_5_Resp;
  assign deviceSVec_5_Resp = 2'h0;
  assign T133 = T134 | deviceSVec_4_Resp;
  assign deviceSVec_4_Resp = 2'h0;
  assign T134 = T135 | deviceSVec_3_Resp;
  assign deviceSVec_3_Resp = 2'h0;
  assign T135 = T136 | deviceSVec_2_Resp;
  assign deviceSVec_2_Resp = Timer_io_ocp_S_Resp;
  assign T136 = T137 | deviceSVec_1_Resp;
  assign deviceSVec_1_Resp = io_excInOut_S_Resp;
  assign T137 = 2'h0 | deviceSVec_0_Resp;
  assign deviceSVec_0_Resp = CpuInfo_io_ocp_S_Resp;
  assign T138 = T139 | io_comSpm_S_Resp;
  assign T139 = T140 | comConf_io_slave_S_Resp;
  assign T140 = T141 | spm_io_S_Resp;
  assign T141 = errResp | ispmResp;
  assign ispmResp = T142 ? 2'h0 : 2'h1;
  assign T142 = ispmCmdReg == 3'h0;
  assign T143 = selISpm ? io_memInOut_M_Cmd : 3'h0;
  assign selISpm = T146 & T144;
  assign T144 = T145 == 1'h1;
  assign T145 = io_memInOut_M_Addr[5'h10:5'h10];
  assign T146 = T148 & T147;
  assign T147 = selNI ^ 1'h1;
  assign T148 = selIO ^ 1'h1;
  assign T174 = reset ? 2'h0 : T149;
  assign T149 = T150 ? 2'h3 : 2'h0;
  assign T150 = T167 & T151;
  assign T151 = validSel ^ 1'h1;
  assign validSel = T152 | validSelVec_15;
  assign validSelVec_15 = selDeviceVec_15 & validDeviceVec_15;
  assign validDeviceVec_15 = 1'h0;
  assign T152 = T153 | validSelVec_14;
  assign validSelVec_14 = selDeviceVec_14 & validDeviceVec_14;
  assign validDeviceVec_14 = 1'h0;
  assign T153 = T154 | validSelVec_13;
  assign validSelVec_13 = selDeviceVec_13 & validDeviceVec_13;
  assign validDeviceVec_13 = 1'h0;
  assign T154 = T155 | validSelVec_12;
  assign validSelVec_12 = selDeviceVec_12 & validDeviceVec_12;
  assign validDeviceVec_12 = 1'h1;
  assign T155 = T156 | validSelVec_11;
  assign validSelVec_11 = selDeviceVec_11 & validDeviceVec_11;
  assign validDeviceVec_11 = 1'h1;
  assign T156 = T157 | validSelVec_10;
  assign validSelVec_10 = selDeviceVec_10 & validDeviceVec_10;
  assign validDeviceVec_10 = 1'h1;
  assign T157 = T158 | validSelVec_9;
  assign validSelVec_9 = selDeviceVec_9 & validDeviceVec_9;
  assign validDeviceVec_9 = 1'h1;
  assign T158 = T159 | validSelVec_8;
  assign validSelVec_8 = selDeviceVec_8 & validDeviceVec_8;
  assign validDeviceVec_8 = 1'h1;
  assign T159 = T160 | validSelVec_7;
  assign validSelVec_7 = selDeviceVec_7 & validDeviceVec_7;
  assign validDeviceVec_7 = 1'h0;
  assign T160 = T161 | validSelVec_6;
  assign validSelVec_6 = selDeviceVec_6 & validDeviceVec_6;
  assign validDeviceVec_6 = 1'h0;
  assign T161 = T162 | validSelVec_5;
  assign validSelVec_5 = selDeviceVec_5 & validDeviceVec_5;
  assign validDeviceVec_5 = 1'h0;
  assign T162 = T163 | validSelVec_4;
  assign validSelVec_4 = selDeviceVec_4 & validDeviceVec_4;
  assign validDeviceVec_4 = 1'h0;
  assign T163 = T164 | validSelVec_3;
  assign validSelVec_3 = selDeviceVec_3 & validDeviceVec_3;
  assign validDeviceVec_3 = 1'h0;
  assign T164 = T165 | validSelVec_2;
  assign validSelVec_2 = selDeviceVec_2 & validDeviceVec_2;
  assign validDeviceVec_2 = 1'h1;
  assign T165 = T166 | validSelVec_1;
  assign validSelVec_1 = selDeviceVec_1 & validDeviceVec_1;
  assign validDeviceVec_1 = 1'h1;
  assign T166 = 1'h0 | validSelVec_0;
  assign validSelVec_0 = selDeviceVec_0 & validDeviceVec_0;
  assign validDeviceVec_0 = 1'h1;
  assign T167 = T168 & selIO;
  assign T168 = io_memInOut_M_Cmd != 3'h0;
  Spm spm(.clk(clk),
       .io_M_Cmd( T45 ),
       .io_M_Addr( T173 ),
       .io_M_Data( io_memInOut_M_Data ),
       .io_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_S_Resp( spm_io_S_Resp ),
       .io_S_Data( spm_io_S_Data )
  );
  OcpCoreBus comConf(
       .io_slave_M_Cmd( T41 ),
       .io_slave_M_Addr( io_memInOut_M_Addr ),
       .io_slave_M_Data( io_memInOut_M_Data ),
       .io_slave_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_slave_S_Resp( comConf_io_slave_S_Resp ),
       .io_slave_S_Data( comConf_io_slave_S_Data ),
       .io_master_M_Cmd( comConf_io_master_M_Cmd ),
       .io_master_M_Addr( comConf_io_master_M_Addr ),
       .io_master_M_Data( comConf_io_master_M_Data ),
       .io_master_M_ByteEn( comConf_io_master_M_ByteEn ),
       .io_master_S_Resp( comConfIO_io_slave_S_Resp ),
       .io_master_S_Data( comConfIO_io_slave_S_Data )
  );
  OcpIOBus comConfIO(
       .io_slave_M_Cmd( R35 ),
       .io_slave_M_Addr( R39 ),
       .io_slave_M_Data( R37 ),
       .io_slave_M_ByteEn( R30 ),
       .io_slave_M_RespAccept( 1'h1 ),
       .io_slave_S_Resp( comConfIO_io_slave_S_Resp ),
       .io_slave_S_Data( comConfIO_io_slave_S_Data ),
       .io_slave_S_CmdAccept( comConfIO_io_slave_S_CmdAccept ),
       .io_master_M_Cmd( comConfIO_io_master_M_Cmd ),
       .io_master_M_Addr( comConfIO_io_master_M_Addr ),
       .io_master_M_Data( comConfIO_io_master_M_Data ),
       .io_master_M_ByteEn( comConfIO_io_master_M_ByteEn ),
       .io_master_M_RespAccept( comConfIO_io_master_M_RespAccept ),
       .io_master_S_Resp( io_comConf_S_Resp ),
       .io_master_S_Data( io_comConf_S_Data ),
       .io_master_S_CmdAccept( io_comConf_S_CmdAccept )
  );
  Uart Uart(.clk(clk), .reset(reset),
       .io_superMode( io_superMode ),
       .io_ocp_M_Cmd( T26 ),
       .io_ocp_M_Addr( io_memInOut_M_Addr ),
       .io_ocp_M_Data( io_memInOut_M_Data ),
       .io_ocp_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_ocp_S_Resp( Uart_io_ocp_S_Resp ),
       .io_ocp_S_Data( Uart_io_ocp_S_Data ),
       .io_uartPins_tx( Uart_io_uartPins_tx ),
       .io_uartPins_rx( io_uartPins_rx )
  );
  Nexys4DDRIO Nexys4DDRIO(
       .io_superMode( io_superMode ),
       .io_ocp_M_Cmd( T22 ),
       .io_ocp_M_Addr( io_memInOut_M_Addr ),
       .io_ocp_M_Data( io_memInOut_M_Data ),
       .io_ocp_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_ocp_S_Resp( Nexys4DDRIO_io_ocp_S_Resp ),
       .io_ocp_S_Data( Nexys4DDRIO_io_ocp_S_Data ),
       .io_nexys4DDRIOPins_MCmd( Nexys4DDRIO_io_nexys4DDRIOPins_MCmd ),
       .io_nexys4DDRIOPins_MAddr( Nexys4DDRIO_io_nexys4DDRIOPins_MAddr ),
       .io_nexys4DDRIOPins_MData( Nexys4DDRIO_io_nexys4DDRIOPins_MData ),
       .io_nexys4DDRIOPins_MByteEn( Nexys4DDRIO_io_nexys4DDRIOPins_MByteEn ),
       .io_nexys4DDRIOPins_SResp( io_nexys4DDRIOPins_SResp ),
       .io_nexys4DDRIOPins_SData( io_nexys4DDRIOPins_SData )
  );
  FpuCtrl FpuCtrl(
       .io_superMode( io_superMode ),
       .io_ocp_M_Cmd( T18 ),
       .io_ocp_M_Addr( io_memInOut_M_Addr ),
       .io_ocp_M_Data( io_memInOut_M_Data ),
       .io_ocp_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_ocp_S_Resp( FpuCtrl_io_ocp_S_Resp ),
       .io_ocp_S_Data( FpuCtrl_io_ocp_S_Data ),
       .io_fpuCtrlPins_MCmd( FpuCtrl_io_fpuCtrlPins_MCmd ),
       .io_fpuCtrlPins_MAddr( FpuCtrl_io_fpuCtrlPins_MAddr ),
       .io_fpuCtrlPins_MData( FpuCtrl_io_fpuCtrlPins_MData ),
       .io_fpuCtrlPins_MByteEn( FpuCtrl_io_fpuCtrlPins_MByteEn ),
       .io_fpuCtrlPins_SResp( io_fpuCtrlPins_SResp ),
       .io_fpuCtrlPins_SData( io_fpuCtrlPins_SData )
  );
  BRamCtrl BRamCtrl(
       .io_superMode( io_superMode ),
       .io_ocp_M_Cmd( T14 ),
       .io_ocp_M_Addr( io_memInOut_M_Addr ),
       .io_ocp_M_Data( io_memInOut_M_Data ),
       .io_ocp_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_ocp_S_Resp( BRamCtrl_io_ocp_S_Resp ),
       .io_ocp_S_Data( BRamCtrl_io_ocp_S_Data ),
       .io_bRamCtrlPins_MCmd( BRamCtrl_io_bRamCtrlPins_MCmd ),
       .io_bRamCtrlPins_MAddr( BRamCtrl_io_bRamCtrlPins_MAddr ),
       .io_bRamCtrlPins_MData( BRamCtrl_io_bRamCtrlPins_MData ),
       .io_bRamCtrlPins_MByteEn( BRamCtrl_io_bRamCtrlPins_MByteEn ),
       .io_bRamCtrlPins_SResp( io_bRamCtrlPins_SResp ),
       .io_bRamCtrlPins_SData( io_bRamCtrlPins_SData )
  );
  IcapCtrl IcapCtrl(
       .io_superMode( io_superMode ),
       .io_ocp_M_Cmd( T10 ),
       .io_ocp_M_Addr( io_memInOut_M_Addr ),
       .io_ocp_M_Data( io_memInOut_M_Data ),
       .io_ocp_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_ocp_S_Resp( IcapCtrl_io_ocp_S_Resp ),
       .io_ocp_S_Data( IcapCtrl_io_ocp_S_Data ),
       .io_icapCtrlPins_MCmd( IcapCtrl_io_icapCtrlPins_MCmd ),
       .io_icapCtrlPins_MAddr( IcapCtrl_io_icapCtrlPins_MAddr ),
       .io_icapCtrlPins_MData( IcapCtrl_io_icapCtrlPins_MData ),
       .io_icapCtrlPins_MByteEn( IcapCtrl_io_icapCtrlPins_MByteEn ),
       .io_icapCtrlPins_SResp( io_icapCtrlPins_SResp ),
       .io_icapCtrlPins_SData( io_icapCtrlPins_SData )
  );
  CpuInfo CpuInfo(.clk(clk),
       .io_superMode( io_superMode ),
       .io_ocp_M_Cmd( T6 ),
       .io_ocp_M_Addr( io_memInOut_M_Addr ),
       .io_ocp_M_Data( io_memInOut_M_Data ),
       .io_ocp_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_ocp_S_Resp( CpuInfo_io_ocp_S_Resp ),
       .io_ocp_S_Data( CpuInfo_io_ocp_S_Data ),
       .io_cpuInfoPins_id( io_cpuInfoPins_id ),
       .io_cpuInfoPins_cnt( io_cpuInfoPins_cnt )
  );
  Timer Timer(.clk(clk), .reset(reset),
       .io_superMode( io_superMode ),
       .io_ocp_M_Cmd( T1 ),
       .io_ocp_M_Addr( io_memInOut_M_Addr ),
       .io_ocp_M_Data( io_memInOut_M_Data ),
       .io_ocp_M_ByteEn( io_memInOut_M_ByteEn ),
       .io_ocp_S_Resp( Timer_io_ocp_S_Resp ),
       .io_ocp_S_Data( Timer_io_ocp_S_Data ),
       .io_timerIntrs_1( Timer_io_timerIntrs_1 ),
       .io_timerIntrs_0( Timer_io_timerIntrs_0 )
  );

  always @(posedge clk) begin
`ifndef SYNTHESIS
// synthesis translate_off
  if(reset) T0 <= 1'b1;
  if(!1'h1 && T0 && !reset) begin
    $fwrite(32'h80000002, "ASSERTION FAILED: %s\n", "Conflicting addressspaces of IO devices");
    $finish;
  end
// synthesis translate_on
`endif
    if(reset) begin
      R30 <= comConf_io_master_M_ByteEn;
    end else if(T32) begin
      R30 <= comConf_io_master_M_ByteEn;
    end
    if(reset) begin
      R35 <= comConf_io_master_M_Cmd;
    end else if(T32) begin
      R35 <= comConf_io_master_M_Cmd;
    end
    if(reset) begin
      R37 <= comConf_io_master_M_Data;
    end else if(T32) begin
      R37 <= comConf_io_master_M_Data;
    end
    if(reset) begin
      R39 <= comConf_io_master_M_Addr;
    end else if(T32) begin
      R39 <= comConf_io_master_M_Addr;
    end
    if(T79) begin
      selComConfReg <= selComConf;
    end
    if(T79) begin
      selComSpmReg <= selComSpm;
    end
    if(T79) begin
      selDeviceReg_0 <= selDeviceVec_0;
    end
    if(T79) begin
      selDeviceReg_1 <= selDeviceVec_1;
    end
    if(T79) begin
      selDeviceReg_2 <= selDeviceVec_2;
    end
    if(T79) begin
      selDeviceReg_3 <= selDeviceVec_3;
    end
    if(T79) begin
      selDeviceReg_4 <= selDeviceVec_4;
    end
    if(T79) begin
      selDeviceReg_5 <= selDeviceVec_5;
    end
    if(T79) begin
      selDeviceReg_6 <= selDeviceVec_6;
    end
    if(T79) begin
      selDeviceReg_7 <= selDeviceVec_7;
    end
    if(T79) begin
      selDeviceReg_8 <= selDeviceVec_8;
    end
    if(T79) begin
      selDeviceReg_9 <= selDeviceVec_9;
    end
    if(T79) begin
      selDeviceReg_10 <= selDeviceVec_10;
    end
    if(T79) begin
      selDeviceReg_11 <= selDeviceVec_11;
    end
    if(T79) begin
      selDeviceReg_12 <= selDeviceVec_12;
    end
    if(T79) begin
      selDeviceReg_13 <= selDeviceVec_13;
    end
    if(T79) begin
      selDeviceReg_14 <= selDeviceVec_14;
    end
    if(T79) begin
      selDeviceReg_15 <= selDeviceVec_15;
    end
    if(selISpm) begin
      ispmCmdReg <= io_memInOut_M_Cmd;
    end else begin
      ispmCmdReg <= 3'h0;
    end
    if(reset) begin
      errResp <= 2'h0;
    end else if(T150) begin
      errResp <= 2'h3;
    end else begin
      errResp <= 2'h0;
    end
  end
endmodule

module MemBlock_3(input clk,
    input [6:0] io_rdAddr,
    output[20:0] io_rdData,
    input [6:0] io_wrAddr,
    input  io_wrEna,
    input [20:0] io_wrData
);

  wire[20:0] T0;
  wire[20:0] T1;
  reg [20:0] mem [127:0];
  wire[20:0] T2;
  wire T3;
  reg [6:0] rdAddrReg;
  reg [20:0] R4;
  wire T5;
  wire T6;
  reg [6:0] R7;
  wire T8;
  reg  R9;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    for (initvar = 0; initvar < 128; initvar = initvar+1)
      mem[initvar] = {1{$random}};
    rdAddrReg = {1{$random}};
    R4 = {1{$random}};
    R7 = {1{$random}};
    R9 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_rdData = T0;
  assign T0 = T5 ? R4 : T1;
  assign T1 = mem[rdAddrReg];
  assign T3 = io_wrEna == 1'h1;
  assign T5 = T8 & T6;
  assign T6 = R7 == rdAddrReg;
  assign T8 = R9 == 1'h1;

  always @(posedge clk) begin
    if (T3)
      mem[io_wrAddr] <= io_wrData;
    rdAddrReg <= io_rdAddr;
    R4 <= io_wrData;
    R7 <= io_wrAddr;
    R9 <= io_wrEna;
  end
endmodule

module MemBlock_4(input clk,
    input [8:0] io_rdAddr,
    output[7:0] io_rdData,
    input [8:0] io_wrAddr,
    input  io_wrEna,
    input [7:0] io_wrData
);

  wire[7:0] T0;
  wire[7:0] T1;
  reg [7:0] mem [511:0];
  wire[7:0] T2;
  wire T3;
  reg [8:0] rdAddrReg;
  reg [7:0] R4;
  wire T5;
  wire T6;
  reg [8:0] R7;
  wire T8;
  reg  R9;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    for (initvar = 0; initvar < 512; initvar = initvar+1)
      mem[initvar] = {1{$random}};
    rdAddrReg = {1{$random}};
    R4 = {1{$random}};
    R7 = {1{$random}};
    R9 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_rdData = T0;
  assign T0 = T5 ? R4 : T1;
  assign T1 = mem[rdAddrReg];
  assign T3 = io_wrEna == 1'h1;
  assign T5 = T8 & T6;
  assign T6 = R7 == rdAddrReg;
  assign T8 = R9 == 1'h1;

  always @(posedge clk) begin
    if (T3)
      mem[io_wrAddr] <= io_wrData;
    rdAddrReg <= io_rdAddr;
    R4 <= io_wrData;
    R7 <= io_wrAddr;
    R9 <= io_wrEna;
  end
endmodule

module DirectMappedCache(input clk, input reset,
    input [2:0] io_master_M_Cmd,
    input [31:0] io_master_M_Addr,
    input [31:0] io_master_M_Data,
    input [3:0] io_master_M_ByteEn,
    output[1:0] io_master_S_Resp,
    output[31:0] io_master_S_Data,
    output[2:0] io_slave_M_Cmd,
    output[31:0] io_slave_M_Addr,
    output[31:0] io_slave_M_Data,
    output io_slave_M_DataValid,
    output[3:0] io_slave_M_DataByteEn,
    input [1:0] io_slave_S_Resp,
    input [31:0] io_slave_S_Data,
    input  io_slave_S_CmdAccept,
    input  io_slave_S_DataAccept,
    input  io_invalidate,
    output io_perf_hit,
    output io_perf_miss
);

  wire[7:0] T0;
  reg [31:0] wrDataReg;
  wire[31:0] T1;
  wire T2;
  wire T3;
  wire T4;
  reg [1:0] stateReg;
  wire[1:0] T1243;
  wire[1:0] T5;
  wire[1:0] T6;
  wire[1:0] T7;
  wire[1:0] T8;
  wire[1:0] T9;
  wire[1:0] T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  reg [2:0] masterReg_Cmd;
  wire T15;
  wire tagValid;
  wire T16;
  wire[20:0] T17;
  reg [31:0] masterReg_Addr;
  wire[31:0] T18;
  wire[31:0] T19;
  wire[31:0] T20;
  wire T21;
  reg  tagV;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  wire T26;
  wire T27;
  wire T28;
  reg  tagVMem_0;
  wire T1244;
  wire T29;
  wire T30;
  wire T31;
  wire T32;
  wire T33;
  wire[127:0] T34;
  wire[6:0] T35;
  wire[6:0] T36;
  wire T37;
  wire T38;
  wire[127:0] T39;
  wire[6:0] T40;
  wire[6:0] T41;
  wire T42;
  wire T43;
  reg  tagVMem_1;
  wire T1245;
  wire T44;
  wire T45;
  wire T46;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire[6:0] T52;
  wire[6:0] T53;
  wire T54;
  reg  tagVMem_2;
  wire T1246;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire T59;
  wire T60;
  wire T61;
  reg  tagVMem_3;
  wire T1247;
  wire T62;
  wire T63;
  wire T64;
  wire T65;
  wire T66;
  wire T67;
  wire T68;
  wire T69;
  wire T70;
  wire T71;
  wire T72;
  reg  tagVMem_4;
  wire T1248;
  wire T73;
  wire T74;
  wire T75;
  wire T76;
  wire T77;
  wire T78;
  wire T79;
  reg  tagVMem_5;
  wire T1249;
  wire T80;
  wire T81;
  wire T82;
  wire T83;
  wire T84;
  wire T85;
  wire T86;
  wire T87;
  wire T88;
  reg  tagVMem_6;
  wire T1250;
  wire T89;
  wire T90;
  wire T91;
  wire T92;
  wire T93;
  wire T94;
  wire T95;
  reg  tagVMem_7;
  wire T1251;
  wire T96;
  wire T97;
  wire T98;
  wire T99;
  wire T100;
  wire T101;
  wire T102;
  wire T103;
  wire T104;
  wire T105;
  wire T106;
  wire T107;
  wire T108;
  reg  tagVMem_8;
  wire T1252;
  wire T109;
  wire T110;
  wire T111;
  wire T112;
  wire T113;
  wire T114;
  wire T115;
  reg  tagVMem_9;
  wire T1253;
  wire T116;
  wire T117;
  wire T118;
  wire T119;
  wire T120;
  wire T121;
  wire T122;
  wire T123;
  wire T124;
  reg  tagVMem_10;
  wire T1254;
  wire T125;
  wire T126;
  wire T127;
  wire T128;
  wire T129;
  wire T130;
  wire T131;
  reg  tagVMem_11;
  wire T1255;
  wire T132;
  wire T133;
  wire T134;
  wire T135;
  wire T136;
  wire T137;
  wire T138;
  wire T139;
  wire T140;
  wire T141;
  wire T142;
  reg  tagVMem_12;
  wire T1256;
  wire T143;
  wire T144;
  wire T145;
  wire T146;
  wire T147;
  wire T148;
  wire T149;
  reg  tagVMem_13;
  wire T1257;
  wire T150;
  wire T151;
  wire T152;
  wire T153;
  wire T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;
  reg  tagVMem_14;
  wire T1258;
  wire T159;
  wire T160;
  wire T161;
  wire T162;
  wire T163;
  wire T164;
  wire T165;
  reg  tagVMem_15;
  wire T1259;
  wire T166;
  wire T167;
  wire T168;
  wire T169;
  wire T170;
  wire T171;
  wire T172;
  wire T173;
  wire T174;
  wire T175;
  wire T176;
  wire T177;
  wire T178;
  wire T179;
  wire T180;
  reg  tagVMem_16;
  wire T1260;
  wire T181;
  wire T182;
  wire T183;
  wire T184;
  wire T185;
  wire T186;
  wire T187;
  reg  tagVMem_17;
  wire T1261;
  wire T188;
  wire T189;
  wire T190;
  wire T191;
  wire T192;
  wire T193;
  wire T194;
  wire T195;
  wire T196;
  reg  tagVMem_18;
  wire T1262;
  wire T197;
  wire T198;
  wire T199;
  wire T200;
  wire T201;
  wire T202;
  wire T203;
  reg  tagVMem_19;
  wire T1263;
  wire T204;
  wire T205;
  wire T206;
  wire T207;
  wire T208;
  wire T209;
  wire T210;
  wire T211;
  wire T212;
  wire T213;
  wire T214;
  reg  tagVMem_20;
  wire T1264;
  wire T215;
  wire T216;
  wire T217;
  wire T218;
  wire T219;
  wire T220;
  wire T221;
  reg  tagVMem_21;
  wire T1265;
  wire T222;
  wire T223;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  wire T228;
  wire T229;
  wire T230;
  reg  tagVMem_22;
  wire T1266;
  wire T231;
  wire T232;
  wire T233;
  wire T234;
  wire T235;
  wire T236;
  wire T237;
  reg  tagVMem_23;
  wire T1267;
  wire T238;
  wire T239;
  wire T240;
  wire T241;
  wire T242;
  wire T243;
  wire T244;
  wire T245;
  wire T246;
  wire T247;
  wire T248;
  wire T249;
  wire T250;
  reg  tagVMem_24;
  wire T1268;
  wire T251;
  wire T252;
  wire T253;
  wire T254;
  wire T255;
  wire T256;
  wire T257;
  reg  tagVMem_25;
  wire T1269;
  wire T258;
  wire T259;
  wire T260;
  wire T261;
  wire T262;
  wire T263;
  wire T264;
  wire T265;
  wire T266;
  reg  tagVMem_26;
  wire T1270;
  wire T267;
  wire T268;
  wire T269;
  wire T270;
  wire T271;
  wire T272;
  wire T273;
  reg  tagVMem_27;
  wire T1271;
  wire T274;
  wire T275;
  wire T276;
  wire T277;
  wire T278;
  wire T279;
  wire T280;
  wire T281;
  wire T282;
  wire T283;
  wire T284;
  reg  tagVMem_28;
  wire T1272;
  wire T285;
  wire T286;
  wire T287;
  wire T288;
  wire T289;
  wire T290;
  wire T291;
  reg  tagVMem_29;
  wire T1273;
  wire T292;
  wire T293;
  wire T294;
  wire T295;
  wire T296;
  wire T297;
  wire T298;
  wire T299;
  wire T300;
  reg  tagVMem_30;
  wire T1274;
  wire T301;
  wire T302;
  wire T303;
  wire T304;
  wire T305;
  wire T306;
  wire T307;
  reg  tagVMem_31;
  wire T1275;
  wire T308;
  wire T309;
  wire T310;
  wire T311;
  wire T312;
  wire T313;
  wire T314;
  wire T315;
  wire T316;
  wire T317;
  wire T318;
  wire T319;
  wire T320;
  wire T321;
  wire T322;
  wire T323;
  wire T324;
  reg  tagVMem_32;
  wire T1276;
  wire T325;
  wire T326;
  wire T327;
  wire T328;
  wire T329;
  wire T330;
  wire T331;
  reg  tagVMem_33;
  wire T1277;
  wire T332;
  wire T333;
  wire T334;
  wire T335;
  wire T336;
  wire T337;
  wire T338;
  wire T339;
  wire T340;
  reg  tagVMem_34;
  wire T1278;
  wire T341;
  wire T342;
  wire T343;
  wire T344;
  wire T345;
  wire T346;
  wire T347;
  reg  tagVMem_35;
  wire T1279;
  wire T348;
  wire T349;
  wire T350;
  wire T351;
  wire T352;
  wire T353;
  wire T354;
  wire T355;
  wire T356;
  wire T357;
  wire T358;
  reg  tagVMem_36;
  wire T1280;
  wire T359;
  wire T360;
  wire T361;
  wire T362;
  wire T363;
  wire T364;
  wire T365;
  reg  tagVMem_37;
  wire T1281;
  wire T366;
  wire T367;
  wire T368;
  wire T369;
  wire T370;
  wire T371;
  wire T372;
  wire T373;
  wire T374;
  reg  tagVMem_38;
  wire T1282;
  wire T375;
  wire T376;
  wire T377;
  wire T378;
  wire T379;
  wire T380;
  wire T381;
  reg  tagVMem_39;
  wire T1283;
  wire T382;
  wire T383;
  wire T384;
  wire T385;
  wire T386;
  wire T387;
  wire T388;
  wire T389;
  wire T390;
  wire T391;
  wire T392;
  wire T393;
  wire T394;
  reg  tagVMem_40;
  wire T1284;
  wire T395;
  wire T396;
  wire T397;
  wire T398;
  wire T399;
  wire T400;
  wire T401;
  reg  tagVMem_41;
  wire T1285;
  wire T402;
  wire T403;
  wire T404;
  wire T405;
  wire T406;
  wire T407;
  wire T408;
  wire T409;
  wire T410;
  reg  tagVMem_42;
  wire T1286;
  wire T411;
  wire T412;
  wire T413;
  wire T414;
  wire T415;
  wire T416;
  wire T417;
  reg  tagVMem_43;
  wire T1287;
  wire T418;
  wire T419;
  wire T420;
  wire T421;
  wire T422;
  wire T423;
  wire T424;
  wire T425;
  wire T426;
  wire T427;
  wire T428;
  reg  tagVMem_44;
  wire T1288;
  wire T429;
  wire T430;
  wire T431;
  wire T432;
  wire T433;
  wire T434;
  wire T435;
  reg  tagVMem_45;
  wire T1289;
  wire T436;
  wire T437;
  wire T438;
  wire T439;
  wire T440;
  wire T441;
  wire T442;
  wire T443;
  wire T444;
  reg  tagVMem_46;
  wire T1290;
  wire T445;
  wire T446;
  wire T447;
  wire T448;
  wire T449;
  wire T450;
  wire T451;
  reg  tagVMem_47;
  wire T1291;
  wire T452;
  wire T453;
  wire T454;
  wire T455;
  wire T456;
  wire T457;
  wire T458;
  wire T459;
  wire T460;
  wire T461;
  wire T462;
  wire T463;
  wire T464;
  wire T465;
  wire T466;
  reg  tagVMem_48;
  wire T1292;
  wire T467;
  wire T468;
  wire T469;
  wire T470;
  wire T471;
  wire T472;
  wire T473;
  reg  tagVMem_49;
  wire T1293;
  wire T474;
  wire T475;
  wire T476;
  wire T477;
  wire T478;
  wire T479;
  wire T480;
  wire T481;
  wire T482;
  reg  tagVMem_50;
  wire T1294;
  wire T483;
  wire T484;
  wire T485;
  wire T486;
  wire T487;
  wire T488;
  wire T489;
  reg  tagVMem_51;
  wire T1295;
  wire T490;
  wire T491;
  wire T492;
  wire T493;
  wire T494;
  wire T495;
  wire T496;
  wire T497;
  wire T498;
  wire T499;
  wire T500;
  reg  tagVMem_52;
  wire T1296;
  wire T501;
  wire T502;
  wire T503;
  wire T504;
  wire T505;
  wire T506;
  wire T507;
  reg  tagVMem_53;
  wire T1297;
  wire T508;
  wire T509;
  wire T510;
  wire T511;
  wire T512;
  wire T513;
  wire T514;
  wire T515;
  wire T516;
  reg  tagVMem_54;
  wire T1298;
  wire T517;
  wire T518;
  wire T519;
  wire T520;
  wire T521;
  wire T522;
  wire T523;
  reg  tagVMem_55;
  wire T1299;
  wire T524;
  wire T525;
  wire T526;
  wire T527;
  wire T528;
  wire T529;
  wire T530;
  wire T531;
  wire T532;
  wire T533;
  wire T534;
  wire T535;
  wire T536;
  reg  tagVMem_56;
  wire T1300;
  wire T537;
  wire T538;
  wire T539;
  wire T540;
  wire T541;
  wire T542;
  wire T543;
  reg  tagVMem_57;
  wire T1301;
  wire T544;
  wire T545;
  wire T546;
  wire T547;
  wire T548;
  wire T549;
  wire T550;
  wire T551;
  wire T552;
  reg  tagVMem_58;
  wire T1302;
  wire T553;
  wire T554;
  wire T555;
  wire T556;
  wire T557;
  wire T558;
  wire T559;
  reg  tagVMem_59;
  wire T1303;
  wire T560;
  wire T561;
  wire T562;
  wire T563;
  wire T564;
  wire T565;
  wire T566;
  wire T567;
  wire T568;
  wire T569;
  wire T570;
  reg  tagVMem_60;
  wire T1304;
  wire T571;
  wire T572;
  wire T573;
  wire T574;
  wire T575;
  wire T576;
  wire T577;
  reg  tagVMem_61;
  wire T1305;
  wire T578;
  wire T579;
  wire T580;
  wire T581;
  wire T582;
  wire T583;
  wire T584;
  wire T585;
  wire T586;
  reg  tagVMem_62;
  wire T1306;
  wire T587;
  wire T588;
  wire T589;
  wire T590;
  wire T591;
  wire T592;
  wire T593;
  reg  tagVMem_63;
  wire T1307;
  wire T594;
  wire T595;
  wire T596;
  wire T597;
  wire T598;
  wire T599;
  wire T600;
  wire T601;
  wire T602;
  wire T603;
  wire T604;
  wire T605;
  wire T606;
  wire T607;
  wire T608;
  wire T609;
  wire T610;
  wire T611;
  wire T612;
  reg  tagVMem_64;
  wire T1308;
  wire T613;
  wire T614;
  wire T615;
  wire T616;
  wire T617;
  wire T618;
  wire T619;
  reg  tagVMem_65;
  wire T1309;
  wire T620;
  wire T621;
  wire T622;
  wire T623;
  wire T624;
  wire T625;
  wire T626;
  wire T627;
  wire T628;
  reg  tagVMem_66;
  wire T1310;
  wire T629;
  wire T630;
  wire T631;
  wire T632;
  wire T633;
  wire T634;
  wire T635;
  reg  tagVMem_67;
  wire T1311;
  wire T636;
  wire T637;
  wire T638;
  wire T639;
  wire T640;
  wire T641;
  wire T642;
  wire T643;
  wire T644;
  wire T645;
  wire T646;
  reg  tagVMem_68;
  wire T1312;
  wire T647;
  wire T648;
  wire T649;
  wire T650;
  wire T651;
  wire T652;
  wire T653;
  reg  tagVMem_69;
  wire T1313;
  wire T654;
  wire T655;
  wire T656;
  wire T657;
  wire T658;
  wire T659;
  wire T660;
  wire T661;
  wire T662;
  reg  tagVMem_70;
  wire T1314;
  wire T663;
  wire T664;
  wire T665;
  wire T666;
  wire T667;
  wire T668;
  wire T669;
  reg  tagVMem_71;
  wire T1315;
  wire T670;
  wire T671;
  wire T672;
  wire T673;
  wire T674;
  wire T675;
  wire T676;
  wire T677;
  wire T678;
  wire T679;
  wire T680;
  wire T681;
  wire T682;
  reg  tagVMem_72;
  wire T1316;
  wire T683;
  wire T684;
  wire T685;
  wire T686;
  wire T687;
  wire T688;
  wire T689;
  reg  tagVMem_73;
  wire T1317;
  wire T690;
  wire T691;
  wire T692;
  wire T693;
  wire T694;
  wire T695;
  wire T696;
  wire T697;
  wire T698;
  reg  tagVMem_74;
  wire T1318;
  wire T699;
  wire T700;
  wire T701;
  wire T702;
  wire T703;
  wire T704;
  wire T705;
  reg  tagVMem_75;
  wire T1319;
  wire T706;
  wire T707;
  wire T708;
  wire T709;
  wire T710;
  wire T711;
  wire T712;
  wire T713;
  wire T714;
  wire T715;
  wire T716;
  reg  tagVMem_76;
  wire T1320;
  wire T717;
  wire T718;
  wire T719;
  wire T720;
  wire T721;
  wire T722;
  wire T723;
  reg  tagVMem_77;
  wire T1321;
  wire T724;
  wire T725;
  wire T726;
  wire T727;
  wire T728;
  wire T729;
  wire T730;
  wire T731;
  wire T732;
  reg  tagVMem_78;
  wire T1322;
  wire T733;
  wire T734;
  wire T735;
  wire T736;
  wire T737;
  wire T738;
  wire T739;
  reg  tagVMem_79;
  wire T1323;
  wire T740;
  wire T741;
  wire T742;
  wire T743;
  wire T744;
  wire T745;
  wire T746;
  wire T747;
  wire T748;
  wire T749;
  wire T750;
  wire T751;
  wire T752;
  wire T753;
  wire T754;
  reg  tagVMem_80;
  wire T1324;
  wire T755;
  wire T756;
  wire T757;
  wire T758;
  wire T759;
  wire T760;
  wire T761;
  reg  tagVMem_81;
  wire T1325;
  wire T762;
  wire T763;
  wire T764;
  wire T765;
  wire T766;
  wire T767;
  wire T768;
  wire T769;
  wire T770;
  reg  tagVMem_82;
  wire T1326;
  wire T771;
  wire T772;
  wire T773;
  wire T774;
  wire T775;
  wire T776;
  wire T777;
  reg  tagVMem_83;
  wire T1327;
  wire T778;
  wire T779;
  wire T780;
  wire T781;
  wire T782;
  wire T783;
  wire T784;
  wire T785;
  wire T786;
  wire T787;
  wire T788;
  reg  tagVMem_84;
  wire T1328;
  wire T789;
  wire T790;
  wire T791;
  wire T792;
  wire T793;
  wire T794;
  wire T795;
  reg  tagVMem_85;
  wire T1329;
  wire T796;
  wire T797;
  wire T798;
  wire T799;
  wire T800;
  wire T801;
  wire T802;
  wire T803;
  wire T804;
  reg  tagVMem_86;
  wire T1330;
  wire T805;
  wire T806;
  wire T807;
  wire T808;
  wire T809;
  wire T810;
  wire T811;
  reg  tagVMem_87;
  wire T1331;
  wire T812;
  wire T813;
  wire T814;
  wire T815;
  wire T816;
  wire T817;
  wire T818;
  wire T819;
  wire T820;
  wire T821;
  wire T822;
  wire T823;
  wire T824;
  reg  tagVMem_88;
  wire T1332;
  wire T825;
  wire T826;
  wire T827;
  wire T828;
  wire T829;
  wire T830;
  wire T831;
  reg  tagVMem_89;
  wire T1333;
  wire T832;
  wire T833;
  wire T834;
  wire T835;
  wire T836;
  wire T837;
  wire T838;
  wire T839;
  wire T840;
  reg  tagVMem_90;
  wire T1334;
  wire T841;
  wire T842;
  wire T843;
  wire T844;
  wire T845;
  wire T846;
  wire T847;
  reg  tagVMem_91;
  wire T1335;
  wire T848;
  wire T849;
  wire T850;
  wire T851;
  wire T852;
  wire T853;
  wire T854;
  wire T855;
  wire T856;
  wire T857;
  wire T858;
  reg  tagVMem_92;
  wire T1336;
  wire T859;
  wire T860;
  wire T861;
  wire T862;
  wire T863;
  wire T864;
  wire T865;
  reg  tagVMem_93;
  wire T1337;
  wire T866;
  wire T867;
  wire T868;
  wire T869;
  wire T870;
  wire T871;
  wire T872;
  wire T873;
  wire T874;
  reg  tagVMem_94;
  wire T1338;
  wire T875;
  wire T876;
  wire T877;
  wire T878;
  wire T879;
  wire T880;
  wire T881;
  reg  tagVMem_95;
  wire T1339;
  wire T882;
  wire T883;
  wire T884;
  wire T885;
  wire T886;
  wire T887;
  wire T888;
  wire T889;
  wire T890;
  wire T891;
  wire T892;
  wire T893;
  wire T894;
  wire T895;
  wire T896;
  wire T897;
  wire T898;
  reg  tagVMem_96;
  wire T1340;
  wire T899;
  wire T900;
  wire T901;
  wire T902;
  wire T903;
  wire T904;
  wire T905;
  reg  tagVMem_97;
  wire T1341;
  wire T906;
  wire T907;
  wire T908;
  wire T909;
  wire T910;
  wire T911;
  wire T912;
  wire T913;
  wire T914;
  reg  tagVMem_98;
  wire T1342;
  wire T915;
  wire T916;
  wire T917;
  wire T918;
  wire T919;
  wire T920;
  wire T921;
  reg  tagVMem_99;
  wire T1343;
  wire T922;
  wire T923;
  wire T924;
  wire T925;
  wire T926;
  wire T927;
  wire T928;
  wire T929;
  wire T930;
  wire T931;
  wire T932;
  reg  tagVMem_100;
  wire T1344;
  wire T933;
  wire T934;
  wire T935;
  wire T936;
  wire T937;
  wire T938;
  wire T939;
  reg  tagVMem_101;
  wire T1345;
  wire T940;
  wire T941;
  wire T942;
  wire T943;
  wire T944;
  wire T945;
  wire T946;
  wire T947;
  wire T948;
  reg  tagVMem_102;
  wire T1346;
  wire T949;
  wire T950;
  wire T951;
  wire T952;
  wire T953;
  wire T954;
  wire T955;
  reg  tagVMem_103;
  wire T1347;
  wire T956;
  wire T957;
  wire T958;
  wire T959;
  wire T960;
  wire T961;
  wire T962;
  wire T963;
  wire T964;
  wire T965;
  wire T966;
  wire T967;
  wire T968;
  reg  tagVMem_104;
  wire T1348;
  wire T969;
  wire T970;
  wire T971;
  wire T972;
  wire T973;
  wire T974;
  wire T975;
  reg  tagVMem_105;
  wire T1349;
  wire T976;
  wire T977;
  wire T978;
  wire T979;
  wire T980;
  wire T981;
  wire T982;
  wire T983;
  wire T984;
  reg  tagVMem_106;
  wire T1350;
  wire T985;
  wire T986;
  wire T987;
  wire T988;
  wire T989;
  wire T990;
  wire T991;
  reg  tagVMem_107;
  wire T1351;
  wire T992;
  wire T993;
  wire T994;
  wire T995;
  wire T996;
  wire T997;
  wire T998;
  wire T999;
  wire T1000;
  wire T1001;
  wire T1002;
  reg  tagVMem_108;
  wire T1352;
  wire T1003;
  wire T1004;
  wire T1005;
  wire T1006;
  wire T1007;
  wire T1008;
  wire T1009;
  reg  tagVMem_109;
  wire T1353;
  wire T1010;
  wire T1011;
  wire T1012;
  wire T1013;
  wire T1014;
  wire T1015;
  wire T1016;
  wire T1017;
  wire T1018;
  reg  tagVMem_110;
  wire T1354;
  wire T1019;
  wire T1020;
  wire T1021;
  wire T1022;
  wire T1023;
  wire T1024;
  wire T1025;
  reg  tagVMem_111;
  wire T1355;
  wire T1026;
  wire T1027;
  wire T1028;
  wire T1029;
  wire T1030;
  wire T1031;
  wire T1032;
  wire T1033;
  wire T1034;
  wire T1035;
  wire T1036;
  wire T1037;
  wire T1038;
  wire T1039;
  wire T1040;
  reg  tagVMem_112;
  wire T1356;
  wire T1041;
  wire T1042;
  wire T1043;
  wire T1044;
  wire T1045;
  wire T1046;
  wire T1047;
  reg  tagVMem_113;
  wire T1357;
  wire T1048;
  wire T1049;
  wire T1050;
  wire T1051;
  wire T1052;
  wire T1053;
  wire T1054;
  wire T1055;
  wire T1056;
  reg  tagVMem_114;
  wire T1358;
  wire T1057;
  wire T1058;
  wire T1059;
  wire T1060;
  wire T1061;
  wire T1062;
  wire T1063;
  reg  tagVMem_115;
  wire T1359;
  wire T1064;
  wire T1065;
  wire T1066;
  wire T1067;
  wire T1068;
  wire T1069;
  wire T1070;
  wire T1071;
  wire T1072;
  wire T1073;
  wire T1074;
  reg  tagVMem_116;
  wire T1360;
  wire T1075;
  wire T1076;
  wire T1077;
  wire T1078;
  wire T1079;
  wire T1080;
  wire T1081;
  reg  tagVMem_117;
  wire T1361;
  wire T1082;
  wire T1083;
  wire T1084;
  wire T1085;
  wire T1086;
  wire T1087;
  wire T1088;
  wire T1089;
  wire T1090;
  reg  tagVMem_118;
  wire T1362;
  wire T1091;
  wire T1092;
  wire T1093;
  wire T1094;
  wire T1095;
  wire T1096;
  wire T1097;
  reg  tagVMem_119;
  wire T1363;
  wire T1098;
  wire T1099;
  wire T1100;
  wire T1101;
  wire T1102;
  wire T1103;
  wire T1104;
  wire T1105;
  wire T1106;
  wire T1107;
  wire T1108;
  wire T1109;
  wire T1110;
  reg  tagVMem_120;
  wire T1364;
  wire T1111;
  wire T1112;
  wire T1113;
  wire T1114;
  wire T1115;
  wire T1116;
  wire T1117;
  reg  tagVMem_121;
  wire T1365;
  wire T1118;
  wire T1119;
  wire T1120;
  wire T1121;
  wire T1122;
  wire T1123;
  wire T1124;
  wire T1125;
  wire T1126;
  reg  tagVMem_122;
  wire T1366;
  wire T1127;
  wire T1128;
  wire T1129;
  wire T1130;
  wire T1131;
  wire T1132;
  wire T1133;
  reg  tagVMem_123;
  wire T1367;
  wire T1134;
  wire T1135;
  wire T1136;
  wire T1137;
  wire T1138;
  wire T1139;
  wire T1140;
  wire T1141;
  wire T1142;
  wire T1143;
  wire T1144;
  reg  tagVMem_124;
  wire T1368;
  wire T1145;
  wire T1146;
  wire T1147;
  wire T1148;
  wire T1149;
  wire T1150;
  wire T1151;
  reg  tagVMem_125;
  wire T1369;
  wire T1152;
  wire T1153;
  wire T1154;
  wire T1155;
  wire T1156;
  wire T1157;
  wire T1158;
  wire T1159;
  wire T1160;
  reg  tagVMem_126;
  wire T1370;
  wire T1161;
  wire T1162;
  wire T1163;
  wire T1164;
  wire T1165;
  wire T1166;
  wire T1167;
  reg  tagVMem_127;
  wire T1371;
  wire T1168;
  wire T1169;
  wire T1170;
  wire T1171;
  wire T1172;
  wire T1173;
  wire T1174;
  wire T1175;
  wire T1176;
  wire T1177;
  wire T1178;
  wire T1179;
  wire T1180;
  wire T1181;
  wire T1182;
  wire T1183;
  wire T1184;
  wire T1185;
  wire T1186;
  wire T1187;
  wire T1188;
  wire T1189;
  reg [1:0] burstCntReg;
  wire[1:0] T1372;
  wire[1:0] T1190;
  wire[1:0] T1191;
  wire T1192;
  wire T1193;
  wire T1194;
  wire T1195;
  wire[3:0] stmsk;
  reg [3:0] masterReg_ByteEn;
  wire T1196;
  reg  fillReg;
  reg [8:0] wrAddrReg;
  wire[8:0] T1197;
  wire[8:0] T1198;
  wire[8:0] T1199;
  wire[6:0] T1200;
  wire[8:0] T1201;
  wire[7:0] T1202;
  wire T1203;
  wire T1204;
  wire T1205;
  wire[8:0] T1206;
  wire[7:0] T1207;
  wire T1208;
  wire T1209;
  wire T1210;
  wire[8:0] T1211;
  wire[7:0] T1212;
  wire T1213;
  wire T1214;
  wire T1215;
  wire[8:0] T1216;
  wire[20:0] T1217;
  wire T1218;
  wire T1219;
  wire T1220;
  wire[6:0] T1221;
  wire[6:0] T1222;
  wire T1223;
  wire T1224;
  wire[31:0] T1225;
  wire[27:0] T1226;
  wire[2:0] T1227;
  wire[2:0] T1228;
  wire[31:0] T1229;
  wire[31:0] rdData;
  wire[23:0] T1230;
  wire[15:0] T1231;
  reg [31:0] slaveReg_Data;
  wire[31:0] T1232;
  wire T1233;
  wire T1234;
  reg [1:0] missIndexReg;
  wire[1:0] T1235;
  wire[1:0] T1236;
  wire[1:0] T1237;
  wire[1:0] T1238;
  wire[1:0] T1239;
  wire T1240;
  wire T1241;
  reg [1:0] slaveReg_Resp;
  wire[1:0] T1242;
  wire[20:0] tagMem_io_rdData;
  wire[7:0] MemBlock_io_rdData;
  wire[7:0] MemBlock_1_io_rdData;
  wire[7:0] MemBlock_2_io_rdData;
  wire[7:0] MemBlock_3_io_rdData;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    wrDataReg = {1{$random}};
    stateReg = {1{$random}};
    masterReg_Cmd = {1{$random}};
    masterReg_Addr = {1{$random}};
    tagV = {1{$random}};
    tagVMem_0 = {1{$random}};
    tagVMem_1 = {1{$random}};
    tagVMem_2 = {1{$random}};
    tagVMem_3 = {1{$random}};
    tagVMem_4 = {1{$random}};
    tagVMem_5 = {1{$random}};
    tagVMem_6 = {1{$random}};
    tagVMem_7 = {1{$random}};
    tagVMem_8 = {1{$random}};
    tagVMem_9 = {1{$random}};
    tagVMem_10 = {1{$random}};
    tagVMem_11 = {1{$random}};
    tagVMem_12 = {1{$random}};
    tagVMem_13 = {1{$random}};
    tagVMem_14 = {1{$random}};
    tagVMem_15 = {1{$random}};
    tagVMem_16 = {1{$random}};
    tagVMem_17 = {1{$random}};
    tagVMem_18 = {1{$random}};
    tagVMem_19 = {1{$random}};
    tagVMem_20 = {1{$random}};
    tagVMem_21 = {1{$random}};
    tagVMem_22 = {1{$random}};
    tagVMem_23 = {1{$random}};
    tagVMem_24 = {1{$random}};
    tagVMem_25 = {1{$random}};
    tagVMem_26 = {1{$random}};
    tagVMem_27 = {1{$random}};
    tagVMem_28 = {1{$random}};
    tagVMem_29 = {1{$random}};
    tagVMem_30 = {1{$random}};
    tagVMem_31 = {1{$random}};
    tagVMem_32 = {1{$random}};
    tagVMem_33 = {1{$random}};
    tagVMem_34 = {1{$random}};
    tagVMem_35 = {1{$random}};
    tagVMem_36 = {1{$random}};
    tagVMem_37 = {1{$random}};
    tagVMem_38 = {1{$random}};
    tagVMem_39 = {1{$random}};
    tagVMem_40 = {1{$random}};
    tagVMem_41 = {1{$random}};
    tagVMem_42 = {1{$random}};
    tagVMem_43 = {1{$random}};
    tagVMem_44 = {1{$random}};
    tagVMem_45 = {1{$random}};
    tagVMem_46 = {1{$random}};
    tagVMem_47 = {1{$random}};
    tagVMem_48 = {1{$random}};
    tagVMem_49 = {1{$random}};
    tagVMem_50 = {1{$random}};
    tagVMem_51 = {1{$random}};
    tagVMem_52 = {1{$random}};
    tagVMem_53 = {1{$random}};
    tagVMem_54 = {1{$random}};
    tagVMem_55 = {1{$random}};
    tagVMem_56 = {1{$random}};
    tagVMem_57 = {1{$random}};
    tagVMem_58 = {1{$random}};
    tagVMem_59 = {1{$random}};
    tagVMem_60 = {1{$random}};
    tagVMem_61 = {1{$random}};
    tagVMem_62 = {1{$random}};
    tagVMem_63 = {1{$random}};
    tagVMem_64 = {1{$random}};
    tagVMem_65 = {1{$random}};
    tagVMem_66 = {1{$random}};
    tagVMem_67 = {1{$random}};
    tagVMem_68 = {1{$random}};
    tagVMem_69 = {1{$random}};
    tagVMem_70 = {1{$random}};
    tagVMem_71 = {1{$random}};
    tagVMem_72 = {1{$random}};
    tagVMem_73 = {1{$random}};
    tagVMem_74 = {1{$random}};
    tagVMem_75 = {1{$random}};
    tagVMem_76 = {1{$random}};
    tagVMem_77 = {1{$random}};
    tagVMem_78 = {1{$random}};
    tagVMem_79 = {1{$random}};
    tagVMem_80 = {1{$random}};
    tagVMem_81 = {1{$random}};
    tagVMem_82 = {1{$random}};
    tagVMem_83 = {1{$random}};
    tagVMem_84 = {1{$random}};
    tagVMem_85 = {1{$random}};
    tagVMem_86 = {1{$random}};
    tagVMem_87 = {1{$random}};
    tagVMem_88 = {1{$random}};
    tagVMem_89 = {1{$random}};
    tagVMem_90 = {1{$random}};
    tagVMem_91 = {1{$random}};
    tagVMem_92 = {1{$random}};
    tagVMem_93 = {1{$random}};
    tagVMem_94 = {1{$random}};
    tagVMem_95 = {1{$random}};
    tagVMem_96 = {1{$random}};
    tagVMem_97 = {1{$random}};
    tagVMem_98 = {1{$random}};
    tagVMem_99 = {1{$random}};
    tagVMem_100 = {1{$random}};
    tagVMem_101 = {1{$random}};
    tagVMem_102 = {1{$random}};
    tagVMem_103 = {1{$random}};
    tagVMem_104 = {1{$random}};
    tagVMem_105 = {1{$random}};
    tagVMem_106 = {1{$random}};
    tagVMem_107 = {1{$random}};
    tagVMem_108 = {1{$random}};
    tagVMem_109 = {1{$random}};
    tagVMem_110 = {1{$random}};
    tagVMem_111 = {1{$random}};
    tagVMem_112 = {1{$random}};
    tagVMem_113 = {1{$random}};
    tagVMem_114 = {1{$random}};
    tagVMem_115 = {1{$random}};
    tagVMem_116 = {1{$random}};
    tagVMem_117 = {1{$random}};
    tagVMem_118 = {1{$random}};
    tagVMem_119 = {1{$random}};
    tagVMem_120 = {1{$random}};
    tagVMem_121 = {1{$random}};
    tagVMem_122 = {1{$random}};
    tagVMem_123 = {1{$random}};
    tagVMem_124 = {1{$random}};
    tagVMem_125 = {1{$random}};
    tagVMem_126 = {1{$random}};
    tagVMem_127 = {1{$random}};
    burstCntReg = {1{$random}};
    masterReg_ByteEn = {1{$random}};
    fillReg = {1{$random}};
    wrAddrReg = {1{$random}};
    slaveReg_Data = {1{$random}};
    missIndexReg = {1{$random}};
    slaveReg_Resp = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = wrDataReg[5'h1f:5'h18];
  assign T1 = T2 ? io_slave_S_Data : io_master_M_Data;
  assign T2 = T4 & T3;
  assign T3 = io_slave_S_Resp != 2'h0;
  assign T4 = stateReg == 2'h2;
  assign T1243 = reset ? 2'h0 : T5;
  assign T5 = T1192 ? 2'h0 : T6;
  assign T6 = T1188 ? 2'h3 : T7;
  assign T7 = T1186 ? 2'h1 : T8;
  assign T8 = T1184 ? 2'h2 : T9;
  assign T9 = T1182 ? 2'h1 : T10;
  assign T10 = T11 ? 2'h2 : stateReg;
  assign T11 = T13 & T12;
  assign T12 = io_slave_S_CmdAccept == 1'h1;
  assign T13 = T15 & T14;
  assign T14 = masterReg_Cmd == 3'h2;
  assign T15 = tagValid ^ 1'h1;
  assign tagValid = tagV & T16;
  assign T16 = tagMem_io_rdData == T17;
  assign T17 = masterReg_Addr[5'h1f:4'hb];
  assign T18 = T4 ? masterReg_Addr : T19;
  assign T19 = T21 ? masterReg_Addr : T20;
  assign T20 = T13 ? masterReg_Addr : io_master_M_Addr;
  assign T21 = stateReg == 2'h1;
  assign T22 = T1181 ? T607 : T23;
  assign T23 = T606 ? T320 : T24;
  assign T24 = T319 ? T177 : T25;
  assign T25 = T176 ? T106 : T26;
  assign T26 = T105 ? T71 : T27;
  assign T27 = T70 ? T54 : T28;
  assign T28 = T51 ? tagVMem_1 : tagVMem_0;
  assign T1244 = reset ? 1'h0 : T29;
  assign T29 = io_invalidate ? 1'h0 : T30;
  assign T30 = T37 ? 1'h0 : T31;
  assign T31 = T32 ? 1'h1 : tagVMem_0;
  assign T32 = T13 & T33;
  assign T33 = T34[1'h0:1'h0];
  assign T34 = 1'h1 << T35;
  assign T35 = T36;
  assign T36 = masterReg_Addr[4'ha:3'h4];
  assign T37 = T42 & T38;
  assign T38 = T39[1'h0:1'h0];
  assign T39 = 1'h1 << T40;
  assign T40 = T41;
  assign T41 = masterReg_Addr[4'ha:3'h4];
  assign T42 = T4 & T43;
  assign T43 = io_slave_S_Resp == 2'h3;
  assign T1245 = reset ? 1'h0 : T44;
  assign T44 = io_invalidate ? 1'h0 : T45;
  assign T45 = T49 ? 1'h0 : T46;
  assign T46 = T47 ? 1'h1 : tagVMem_1;
  assign T47 = T13 & T48;
  assign T48 = T34[1'h1:1'h1];
  assign T49 = T42 & T50;
  assign T50 = T39[1'h1:1'h1];
  assign T51 = T52[1'h0:1'h0];
  assign T52 = T53;
  assign T53 = io_master_M_Addr[4'ha:3'h4];
  assign T54 = T69 ? tagVMem_3 : tagVMem_2;
  assign T1246 = reset ? 1'h0 : T55;
  assign T55 = io_invalidate ? 1'h0 : T56;
  assign T56 = T60 ? 1'h0 : T57;
  assign T57 = T58 ? 1'h1 : tagVMem_2;
  assign T58 = T13 & T59;
  assign T59 = T34[2'h2:2'h2];
  assign T60 = T42 & T61;
  assign T61 = T39[2'h2:2'h2];
  assign T1247 = reset ? 1'h0 : T62;
  assign T62 = io_invalidate ? 1'h0 : T63;
  assign T63 = T67 ? 1'h0 : T64;
  assign T64 = T65 ? 1'h1 : tagVMem_3;
  assign T65 = T13 & T66;
  assign T66 = T34[2'h3:2'h3];
  assign T67 = T42 & T68;
  assign T68 = T39[2'h3:2'h3];
  assign T69 = T52[1'h0:1'h0];
  assign T70 = T52[1'h1:1'h1];
  assign T71 = T104 ? T88 : T72;
  assign T72 = T87 ? tagVMem_5 : tagVMem_4;
  assign T1248 = reset ? 1'h0 : T73;
  assign T73 = io_invalidate ? 1'h0 : T74;
  assign T74 = T78 ? 1'h0 : T75;
  assign T75 = T76 ? 1'h1 : tagVMem_4;
  assign T76 = T13 & T77;
  assign T77 = T34[3'h4:3'h4];
  assign T78 = T42 & T79;
  assign T79 = T39[3'h4:3'h4];
  assign T1249 = reset ? 1'h0 : T80;
  assign T80 = io_invalidate ? 1'h0 : T81;
  assign T81 = T85 ? 1'h0 : T82;
  assign T82 = T83 ? 1'h1 : tagVMem_5;
  assign T83 = T13 & T84;
  assign T84 = T34[3'h5:3'h5];
  assign T85 = T42 & T86;
  assign T86 = T39[3'h5:3'h5];
  assign T87 = T52[1'h0:1'h0];
  assign T88 = T103 ? tagVMem_7 : tagVMem_6;
  assign T1250 = reset ? 1'h0 : T89;
  assign T89 = io_invalidate ? 1'h0 : T90;
  assign T90 = T94 ? 1'h0 : T91;
  assign T91 = T92 ? 1'h1 : tagVMem_6;
  assign T92 = T13 & T93;
  assign T93 = T34[3'h6:3'h6];
  assign T94 = T42 & T95;
  assign T95 = T39[3'h6:3'h6];
  assign T1251 = reset ? 1'h0 : T96;
  assign T96 = io_invalidate ? 1'h0 : T97;
  assign T97 = T101 ? 1'h0 : T98;
  assign T98 = T99 ? 1'h1 : tagVMem_7;
  assign T99 = T13 & T100;
  assign T100 = T34[3'h7:3'h7];
  assign T101 = T42 & T102;
  assign T102 = T39[3'h7:3'h7];
  assign T103 = T52[1'h0:1'h0];
  assign T104 = T52[1'h1:1'h1];
  assign T105 = T52[2'h2:2'h2];
  assign T106 = T175 ? T141 : T107;
  assign T107 = T140 ? T124 : T108;
  assign T108 = T123 ? tagVMem_9 : tagVMem_8;
  assign T1252 = reset ? 1'h0 : T109;
  assign T109 = io_invalidate ? 1'h0 : T110;
  assign T110 = T114 ? 1'h0 : T111;
  assign T111 = T112 ? 1'h1 : tagVMem_8;
  assign T112 = T13 & T113;
  assign T113 = T34[4'h8:4'h8];
  assign T114 = T42 & T115;
  assign T115 = T39[4'h8:4'h8];
  assign T1253 = reset ? 1'h0 : T116;
  assign T116 = io_invalidate ? 1'h0 : T117;
  assign T117 = T121 ? 1'h0 : T118;
  assign T118 = T119 ? 1'h1 : tagVMem_9;
  assign T119 = T13 & T120;
  assign T120 = T34[4'h9:4'h9];
  assign T121 = T42 & T122;
  assign T122 = T39[4'h9:4'h9];
  assign T123 = T52[1'h0:1'h0];
  assign T124 = T139 ? tagVMem_11 : tagVMem_10;
  assign T1254 = reset ? 1'h0 : T125;
  assign T125 = io_invalidate ? 1'h0 : T126;
  assign T126 = T130 ? 1'h0 : T127;
  assign T127 = T128 ? 1'h1 : tagVMem_10;
  assign T128 = T13 & T129;
  assign T129 = T34[4'ha:4'ha];
  assign T130 = T42 & T131;
  assign T131 = T39[4'ha:4'ha];
  assign T1255 = reset ? 1'h0 : T132;
  assign T132 = io_invalidate ? 1'h0 : T133;
  assign T133 = T137 ? 1'h0 : T134;
  assign T134 = T135 ? 1'h1 : tagVMem_11;
  assign T135 = T13 & T136;
  assign T136 = T34[4'hb:4'hb];
  assign T137 = T42 & T138;
  assign T138 = T39[4'hb:4'hb];
  assign T139 = T52[1'h0:1'h0];
  assign T140 = T52[1'h1:1'h1];
  assign T141 = T174 ? T158 : T142;
  assign T142 = T157 ? tagVMem_13 : tagVMem_12;
  assign T1256 = reset ? 1'h0 : T143;
  assign T143 = io_invalidate ? 1'h0 : T144;
  assign T144 = T148 ? 1'h0 : T145;
  assign T145 = T146 ? 1'h1 : tagVMem_12;
  assign T146 = T13 & T147;
  assign T147 = T34[4'hc:4'hc];
  assign T148 = T42 & T149;
  assign T149 = T39[4'hc:4'hc];
  assign T1257 = reset ? 1'h0 : T150;
  assign T150 = io_invalidate ? 1'h0 : T151;
  assign T151 = T155 ? 1'h0 : T152;
  assign T152 = T153 ? 1'h1 : tagVMem_13;
  assign T153 = T13 & T154;
  assign T154 = T34[4'hd:4'hd];
  assign T155 = T42 & T156;
  assign T156 = T39[4'hd:4'hd];
  assign T157 = T52[1'h0:1'h0];
  assign T158 = T173 ? tagVMem_15 : tagVMem_14;
  assign T1258 = reset ? 1'h0 : T159;
  assign T159 = io_invalidate ? 1'h0 : T160;
  assign T160 = T164 ? 1'h0 : T161;
  assign T161 = T162 ? 1'h1 : tagVMem_14;
  assign T162 = T13 & T163;
  assign T163 = T34[4'he:4'he];
  assign T164 = T42 & T165;
  assign T165 = T39[4'he:4'he];
  assign T1259 = reset ? 1'h0 : T166;
  assign T166 = io_invalidate ? 1'h0 : T167;
  assign T167 = T171 ? 1'h0 : T168;
  assign T168 = T169 ? 1'h1 : tagVMem_15;
  assign T169 = T13 & T170;
  assign T170 = T34[4'hf:4'hf];
  assign T171 = T42 & T172;
  assign T172 = T39[4'hf:4'hf];
  assign T173 = T52[1'h0:1'h0];
  assign T174 = T52[1'h1:1'h1];
  assign T175 = T52[2'h2:2'h2];
  assign T176 = T52[2'h3:2'h3];
  assign T177 = T318 ? T248 : T178;
  assign T178 = T247 ? T213 : T179;
  assign T179 = T212 ? T196 : T180;
  assign T180 = T195 ? tagVMem_17 : tagVMem_16;
  assign T1260 = reset ? 1'h0 : T181;
  assign T181 = io_invalidate ? 1'h0 : T182;
  assign T182 = T186 ? 1'h0 : T183;
  assign T183 = T184 ? 1'h1 : tagVMem_16;
  assign T184 = T13 & T185;
  assign T185 = T34[5'h10:5'h10];
  assign T186 = T42 & T187;
  assign T187 = T39[5'h10:5'h10];
  assign T1261 = reset ? 1'h0 : T188;
  assign T188 = io_invalidate ? 1'h0 : T189;
  assign T189 = T193 ? 1'h0 : T190;
  assign T190 = T191 ? 1'h1 : tagVMem_17;
  assign T191 = T13 & T192;
  assign T192 = T34[5'h11:5'h11];
  assign T193 = T42 & T194;
  assign T194 = T39[5'h11:5'h11];
  assign T195 = T52[1'h0:1'h0];
  assign T196 = T211 ? tagVMem_19 : tagVMem_18;
  assign T1262 = reset ? 1'h0 : T197;
  assign T197 = io_invalidate ? 1'h0 : T198;
  assign T198 = T202 ? 1'h0 : T199;
  assign T199 = T200 ? 1'h1 : tagVMem_18;
  assign T200 = T13 & T201;
  assign T201 = T34[5'h12:5'h12];
  assign T202 = T42 & T203;
  assign T203 = T39[5'h12:5'h12];
  assign T1263 = reset ? 1'h0 : T204;
  assign T204 = io_invalidate ? 1'h0 : T205;
  assign T205 = T209 ? 1'h0 : T206;
  assign T206 = T207 ? 1'h1 : tagVMem_19;
  assign T207 = T13 & T208;
  assign T208 = T34[5'h13:5'h13];
  assign T209 = T42 & T210;
  assign T210 = T39[5'h13:5'h13];
  assign T211 = T52[1'h0:1'h0];
  assign T212 = T52[1'h1:1'h1];
  assign T213 = T246 ? T230 : T214;
  assign T214 = T229 ? tagVMem_21 : tagVMem_20;
  assign T1264 = reset ? 1'h0 : T215;
  assign T215 = io_invalidate ? 1'h0 : T216;
  assign T216 = T220 ? 1'h0 : T217;
  assign T217 = T218 ? 1'h1 : tagVMem_20;
  assign T218 = T13 & T219;
  assign T219 = T34[5'h14:5'h14];
  assign T220 = T42 & T221;
  assign T221 = T39[5'h14:5'h14];
  assign T1265 = reset ? 1'h0 : T222;
  assign T222 = io_invalidate ? 1'h0 : T223;
  assign T223 = T227 ? 1'h0 : T224;
  assign T224 = T225 ? 1'h1 : tagVMem_21;
  assign T225 = T13 & T226;
  assign T226 = T34[5'h15:5'h15];
  assign T227 = T42 & T228;
  assign T228 = T39[5'h15:5'h15];
  assign T229 = T52[1'h0:1'h0];
  assign T230 = T245 ? tagVMem_23 : tagVMem_22;
  assign T1266 = reset ? 1'h0 : T231;
  assign T231 = io_invalidate ? 1'h0 : T232;
  assign T232 = T236 ? 1'h0 : T233;
  assign T233 = T234 ? 1'h1 : tagVMem_22;
  assign T234 = T13 & T235;
  assign T235 = T34[5'h16:5'h16];
  assign T236 = T42 & T237;
  assign T237 = T39[5'h16:5'h16];
  assign T1267 = reset ? 1'h0 : T238;
  assign T238 = io_invalidate ? 1'h0 : T239;
  assign T239 = T243 ? 1'h0 : T240;
  assign T240 = T241 ? 1'h1 : tagVMem_23;
  assign T241 = T13 & T242;
  assign T242 = T34[5'h17:5'h17];
  assign T243 = T42 & T244;
  assign T244 = T39[5'h17:5'h17];
  assign T245 = T52[1'h0:1'h0];
  assign T246 = T52[1'h1:1'h1];
  assign T247 = T52[2'h2:2'h2];
  assign T248 = T317 ? T283 : T249;
  assign T249 = T282 ? T266 : T250;
  assign T250 = T265 ? tagVMem_25 : tagVMem_24;
  assign T1268 = reset ? 1'h0 : T251;
  assign T251 = io_invalidate ? 1'h0 : T252;
  assign T252 = T256 ? 1'h0 : T253;
  assign T253 = T254 ? 1'h1 : tagVMem_24;
  assign T254 = T13 & T255;
  assign T255 = T34[5'h18:5'h18];
  assign T256 = T42 & T257;
  assign T257 = T39[5'h18:5'h18];
  assign T1269 = reset ? 1'h0 : T258;
  assign T258 = io_invalidate ? 1'h0 : T259;
  assign T259 = T263 ? 1'h0 : T260;
  assign T260 = T261 ? 1'h1 : tagVMem_25;
  assign T261 = T13 & T262;
  assign T262 = T34[5'h19:5'h19];
  assign T263 = T42 & T264;
  assign T264 = T39[5'h19:5'h19];
  assign T265 = T52[1'h0:1'h0];
  assign T266 = T281 ? tagVMem_27 : tagVMem_26;
  assign T1270 = reset ? 1'h0 : T267;
  assign T267 = io_invalidate ? 1'h0 : T268;
  assign T268 = T272 ? 1'h0 : T269;
  assign T269 = T270 ? 1'h1 : tagVMem_26;
  assign T270 = T13 & T271;
  assign T271 = T34[5'h1a:5'h1a];
  assign T272 = T42 & T273;
  assign T273 = T39[5'h1a:5'h1a];
  assign T1271 = reset ? 1'h0 : T274;
  assign T274 = io_invalidate ? 1'h0 : T275;
  assign T275 = T279 ? 1'h0 : T276;
  assign T276 = T277 ? 1'h1 : tagVMem_27;
  assign T277 = T13 & T278;
  assign T278 = T34[5'h1b:5'h1b];
  assign T279 = T42 & T280;
  assign T280 = T39[5'h1b:5'h1b];
  assign T281 = T52[1'h0:1'h0];
  assign T282 = T52[1'h1:1'h1];
  assign T283 = T316 ? T300 : T284;
  assign T284 = T299 ? tagVMem_29 : tagVMem_28;
  assign T1272 = reset ? 1'h0 : T285;
  assign T285 = io_invalidate ? 1'h0 : T286;
  assign T286 = T290 ? 1'h0 : T287;
  assign T287 = T288 ? 1'h1 : tagVMem_28;
  assign T288 = T13 & T289;
  assign T289 = T34[5'h1c:5'h1c];
  assign T290 = T42 & T291;
  assign T291 = T39[5'h1c:5'h1c];
  assign T1273 = reset ? 1'h0 : T292;
  assign T292 = io_invalidate ? 1'h0 : T293;
  assign T293 = T297 ? 1'h0 : T294;
  assign T294 = T295 ? 1'h1 : tagVMem_29;
  assign T295 = T13 & T296;
  assign T296 = T34[5'h1d:5'h1d];
  assign T297 = T42 & T298;
  assign T298 = T39[5'h1d:5'h1d];
  assign T299 = T52[1'h0:1'h0];
  assign T300 = T315 ? tagVMem_31 : tagVMem_30;
  assign T1274 = reset ? 1'h0 : T301;
  assign T301 = io_invalidate ? 1'h0 : T302;
  assign T302 = T306 ? 1'h0 : T303;
  assign T303 = T304 ? 1'h1 : tagVMem_30;
  assign T304 = T13 & T305;
  assign T305 = T34[5'h1e:5'h1e];
  assign T306 = T42 & T307;
  assign T307 = T39[5'h1e:5'h1e];
  assign T1275 = reset ? 1'h0 : T308;
  assign T308 = io_invalidate ? 1'h0 : T309;
  assign T309 = T313 ? 1'h0 : T310;
  assign T310 = T311 ? 1'h1 : tagVMem_31;
  assign T311 = T13 & T312;
  assign T312 = T34[5'h1f:5'h1f];
  assign T313 = T42 & T314;
  assign T314 = T39[5'h1f:5'h1f];
  assign T315 = T52[1'h0:1'h0];
  assign T316 = T52[1'h1:1'h1];
  assign T317 = T52[2'h2:2'h2];
  assign T318 = T52[2'h3:2'h3];
  assign T319 = T52[3'h4:3'h4];
  assign T320 = T605 ? T463 : T321;
  assign T321 = T462 ? T392 : T322;
  assign T322 = T391 ? T357 : T323;
  assign T323 = T356 ? T340 : T324;
  assign T324 = T339 ? tagVMem_33 : tagVMem_32;
  assign T1276 = reset ? 1'h0 : T325;
  assign T325 = io_invalidate ? 1'h0 : T326;
  assign T326 = T330 ? 1'h0 : T327;
  assign T327 = T328 ? 1'h1 : tagVMem_32;
  assign T328 = T13 & T329;
  assign T329 = T34[6'h20:6'h20];
  assign T330 = T42 & T331;
  assign T331 = T39[6'h20:6'h20];
  assign T1277 = reset ? 1'h0 : T332;
  assign T332 = io_invalidate ? 1'h0 : T333;
  assign T333 = T337 ? 1'h0 : T334;
  assign T334 = T335 ? 1'h1 : tagVMem_33;
  assign T335 = T13 & T336;
  assign T336 = T34[6'h21:6'h21];
  assign T337 = T42 & T338;
  assign T338 = T39[6'h21:6'h21];
  assign T339 = T52[1'h0:1'h0];
  assign T340 = T355 ? tagVMem_35 : tagVMem_34;
  assign T1278 = reset ? 1'h0 : T341;
  assign T341 = io_invalidate ? 1'h0 : T342;
  assign T342 = T346 ? 1'h0 : T343;
  assign T343 = T344 ? 1'h1 : tagVMem_34;
  assign T344 = T13 & T345;
  assign T345 = T34[6'h22:6'h22];
  assign T346 = T42 & T347;
  assign T347 = T39[6'h22:6'h22];
  assign T1279 = reset ? 1'h0 : T348;
  assign T348 = io_invalidate ? 1'h0 : T349;
  assign T349 = T353 ? 1'h0 : T350;
  assign T350 = T351 ? 1'h1 : tagVMem_35;
  assign T351 = T13 & T352;
  assign T352 = T34[6'h23:6'h23];
  assign T353 = T42 & T354;
  assign T354 = T39[6'h23:6'h23];
  assign T355 = T52[1'h0:1'h0];
  assign T356 = T52[1'h1:1'h1];
  assign T357 = T390 ? T374 : T358;
  assign T358 = T373 ? tagVMem_37 : tagVMem_36;
  assign T1280 = reset ? 1'h0 : T359;
  assign T359 = io_invalidate ? 1'h0 : T360;
  assign T360 = T364 ? 1'h0 : T361;
  assign T361 = T362 ? 1'h1 : tagVMem_36;
  assign T362 = T13 & T363;
  assign T363 = T34[6'h24:6'h24];
  assign T364 = T42 & T365;
  assign T365 = T39[6'h24:6'h24];
  assign T1281 = reset ? 1'h0 : T366;
  assign T366 = io_invalidate ? 1'h0 : T367;
  assign T367 = T371 ? 1'h0 : T368;
  assign T368 = T369 ? 1'h1 : tagVMem_37;
  assign T369 = T13 & T370;
  assign T370 = T34[6'h25:6'h25];
  assign T371 = T42 & T372;
  assign T372 = T39[6'h25:6'h25];
  assign T373 = T52[1'h0:1'h0];
  assign T374 = T389 ? tagVMem_39 : tagVMem_38;
  assign T1282 = reset ? 1'h0 : T375;
  assign T375 = io_invalidate ? 1'h0 : T376;
  assign T376 = T380 ? 1'h0 : T377;
  assign T377 = T378 ? 1'h1 : tagVMem_38;
  assign T378 = T13 & T379;
  assign T379 = T34[6'h26:6'h26];
  assign T380 = T42 & T381;
  assign T381 = T39[6'h26:6'h26];
  assign T1283 = reset ? 1'h0 : T382;
  assign T382 = io_invalidate ? 1'h0 : T383;
  assign T383 = T387 ? 1'h0 : T384;
  assign T384 = T385 ? 1'h1 : tagVMem_39;
  assign T385 = T13 & T386;
  assign T386 = T34[6'h27:6'h27];
  assign T387 = T42 & T388;
  assign T388 = T39[6'h27:6'h27];
  assign T389 = T52[1'h0:1'h0];
  assign T390 = T52[1'h1:1'h1];
  assign T391 = T52[2'h2:2'h2];
  assign T392 = T461 ? T427 : T393;
  assign T393 = T426 ? T410 : T394;
  assign T394 = T409 ? tagVMem_41 : tagVMem_40;
  assign T1284 = reset ? 1'h0 : T395;
  assign T395 = io_invalidate ? 1'h0 : T396;
  assign T396 = T400 ? 1'h0 : T397;
  assign T397 = T398 ? 1'h1 : tagVMem_40;
  assign T398 = T13 & T399;
  assign T399 = T34[6'h28:6'h28];
  assign T400 = T42 & T401;
  assign T401 = T39[6'h28:6'h28];
  assign T1285 = reset ? 1'h0 : T402;
  assign T402 = io_invalidate ? 1'h0 : T403;
  assign T403 = T407 ? 1'h0 : T404;
  assign T404 = T405 ? 1'h1 : tagVMem_41;
  assign T405 = T13 & T406;
  assign T406 = T34[6'h29:6'h29];
  assign T407 = T42 & T408;
  assign T408 = T39[6'h29:6'h29];
  assign T409 = T52[1'h0:1'h0];
  assign T410 = T425 ? tagVMem_43 : tagVMem_42;
  assign T1286 = reset ? 1'h0 : T411;
  assign T411 = io_invalidate ? 1'h0 : T412;
  assign T412 = T416 ? 1'h0 : T413;
  assign T413 = T414 ? 1'h1 : tagVMem_42;
  assign T414 = T13 & T415;
  assign T415 = T34[6'h2a:6'h2a];
  assign T416 = T42 & T417;
  assign T417 = T39[6'h2a:6'h2a];
  assign T1287 = reset ? 1'h0 : T418;
  assign T418 = io_invalidate ? 1'h0 : T419;
  assign T419 = T423 ? 1'h0 : T420;
  assign T420 = T421 ? 1'h1 : tagVMem_43;
  assign T421 = T13 & T422;
  assign T422 = T34[6'h2b:6'h2b];
  assign T423 = T42 & T424;
  assign T424 = T39[6'h2b:6'h2b];
  assign T425 = T52[1'h0:1'h0];
  assign T426 = T52[1'h1:1'h1];
  assign T427 = T460 ? T444 : T428;
  assign T428 = T443 ? tagVMem_45 : tagVMem_44;
  assign T1288 = reset ? 1'h0 : T429;
  assign T429 = io_invalidate ? 1'h0 : T430;
  assign T430 = T434 ? 1'h0 : T431;
  assign T431 = T432 ? 1'h1 : tagVMem_44;
  assign T432 = T13 & T433;
  assign T433 = T34[6'h2c:6'h2c];
  assign T434 = T42 & T435;
  assign T435 = T39[6'h2c:6'h2c];
  assign T1289 = reset ? 1'h0 : T436;
  assign T436 = io_invalidate ? 1'h0 : T437;
  assign T437 = T441 ? 1'h0 : T438;
  assign T438 = T439 ? 1'h1 : tagVMem_45;
  assign T439 = T13 & T440;
  assign T440 = T34[6'h2d:6'h2d];
  assign T441 = T42 & T442;
  assign T442 = T39[6'h2d:6'h2d];
  assign T443 = T52[1'h0:1'h0];
  assign T444 = T459 ? tagVMem_47 : tagVMem_46;
  assign T1290 = reset ? 1'h0 : T445;
  assign T445 = io_invalidate ? 1'h0 : T446;
  assign T446 = T450 ? 1'h0 : T447;
  assign T447 = T448 ? 1'h1 : tagVMem_46;
  assign T448 = T13 & T449;
  assign T449 = T34[6'h2e:6'h2e];
  assign T450 = T42 & T451;
  assign T451 = T39[6'h2e:6'h2e];
  assign T1291 = reset ? 1'h0 : T452;
  assign T452 = io_invalidate ? 1'h0 : T453;
  assign T453 = T457 ? 1'h0 : T454;
  assign T454 = T455 ? 1'h1 : tagVMem_47;
  assign T455 = T13 & T456;
  assign T456 = T34[6'h2f:6'h2f];
  assign T457 = T42 & T458;
  assign T458 = T39[6'h2f:6'h2f];
  assign T459 = T52[1'h0:1'h0];
  assign T460 = T52[1'h1:1'h1];
  assign T461 = T52[2'h2:2'h2];
  assign T462 = T52[2'h3:2'h3];
  assign T463 = T604 ? T534 : T464;
  assign T464 = T533 ? T499 : T465;
  assign T465 = T498 ? T482 : T466;
  assign T466 = T481 ? tagVMem_49 : tagVMem_48;
  assign T1292 = reset ? 1'h0 : T467;
  assign T467 = io_invalidate ? 1'h0 : T468;
  assign T468 = T472 ? 1'h0 : T469;
  assign T469 = T470 ? 1'h1 : tagVMem_48;
  assign T470 = T13 & T471;
  assign T471 = T34[6'h30:6'h30];
  assign T472 = T42 & T473;
  assign T473 = T39[6'h30:6'h30];
  assign T1293 = reset ? 1'h0 : T474;
  assign T474 = io_invalidate ? 1'h0 : T475;
  assign T475 = T479 ? 1'h0 : T476;
  assign T476 = T477 ? 1'h1 : tagVMem_49;
  assign T477 = T13 & T478;
  assign T478 = T34[6'h31:6'h31];
  assign T479 = T42 & T480;
  assign T480 = T39[6'h31:6'h31];
  assign T481 = T52[1'h0:1'h0];
  assign T482 = T497 ? tagVMem_51 : tagVMem_50;
  assign T1294 = reset ? 1'h0 : T483;
  assign T483 = io_invalidate ? 1'h0 : T484;
  assign T484 = T488 ? 1'h0 : T485;
  assign T485 = T486 ? 1'h1 : tagVMem_50;
  assign T486 = T13 & T487;
  assign T487 = T34[6'h32:6'h32];
  assign T488 = T42 & T489;
  assign T489 = T39[6'h32:6'h32];
  assign T1295 = reset ? 1'h0 : T490;
  assign T490 = io_invalidate ? 1'h0 : T491;
  assign T491 = T495 ? 1'h0 : T492;
  assign T492 = T493 ? 1'h1 : tagVMem_51;
  assign T493 = T13 & T494;
  assign T494 = T34[6'h33:6'h33];
  assign T495 = T42 & T496;
  assign T496 = T39[6'h33:6'h33];
  assign T497 = T52[1'h0:1'h0];
  assign T498 = T52[1'h1:1'h1];
  assign T499 = T532 ? T516 : T500;
  assign T500 = T515 ? tagVMem_53 : tagVMem_52;
  assign T1296 = reset ? 1'h0 : T501;
  assign T501 = io_invalidate ? 1'h0 : T502;
  assign T502 = T506 ? 1'h0 : T503;
  assign T503 = T504 ? 1'h1 : tagVMem_52;
  assign T504 = T13 & T505;
  assign T505 = T34[6'h34:6'h34];
  assign T506 = T42 & T507;
  assign T507 = T39[6'h34:6'h34];
  assign T1297 = reset ? 1'h0 : T508;
  assign T508 = io_invalidate ? 1'h0 : T509;
  assign T509 = T513 ? 1'h0 : T510;
  assign T510 = T511 ? 1'h1 : tagVMem_53;
  assign T511 = T13 & T512;
  assign T512 = T34[6'h35:6'h35];
  assign T513 = T42 & T514;
  assign T514 = T39[6'h35:6'h35];
  assign T515 = T52[1'h0:1'h0];
  assign T516 = T531 ? tagVMem_55 : tagVMem_54;
  assign T1298 = reset ? 1'h0 : T517;
  assign T517 = io_invalidate ? 1'h0 : T518;
  assign T518 = T522 ? 1'h0 : T519;
  assign T519 = T520 ? 1'h1 : tagVMem_54;
  assign T520 = T13 & T521;
  assign T521 = T34[6'h36:6'h36];
  assign T522 = T42 & T523;
  assign T523 = T39[6'h36:6'h36];
  assign T1299 = reset ? 1'h0 : T524;
  assign T524 = io_invalidate ? 1'h0 : T525;
  assign T525 = T529 ? 1'h0 : T526;
  assign T526 = T527 ? 1'h1 : tagVMem_55;
  assign T527 = T13 & T528;
  assign T528 = T34[6'h37:6'h37];
  assign T529 = T42 & T530;
  assign T530 = T39[6'h37:6'h37];
  assign T531 = T52[1'h0:1'h0];
  assign T532 = T52[1'h1:1'h1];
  assign T533 = T52[2'h2:2'h2];
  assign T534 = T603 ? T569 : T535;
  assign T535 = T568 ? T552 : T536;
  assign T536 = T551 ? tagVMem_57 : tagVMem_56;
  assign T1300 = reset ? 1'h0 : T537;
  assign T537 = io_invalidate ? 1'h0 : T538;
  assign T538 = T542 ? 1'h0 : T539;
  assign T539 = T540 ? 1'h1 : tagVMem_56;
  assign T540 = T13 & T541;
  assign T541 = T34[6'h38:6'h38];
  assign T542 = T42 & T543;
  assign T543 = T39[6'h38:6'h38];
  assign T1301 = reset ? 1'h0 : T544;
  assign T544 = io_invalidate ? 1'h0 : T545;
  assign T545 = T549 ? 1'h0 : T546;
  assign T546 = T547 ? 1'h1 : tagVMem_57;
  assign T547 = T13 & T548;
  assign T548 = T34[6'h39:6'h39];
  assign T549 = T42 & T550;
  assign T550 = T39[6'h39:6'h39];
  assign T551 = T52[1'h0:1'h0];
  assign T552 = T567 ? tagVMem_59 : tagVMem_58;
  assign T1302 = reset ? 1'h0 : T553;
  assign T553 = io_invalidate ? 1'h0 : T554;
  assign T554 = T558 ? 1'h0 : T555;
  assign T555 = T556 ? 1'h1 : tagVMem_58;
  assign T556 = T13 & T557;
  assign T557 = T34[6'h3a:6'h3a];
  assign T558 = T42 & T559;
  assign T559 = T39[6'h3a:6'h3a];
  assign T1303 = reset ? 1'h0 : T560;
  assign T560 = io_invalidate ? 1'h0 : T561;
  assign T561 = T565 ? 1'h0 : T562;
  assign T562 = T563 ? 1'h1 : tagVMem_59;
  assign T563 = T13 & T564;
  assign T564 = T34[6'h3b:6'h3b];
  assign T565 = T42 & T566;
  assign T566 = T39[6'h3b:6'h3b];
  assign T567 = T52[1'h0:1'h0];
  assign T568 = T52[1'h1:1'h1];
  assign T569 = T602 ? T586 : T570;
  assign T570 = T585 ? tagVMem_61 : tagVMem_60;
  assign T1304 = reset ? 1'h0 : T571;
  assign T571 = io_invalidate ? 1'h0 : T572;
  assign T572 = T576 ? 1'h0 : T573;
  assign T573 = T574 ? 1'h1 : tagVMem_60;
  assign T574 = T13 & T575;
  assign T575 = T34[6'h3c:6'h3c];
  assign T576 = T42 & T577;
  assign T577 = T39[6'h3c:6'h3c];
  assign T1305 = reset ? 1'h0 : T578;
  assign T578 = io_invalidate ? 1'h0 : T579;
  assign T579 = T583 ? 1'h0 : T580;
  assign T580 = T581 ? 1'h1 : tagVMem_61;
  assign T581 = T13 & T582;
  assign T582 = T34[6'h3d:6'h3d];
  assign T583 = T42 & T584;
  assign T584 = T39[6'h3d:6'h3d];
  assign T585 = T52[1'h0:1'h0];
  assign T586 = T601 ? tagVMem_63 : tagVMem_62;
  assign T1306 = reset ? 1'h0 : T587;
  assign T587 = io_invalidate ? 1'h0 : T588;
  assign T588 = T592 ? 1'h0 : T589;
  assign T589 = T590 ? 1'h1 : tagVMem_62;
  assign T590 = T13 & T591;
  assign T591 = T34[6'h3e:6'h3e];
  assign T592 = T42 & T593;
  assign T593 = T39[6'h3e:6'h3e];
  assign T1307 = reset ? 1'h0 : T594;
  assign T594 = io_invalidate ? 1'h0 : T595;
  assign T595 = T599 ? 1'h0 : T596;
  assign T596 = T597 ? 1'h1 : tagVMem_63;
  assign T597 = T13 & T598;
  assign T598 = T34[6'h3f:6'h3f];
  assign T599 = T42 & T600;
  assign T600 = T39[6'h3f:6'h3f];
  assign T601 = T52[1'h0:1'h0];
  assign T602 = T52[1'h1:1'h1];
  assign T603 = T52[2'h2:2'h2];
  assign T604 = T52[2'h3:2'h3];
  assign T605 = T52[3'h4:3'h4];
  assign T606 = T52[3'h5:3'h5];
  assign T607 = T1180 ? T894 : T608;
  assign T608 = T893 ? T751 : T609;
  assign T609 = T750 ? T680 : T610;
  assign T610 = T679 ? T645 : T611;
  assign T611 = T644 ? T628 : T612;
  assign T612 = T627 ? tagVMem_65 : tagVMem_64;
  assign T1308 = reset ? 1'h0 : T613;
  assign T613 = io_invalidate ? 1'h0 : T614;
  assign T614 = T618 ? 1'h0 : T615;
  assign T615 = T616 ? 1'h1 : tagVMem_64;
  assign T616 = T13 & T617;
  assign T617 = T34[7'h40:7'h40];
  assign T618 = T42 & T619;
  assign T619 = T39[7'h40:7'h40];
  assign T1309 = reset ? 1'h0 : T620;
  assign T620 = io_invalidate ? 1'h0 : T621;
  assign T621 = T625 ? 1'h0 : T622;
  assign T622 = T623 ? 1'h1 : tagVMem_65;
  assign T623 = T13 & T624;
  assign T624 = T34[7'h41:7'h41];
  assign T625 = T42 & T626;
  assign T626 = T39[7'h41:7'h41];
  assign T627 = T52[1'h0:1'h0];
  assign T628 = T643 ? tagVMem_67 : tagVMem_66;
  assign T1310 = reset ? 1'h0 : T629;
  assign T629 = io_invalidate ? 1'h0 : T630;
  assign T630 = T634 ? 1'h0 : T631;
  assign T631 = T632 ? 1'h1 : tagVMem_66;
  assign T632 = T13 & T633;
  assign T633 = T34[7'h42:7'h42];
  assign T634 = T42 & T635;
  assign T635 = T39[7'h42:7'h42];
  assign T1311 = reset ? 1'h0 : T636;
  assign T636 = io_invalidate ? 1'h0 : T637;
  assign T637 = T641 ? 1'h0 : T638;
  assign T638 = T639 ? 1'h1 : tagVMem_67;
  assign T639 = T13 & T640;
  assign T640 = T34[7'h43:7'h43];
  assign T641 = T42 & T642;
  assign T642 = T39[7'h43:7'h43];
  assign T643 = T52[1'h0:1'h0];
  assign T644 = T52[1'h1:1'h1];
  assign T645 = T678 ? T662 : T646;
  assign T646 = T661 ? tagVMem_69 : tagVMem_68;
  assign T1312 = reset ? 1'h0 : T647;
  assign T647 = io_invalidate ? 1'h0 : T648;
  assign T648 = T652 ? 1'h0 : T649;
  assign T649 = T650 ? 1'h1 : tagVMem_68;
  assign T650 = T13 & T651;
  assign T651 = T34[7'h44:7'h44];
  assign T652 = T42 & T653;
  assign T653 = T39[7'h44:7'h44];
  assign T1313 = reset ? 1'h0 : T654;
  assign T654 = io_invalidate ? 1'h0 : T655;
  assign T655 = T659 ? 1'h0 : T656;
  assign T656 = T657 ? 1'h1 : tagVMem_69;
  assign T657 = T13 & T658;
  assign T658 = T34[7'h45:7'h45];
  assign T659 = T42 & T660;
  assign T660 = T39[7'h45:7'h45];
  assign T661 = T52[1'h0:1'h0];
  assign T662 = T677 ? tagVMem_71 : tagVMem_70;
  assign T1314 = reset ? 1'h0 : T663;
  assign T663 = io_invalidate ? 1'h0 : T664;
  assign T664 = T668 ? 1'h0 : T665;
  assign T665 = T666 ? 1'h1 : tagVMem_70;
  assign T666 = T13 & T667;
  assign T667 = T34[7'h46:7'h46];
  assign T668 = T42 & T669;
  assign T669 = T39[7'h46:7'h46];
  assign T1315 = reset ? 1'h0 : T670;
  assign T670 = io_invalidate ? 1'h0 : T671;
  assign T671 = T675 ? 1'h0 : T672;
  assign T672 = T673 ? 1'h1 : tagVMem_71;
  assign T673 = T13 & T674;
  assign T674 = T34[7'h47:7'h47];
  assign T675 = T42 & T676;
  assign T676 = T39[7'h47:7'h47];
  assign T677 = T52[1'h0:1'h0];
  assign T678 = T52[1'h1:1'h1];
  assign T679 = T52[2'h2:2'h2];
  assign T680 = T749 ? T715 : T681;
  assign T681 = T714 ? T698 : T682;
  assign T682 = T697 ? tagVMem_73 : tagVMem_72;
  assign T1316 = reset ? 1'h0 : T683;
  assign T683 = io_invalidate ? 1'h0 : T684;
  assign T684 = T688 ? 1'h0 : T685;
  assign T685 = T686 ? 1'h1 : tagVMem_72;
  assign T686 = T13 & T687;
  assign T687 = T34[7'h48:7'h48];
  assign T688 = T42 & T689;
  assign T689 = T39[7'h48:7'h48];
  assign T1317 = reset ? 1'h0 : T690;
  assign T690 = io_invalidate ? 1'h0 : T691;
  assign T691 = T695 ? 1'h0 : T692;
  assign T692 = T693 ? 1'h1 : tagVMem_73;
  assign T693 = T13 & T694;
  assign T694 = T34[7'h49:7'h49];
  assign T695 = T42 & T696;
  assign T696 = T39[7'h49:7'h49];
  assign T697 = T52[1'h0:1'h0];
  assign T698 = T713 ? tagVMem_75 : tagVMem_74;
  assign T1318 = reset ? 1'h0 : T699;
  assign T699 = io_invalidate ? 1'h0 : T700;
  assign T700 = T704 ? 1'h0 : T701;
  assign T701 = T702 ? 1'h1 : tagVMem_74;
  assign T702 = T13 & T703;
  assign T703 = T34[7'h4a:7'h4a];
  assign T704 = T42 & T705;
  assign T705 = T39[7'h4a:7'h4a];
  assign T1319 = reset ? 1'h0 : T706;
  assign T706 = io_invalidate ? 1'h0 : T707;
  assign T707 = T711 ? 1'h0 : T708;
  assign T708 = T709 ? 1'h1 : tagVMem_75;
  assign T709 = T13 & T710;
  assign T710 = T34[7'h4b:7'h4b];
  assign T711 = T42 & T712;
  assign T712 = T39[7'h4b:7'h4b];
  assign T713 = T52[1'h0:1'h0];
  assign T714 = T52[1'h1:1'h1];
  assign T715 = T748 ? T732 : T716;
  assign T716 = T731 ? tagVMem_77 : tagVMem_76;
  assign T1320 = reset ? 1'h0 : T717;
  assign T717 = io_invalidate ? 1'h0 : T718;
  assign T718 = T722 ? 1'h0 : T719;
  assign T719 = T720 ? 1'h1 : tagVMem_76;
  assign T720 = T13 & T721;
  assign T721 = T34[7'h4c:7'h4c];
  assign T722 = T42 & T723;
  assign T723 = T39[7'h4c:7'h4c];
  assign T1321 = reset ? 1'h0 : T724;
  assign T724 = io_invalidate ? 1'h0 : T725;
  assign T725 = T729 ? 1'h0 : T726;
  assign T726 = T727 ? 1'h1 : tagVMem_77;
  assign T727 = T13 & T728;
  assign T728 = T34[7'h4d:7'h4d];
  assign T729 = T42 & T730;
  assign T730 = T39[7'h4d:7'h4d];
  assign T731 = T52[1'h0:1'h0];
  assign T732 = T747 ? tagVMem_79 : tagVMem_78;
  assign T1322 = reset ? 1'h0 : T733;
  assign T733 = io_invalidate ? 1'h0 : T734;
  assign T734 = T738 ? 1'h0 : T735;
  assign T735 = T736 ? 1'h1 : tagVMem_78;
  assign T736 = T13 & T737;
  assign T737 = T34[7'h4e:7'h4e];
  assign T738 = T42 & T739;
  assign T739 = T39[7'h4e:7'h4e];
  assign T1323 = reset ? 1'h0 : T740;
  assign T740 = io_invalidate ? 1'h0 : T741;
  assign T741 = T745 ? 1'h0 : T742;
  assign T742 = T743 ? 1'h1 : tagVMem_79;
  assign T743 = T13 & T744;
  assign T744 = T34[7'h4f:7'h4f];
  assign T745 = T42 & T746;
  assign T746 = T39[7'h4f:7'h4f];
  assign T747 = T52[1'h0:1'h0];
  assign T748 = T52[1'h1:1'h1];
  assign T749 = T52[2'h2:2'h2];
  assign T750 = T52[2'h3:2'h3];
  assign T751 = T892 ? T822 : T752;
  assign T752 = T821 ? T787 : T753;
  assign T753 = T786 ? T770 : T754;
  assign T754 = T769 ? tagVMem_81 : tagVMem_80;
  assign T1324 = reset ? 1'h0 : T755;
  assign T755 = io_invalidate ? 1'h0 : T756;
  assign T756 = T760 ? 1'h0 : T757;
  assign T757 = T758 ? 1'h1 : tagVMem_80;
  assign T758 = T13 & T759;
  assign T759 = T34[7'h50:7'h50];
  assign T760 = T42 & T761;
  assign T761 = T39[7'h50:7'h50];
  assign T1325 = reset ? 1'h0 : T762;
  assign T762 = io_invalidate ? 1'h0 : T763;
  assign T763 = T767 ? 1'h0 : T764;
  assign T764 = T765 ? 1'h1 : tagVMem_81;
  assign T765 = T13 & T766;
  assign T766 = T34[7'h51:7'h51];
  assign T767 = T42 & T768;
  assign T768 = T39[7'h51:7'h51];
  assign T769 = T52[1'h0:1'h0];
  assign T770 = T785 ? tagVMem_83 : tagVMem_82;
  assign T1326 = reset ? 1'h0 : T771;
  assign T771 = io_invalidate ? 1'h0 : T772;
  assign T772 = T776 ? 1'h0 : T773;
  assign T773 = T774 ? 1'h1 : tagVMem_82;
  assign T774 = T13 & T775;
  assign T775 = T34[7'h52:7'h52];
  assign T776 = T42 & T777;
  assign T777 = T39[7'h52:7'h52];
  assign T1327 = reset ? 1'h0 : T778;
  assign T778 = io_invalidate ? 1'h0 : T779;
  assign T779 = T783 ? 1'h0 : T780;
  assign T780 = T781 ? 1'h1 : tagVMem_83;
  assign T781 = T13 & T782;
  assign T782 = T34[7'h53:7'h53];
  assign T783 = T42 & T784;
  assign T784 = T39[7'h53:7'h53];
  assign T785 = T52[1'h0:1'h0];
  assign T786 = T52[1'h1:1'h1];
  assign T787 = T820 ? T804 : T788;
  assign T788 = T803 ? tagVMem_85 : tagVMem_84;
  assign T1328 = reset ? 1'h0 : T789;
  assign T789 = io_invalidate ? 1'h0 : T790;
  assign T790 = T794 ? 1'h0 : T791;
  assign T791 = T792 ? 1'h1 : tagVMem_84;
  assign T792 = T13 & T793;
  assign T793 = T34[7'h54:7'h54];
  assign T794 = T42 & T795;
  assign T795 = T39[7'h54:7'h54];
  assign T1329 = reset ? 1'h0 : T796;
  assign T796 = io_invalidate ? 1'h0 : T797;
  assign T797 = T801 ? 1'h0 : T798;
  assign T798 = T799 ? 1'h1 : tagVMem_85;
  assign T799 = T13 & T800;
  assign T800 = T34[7'h55:7'h55];
  assign T801 = T42 & T802;
  assign T802 = T39[7'h55:7'h55];
  assign T803 = T52[1'h0:1'h0];
  assign T804 = T819 ? tagVMem_87 : tagVMem_86;
  assign T1330 = reset ? 1'h0 : T805;
  assign T805 = io_invalidate ? 1'h0 : T806;
  assign T806 = T810 ? 1'h0 : T807;
  assign T807 = T808 ? 1'h1 : tagVMem_86;
  assign T808 = T13 & T809;
  assign T809 = T34[7'h56:7'h56];
  assign T810 = T42 & T811;
  assign T811 = T39[7'h56:7'h56];
  assign T1331 = reset ? 1'h0 : T812;
  assign T812 = io_invalidate ? 1'h0 : T813;
  assign T813 = T817 ? 1'h0 : T814;
  assign T814 = T815 ? 1'h1 : tagVMem_87;
  assign T815 = T13 & T816;
  assign T816 = T34[7'h57:7'h57];
  assign T817 = T42 & T818;
  assign T818 = T39[7'h57:7'h57];
  assign T819 = T52[1'h0:1'h0];
  assign T820 = T52[1'h1:1'h1];
  assign T821 = T52[2'h2:2'h2];
  assign T822 = T891 ? T857 : T823;
  assign T823 = T856 ? T840 : T824;
  assign T824 = T839 ? tagVMem_89 : tagVMem_88;
  assign T1332 = reset ? 1'h0 : T825;
  assign T825 = io_invalidate ? 1'h0 : T826;
  assign T826 = T830 ? 1'h0 : T827;
  assign T827 = T828 ? 1'h1 : tagVMem_88;
  assign T828 = T13 & T829;
  assign T829 = T34[7'h58:7'h58];
  assign T830 = T42 & T831;
  assign T831 = T39[7'h58:7'h58];
  assign T1333 = reset ? 1'h0 : T832;
  assign T832 = io_invalidate ? 1'h0 : T833;
  assign T833 = T837 ? 1'h0 : T834;
  assign T834 = T835 ? 1'h1 : tagVMem_89;
  assign T835 = T13 & T836;
  assign T836 = T34[7'h59:7'h59];
  assign T837 = T42 & T838;
  assign T838 = T39[7'h59:7'h59];
  assign T839 = T52[1'h0:1'h0];
  assign T840 = T855 ? tagVMem_91 : tagVMem_90;
  assign T1334 = reset ? 1'h0 : T841;
  assign T841 = io_invalidate ? 1'h0 : T842;
  assign T842 = T846 ? 1'h0 : T843;
  assign T843 = T844 ? 1'h1 : tagVMem_90;
  assign T844 = T13 & T845;
  assign T845 = T34[7'h5a:7'h5a];
  assign T846 = T42 & T847;
  assign T847 = T39[7'h5a:7'h5a];
  assign T1335 = reset ? 1'h0 : T848;
  assign T848 = io_invalidate ? 1'h0 : T849;
  assign T849 = T853 ? 1'h0 : T850;
  assign T850 = T851 ? 1'h1 : tagVMem_91;
  assign T851 = T13 & T852;
  assign T852 = T34[7'h5b:7'h5b];
  assign T853 = T42 & T854;
  assign T854 = T39[7'h5b:7'h5b];
  assign T855 = T52[1'h0:1'h0];
  assign T856 = T52[1'h1:1'h1];
  assign T857 = T890 ? T874 : T858;
  assign T858 = T873 ? tagVMem_93 : tagVMem_92;
  assign T1336 = reset ? 1'h0 : T859;
  assign T859 = io_invalidate ? 1'h0 : T860;
  assign T860 = T864 ? 1'h0 : T861;
  assign T861 = T862 ? 1'h1 : tagVMem_92;
  assign T862 = T13 & T863;
  assign T863 = T34[7'h5c:7'h5c];
  assign T864 = T42 & T865;
  assign T865 = T39[7'h5c:7'h5c];
  assign T1337 = reset ? 1'h0 : T866;
  assign T866 = io_invalidate ? 1'h0 : T867;
  assign T867 = T871 ? 1'h0 : T868;
  assign T868 = T869 ? 1'h1 : tagVMem_93;
  assign T869 = T13 & T870;
  assign T870 = T34[7'h5d:7'h5d];
  assign T871 = T42 & T872;
  assign T872 = T39[7'h5d:7'h5d];
  assign T873 = T52[1'h0:1'h0];
  assign T874 = T889 ? tagVMem_95 : tagVMem_94;
  assign T1338 = reset ? 1'h0 : T875;
  assign T875 = io_invalidate ? 1'h0 : T876;
  assign T876 = T880 ? 1'h0 : T877;
  assign T877 = T878 ? 1'h1 : tagVMem_94;
  assign T878 = T13 & T879;
  assign T879 = T34[7'h5e:7'h5e];
  assign T880 = T42 & T881;
  assign T881 = T39[7'h5e:7'h5e];
  assign T1339 = reset ? 1'h0 : T882;
  assign T882 = io_invalidate ? 1'h0 : T883;
  assign T883 = T887 ? 1'h0 : T884;
  assign T884 = T885 ? 1'h1 : tagVMem_95;
  assign T885 = T13 & T886;
  assign T886 = T34[7'h5f:7'h5f];
  assign T887 = T42 & T888;
  assign T888 = T39[7'h5f:7'h5f];
  assign T889 = T52[1'h0:1'h0];
  assign T890 = T52[1'h1:1'h1];
  assign T891 = T52[2'h2:2'h2];
  assign T892 = T52[2'h3:2'h3];
  assign T893 = T52[3'h4:3'h4];
  assign T894 = T1179 ? T1037 : T895;
  assign T895 = T1036 ? T966 : T896;
  assign T896 = T965 ? T931 : T897;
  assign T897 = T930 ? T914 : T898;
  assign T898 = T913 ? tagVMem_97 : tagVMem_96;
  assign T1340 = reset ? 1'h0 : T899;
  assign T899 = io_invalidate ? 1'h0 : T900;
  assign T900 = T904 ? 1'h0 : T901;
  assign T901 = T902 ? 1'h1 : tagVMem_96;
  assign T902 = T13 & T903;
  assign T903 = T34[7'h60:7'h60];
  assign T904 = T42 & T905;
  assign T905 = T39[7'h60:7'h60];
  assign T1341 = reset ? 1'h0 : T906;
  assign T906 = io_invalidate ? 1'h0 : T907;
  assign T907 = T911 ? 1'h0 : T908;
  assign T908 = T909 ? 1'h1 : tagVMem_97;
  assign T909 = T13 & T910;
  assign T910 = T34[7'h61:7'h61];
  assign T911 = T42 & T912;
  assign T912 = T39[7'h61:7'h61];
  assign T913 = T52[1'h0:1'h0];
  assign T914 = T929 ? tagVMem_99 : tagVMem_98;
  assign T1342 = reset ? 1'h0 : T915;
  assign T915 = io_invalidate ? 1'h0 : T916;
  assign T916 = T920 ? 1'h0 : T917;
  assign T917 = T918 ? 1'h1 : tagVMem_98;
  assign T918 = T13 & T919;
  assign T919 = T34[7'h62:7'h62];
  assign T920 = T42 & T921;
  assign T921 = T39[7'h62:7'h62];
  assign T1343 = reset ? 1'h0 : T922;
  assign T922 = io_invalidate ? 1'h0 : T923;
  assign T923 = T927 ? 1'h0 : T924;
  assign T924 = T925 ? 1'h1 : tagVMem_99;
  assign T925 = T13 & T926;
  assign T926 = T34[7'h63:7'h63];
  assign T927 = T42 & T928;
  assign T928 = T39[7'h63:7'h63];
  assign T929 = T52[1'h0:1'h0];
  assign T930 = T52[1'h1:1'h1];
  assign T931 = T964 ? T948 : T932;
  assign T932 = T947 ? tagVMem_101 : tagVMem_100;
  assign T1344 = reset ? 1'h0 : T933;
  assign T933 = io_invalidate ? 1'h0 : T934;
  assign T934 = T938 ? 1'h0 : T935;
  assign T935 = T936 ? 1'h1 : tagVMem_100;
  assign T936 = T13 & T937;
  assign T937 = T34[7'h64:7'h64];
  assign T938 = T42 & T939;
  assign T939 = T39[7'h64:7'h64];
  assign T1345 = reset ? 1'h0 : T940;
  assign T940 = io_invalidate ? 1'h0 : T941;
  assign T941 = T945 ? 1'h0 : T942;
  assign T942 = T943 ? 1'h1 : tagVMem_101;
  assign T943 = T13 & T944;
  assign T944 = T34[7'h65:7'h65];
  assign T945 = T42 & T946;
  assign T946 = T39[7'h65:7'h65];
  assign T947 = T52[1'h0:1'h0];
  assign T948 = T963 ? tagVMem_103 : tagVMem_102;
  assign T1346 = reset ? 1'h0 : T949;
  assign T949 = io_invalidate ? 1'h0 : T950;
  assign T950 = T954 ? 1'h0 : T951;
  assign T951 = T952 ? 1'h1 : tagVMem_102;
  assign T952 = T13 & T953;
  assign T953 = T34[7'h66:7'h66];
  assign T954 = T42 & T955;
  assign T955 = T39[7'h66:7'h66];
  assign T1347 = reset ? 1'h0 : T956;
  assign T956 = io_invalidate ? 1'h0 : T957;
  assign T957 = T961 ? 1'h0 : T958;
  assign T958 = T959 ? 1'h1 : tagVMem_103;
  assign T959 = T13 & T960;
  assign T960 = T34[7'h67:7'h67];
  assign T961 = T42 & T962;
  assign T962 = T39[7'h67:7'h67];
  assign T963 = T52[1'h0:1'h0];
  assign T964 = T52[1'h1:1'h1];
  assign T965 = T52[2'h2:2'h2];
  assign T966 = T1035 ? T1001 : T967;
  assign T967 = T1000 ? T984 : T968;
  assign T968 = T983 ? tagVMem_105 : tagVMem_104;
  assign T1348 = reset ? 1'h0 : T969;
  assign T969 = io_invalidate ? 1'h0 : T970;
  assign T970 = T974 ? 1'h0 : T971;
  assign T971 = T972 ? 1'h1 : tagVMem_104;
  assign T972 = T13 & T973;
  assign T973 = T34[7'h68:7'h68];
  assign T974 = T42 & T975;
  assign T975 = T39[7'h68:7'h68];
  assign T1349 = reset ? 1'h0 : T976;
  assign T976 = io_invalidate ? 1'h0 : T977;
  assign T977 = T981 ? 1'h0 : T978;
  assign T978 = T979 ? 1'h1 : tagVMem_105;
  assign T979 = T13 & T980;
  assign T980 = T34[7'h69:7'h69];
  assign T981 = T42 & T982;
  assign T982 = T39[7'h69:7'h69];
  assign T983 = T52[1'h0:1'h0];
  assign T984 = T999 ? tagVMem_107 : tagVMem_106;
  assign T1350 = reset ? 1'h0 : T985;
  assign T985 = io_invalidate ? 1'h0 : T986;
  assign T986 = T990 ? 1'h0 : T987;
  assign T987 = T988 ? 1'h1 : tagVMem_106;
  assign T988 = T13 & T989;
  assign T989 = T34[7'h6a:7'h6a];
  assign T990 = T42 & T991;
  assign T991 = T39[7'h6a:7'h6a];
  assign T1351 = reset ? 1'h0 : T992;
  assign T992 = io_invalidate ? 1'h0 : T993;
  assign T993 = T997 ? 1'h0 : T994;
  assign T994 = T995 ? 1'h1 : tagVMem_107;
  assign T995 = T13 & T996;
  assign T996 = T34[7'h6b:7'h6b];
  assign T997 = T42 & T998;
  assign T998 = T39[7'h6b:7'h6b];
  assign T999 = T52[1'h0:1'h0];
  assign T1000 = T52[1'h1:1'h1];
  assign T1001 = T1034 ? T1018 : T1002;
  assign T1002 = T1017 ? tagVMem_109 : tagVMem_108;
  assign T1352 = reset ? 1'h0 : T1003;
  assign T1003 = io_invalidate ? 1'h0 : T1004;
  assign T1004 = T1008 ? 1'h0 : T1005;
  assign T1005 = T1006 ? 1'h1 : tagVMem_108;
  assign T1006 = T13 & T1007;
  assign T1007 = T34[7'h6c:7'h6c];
  assign T1008 = T42 & T1009;
  assign T1009 = T39[7'h6c:7'h6c];
  assign T1353 = reset ? 1'h0 : T1010;
  assign T1010 = io_invalidate ? 1'h0 : T1011;
  assign T1011 = T1015 ? 1'h0 : T1012;
  assign T1012 = T1013 ? 1'h1 : tagVMem_109;
  assign T1013 = T13 & T1014;
  assign T1014 = T34[7'h6d:7'h6d];
  assign T1015 = T42 & T1016;
  assign T1016 = T39[7'h6d:7'h6d];
  assign T1017 = T52[1'h0:1'h0];
  assign T1018 = T1033 ? tagVMem_111 : tagVMem_110;
  assign T1354 = reset ? 1'h0 : T1019;
  assign T1019 = io_invalidate ? 1'h0 : T1020;
  assign T1020 = T1024 ? 1'h0 : T1021;
  assign T1021 = T1022 ? 1'h1 : tagVMem_110;
  assign T1022 = T13 & T1023;
  assign T1023 = T34[7'h6e:7'h6e];
  assign T1024 = T42 & T1025;
  assign T1025 = T39[7'h6e:7'h6e];
  assign T1355 = reset ? 1'h0 : T1026;
  assign T1026 = io_invalidate ? 1'h0 : T1027;
  assign T1027 = T1031 ? 1'h0 : T1028;
  assign T1028 = T1029 ? 1'h1 : tagVMem_111;
  assign T1029 = T13 & T1030;
  assign T1030 = T34[7'h6f:7'h6f];
  assign T1031 = T42 & T1032;
  assign T1032 = T39[7'h6f:7'h6f];
  assign T1033 = T52[1'h0:1'h0];
  assign T1034 = T52[1'h1:1'h1];
  assign T1035 = T52[2'h2:2'h2];
  assign T1036 = T52[2'h3:2'h3];
  assign T1037 = T1178 ? T1108 : T1038;
  assign T1038 = T1107 ? T1073 : T1039;
  assign T1039 = T1072 ? T1056 : T1040;
  assign T1040 = T1055 ? tagVMem_113 : tagVMem_112;
  assign T1356 = reset ? 1'h0 : T1041;
  assign T1041 = io_invalidate ? 1'h0 : T1042;
  assign T1042 = T1046 ? 1'h0 : T1043;
  assign T1043 = T1044 ? 1'h1 : tagVMem_112;
  assign T1044 = T13 & T1045;
  assign T1045 = T34[7'h70:7'h70];
  assign T1046 = T42 & T1047;
  assign T1047 = T39[7'h70:7'h70];
  assign T1357 = reset ? 1'h0 : T1048;
  assign T1048 = io_invalidate ? 1'h0 : T1049;
  assign T1049 = T1053 ? 1'h0 : T1050;
  assign T1050 = T1051 ? 1'h1 : tagVMem_113;
  assign T1051 = T13 & T1052;
  assign T1052 = T34[7'h71:7'h71];
  assign T1053 = T42 & T1054;
  assign T1054 = T39[7'h71:7'h71];
  assign T1055 = T52[1'h0:1'h0];
  assign T1056 = T1071 ? tagVMem_115 : tagVMem_114;
  assign T1358 = reset ? 1'h0 : T1057;
  assign T1057 = io_invalidate ? 1'h0 : T1058;
  assign T1058 = T1062 ? 1'h0 : T1059;
  assign T1059 = T1060 ? 1'h1 : tagVMem_114;
  assign T1060 = T13 & T1061;
  assign T1061 = T34[7'h72:7'h72];
  assign T1062 = T42 & T1063;
  assign T1063 = T39[7'h72:7'h72];
  assign T1359 = reset ? 1'h0 : T1064;
  assign T1064 = io_invalidate ? 1'h0 : T1065;
  assign T1065 = T1069 ? 1'h0 : T1066;
  assign T1066 = T1067 ? 1'h1 : tagVMem_115;
  assign T1067 = T13 & T1068;
  assign T1068 = T34[7'h73:7'h73];
  assign T1069 = T42 & T1070;
  assign T1070 = T39[7'h73:7'h73];
  assign T1071 = T52[1'h0:1'h0];
  assign T1072 = T52[1'h1:1'h1];
  assign T1073 = T1106 ? T1090 : T1074;
  assign T1074 = T1089 ? tagVMem_117 : tagVMem_116;
  assign T1360 = reset ? 1'h0 : T1075;
  assign T1075 = io_invalidate ? 1'h0 : T1076;
  assign T1076 = T1080 ? 1'h0 : T1077;
  assign T1077 = T1078 ? 1'h1 : tagVMem_116;
  assign T1078 = T13 & T1079;
  assign T1079 = T34[7'h74:7'h74];
  assign T1080 = T42 & T1081;
  assign T1081 = T39[7'h74:7'h74];
  assign T1361 = reset ? 1'h0 : T1082;
  assign T1082 = io_invalidate ? 1'h0 : T1083;
  assign T1083 = T1087 ? 1'h0 : T1084;
  assign T1084 = T1085 ? 1'h1 : tagVMem_117;
  assign T1085 = T13 & T1086;
  assign T1086 = T34[7'h75:7'h75];
  assign T1087 = T42 & T1088;
  assign T1088 = T39[7'h75:7'h75];
  assign T1089 = T52[1'h0:1'h0];
  assign T1090 = T1105 ? tagVMem_119 : tagVMem_118;
  assign T1362 = reset ? 1'h0 : T1091;
  assign T1091 = io_invalidate ? 1'h0 : T1092;
  assign T1092 = T1096 ? 1'h0 : T1093;
  assign T1093 = T1094 ? 1'h1 : tagVMem_118;
  assign T1094 = T13 & T1095;
  assign T1095 = T34[7'h76:7'h76];
  assign T1096 = T42 & T1097;
  assign T1097 = T39[7'h76:7'h76];
  assign T1363 = reset ? 1'h0 : T1098;
  assign T1098 = io_invalidate ? 1'h0 : T1099;
  assign T1099 = T1103 ? 1'h0 : T1100;
  assign T1100 = T1101 ? 1'h1 : tagVMem_119;
  assign T1101 = T13 & T1102;
  assign T1102 = T34[7'h77:7'h77];
  assign T1103 = T42 & T1104;
  assign T1104 = T39[7'h77:7'h77];
  assign T1105 = T52[1'h0:1'h0];
  assign T1106 = T52[1'h1:1'h1];
  assign T1107 = T52[2'h2:2'h2];
  assign T1108 = T1177 ? T1143 : T1109;
  assign T1109 = T1142 ? T1126 : T1110;
  assign T1110 = T1125 ? tagVMem_121 : tagVMem_120;
  assign T1364 = reset ? 1'h0 : T1111;
  assign T1111 = io_invalidate ? 1'h0 : T1112;
  assign T1112 = T1116 ? 1'h0 : T1113;
  assign T1113 = T1114 ? 1'h1 : tagVMem_120;
  assign T1114 = T13 & T1115;
  assign T1115 = T34[7'h78:7'h78];
  assign T1116 = T42 & T1117;
  assign T1117 = T39[7'h78:7'h78];
  assign T1365 = reset ? 1'h0 : T1118;
  assign T1118 = io_invalidate ? 1'h0 : T1119;
  assign T1119 = T1123 ? 1'h0 : T1120;
  assign T1120 = T1121 ? 1'h1 : tagVMem_121;
  assign T1121 = T13 & T1122;
  assign T1122 = T34[7'h79:7'h79];
  assign T1123 = T42 & T1124;
  assign T1124 = T39[7'h79:7'h79];
  assign T1125 = T52[1'h0:1'h0];
  assign T1126 = T1141 ? tagVMem_123 : tagVMem_122;
  assign T1366 = reset ? 1'h0 : T1127;
  assign T1127 = io_invalidate ? 1'h0 : T1128;
  assign T1128 = T1132 ? 1'h0 : T1129;
  assign T1129 = T1130 ? 1'h1 : tagVMem_122;
  assign T1130 = T13 & T1131;
  assign T1131 = T34[7'h7a:7'h7a];
  assign T1132 = T42 & T1133;
  assign T1133 = T39[7'h7a:7'h7a];
  assign T1367 = reset ? 1'h0 : T1134;
  assign T1134 = io_invalidate ? 1'h0 : T1135;
  assign T1135 = T1139 ? 1'h0 : T1136;
  assign T1136 = T1137 ? 1'h1 : tagVMem_123;
  assign T1137 = T13 & T1138;
  assign T1138 = T34[7'h7b:7'h7b];
  assign T1139 = T42 & T1140;
  assign T1140 = T39[7'h7b:7'h7b];
  assign T1141 = T52[1'h0:1'h0];
  assign T1142 = T52[1'h1:1'h1];
  assign T1143 = T1176 ? T1160 : T1144;
  assign T1144 = T1159 ? tagVMem_125 : tagVMem_124;
  assign T1368 = reset ? 1'h0 : T1145;
  assign T1145 = io_invalidate ? 1'h0 : T1146;
  assign T1146 = T1150 ? 1'h0 : T1147;
  assign T1147 = T1148 ? 1'h1 : tagVMem_124;
  assign T1148 = T13 & T1149;
  assign T1149 = T34[7'h7c:7'h7c];
  assign T1150 = T42 & T1151;
  assign T1151 = T39[7'h7c:7'h7c];
  assign T1369 = reset ? 1'h0 : T1152;
  assign T1152 = io_invalidate ? 1'h0 : T1153;
  assign T1153 = T1157 ? 1'h0 : T1154;
  assign T1154 = T1155 ? 1'h1 : tagVMem_125;
  assign T1155 = T13 & T1156;
  assign T1156 = T34[7'h7d:7'h7d];
  assign T1157 = T42 & T1158;
  assign T1158 = T39[7'h7d:7'h7d];
  assign T1159 = T52[1'h0:1'h0];
  assign T1160 = T1175 ? tagVMem_127 : tagVMem_126;
  assign T1370 = reset ? 1'h0 : T1161;
  assign T1161 = io_invalidate ? 1'h0 : T1162;
  assign T1162 = T1166 ? 1'h0 : T1163;
  assign T1163 = T1164 ? 1'h1 : tagVMem_126;
  assign T1164 = T13 & T1165;
  assign T1165 = T34[7'h7e:7'h7e];
  assign T1166 = T42 & T1167;
  assign T1167 = T39[7'h7e:7'h7e];
  assign T1371 = reset ? 1'h0 : T1168;
  assign T1168 = io_invalidate ? 1'h0 : T1169;
  assign T1169 = T1173 ? 1'h0 : T1170;
  assign T1170 = T1171 ? 1'h1 : tagVMem_127;
  assign T1171 = T13 & T1172;
  assign T1172 = T34[7'h7f:7'h7f];
  assign T1173 = T42 & T1174;
  assign T1174 = T39[7'h7f:7'h7f];
  assign T1175 = T52[1'h0:1'h0];
  assign T1176 = T52[1'h1:1'h1];
  assign T1177 = T52[2'h2:2'h2];
  assign T1178 = T52[2'h3:2'h3];
  assign T1179 = T52[3'h4:3'h4];
  assign T1180 = T52[3'h5:3'h5];
  assign T1181 = T52[3'h6:3'h6];
  assign T1182 = T13 & T1183;
  assign T1183 = T12 ^ 1'h1;
  assign T1184 = T21 & T1185;
  assign T1185 = io_slave_S_CmdAccept == 1'h1;
  assign T1186 = T21 & T1187;
  assign T1187 = T1185 ^ 1'h1;
  assign T1188 = T2 & T1189;
  assign T1189 = burstCntReg == 2'h3;
  assign T1372 = reset ? 2'h0 : T1190;
  assign T1190 = T2 ? T1191 : burstCntReg;
  assign T1191 = burstCntReg + 2'h1;
  assign T1192 = stateReg == 2'h3;
  assign T1193 = fillReg | T1194;
  assign T1194 = tagValid & T1195;
  assign T1195 = stmsk[2'h3:2'h3];
  assign stmsk = T1196 ? masterReg_ByteEn : 4'h0;
  assign T1196 = masterReg_Cmd == 3'h1;
  assign T1197 = T4 ? T1199 : T1198;
  assign T1198 = io_master_M_Addr[4'ha:2'h2];
  assign T1199 = {T1200, burstCntReg};
  assign T1200 = masterReg_Addr[4'ha:3'h4];
  assign T1201 = io_master_M_Addr[4'ha:2'h2];
  assign T1202 = wrDataReg[5'h17:5'h10];
  assign T1203 = fillReg | T1204;
  assign T1204 = tagValid & T1205;
  assign T1205 = stmsk[2'h2:2'h2];
  assign T1206 = io_master_M_Addr[4'ha:2'h2];
  assign T1207 = wrDataReg[4'hf:4'h8];
  assign T1208 = fillReg | T1209;
  assign T1209 = tagValid & T1210;
  assign T1210 = stmsk[1'h1:1'h1];
  assign T1211 = io_master_M_Addr[4'ha:2'h2];
  assign T1212 = wrDataReg[3'h7:1'h0];
  assign T1213 = fillReg | T1214;
  assign T1214 = tagValid & T1215;
  assign T1215 = stmsk[1'h0:1'h0];
  assign T1216 = io_master_M_Addr[4'ha:2'h2];
  assign T1217 = masterReg_Addr[5'h1f:4'hb];
  assign T1218 = T1220 & T1219;
  assign T1219 = masterReg_Cmd == 3'h2;
  assign T1220 = tagValid ^ 1'h1;
  assign T1221 = masterReg_Addr[4'ha:3'h4];
  assign T1222 = io_master_M_Addr[4'ha:3'h4];
  assign io_perf_miss = T13;
  assign io_perf_hit = T1223;
  assign T1223 = tagValid & T1224;
  assign T1224 = masterReg_Cmd == 3'h2;
  assign io_slave_M_DataByteEn = 4'h0;
  assign io_slave_M_DataValid = 1'h0;
  assign io_slave_M_Data = 32'h0;
  assign io_slave_M_Addr = T1225;
  assign T1225 = {T1226, 4'h0};
  assign T1226 = masterReg_Addr[5'h1f:3'h4];
  assign io_slave_M_Cmd = T1227;
  assign T1227 = T21 ? 3'h2 : T1228;
  assign T1228 = T13 ? 3'h2 : 3'h0;
  assign io_master_S_Data = T1229;
  assign T1229 = T1192 ? slaveReg_Data : rdData;
  assign rdData = {MemBlock_3_io_rdData, T1230};
  assign T1230 = {MemBlock_2_io_rdData, T1231};
  assign T1231 = {MemBlock_1_io_rdData, MemBlock_io_rdData};
  assign T1232 = T1233 ? io_slave_S_Data : slaveReg_Data;
  assign T1233 = T2 & T1234;
  assign T1234 = burstCntReg == missIndexReg;
  assign T1235 = T13 ? T1236 : missIndexReg;
  assign T1236 = T1237;
  assign T1237 = masterReg_Addr[2'h3:2'h2];
  assign io_master_S_Resp = T1238;
  assign T1238 = T1192 ? slaveReg_Resp : T1239;
  assign T1239 = T1240 ? 2'h1 : 2'h0;
  assign T1240 = tagValid & T1241;
  assign T1241 = masterReg_Cmd == 3'h2;
  assign T1242 = T1233 ? io_slave_S_Resp : slaveReg_Resp;
  MemBlock_3 tagMem(.clk(clk),
       .io_rdAddr( T1222 ),
       .io_rdData( tagMem_io_rdData ),
       .io_wrAddr( T1221 ),
       .io_wrEna( T1218 ),
       .io_wrData( T1217 )
  );
  MemBlock_4 MemBlock(.clk(clk),
       .io_rdAddr( T1216 ),
       .io_rdData( MemBlock_io_rdData ),
       .io_wrAddr( wrAddrReg ),
       .io_wrEna( T1213 ),
       .io_wrData( T1212 )
  );
  MemBlock_4 MemBlock_1(.clk(clk),
       .io_rdAddr( T1211 ),
       .io_rdData( MemBlock_1_io_rdData ),
       .io_wrAddr( wrAddrReg ),
       .io_wrEna( T1208 ),
       .io_wrData( T1207 )
  );
  MemBlock_4 MemBlock_2(.clk(clk),
       .io_rdAddr( T1206 ),
       .io_rdData( MemBlock_2_io_rdData ),
       .io_wrAddr( wrAddrReg ),
       .io_wrEna( T1203 ),
       .io_wrData( T1202 )
  );
  MemBlock_4 MemBlock_3(.clk(clk),
       .io_rdAddr( T1201 ),
       .io_rdData( MemBlock_3_io_rdData ),
       .io_wrAddr( wrAddrReg ),
       .io_wrEna( T1193 ),
       .io_wrData( T0 )
  );

  always @(posedge clk) begin
    if(T2) begin
      wrDataReg <= io_slave_S_Data;
    end else begin
      wrDataReg <= io_master_M_Data;
    end
    if(reset) begin
      stateReg <= 2'h0;
    end else if(T1192) begin
      stateReg <= 2'h0;
    end else if(T1188) begin
      stateReg <= 2'h3;
    end else if(T1186) begin
      stateReg <= 2'h1;
    end else if(T1184) begin
      stateReg <= 2'h2;
    end else if(T1182) begin
      stateReg <= 2'h1;
    end else if(T11) begin
      stateReg <= 2'h2;
    end
    masterReg_Cmd <= io_master_M_Cmd;
    if(T4) begin
      masterReg_Addr <= masterReg_Addr;
    end else if(T21) begin
      masterReg_Addr <= masterReg_Addr;
    end else if(T13) begin
      masterReg_Addr <= masterReg_Addr;
    end else begin
      masterReg_Addr <= io_master_M_Addr;
    end
    if(T1181) begin
      tagV <= T607;
    end else if(T606) begin
      tagV <= T320;
    end else if(T319) begin
      tagV <= T177;
    end else if(T176) begin
      tagV <= T106;
    end else if(T105) begin
      tagV <= T71;
    end else if(T70) begin
      tagV <= T54;
    end else if(T51) begin
      tagV <= tagVMem_1;
    end else begin
      tagV <= tagVMem_0;
    end
    if(reset) begin
      tagVMem_0 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_0 <= 1'h0;
    end else if(T37) begin
      tagVMem_0 <= 1'h0;
    end else if(T32) begin
      tagVMem_0 <= 1'h1;
    end
    if(reset) begin
      tagVMem_1 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_1 <= 1'h0;
    end else if(T49) begin
      tagVMem_1 <= 1'h0;
    end else if(T47) begin
      tagVMem_1 <= 1'h1;
    end
    if(reset) begin
      tagVMem_2 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_2 <= 1'h0;
    end else if(T60) begin
      tagVMem_2 <= 1'h0;
    end else if(T58) begin
      tagVMem_2 <= 1'h1;
    end
    if(reset) begin
      tagVMem_3 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_3 <= 1'h0;
    end else if(T67) begin
      tagVMem_3 <= 1'h0;
    end else if(T65) begin
      tagVMem_3 <= 1'h1;
    end
    if(reset) begin
      tagVMem_4 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_4 <= 1'h0;
    end else if(T78) begin
      tagVMem_4 <= 1'h0;
    end else if(T76) begin
      tagVMem_4 <= 1'h1;
    end
    if(reset) begin
      tagVMem_5 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_5 <= 1'h0;
    end else if(T85) begin
      tagVMem_5 <= 1'h0;
    end else if(T83) begin
      tagVMem_5 <= 1'h1;
    end
    if(reset) begin
      tagVMem_6 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_6 <= 1'h0;
    end else if(T94) begin
      tagVMem_6 <= 1'h0;
    end else if(T92) begin
      tagVMem_6 <= 1'h1;
    end
    if(reset) begin
      tagVMem_7 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_7 <= 1'h0;
    end else if(T101) begin
      tagVMem_7 <= 1'h0;
    end else if(T99) begin
      tagVMem_7 <= 1'h1;
    end
    if(reset) begin
      tagVMem_8 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_8 <= 1'h0;
    end else if(T114) begin
      tagVMem_8 <= 1'h0;
    end else if(T112) begin
      tagVMem_8 <= 1'h1;
    end
    if(reset) begin
      tagVMem_9 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_9 <= 1'h0;
    end else if(T121) begin
      tagVMem_9 <= 1'h0;
    end else if(T119) begin
      tagVMem_9 <= 1'h1;
    end
    if(reset) begin
      tagVMem_10 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_10 <= 1'h0;
    end else if(T130) begin
      tagVMem_10 <= 1'h0;
    end else if(T128) begin
      tagVMem_10 <= 1'h1;
    end
    if(reset) begin
      tagVMem_11 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_11 <= 1'h0;
    end else if(T137) begin
      tagVMem_11 <= 1'h0;
    end else if(T135) begin
      tagVMem_11 <= 1'h1;
    end
    if(reset) begin
      tagVMem_12 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_12 <= 1'h0;
    end else if(T148) begin
      tagVMem_12 <= 1'h0;
    end else if(T146) begin
      tagVMem_12 <= 1'h1;
    end
    if(reset) begin
      tagVMem_13 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_13 <= 1'h0;
    end else if(T155) begin
      tagVMem_13 <= 1'h0;
    end else if(T153) begin
      tagVMem_13 <= 1'h1;
    end
    if(reset) begin
      tagVMem_14 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_14 <= 1'h0;
    end else if(T164) begin
      tagVMem_14 <= 1'h0;
    end else if(T162) begin
      tagVMem_14 <= 1'h1;
    end
    if(reset) begin
      tagVMem_15 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_15 <= 1'h0;
    end else if(T171) begin
      tagVMem_15 <= 1'h0;
    end else if(T169) begin
      tagVMem_15 <= 1'h1;
    end
    if(reset) begin
      tagVMem_16 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_16 <= 1'h0;
    end else if(T186) begin
      tagVMem_16 <= 1'h0;
    end else if(T184) begin
      tagVMem_16 <= 1'h1;
    end
    if(reset) begin
      tagVMem_17 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_17 <= 1'h0;
    end else if(T193) begin
      tagVMem_17 <= 1'h0;
    end else if(T191) begin
      tagVMem_17 <= 1'h1;
    end
    if(reset) begin
      tagVMem_18 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_18 <= 1'h0;
    end else if(T202) begin
      tagVMem_18 <= 1'h0;
    end else if(T200) begin
      tagVMem_18 <= 1'h1;
    end
    if(reset) begin
      tagVMem_19 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_19 <= 1'h0;
    end else if(T209) begin
      tagVMem_19 <= 1'h0;
    end else if(T207) begin
      tagVMem_19 <= 1'h1;
    end
    if(reset) begin
      tagVMem_20 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_20 <= 1'h0;
    end else if(T220) begin
      tagVMem_20 <= 1'h0;
    end else if(T218) begin
      tagVMem_20 <= 1'h1;
    end
    if(reset) begin
      tagVMem_21 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_21 <= 1'h0;
    end else if(T227) begin
      tagVMem_21 <= 1'h0;
    end else if(T225) begin
      tagVMem_21 <= 1'h1;
    end
    if(reset) begin
      tagVMem_22 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_22 <= 1'h0;
    end else if(T236) begin
      tagVMem_22 <= 1'h0;
    end else if(T234) begin
      tagVMem_22 <= 1'h1;
    end
    if(reset) begin
      tagVMem_23 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_23 <= 1'h0;
    end else if(T243) begin
      tagVMem_23 <= 1'h0;
    end else if(T241) begin
      tagVMem_23 <= 1'h1;
    end
    if(reset) begin
      tagVMem_24 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_24 <= 1'h0;
    end else if(T256) begin
      tagVMem_24 <= 1'h0;
    end else if(T254) begin
      tagVMem_24 <= 1'h1;
    end
    if(reset) begin
      tagVMem_25 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_25 <= 1'h0;
    end else if(T263) begin
      tagVMem_25 <= 1'h0;
    end else if(T261) begin
      tagVMem_25 <= 1'h1;
    end
    if(reset) begin
      tagVMem_26 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_26 <= 1'h0;
    end else if(T272) begin
      tagVMem_26 <= 1'h0;
    end else if(T270) begin
      tagVMem_26 <= 1'h1;
    end
    if(reset) begin
      tagVMem_27 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_27 <= 1'h0;
    end else if(T279) begin
      tagVMem_27 <= 1'h0;
    end else if(T277) begin
      tagVMem_27 <= 1'h1;
    end
    if(reset) begin
      tagVMem_28 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_28 <= 1'h0;
    end else if(T290) begin
      tagVMem_28 <= 1'h0;
    end else if(T288) begin
      tagVMem_28 <= 1'h1;
    end
    if(reset) begin
      tagVMem_29 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_29 <= 1'h0;
    end else if(T297) begin
      tagVMem_29 <= 1'h0;
    end else if(T295) begin
      tagVMem_29 <= 1'h1;
    end
    if(reset) begin
      tagVMem_30 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_30 <= 1'h0;
    end else if(T306) begin
      tagVMem_30 <= 1'h0;
    end else if(T304) begin
      tagVMem_30 <= 1'h1;
    end
    if(reset) begin
      tagVMem_31 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_31 <= 1'h0;
    end else if(T313) begin
      tagVMem_31 <= 1'h0;
    end else if(T311) begin
      tagVMem_31 <= 1'h1;
    end
    if(reset) begin
      tagVMem_32 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_32 <= 1'h0;
    end else if(T330) begin
      tagVMem_32 <= 1'h0;
    end else if(T328) begin
      tagVMem_32 <= 1'h1;
    end
    if(reset) begin
      tagVMem_33 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_33 <= 1'h0;
    end else if(T337) begin
      tagVMem_33 <= 1'h0;
    end else if(T335) begin
      tagVMem_33 <= 1'h1;
    end
    if(reset) begin
      tagVMem_34 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_34 <= 1'h0;
    end else if(T346) begin
      tagVMem_34 <= 1'h0;
    end else if(T344) begin
      tagVMem_34 <= 1'h1;
    end
    if(reset) begin
      tagVMem_35 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_35 <= 1'h0;
    end else if(T353) begin
      tagVMem_35 <= 1'h0;
    end else if(T351) begin
      tagVMem_35 <= 1'h1;
    end
    if(reset) begin
      tagVMem_36 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_36 <= 1'h0;
    end else if(T364) begin
      tagVMem_36 <= 1'h0;
    end else if(T362) begin
      tagVMem_36 <= 1'h1;
    end
    if(reset) begin
      tagVMem_37 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_37 <= 1'h0;
    end else if(T371) begin
      tagVMem_37 <= 1'h0;
    end else if(T369) begin
      tagVMem_37 <= 1'h1;
    end
    if(reset) begin
      tagVMem_38 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_38 <= 1'h0;
    end else if(T380) begin
      tagVMem_38 <= 1'h0;
    end else if(T378) begin
      tagVMem_38 <= 1'h1;
    end
    if(reset) begin
      tagVMem_39 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_39 <= 1'h0;
    end else if(T387) begin
      tagVMem_39 <= 1'h0;
    end else if(T385) begin
      tagVMem_39 <= 1'h1;
    end
    if(reset) begin
      tagVMem_40 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_40 <= 1'h0;
    end else if(T400) begin
      tagVMem_40 <= 1'h0;
    end else if(T398) begin
      tagVMem_40 <= 1'h1;
    end
    if(reset) begin
      tagVMem_41 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_41 <= 1'h0;
    end else if(T407) begin
      tagVMem_41 <= 1'h0;
    end else if(T405) begin
      tagVMem_41 <= 1'h1;
    end
    if(reset) begin
      tagVMem_42 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_42 <= 1'h0;
    end else if(T416) begin
      tagVMem_42 <= 1'h0;
    end else if(T414) begin
      tagVMem_42 <= 1'h1;
    end
    if(reset) begin
      tagVMem_43 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_43 <= 1'h0;
    end else if(T423) begin
      tagVMem_43 <= 1'h0;
    end else if(T421) begin
      tagVMem_43 <= 1'h1;
    end
    if(reset) begin
      tagVMem_44 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_44 <= 1'h0;
    end else if(T434) begin
      tagVMem_44 <= 1'h0;
    end else if(T432) begin
      tagVMem_44 <= 1'h1;
    end
    if(reset) begin
      tagVMem_45 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_45 <= 1'h0;
    end else if(T441) begin
      tagVMem_45 <= 1'h0;
    end else if(T439) begin
      tagVMem_45 <= 1'h1;
    end
    if(reset) begin
      tagVMem_46 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_46 <= 1'h0;
    end else if(T450) begin
      tagVMem_46 <= 1'h0;
    end else if(T448) begin
      tagVMem_46 <= 1'h1;
    end
    if(reset) begin
      tagVMem_47 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_47 <= 1'h0;
    end else if(T457) begin
      tagVMem_47 <= 1'h0;
    end else if(T455) begin
      tagVMem_47 <= 1'h1;
    end
    if(reset) begin
      tagVMem_48 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_48 <= 1'h0;
    end else if(T472) begin
      tagVMem_48 <= 1'h0;
    end else if(T470) begin
      tagVMem_48 <= 1'h1;
    end
    if(reset) begin
      tagVMem_49 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_49 <= 1'h0;
    end else if(T479) begin
      tagVMem_49 <= 1'h0;
    end else if(T477) begin
      tagVMem_49 <= 1'h1;
    end
    if(reset) begin
      tagVMem_50 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_50 <= 1'h0;
    end else if(T488) begin
      tagVMem_50 <= 1'h0;
    end else if(T486) begin
      tagVMem_50 <= 1'h1;
    end
    if(reset) begin
      tagVMem_51 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_51 <= 1'h0;
    end else if(T495) begin
      tagVMem_51 <= 1'h0;
    end else if(T493) begin
      tagVMem_51 <= 1'h1;
    end
    if(reset) begin
      tagVMem_52 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_52 <= 1'h0;
    end else if(T506) begin
      tagVMem_52 <= 1'h0;
    end else if(T504) begin
      tagVMem_52 <= 1'h1;
    end
    if(reset) begin
      tagVMem_53 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_53 <= 1'h0;
    end else if(T513) begin
      tagVMem_53 <= 1'h0;
    end else if(T511) begin
      tagVMem_53 <= 1'h1;
    end
    if(reset) begin
      tagVMem_54 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_54 <= 1'h0;
    end else if(T522) begin
      tagVMem_54 <= 1'h0;
    end else if(T520) begin
      tagVMem_54 <= 1'h1;
    end
    if(reset) begin
      tagVMem_55 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_55 <= 1'h0;
    end else if(T529) begin
      tagVMem_55 <= 1'h0;
    end else if(T527) begin
      tagVMem_55 <= 1'h1;
    end
    if(reset) begin
      tagVMem_56 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_56 <= 1'h0;
    end else if(T542) begin
      tagVMem_56 <= 1'h0;
    end else if(T540) begin
      tagVMem_56 <= 1'h1;
    end
    if(reset) begin
      tagVMem_57 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_57 <= 1'h0;
    end else if(T549) begin
      tagVMem_57 <= 1'h0;
    end else if(T547) begin
      tagVMem_57 <= 1'h1;
    end
    if(reset) begin
      tagVMem_58 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_58 <= 1'h0;
    end else if(T558) begin
      tagVMem_58 <= 1'h0;
    end else if(T556) begin
      tagVMem_58 <= 1'h1;
    end
    if(reset) begin
      tagVMem_59 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_59 <= 1'h0;
    end else if(T565) begin
      tagVMem_59 <= 1'h0;
    end else if(T563) begin
      tagVMem_59 <= 1'h1;
    end
    if(reset) begin
      tagVMem_60 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_60 <= 1'h0;
    end else if(T576) begin
      tagVMem_60 <= 1'h0;
    end else if(T574) begin
      tagVMem_60 <= 1'h1;
    end
    if(reset) begin
      tagVMem_61 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_61 <= 1'h0;
    end else if(T583) begin
      tagVMem_61 <= 1'h0;
    end else if(T581) begin
      tagVMem_61 <= 1'h1;
    end
    if(reset) begin
      tagVMem_62 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_62 <= 1'h0;
    end else if(T592) begin
      tagVMem_62 <= 1'h0;
    end else if(T590) begin
      tagVMem_62 <= 1'h1;
    end
    if(reset) begin
      tagVMem_63 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_63 <= 1'h0;
    end else if(T599) begin
      tagVMem_63 <= 1'h0;
    end else if(T597) begin
      tagVMem_63 <= 1'h1;
    end
    if(reset) begin
      tagVMem_64 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_64 <= 1'h0;
    end else if(T618) begin
      tagVMem_64 <= 1'h0;
    end else if(T616) begin
      tagVMem_64 <= 1'h1;
    end
    if(reset) begin
      tagVMem_65 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_65 <= 1'h0;
    end else if(T625) begin
      tagVMem_65 <= 1'h0;
    end else if(T623) begin
      tagVMem_65 <= 1'h1;
    end
    if(reset) begin
      tagVMem_66 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_66 <= 1'h0;
    end else if(T634) begin
      tagVMem_66 <= 1'h0;
    end else if(T632) begin
      tagVMem_66 <= 1'h1;
    end
    if(reset) begin
      tagVMem_67 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_67 <= 1'h0;
    end else if(T641) begin
      tagVMem_67 <= 1'h0;
    end else if(T639) begin
      tagVMem_67 <= 1'h1;
    end
    if(reset) begin
      tagVMem_68 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_68 <= 1'h0;
    end else if(T652) begin
      tagVMem_68 <= 1'h0;
    end else if(T650) begin
      tagVMem_68 <= 1'h1;
    end
    if(reset) begin
      tagVMem_69 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_69 <= 1'h0;
    end else if(T659) begin
      tagVMem_69 <= 1'h0;
    end else if(T657) begin
      tagVMem_69 <= 1'h1;
    end
    if(reset) begin
      tagVMem_70 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_70 <= 1'h0;
    end else if(T668) begin
      tagVMem_70 <= 1'h0;
    end else if(T666) begin
      tagVMem_70 <= 1'h1;
    end
    if(reset) begin
      tagVMem_71 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_71 <= 1'h0;
    end else if(T675) begin
      tagVMem_71 <= 1'h0;
    end else if(T673) begin
      tagVMem_71 <= 1'h1;
    end
    if(reset) begin
      tagVMem_72 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_72 <= 1'h0;
    end else if(T688) begin
      tagVMem_72 <= 1'h0;
    end else if(T686) begin
      tagVMem_72 <= 1'h1;
    end
    if(reset) begin
      tagVMem_73 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_73 <= 1'h0;
    end else if(T695) begin
      tagVMem_73 <= 1'h0;
    end else if(T693) begin
      tagVMem_73 <= 1'h1;
    end
    if(reset) begin
      tagVMem_74 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_74 <= 1'h0;
    end else if(T704) begin
      tagVMem_74 <= 1'h0;
    end else if(T702) begin
      tagVMem_74 <= 1'h1;
    end
    if(reset) begin
      tagVMem_75 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_75 <= 1'h0;
    end else if(T711) begin
      tagVMem_75 <= 1'h0;
    end else if(T709) begin
      tagVMem_75 <= 1'h1;
    end
    if(reset) begin
      tagVMem_76 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_76 <= 1'h0;
    end else if(T722) begin
      tagVMem_76 <= 1'h0;
    end else if(T720) begin
      tagVMem_76 <= 1'h1;
    end
    if(reset) begin
      tagVMem_77 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_77 <= 1'h0;
    end else if(T729) begin
      tagVMem_77 <= 1'h0;
    end else if(T727) begin
      tagVMem_77 <= 1'h1;
    end
    if(reset) begin
      tagVMem_78 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_78 <= 1'h0;
    end else if(T738) begin
      tagVMem_78 <= 1'h0;
    end else if(T736) begin
      tagVMem_78 <= 1'h1;
    end
    if(reset) begin
      tagVMem_79 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_79 <= 1'h0;
    end else if(T745) begin
      tagVMem_79 <= 1'h0;
    end else if(T743) begin
      tagVMem_79 <= 1'h1;
    end
    if(reset) begin
      tagVMem_80 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_80 <= 1'h0;
    end else if(T760) begin
      tagVMem_80 <= 1'h0;
    end else if(T758) begin
      tagVMem_80 <= 1'h1;
    end
    if(reset) begin
      tagVMem_81 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_81 <= 1'h0;
    end else if(T767) begin
      tagVMem_81 <= 1'h0;
    end else if(T765) begin
      tagVMem_81 <= 1'h1;
    end
    if(reset) begin
      tagVMem_82 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_82 <= 1'h0;
    end else if(T776) begin
      tagVMem_82 <= 1'h0;
    end else if(T774) begin
      tagVMem_82 <= 1'h1;
    end
    if(reset) begin
      tagVMem_83 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_83 <= 1'h0;
    end else if(T783) begin
      tagVMem_83 <= 1'h0;
    end else if(T781) begin
      tagVMem_83 <= 1'h1;
    end
    if(reset) begin
      tagVMem_84 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_84 <= 1'h0;
    end else if(T794) begin
      tagVMem_84 <= 1'h0;
    end else if(T792) begin
      tagVMem_84 <= 1'h1;
    end
    if(reset) begin
      tagVMem_85 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_85 <= 1'h0;
    end else if(T801) begin
      tagVMem_85 <= 1'h0;
    end else if(T799) begin
      tagVMem_85 <= 1'h1;
    end
    if(reset) begin
      tagVMem_86 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_86 <= 1'h0;
    end else if(T810) begin
      tagVMem_86 <= 1'h0;
    end else if(T808) begin
      tagVMem_86 <= 1'h1;
    end
    if(reset) begin
      tagVMem_87 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_87 <= 1'h0;
    end else if(T817) begin
      tagVMem_87 <= 1'h0;
    end else if(T815) begin
      tagVMem_87 <= 1'h1;
    end
    if(reset) begin
      tagVMem_88 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_88 <= 1'h0;
    end else if(T830) begin
      tagVMem_88 <= 1'h0;
    end else if(T828) begin
      tagVMem_88 <= 1'h1;
    end
    if(reset) begin
      tagVMem_89 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_89 <= 1'h0;
    end else if(T837) begin
      tagVMem_89 <= 1'h0;
    end else if(T835) begin
      tagVMem_89 <= 1'h1;
    end
    if(reset) begin
      tagVMem_90 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_90 <= 1'h0;
    end else if(T846) begin
      tagVMem_90 <= 1'h0;
    end else if(T844) begin
      tagVMem_90 <= 1'h1;
    end
    if(reset) begin
      tagVMem_91 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_91 <= 1'h0;
    end else if(T853) begin
      tagVMem_91 <= 1'h0;
    end else if(T851) begin
      tagVMem_91 <= 1'h1;
    end
    if(reset) begin
      tagVMem_92 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_92 <= 1'h0;
    end else if(T864) begin
      tagVMem_92 <= 1'h0;
    end else if(T862) begin
      tagVMem_92 <= 1'h1;
    end
    if(reset) begin
      tagVMem_93 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_93 <= 1'h0;
    end else if(T871) begin
      tagVMem_93 <= 1'h0;
    end else if(T869) begin
      tagVMem_93 <= 1'h1;
    end
    if(reset) begin
      tagVMem_94 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_94 <= 1'h0;
    end else if(T880) begin
      tagVMem_94 <= 1'h0;
    end else if(T878) begin
      tagVMem_94 <= 1'h1;
    end
    if(reset) begin
      tagVMem_95 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_95 <= 1'h0;
    end else if(T887) begin
      tagVMem_95 <= 1'h0;
    end else if(T885) begin
      tagVMem_95 <= 1'h1;
    end
    if(reset) begin
      tagVMem_96 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_96 <= 1'h0;
    end else if(T904) begin
      tagVMem_96 <= 1'h0;
    end else if(T902) begin
      tagVMem_96 <= 1'h1;
    end
    if(reset) begin
      tagVMem_97 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_97 <= 1'h0;
    end else if(T911) begin
      tagVMem_97 <= 1'h0;
    end else if(T909) begin
      tagVMem_97 <= 1'h1;
    end
    if(reset) begin
      tagVMem_98 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_98 <= 1'h0;
    end else if(T920) begin
      tagVMem_98 <= 1'h0;
    end else if(T918) begin
      tagVMem_98 <= 1'h1;
    end
    if(reset) begin
      tagVMem_99 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_99 <= 1'h0;
    end else if(T927) begin
      tagVMem_99 <= 1'h0;
    end else if(T925) begin
      tagVMem_99 <= 1'h1;
    end
    if(reset) begin
      tagVMem_100 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_100 <= 1'h0;
    end else if(T938) begin
      tagVMem_100 <= 1'h0;
    end else if(T936) begin
      tagVMem_100 <= 1'h1;
    end
    if(reset) begin
      tagVMem_101 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_101 <= 1'h0;
    end else if(T945) begin
      tagVMem_101 <= 1'h0;
    end else if(T943) begin
      tagVMem_101 <= 1'h1;
    end
    if(reset) begin
      tagVMem_102 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_102 <= 1'h0;
    end else if(T954) begin
      tagVMem_102 <= 1'h0;
    end else if(T952) begin
      tagVMem_102 <= 1'h1;
    end
    if(reset) begin
      tagVMem_103 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_103 <= 1'h0;
    end else if(T961) begin
      tagVMem_103 <= 1'h0;
    end else if(T959) begin
      tagVMem_103 <= 1'h1;
    end
    if(reset) begin
      tagVMem_104 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_104 <= 1'h0;
    end else if(T974) begin
      tagVMem_104 <= 1'h0;
    end else if(T972) begin
      tagVMem_104 <= 1'h1;
    end
    if(reset) begin
      tagVMem_105 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_105 <= 1'h0;
    end else if(T981) begin
      tagVMem_105 <= 1'h0;
    end else if(T979) begin
      tagVMem_105 <= 1'h1;
    end
    if(reset) begin
      tagVMem_106 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_106 <= 1'h0;
    end else if(T990) begin
      tagVMem_106 <= 1'h0;
    end else if(T988) begin
      tagVMem_106 <= 1'h1;
    end
    if(reset) begin
      tagVMem_107 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_107 <= 1'h0;
    end else if(T997) begin
      tagVMem_107 <= 1'h0;
    end else if(T995) begin
      tagVMem_107 <= 1'h1;
    end
    if(reset) begin
      tagVMem_108 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_108 <= 1'h0;
    end else if(T1008) begin
      tagVMem_108 <= 1'h0;
    end else if(T1006) begin
      tagVMem_108 <= 1'h1;
    end
    if(reset) begin
      tagVMem_109 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_109 <= 1'h0;
    end else if(T1015) begin
      tagVMem_109 <= 1'h0;
    end else if(T1013) begin
      tagVMem_109 <= 1'h1;
    end
    if(reset) begin
      tagVMem_110 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_110 <= 1'h0;
    end else if(T1024) begin
      tagVMem_110 <= 1'h0;
    end else if(T1022) begin
      tagVMem_110 <= 1'h1;
    end
    if(reset) begin
      tagVMem_111 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_111 <= 1'h0;
    end else if(T1031) begin
      tagVMem_111 <= 1'h0;
    end else if(T1029) begin
      tagVMem_111 <= 1'h1;
    end
    if(reset) begin
      tagVMem_112 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_112 <= 1'h0;
    end else if(T1046) begin
      tagVMem_112 <= 1'h0;
    end else if(T1044) begin
      tagVMem_112 <= 1'h1;
    end
    if(reset) begin
      tagVMem_113 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_113 <= 1'h0;
    end else if(T1053) begin
      tagVMem_113 <= 1'h0;
    end else if(T1051) begin
      tagVMem_113 <= 1'h1;
    end
    if(reset) begin
      tagVMem_114 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_114 <= 1'h0;
    end else if(T1062) begin
      tagVMem_114 <= 1'h0;
    end else if(T1060) begin
      tagVMem_114 <= 1'h1;
    end
    if(reset) begin
      tagVMem_115 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_115 <= 1'h0;
    end else if(T1069) begin
      tagVMem_115 <= 1'h0;
    end else if(T1067) begin
      tagVMem_115 <= 1'h1;
    end
    if(reset) begin
      tagVMem_116 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_116 <= 1'h0;
    end else if(T1080) begin
      tagVMem_116 <= 1'h0;
    end else if(T1078) begin
      tagVMem_116 <= 1'h1;
    end
    if(reset) begin
      tagVMem_117 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_117 <= 1'h0;
    end else if(T1087) begin
      tagVMem_117 <= 1'h0;
    end else if(T1085) begin
      tagVMem_117 <= 1'h1;
    end
    if(reset) begin
      tagVMem_118 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_118 <= 1'h0;
    end else if(T1096) begin
      tagVMem_118 <= 1'h0;
    end else if(T1094) begin
      tagVMem_118 <= 1'h1;
    end
    if(reset) begin
      tagVMem_119 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_119 <= 1'h0;
    end else if(T1103) begin
      tagVMem_119 <= 1'h0;
    end else if(T1101) begin
      tagVMem_119 <= 1'h1;
    end
    if(reset) begin
      tagVMem_120 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_120 <= 1'h0;
    end else if(T1116) begin
      tagVMem_120 <= 1'h0;
    end else if(T1114) begin
      tagVMem_120 <= 1'h1;
    end
    if(reset) begin
      tagVMem_121 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_121 <= 1'h0;
    end else if(T1123) begin
      tagVMem_121 <= 1'h0;
    end else if(T1121) begin
      tagVMem_121 <= 1'h1;
    end
    if(reset) begin
      tagVMem_122 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_122 <= 1'h0;
    end else if(T1132) begin
      tagVMem_122 <= 1'h0;
    end else if(T1130) begin
      tagVMem_122 <= 1'h1;
    end
    if(reset) begin
      tagVMem_123 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_123 <= 1'h0;
    end else if(T1139) begin
      tagVMem_123 <= 1'h0;
    end else if(T1137) begin
      tagVMem_123 <= 1'h1;
    end
    if(reset) begin
      tagVMem_124 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_124 <= 1'h0;
    end else if(T1150) begin
      tagVMem_124 <= 1'h0;
    end else if(T1148) begin
      tagVMem_124 <= 1'h1;
    end
    if(reset) begin
      tagVMem_125 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_125 <= 1'h0;
    end else if(T1157) begin
      tagVMem_125 <= 1'h0;
    end else if(T1155) begin
      tagVMem_125 <= 1'h1;
    end
    if(reset) begin
      tagVMem_126 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_126 <= 1'h0;
    end else if(T1166) begin
      tagVMem_126 <= 1'h0;
    end else if(T1164) begin
      tagVMem_126 <= 1'h1;
    end
    if(reset) begin
      tagVMem_127 <= 1'h0;
    end else if(io_invalidate) begin
      tagVMem_127 <= 1'h0;
    end else if(T1173) begin
      tagVMem_127 <= 1'h0;
    end else if(T1171) begin
      tagVMem_127 <= 1'h1;
    end
    if(reset) begin
      burstCntReg <= 2'h0;
    end else if(T2) begin
      burstCntReg <= T1191;
    end
    masterReg_ByteEn <= io_master_M_ByteEn;
    fillReg <= T2;
    if(T4) begin
      wrAddrReg <= T1199;
    end else begin
      wrAddrReg <= T1198;
    end
    if(T1233) begin
      slaveReg_Data <= io_slave_S_Data;
    end
    if(T13) begin
      missIndexReg <= T1236;
    end
    if(T1233) begin
      slaveReg_Resp <= io_slave_S_Resp;
    end
  end
endmodule

module StackCache(input clk, input reset,
    input  io_ena_in,
    input [2:0] io_exsc_op,
    input [31:0] io_exsc_opData,
    input [31:0] io_exsc_opOff,
    output[31:0] io_scex_stackTop,
    output[31:0] io_scex_memTop,
    output io_illMem,
    output io_stall,
    input [2:0] io_fromCPU_M_Cmd,
    input [31:0] io_fromCPU_M_Addr,
    input [31:0] io_fromCPU_M_Data,
    input [3:0] io_fromCPU_M_ByteEn,
    output[1:0] io_fromCPU_S_Resp,
    output[31:0] io_fromCPU_S_Data,
    output[2:0] io_toMemory_M_Cmd,
    output[31:0] io_toMemory_M_Addr,
    output[31:0] io_toMemory_M_Data,
    output io_toMemory_M_DataValid,
    output[3:0] io_toMemory_M_DataByteEn,
    input [1:0] io_toMemory_S_Resp,
    input [31:0] io_toMemory_S_Data,
    input  io_toMemory_S_CmdAccept,
    input  io_toMemory_S_DataAccept,
    output io_perf_spill,
    output io_perf_fill
);

  wire[3:0] mb_wrEna;
  wire[3:0] T0;
  wire[3:0] T1;
  wire[3:0] T2;
  wire[3:0] T157;
  wire T3;
  wire T4;
  reg [32:0] transferAddrReg;
  wire[32:0] T5;
  wire[32:0] T6;
  wire[32:0] T7;
  wire[32:0] T8;
  wire[32:0] T9;
  wire[32:0] T10;
  wire[32:0] T11;
  wire[32:0] T12;
  wire[32:0] T13;
  wire[32:0] T158;
  wire[31:0] T14;
  wire[27:0] T15;
  reg [31:0] memTopReg;
  wire[31:0] T92;
  wire[31:0] T93;
  wire[31:0] T94;
  wire[31:0] T95;
  wire[31:0] T96;
  wire T97;
  wire T98;
  wire T18;
  reg [2:0] stateReg;
  wire[2:0] T159;
  wire[2:0] T19;
  wire[2:0] T20;
  wire[2:0] T21;
  wire[2:0] T22;
  wire[2:0] T23;
  wire[2:0] T24;
  wire[2:0] T25;
  wire[2:0] T26;
  wire[2:0] T27;
  wire[2:0] T28;
  wire[2:0] T29;
  wire[2:0] T30;
  wire[2:0] T31;
  wire stackAboveMem;
  wire[31:0] T32;
  reg [31:0] stackTopReg;
  wire[31:0] T33;
  wire[31:0] T34;
  wire[31:0] T35;
  wire[31:0] T36;
  wire T37;
  wire T38;
  wire T39;
  wire T40;
  wire[31:0] T41;
  wire[2:0] T42;
  wire T43;
  wire[31:0] T44;
  wire[2:0] T45;
  wire T46;
  wire[2:0] T47;
  wire T48;
  wire[1:0] burstCounter;
  wire[2:0] T49;
  wire[2:0] T50;
  wire T51;
  wire[2:0] T52;
  wire T53;
  wire[32:0] T160;
  wire T54;
  wire[2:0] T56;
  wire T57;
  wire T58;
  wire[2:0] T59;
  wire[2:0] T60;
  wire T61;
  wire[32:0] T161;
  reg [31:0] newMemTopReg;
  wire[31:0] T62;
  wire[31:0] T63;
  wire[31:0] T64;
  wire T65;
  wire T66;
  wire T67;
  wire T68;
  wire[31:0] stackTopInc;
  wire T99;
  wire[31:0] T100;
  wire[31:0] T101;
  wire[31:0] T102;
  reg  isReserveReg;
  wire T103;
  wire T104;
  wire T55;
  wire[31:0] T105;
  wire T16;
  wire T17;
  wire[32:0] T162;
  wire[31:0] T69;
  wire[27:0] T70;
  wire[31:0] T71;
  wire T72;
  wire T73;
  wire[32:0] T163;
  wire[31:0] T74;
  wire[27:0] T75;
  wire T76;
  wire T77;
  wire[32:0] T78;
  wire[32:0] T79;
  wire T80;
  wire[32:0] T81;
  wire T82;
  wire[32:0] T83;
  wire[32:0] T84;
  wire T85;
  wire T86;
  wire T87;
  wire[32:0] T88;
  wire T89;
  wire T90;
  wire T91;
  wire[32:0] T164;
  wire T106;
  wire T107;
  wire T108;
  wire T109;
  wire[31:0] mb_wrData;
  wire[31:0] T110;
  wire[8:0] mb_wrAddr;
  wire[8:0] T111;
  wire[8:0] relAddr;
  wire[31:0] T112;
  wire[8:0] T113;
  wire[31:0] mb_rdData;
  wire[23:0] T114;
  wire[15:0] T115;
  wire[8:0] mb_rdAddr;
  wire[8:0] T116;
  wire[8:0] T117;
  wire[8:0] T118;
  wire[8:0] T119;
  wire[8:0] T120;
  wire[8:0] T121;
  wire[8:0] T122;
  wire[8:0] T123;
  wire[8:0] T124;
  wire[8:0] T125;
  reg [8:0] rdAddrReg;
  wire[7:0] T126;
  wire T127;
  wire[7:0] T128;
  wire T129;
  wire[7:0] T130;
  wire T131;
  wire[7:0] T132;
  wire T133;
  wire T134;
  wire T135;
  wire[3:0] T136;
  wire[3:0] T165;
  wire writeEnable;
  wire T137;
  wire T138;
  wire[32:0] T166;
  wire T139;
  wire[32:0] T167;
  wire T140;
  wire T141;
  wire[32:0] T168;
  wire T142;
  wire[32:0] T169;
  wire[31:0] T143;
  wire T144;
  wire[31:0] T170;
  wire[2:0] T145;
  wire[2:0] T146;
  wire[2:0] T147;
  reg [1:0] responseToCPUReg;
  wire[1:0] T171;
  wire[1:0] T148;
  wire[1:0] T149;
  wire T150;
  wire T151;
  wire T152;
  wire T153;
  wire T154;
  wire T155;
  wire T156;
  wire[7:0] MemBlock_io_rdData;
  wire[7:0] MemBlock_1_io_rdData;
  wire[7:0] MemBlock_2_io_rdData;
  wire[7:0] MemBlock_3_io_rdData;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    transferAddrReg = {2{$random}};
    memTopReg = {1{$random}};
    stateReg = {1{$random}};
    stackTopReg = {1{$random}};
    newMemTopReg = {1{$random}};
    isReserveReg = {1{$random}};
    rdAddrReg = {1{$random}};
    responseToCPUReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign mb_wrEna = T0;
  assign T0 = T109 ? io_fromCPU_M_ByteEn : T1;
  assign T1 = T107 ? T2 : 4'h0;
  assign T2 = 4'h0 - T157;
  assign T157 = {3'h0, T3};
  assign T3 = T106 & T4;
  assign T4 = T164 <= transferAddrReg;
  assign T5 = T91 ? transferAddrReg : T6;
  assign T6 = T89 ? T88 : T7;
  assign T7 = T85 ? T84 : T8;
  assign T8 = T107 ? T83 : T9;
  assign T9 = T82 ? T81 : T10;
  assign T10 = T80 ? T78 : T11;
  assign T11 = T76 ? T163 : T12;
  assign T12 = T72 ? T162 : T13;
  assign T13 = T16 ? T158 : transferAddrReg;
  assign T158 = {1'h0, T14};
  assign T14 = {T15, 4'h0};
  assign T15 = memTopReg[5'h1f:3'h4];
  assign T92 = T91 ? memTopReg : T93;
  assign T93 = T107 ? T105 : T94;
  assign T94 = T55 ? T100 : T95;
  assign T95 = T99 ? stackTopInc : T96;
  assign T96 = T97 ? io_exsc_opData : memTopReg;
  assign T97 = T18 & T98;
  assign T98 = 3'h2 == io_exsc_op;
  assign T18 = 3'h0 == stateReg;
  assign T159 = reset ? 3'h0 : T19;
  assign T19 = T91 ? stateReg : T20;
  assign T20 = T66 ? 3'h0 : T21;
  assign T21 = T85 ? 3'h6 : T22;
  assign T22 = T107 ? T59 : T23;
  assign T23 = T58 ? T56 : T24;
  assign T24 = T55 ? T49 : T25;
  assign T25 = T82 ? T47 : T26;
  assign T26 = T80 ? T45 : T27;
  assign T27 = T76 ? 3'h4 : T28;
  assign T28 = T72 ? T42 : T29;
  assign T29 = T16 ? T31 : T30;
  assign T30 = T18 ? 3'h0 : stateReg;
  assign T31 = stackAboveMem ? 3'h1 : 3'h0;
  assign stackAboveMem = T32 < io_exsc_opOff;
  assign T32 = memTopReg - stackTopReg;
  assign T33 = T91 ? stackTopReg : T34;
  assign T34 = T72 ? T41 : T35;
  assign T35 = T39 ? stackTopInc : T36;
  assign T36 = T37 ? io_exsc_opData : stackTopReg;
  assign T37 = T18 & T38;
  assign T38 = 3'h1 == io_exsc_op;
  assign T39 = T18 & T40;
  assign T40 = 3'h5 == io_exsc_op;
  assign T41 = stackTopReg - io_exsc_opOff;
  assign T42 = T43 ? 3'h4 : 3'h0;
  assign T43 = 32'h800 < T44;
  assign T44 = memTopReg - T41;
  assign T45 = T46 ? 3'h3 : 3'h4;
  assign T46 = io_toMemory_S_CmdAccept == 1'h1;
  assign T47 = T48 ? 3'h5 : 3'h3;
  assign T48 = burstCounter == 2'h3;
  assign burstCounter = transferAddrReg[2'h3:2'h2];
  assign T49 = T54 ? T52 : T50;
  assign T50 = T51 ? 3'h0 : 3'h5;
  assign T51 = io_toMemory_S_Resp == 2'h3;
  assign T52 = T53 ? 3'h0 : 3'h4;
  assign T53 = T160 <= transferAddrReg;
  assign T160 = {1'h0, memTopReg};
  assign T54 = io_toMemory_S_Resp == 2'h1;
  assign T56 = T57 ? 3'h2 : 3'h1;
  assign T57 = io_toMemory_S_CmdAccept == 1'h1;
  assign T58 = 3'h1 == stateReg;
  assign T59 = T65 ? T60 : 3'h2;
  assign T60 = T61 ? 3'h0 : 3'h1;
  assign T61 = T161 <= transferAddrReg;
  assign T161 = {1'h0, newMemTopReg};
  assign T62 = T76 ? T64 : T63;
  assign T63 = T16 ? stackTopInc : newMemTopReg;
  assign T64 = memTopReg - io_exsc_opOff;
  assign T65 = burstCounter == 2'h3;
  assign T66 = T68 & T67;
  assign T67 = burstCounter == 2'h3;
  assign T68 = 3'h6 == stateReg;
  assign stackTopInc = stackTopReg + io_exsc_opOff;
  assign T99 = T39 & stackAboveMem;
  assign T100 = T53 ? T101 : memTopReg;
  assign T101 = isReserveReg ? T102 : newMemTopReg;
  assign T102 = stackTopReg + 32'h800;
  assign T103 = T76 ? 1'h0 : T104;
  assign T104 = T72 ? 1'h1 : isReserveReg;
  assign T55 = 3'h5 == stateReg;
  assign T105 = T61 ? newMemTopReg : memTopReg;
  assign T16 = T18 & T17;
  assign T17 = 3'h4 == io_exsc_op;
  assign T162 = {1'h0, T69};
  assign T69 = {T70, 4'h0};
  assign T70 = T71[5'h1f:3'h4];
  assign T71 = T41 + 32'h800;
  assign T72 = T18 & T73;
  assign T73 = 3'h3 == io_exsc_op;
  assign T163 = {1'h0, T74};
  assign T74 = {T75, 4'h0};
  assign T75 = T64[5'h1f:3'h4];
  assign T76 = T18 & T77;
  assign T77 = 3'h6 == io_exsc_op;
  assign T78 = T46 ? T79 : transferAddrReg;
  assign T79 = transferAddrReg + 33'h4;
  assign T80 = 3'h4 == stateReg;
  assign T81 = transferAddrReg + 33'h4;
  assign T82 = 3'h3 == stateReg;
  assign T83 = transferAddrReg + 33'h4;
  assign T84 = transferAddrReg + 33'h4;
  assign T85 = T87 & T86;
  assign T86 = io_toMemory_S_Resp == 2'h3;
  assign T87 = 3'h2 == stateReg;
  assign T88 = transferAddrReg + 33'h4;
  assign T89 = T68 & T90;
  assign T90 = io_toMemory_S_Resp != 2'h0;
  assign T91 = io_ena_in ^ 1'h1;
  assign T164 = {1'h0, memTopReg};
  assign T106 = T61 ^ 1'h1;
  assign T107 = T87 & T108;
  assign T108 = io_toMemory_S_Resp == 2'h1;
  assign T109 = io_fromCPU_M_Cmd == 3'h1;
  assign mb_wrData = T110;
  assign T110 = T107 ? io_toMemory_S_Data : io_fromCPU_M_Data;
  assign mb_wrAddr = T111;
  assign T111 = T107 ? T113 : relAddr;
  assign relAddr = T112[4'ha:2'h2];
  assign T112 = io_fromCPU_M_Addr + stackTopReg;
  assign T113 = transferAddrReg[4'ha:2'h2];
  assign mb_rdData = {MemBlock_3_io_rdData, T114};
  assign T114 = {MemBlock_2_io_rdData, T115};
  assign T115 = {MemBlock_1_io_rdData, MemBlock_io_rdData};
  assign mb_rdAddr = T116;
  assign T116 = T55 ? rdAddrReg : T117;
  assign T117 = T82 ? T125 : T118;
  assign T118 = T80 ? T123 : T119;
  assign T119 = T76 ? T122 : T120;
  assign T120 = T72 ? T121 : relAddr;
  assign T121 = T69[4'ha:2'h2];
  assign T122 = T74[4'ha:2'h2];
  assign T123 = T46 ? T124 : rdAddrReg;
  assign T124 = T79[4'ha:2'h2];
  assign T125 = T81[4'ha:2'h2];
  assign T126 = mb_wrData[5'h1f:5'h18];
  assign T127 = mb_wrEna[2'h3:2'h3];
  assign T128 = mb_wrData[5'h17:5'h10];
  assign T129 = mb_wrEna[2'h2:2'h2];
  assign T130 = mb_wrData[4'hf:4'h8];
  assign T131 = mb_wrEna[1'h1:1'h1];
  assign T132 = mb_wrData[3'h7:1'h0];
  assign T133 = mb_wrEna[1'h0:1'h0];
  assign io_perf_fill = T134;
  assign T134 = T58 & T57;
  assign io_perf_spill = T135;
  assign T135 = T80 & T46;
  assign io_toMemory_M_DataByteEn = T136;
  assign T136 = 4'h0 - T165;
  assign T165 = {3'h0, writeEnable};
  assign writeEnable = isReserveReg ? T140 : T137;
  assign T137 = T139 & T138;
  assign T138 = transferAddrReg < T166;
  assign T166 = {1'h0, memTopReg};
  assign T139 = T167 <= transferAddrReg;
  assign T167 = {1'h0, newMemTopReg};
  assign T140 = T142 & T141;
  assign T141 = transferAddrReg < T168;
  assign T168 = {1'h0, memTopReg};
  assign T142 = T169 <= transferAddrReg;
  assign T169 = {1'h0, T143};
  assign T143 = stackTopReg + 32'h800;
  assign io_toMemory_M_DataValid = T144;
  assign T144 = T82 ? 1'h1 : T80;
  assign io_toMemory_M_Data = mb_rdData;
  assign io_toMemory_M_Addr = T170;
  assign T170 = transferAddrReg[5'h1f:1'h0];
  assign io_toMemory_M_Cmd = T145;
  assign T145 = T91 ? 3'h0 : T146;
  assign T146 = T58 ? 3'h2 : T147;
  assign T147 = T80 ? 3'h1 : 3'h0;
  assign io_fromCPU_S_Data = mb_rdData;
  assign io_fromCPU_S_Resp = responseToCPUReg;
  assign T171 = reset ? 2'h0 : T148;
  assign T148 = T150 ? 2'h1 : T149;
  assign T149 = T109 ? 2'h1 : 2'h0;
  assign T150 = T152 & T151;
  assign T151 = io_fromCPU_M_Cmd == 3'h2;
  assign T152 = T109 ^ 1'h1;
  assign io_stall = T153;
  assign T153 = stateReg != 3'h0;
  assign io_illMem = T154;
  assign T154 = T66 ? 1'h1 : T155;
  assign T155 = T55 ? T156 : 1'h0;
  assign T156 = io_toMemory_S_Resp == 2'h3;
  assign io_scex_memTop = memTopReg;
  assign io_scex_stackTop = stackTopReg;
  MemBlock_2 MemBlock(.clk(clk),
       .io_rdAddr( mb_rdAddr ),
       .io_rdData( MemBlock_io_rdData ),
       .io_wrAddr( mb_wrAddr ),
       .io_wrEna( T133 ),
       .io_wrData( T132 )
  );
  MemBlock_2 MemBlock_1(.clk(clk),
       .io_rdAddr( mb_rdAddr ),
       .io_rdData( MemBlock_1_io_rdData ),
       .io_wrAddr( mb_wrAddr ),
       .io_wrEna( T131 ),
       .io_wrData( T130 )
  );
  MemBlock_2 MemBlock_2(.clk(clk),
       .io_rdAddr( mb_rdAddr ),
       .io_rdData( MemBlock_2_io_rdData ),
       .io_wrAddr( mb_wrAddr ),
       .io_wrEna( T129 ),
       .io_wrData( T128 )
  );
  MemBlock_2 MemBlock_3(.clk(clk),
       .io_rdAddr( mb_rdAddr ),
       .io_rdData( MemBlock_3_io_rdData ),
       .io_wrAddr( mb_wrAddr ),
       .io_wrEna( T127 ),
       .io_wrData( T126 )
  );

  always @(posedge clk) begin
    if(T91) begin
      transferAddrReg <= transferAddrReg;
    end else if(T89) begin
      transferAddrReg <= T88;
    end else if(T85) begin
      transferAddrReg <= T84;
    end else if(T107) begin
      transferAddrReg <= T83;
    end else if(T82) begin
      transferAddrReg <= T81;
    end else if(T80) begin
      transferAddrReg <= T78;
    end else if(T76) begin
      transferAddrReg <= T163;
    end else if(T72) begin
      transferAddrReg <= T162;
    end else if(T16) begin
      transferAddrReg <= T158;
    end
    if(T91) begin
      memTopReg <= memTopReg;
    end else if(T107) begin
      memTopReg <= T105;
    end else if(T55) begin
      memTopReg <= T100;
    end else if(T99) begin
      memTopReg <= stackTopInc;
    end else if(T97) begin
      memTopReg <= io_exsc_opData;
    end
    if(reset) begin
      stateReg <= 3'h0;
    end else if(T91) begin
      stateReg <= stateReg;
    end else if(T66) begin
      stateReg <= 3'h0;
    end else if(T85) begin
      stateReg <= 3'h6;
    end else if(T107) begin
      stateReg <= T59;
    end else if(T58) begin
      stateReg <= T56;
    end else if(T55) begin
      stateReg <= T49;
    end else if(T82) begin
      stateReg <= T47;
    end else if(T80) begin
      stateReg <= T45;
    end else if(T76) begin
      stateReg <= 3'h4;
    end else if(T72) begin
      stateReg <= T42;
    end else if(T16) begin
      stateReg <= T31;
    end else if(T18) begin
      stateReg <= 3'h0;
    end
    if(T91) begin
      stackTopReg <= stackTopReg;
    end else if(T72) begin
      stackTopReg <= T41;
    end else if(T39) begin
      stackTopReg <= stackTopInc;
    end else if(T37) begin
      stackTopReg <= io_exsc_opData;
    end
    if(T76) begin
      newMemTopReg <= T64;
    end else if(T16) begin
      newMemTopReg <= stackTopInc;
    end
    if(T76) begin
      isReserveReg <= 1'h0;
    end else if(T72) begin
      isReserveReg <= 1'h1;
    end
    rdAddrReg <= mb_rdAddr;
    if(reset) begin
      responseToCPUReg <= 2'h0;
    end else if(T150) begin
      responseToCPUReg <= 2'h1;
    end else if(T109) begin
      responseToCPUReg <= 2'h1;
    end else begin
      responseToCPUReg <= 2'h0;
    end
  end
endmodule

module NullCache(input clk, input reset,
    input [2:0] io_master_M_Cmd,
    input [31:0] io_master_M_Addr,
    input [31:0] io_master_M_Data,
    input [3:0] io_master_M_ByteEn,
    output[1:0] io_master_S_Resp,
    output[31:0] io_master_S_Data,
    output[2:0] io_slave_M_Cmd,
    output[31:0] io_slave_M_Addr,
    output[31:0] io_slave_M_Data,
    output io_slave_M_DataValid,
    output[3:0] io_slave_M_DataByteEn,
    input [1:0] io_slave_S_Resp,
    input [31:0] io_slave_S_Data,
    input  io_slave_S_CmdAccept,
    input  io_slave_S_DataAccept,
    //input  io_invalidate
    output io_perf_hit,
    output io_perf_miss
);

  wire T0;
  wire T1;
  wire T2;
  reg [2:0] masterReg_Cmd;
  wire[2:0] T3;
  wire[2:0] T4;
  wire T5;
  wire T6;
  wire T7;
  wire[31:0] T8;
  wire[27:0] T9;
  reg [31:0] masterReg_Addr;
  wire[31:0] T10;
  wire[2:0] T11;
  wire[31:0] T12;
  reg [31:0] slaveReg_Data;
  wire[31:0] T13;
  wire T14;
  wire T15;
  reg [1:0] posReg;
  wire[1:0] T16;
  wire[1:0] T17;
  reg [1:0] burstCntReg;
  wire[1:0] T31;
  wire[1:0] T18;
  wire[1:0] T19;
  wire T20;
  wire T21;
  wire T22;
  reg [1:0] stateReg;
  wire[1:0] T32;
  wire[1:0] T23;
  wire[1:0] T24;
  wire[1:0] T25;
  wire T26;
  wire T27;
  wire T28;
  wire[1:0] T29;
  reg [1:0] slaveReg_Resp;
  wire[1:0] T30;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    masterReg_Cmd = {1{$random}};
    masterReg_Addr = {1{$random}};
    slaveReg_Data = {1{$random}};
    posReg = {1{$random}};
    burstCntReg = {1{$random}};
    stateReg = {1{$random}};
    slaveReg_Resp = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_perf_miss = T0;
  assign T0 = T2 & T1;
  assign T1 = io_slave_S_CmdAccept == 1'h1;
  assign T2 = masterReg_Cmd == 3'h2;
  assign T3 = reset ? 3'h0 : T4;
  assign T4 = T5 ? io_master_M_Cmd : masterReg_Cmd;
  assign T5 = T7 | T6;
  assign T6 = io_slave_S_CmdAccept == 1'h1;
  assign T7 = masterReg_Cmd != 3'h2;
  assign io_perf_hit = 1'h0;
  assign io_slave_M_DataByteEn = 4'h0;
  assign io_slave_M_DataValid = 1'h0;
  assign io_slave_M_Data = 32'h0;
  assign io_slave_M_Addr = T8;
  assign T8 = {T9, 4'h0};
  assign T9 = masterReg_Addr[5'h1f:3'h4];
  assign T10 = T5 ? io_master_M_Addr : masterReg_Addr;
  assign io_slave_M_Cmd = T11;
  assign T11 = T2 ? 3'h2 : 3'h0;
  assign io_master_S_Data = T12;
  assign T12 = T28 ? slaveReg_Data : 32'h0;
  assign T13 = T14 ? io_slave_S_Data : slaveReg_Data;
  assign T14 = T22 & T15;
  assign T15 = burstCntReg == posReg;
  assign T16 = T0 ? T17 : posReg;
  assign T17 = masterReg_Addr[2'h3:2'h2];
  assign T31 = reset ? 2'h0 : T18;
  assign T18 = T20 ? T19 : burstCntReg;
  assign T19 = burstCntReg + 2'h1;
  assign T20 = T22 & T21;
  assign T21 = io_slave_S_Resp != 2'h0;
  assign T22 = stateReg == 2'h1;
  assign T32 = reset ? 2'h0 : T23;
  assign T23 = T0 ? 2'h1 : T24;
  assign T24 = T28 ? 2'h0 : T25;
  assign T25 = T26 ? 2'h2 : stateReg;
  assign T26 = T20 & T27;
  assign T27 = burstCntReg == 2'h3;
  assign T28 = stateReg == 2'h2;
  assign io_master_S_Resp = T29;
  assign T29 = T28 ? slaveReg_Resp : 2'h0;
  assign T30 = T14 ? io_slave_S_Resp : slaveReg_Resp;

  always @(posedge clk) begin
    if(reset) begin
      masterReg_Cmd <= 3'h0;
    end else if(T5) begin
      masterReg_Cmd <= io_master_M_Cmd;
    end
    if(T5) begin
      masterReg_Addr <= io_master_M_Addr;
    end
    if(T14) begin
      slaveReg_Data <= io_slave_S_Data;
    end
    if(T0) begin
      posReg <= T17;
    end
    if(reset) begin
      burstCntReg <= 2'h0;
    end else if(T20) begin
      burstCntReg <= T19;
    end
    if(reset) begin
      stateReg <= 2'h0;
    end else if(T0) begin
      stateReg <= 2'h1;
    end else if(T28) begin
      stateReg <= 2'h0;
    end else if(T26) begin
      stateReg <= 2'h2;
    end
    if(T14) begin
      slaveReg_Resp <= io_slave_S_Resp;
    end
  end
endmodule

module OcpBurstBus(
    output[2:0] io_master_M_Cmd,
    output[31:0] io_master_M_Addr,
    output[31:0] io_master_M_Data,
    output io_master_M_DataValid,
    output[3:0] io_master_M_DataByteEn,
    input [1:0] io_master_S_Resp,
    input [31:0] io_master_S_Data,
    input  io_master_S_CmdAccept,
    input  io_master_S_DataAccept,
    input [2:0] io_slave_M_Cmd,
    input [31:0] io_slave_M_Addr,
    input [31:0] io_slave_M_Data,
    input  io_slave_M_DataValid,
    input [3:0] io_slave_M_DataByteEn,
    output[1:0] io_slave_S_Resp,
    output[31:0] io_slave_S_Data,
    output io_slave_S_CmdAccept,
    output io_slave_S_DataAccept
);



  assign io_slave_S_DataAccept = io_master_S_DataAccept;
  assign io_slave_S_CmdAccept = io_master_S_CmdAccept;
  assign io_slave_S_Data = io_master_S_Data;
  assign io_slave_S_Resp = io_master_S_Resp;
  assign io_master_M_DataByteEn = io_slave_M_DataByteEn;
  assign io_master_M_DataValid = io_slave_M_DataValid;
  assign io_master_M_Data = io_slave_M_Data;
  assign io_master_M_Addr = io_slave_M_Addr;
  assign io_master_M_Cmd = io_slave_M_Cmd;
endmodule

module WriteNoBuffer(input clk, input reset,
    input [2:0] io_readMaster_M_Cmd,
    input [31:0] io_readMaster_M_Addr,
    input [31:0] io_readMaster_M_Data,
    input  io_readMaster_M_DataValid,
    input [3:0] io_readMaster_M_DataByteEn,
    output[1:0] io_readMaster_S_Resp,
    output[31:0] io_readMaster_S_Data,
    output io_readMaster_S_CmdAccept,
    output io_readMaster_S_DataAccept,
    input [2:0] io_writeMaster_M_Cmd,
    input [31:0] io_writeMaster_M_Addr,
    input [31:0] io_writeMaster_M_Data,
    input [3:0] io_writeMaster_M_ByteEn,
    input [1:0] io_writeMaster_M_AddrSpace,
    output[1:0] io_writeMaster_S_Resp,
    output[31:0] io_writeMaster_S_Data,
    output[2:0] io_slave_M_Cmd,
    output[31:0] io_slave_M_Addr,
    output[31:0] io_slave_M_Data,
    output io_slave_M_DataValid,
    output[3:0] io_slave_M_DataByteEn,
    input [1:0] io_slave_S_Resp,
    input [31:0] io_slave_S_Data,
    input  io_slave_S_CmdAccept,
    input  io_slave_S_DataAccept,
    output io_perf_hit,
    output io_perf_miss
);

  wire T0;
  wire[3:0] T1;
  wire[3:0] T2;
  wire T3;
  reg [1:0] state;
  wire[1:0] T33;
  wire[1:0] T4;
  wire[1:0] T5;
  wire[1:0] T6;
  wire T7;
  wire T8;
  reg [1:0] cntReg;
  wire[1:0] T34;
  wire[1:0] T9;
  wire[1:0] T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  reg [3:0] writeMasterReg_ByteEn;
  wire[3:0] T16;
  wire T17;
  wire T18;
  wire T19;
  wire[1:0] wrPos;
  reg [31:0] writeMasterReg_Addr;
  wire[31:0] T20;
  wire T21;
  wire[31:0] T22;
  reg [31:0] writeMasterReg_Data;
  wire[31:0] T23;
  wire[31:0] T24;
  wire[31:0] T25;
  wire[27:0] T26;
  wire T27;
  wire T28;
  wire[2:0] T29;
  wire[1:0] T30;
  wire[1:0] T31;
  wire[1:0] T32;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    state = {1{$random}};
    cntReg = {1{$random}};
    writeMasterReg_ByteEn = {1{$random}};
    writeMasterReg_Addr = {1{$random}};
    writeMasterReg_Data = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_perf_miss = T0;
  assign T0 = io_writeMaster_M_Cmd == 3'h1;
  assign io_perf_hit = 1'h0;
  assign io_slave_M_DataByteEn = T1;
  assign T1 = T18 ? writeMasterReg_ByteEn : T2;
  assign T2 = T3 ? 4'h0 : io_readMaster_M_DataByteEn;
  assign T3 = state == 2'h1;
  assign T33 = reset ? 2'h0 : T4;
  assign T4 = T0 ? 2'h1 : T5;
  assign T5 = T13 ? 2'h0 : T6;
  assign T6 = T7 ? 2'h2 : state;
  assign T7 = T3 & T8;
  assign T8 = cntReg == 2'h3;
  assign T34 = reset ? 2'h0 : T9;
  assign T9 = T11 ? T10 : cntReg;
  assign T10 = cntReg + 2'h1;
  assign T11 = T3 & T12;
  assign T12 = io_slave_S_DataAccept == 1'h1;
  assign T13 = T15 & T14;
  assign T14 = io_slave_S_Resp != 2'h0;
  assign T15 = state == 2'h2;
  assign T16 = T17 ? io_writeMaster_M_ByteEn : writeMasterReg_ByteEn;
  assign T17 = state != 2'h1;
  assign T18 = T3 & T19;
  assign T19 = cntReg == wrPos;
  assign wrPos = writeMasterReg_Addr[2'h3:2'h2];
  assign T20 = T17 ? io_writeMaster_M_Addr : writeMasterReg_Addr;
  assign io_slave_M_DataValid = T21;
  assign T21 = T3 ? 1'h1 : io_readMaster_M_DataValid;
  assign io_slave_M_Data = T22;
  assign T22 = T3 ? writeMasterReg_Data : io_readMaster_M_Data;
  assign T23 = T17 ? io_writeMaster_M_Data : writeMasterReg_Data;
  assign io_slave_M_Addr = T24;
  assign T24 = T27 ? T25 : io_readMaster_M_Addr;
  assign T25 = {T26, 4'h0};
  assign T26 = writeMasterReg_Addr[5'h1f:3'h4];
  assign T27 = T3 & T28;
  assign T28 = cntReg == 2'h0;
  assign io_slave_M_Cmd = T29;
  assign T29 = T27 ? 3'h1 : io_readMaster_M_Cmd;
  assign io_writeMaster_S_Data = io_slave_S_Data;
  assign io_writeMaster_S_Resp = T30;
  assign T30 = T15 ? io_slave_S_Resp : 2'h0;
  assign io_readMaster_S_DataAccept = io_slave_S_DataAccept;
  assign io_readMaster_S_CmdAccept = io_slave_S_CmdAccept;
  assign io_readMaster_S_Data = io_slave_S_Data;
  assign io_readMaster_S_Resp = T31;
  assign T31 = T15 ? 2'h0 : T32;
  assign T32 = T3 ? 2'h0 : io_slave_S_Resp;

  always @(posedge clk) begin
    if(reset) begin
      state <= 2'h0;
    end else if(T0) begin
      state <= 2'h1;
    end else if(T13) begin
      state <= 2'h0;
    end else if(T7) begin
      state <= 2'h2;
    end
    if(reset) begin
      cntReg <= 2'h0;
    end else if(T11) begin
      cntReg <= T10;
    end
    if(T17) begin
      writeMasterReg_ByteEn <= io_writeMaster_M_ByteEn;
    end
    if(T17) begin
      writeMasterReg_Addr <= io_writeMaster_M_Addr;
    end
    if(T17) begin
      writeMasterReg_Data <= io_writeMaster_M_Data;
    end
  end
endmodule

module DataCache(input clk, input reset,
    input [2:0] io_master_M_Cmd,
    input [31:0] io_master_M_Addr,
    input [31:0] io_master_M_Data,
    input [3:0] io_master_M_ByteEn,
    input [1:0] io_master_M_AddrSpace,
    output[1:0] io_master_S_Resp,
    output[31:0] io_master_S_Data,
    output[2:0] io_slave_M_Cmd,
    output[31:0] io_slave_M_Addr,
    output[31:0] io_slave_M_Data,
    output io_slave_M_DataValid,
    output[3:0] io_slave_M_DataByteEn,
    input [1:0] io_slave_S_Resp,
    input [31:0] io_slave_S_Data,
    input  io_slave_S_CmdAccept,
    input  io_slave_S_DataAccept,
    input  io_scIO_ena_in,
    input [2:0] io_scIO_exsc_op,
    input [31:0] io_scIO_exsc_opData,
    input [31:0] io_scIO_exsc_opOff,
    output[31:0] io_scIO_scex_stackTop,
    output[31:0] io_scIO_scex_memTop,
    output io_scIO_illMem,
    output io_scIO_stall,
    input  io_invalDCache,
    output io_dcPerf_hit,
    output io_dcPerf_miss,
    output io_scPerf_spill,
    output io_scPerf_fill,
    output io_wcPerf_hit,
    output io_wcPerf_miss
);

  wire[2:0] T0;
  wire T1;
  wire selSC;
  wire[3:0] T2;
  wire T3;
  wire T4;
  reg  R5;
  wire T6;
  wire T7;
  wire T8;
  wire[31:0] T9;
  wire[31:0] T10;
  wire[2:0] T11;
  wire[3:0] T12;
  wire T13;
  wire T14;
  reg  R15;
  wire T16;
  wire T17;
  wire T18;
  wire[31:0] T19;
  wire[31:0] T20;
  wire[2:0] T21;
  wire[1:0] T22;
  wire T23;
  wire[1:0] T24;
  wire T25;
  wire[2:0] T26;
  wire T27;
  wire T28;
  wire T29;
  wire selDC;
  wire[1:0] T30;
  wire[2:0] T31;
  wire[1:0] T32;
  wire[2:0] T33;
  wire T34;
  wire T35;
  wire[31:0] T36;
  wire[31:0] T37;
  reg  selDCReg;
  wire T38;
  wire T39;
  reg  selSCReg;
  wire T40;
  wire[1:0] T41;
  wire[1:0] T42;
  wire[1:0] T43;
  wire[1:0] bp_io_master_S_Resp;
  wire[31:0] bp_io_master_S_Data;
  wire[2:0] bp_io_slave_M_Cmd;
  wire[31:0] bp_io_slave_M_Addr;
  wire[31:0] bp_io_slave_M_Data;
  wire bp_io_slave_M_DataValid;
  wire[3:0] bp_io_slave_M_DataByteEn;
  wire[2:0] burstReadBus1_io_master_M_Cmd;
  wire[31:0] burstReadBus1_io_master_M_Addr;
  wire[31:0] burstReadBus1_io_master_M_Data;
  wire burstReadBus1_io_master_M_DataValid;
  wire[3:0] burstReadBus1_io_master_M_DataByteEn;
  wire[1:0] burstReadBus1_io_slave_S_Resp;
  wire[31:0] burstReadBus1_io_slave_S_Data;
  wire burstReadBus1_io_slave_S_CmdAccept;
  wire burstReadBus1_io_slave_S_DataAccept;
  wire[2:0] burstReadBus2_io_master_M_Cmd;
  wire[31:0] burstReadBus2_io_master_M_Addr;
  wire[31:0] burstReadBus2_io_master_M_Data;
  wire burstReadBus2_io_master_M_DataValid;
  wire[3:0] burstReadBus2_io_master_M_DataByteEn;
  wire[1:0] burstReadBus2_io_slave_S_Resp;
  wire[31:0] burstReadBus2_io_slave_S_Data;
  wire burstReadBus2_io_slave_S_CmdAccept;
  wire burstReadBus2_io_slave_S_DataAccept;
  wire[1:0] wc_io_readMaster_S_Resp;
  wire[31:0] wc_io_readMaster_S_Data;
  wire wc_io_readMaster_S_CmdAccept;
  wire wc_io_readMaster_S_DataAccept;
  wire[1:0] wc_io_writeMaster_S_Resp;
  wire[2:0] wc_io_slave_M_Cmd;
  wire[31:0] wc_io_slave_M_Addr;
  wire[31:0] wc_io_slave_M_Data;
  wire wc_io_slave_M_DataValid;
  wire[3:0] wc_io_slave_M_DataByteEn;
  wire wc_io_perf_hit;
  wire wc_io_perf_miss;
  wire[1:0] dm_io_master_S_Resp;
  wire[31:0] dm_io_master_S_Data;
  wire[2:0] dm_io_slave_M_Cmd;
  wire[31:0] dm_io_slave_M_Addr;
  wire[31:0] dm_io_slave_M_Data;
  wire dm_io_slave_M_DataValid;
  wire[3:0] dm_io_slave_M_DataByteEn;
  wire dm_io_perf_hit;
  wire dm_io_perf_miss;
  wire[31:0] sc_io_scex_stackTop;
  wire[31:0] sc_io_scex_memTop;
  wire sc_io_illMem;
  wire sc_io_stall;
  wire[1:0] sc_io_fromCPU_S_Resp;
  wire[31:0] sc_io_fromCPU_S_Data;
  wire[2:0] sc_io_toMemory_M_Cmd;
  wire[31:0] sc_io_toMemory_M_Addr;
  wire[31:0] sc_io_toMemory_M_Data;
  wire sc_io_toMemory_M_DataValid;
  wire[3:0] sc_io_toMemory_M_DataByteEn;
  wire sc_io_perf_spill;
  wire sc_io_perf_fill;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    R5 = {1{$random}};
    R15 = {1{$random}};
    selDCReg = {1{$random}};
    selSCReg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = T1 ? io_master_M_Cmd : 3'h0;
  assign T1 = selSC ^ 1'h1;
  assign selSC = io_master_M_AddrSpace == 2'h0;
  assign T2 = T3 ? burstReadBus1_io_master_M_DataByteEn : sc_io_toMemory_M_DataByteEn;
  assign T3 = T7 ? 1'h0 : T4;
  assign T4 = T6 ? 1'h1 : R5;
  assign T6 = burstReadBus1_io_master_M_Cmd != 3'h0;
  assign T7 = sc_io_toMemory_M_Cmd != 3'h0;
  assign T8 = T3 ? burstReadBus1_io_master_M_DataValid : sc_io_toMemory_M_DataValid;
  assign T9 = T3 ? burstReadBus1_io_master_M_Data : sc_io_toMemory_M_Data;
  assign T10 = T3 ? burstReadBus1_io_master_M_Addr : sc_io_toMemory_M_Addr;
  assign T11 = burstReadBus1_io_master_M_Cmd | sc_io_toMemory_M_Cmd;
  assign T12 = T13 ? bp_io_slave_M_DataByteEn : dm_io_slave_M_DataByteEn;
  assign T13 = T17 ? 1'h0 : T14;
  assign T14 = T16 ? 1'h1 : R15;
  assign T16 = bp_io_slave_M_Cmd != 3'h0;
  assign T17 = dm_io_slave_M_Cmd != 3'h0;
  assign T18 = T13 ? bp_io_slave_M_DataValid : dm_io_slave_M_DataValid;
  assign T19 = T13 ? bp_io_slave_M_Data : dm_io_slave_M_Data;
  assign T20 = T13 ? bp_io_slave_M_Addr : dm_io_slave_M_Addr;
  assign T21 = bp_io_slave_M_Cmd | dm_io_slave_M_Cmd;
  assign T22 = T23 ? 2'h0 : burstReadBus2_io_slave_S_Resp;
  assign T23 = R5 ^ 1'h1;
  assign T24 = T25 ? 2'h0 : burstReadBus1_io_slave_S_Resp;
  assign T25 = R15 ^ 1'h1;
  assign T26 = T27 ? io_master_M_Cmd : 3'h0;
  assign T27 = T29 & T28;
  assign T28 = selSC ^ 1'h1;
  assign T29 = selDC ^ 1'h1;
  assign selDC = io_master_M_AddrSpace == 2'h2;
  assign T30 = R5 ? 2'h0 : burstReadBus2_io_slave_S_Resp;
  assign T31 = selSC ? io_master_M_Cmd : 3'h0;
  assign T32 = R15 ? 2'h0 : burstReadBus1_io_slave_S_Resp;
  assign T33 = T34 ? io_master_M_Cmd : 3'h0;
  assign T34 = selDC | T35;
  assign T35 = io_master_M_Cmd == 3'h1;
  assign io_wcPerf_miss = wc_io_perf_miss;
  assign io_wcPerf_hit = wc_io_perf_hit;
  assign io_scPerf_fill = sc_io_perf_fill;
  assign io_scPerf_spill = sc_io_perf_spill;
  assign io_dcPerf_miss = dm_io_perf_miss;
  assign io_dcPerf_hit = dm_io_perf_hit;
  assign io_scIO_stall = sc_io_stall;
  assign io_scIO_illMem = sc_io_illMem;
  assign io_scIO_scex_memTop = sc_io_scex_memTop;
  assign io_scIO_scex_stackTop = sc_io_scex_stackTop;
  assign io_slave_M_DataByteEn = wc_io_slave_M_DataByteEn;
  assign io_slave_M_DataValid = wc_io_slave_M_DataValid;
  assign io_slave_M_Data = wc_io_slave_M_Data;
  assign io_slave_M_Addr = wc_io_slave_M_Addr;
  assign io_slave_M_Cmd = wc_io_slave_M_Cmd;
  assign io_master_S_Data = T36;
  assign T36 = selSCReg ? sc_io_fromCPU_S_Data : T37;
  assign T37 = selDCReg ? dm_io_master_S_Data : bp_io_master_S_Data;
  assign T38 = T39 ? selDC : selDCReg;
  assign T39 = io_master_M_Cmd != 3'h0;
  assign T40 = T39 ? selSC : selSCReg;
  assign io_master_S_Resp = T41;
  assign T41 = T42 | wc_io_writeMaster_S_Resp;
  assign T42 = T43 | bp_io_master_S_Resp;
  assign T43 = dm_io_master_S_Resp | sc_io_fromCPU_S_Resp;
  DirectMappedCache dm(.clk(clk), .reset(reset),
       .io_master_M_Cmd( T33 ),
       .io_master_M_Addr( io_master_M_Addr ),
       .io_master_M_Data( io_master_M_Data ),
       .io_master_M_ByteEn( io_master_M_ByteEn ),
       .io_master_S_Resp( dm_io_master_S_Resp ),
       .io_master_S_Data( dm_io_master_S_Data ),
       .io_slave_M_Cmd( dm_io_slave_M_Cmd ),
       .io_slave_M_Addr( dm_io_slave_M_Addr ),
       .io_slave_M_Data( dm_io_slave_M_Data ),
       .io_slave_M_DataValid( dm_io_slave_M_DataValid ),
       .io_slave_M_DataByteEn( dm_io_slave_M_DataByteEn ),
       .io_slave_S_Resp( T32 ),
       .io_slave_S_Data( burstReadBus1_io_slave_S_Data ),
       .io_slave_S_CmdAccept( burstReadBus1_io_slave_S_CmdAccept ),
       .io_slave_S_DataAccept( burstReadBus1_io_slave_S_DataAccept ),
       .io_invalidate( io_invalDCache ),
       .io_perf_hit( dm_io_perf_hit ),
       .io_perf_miss( dm_io_perf_miss )
  );
  StackCache sc(.clk(clk), .reset(reset),
       .io_ena_in( io_scIO_ena_in ),
       .io_exsc_op( io_scIO_exsc_op ),
       .io_exsc_opData( io_scIO_exsc_opData ),
       .io_exsc_opOff( io_scIO_exsc_opOff ),
       .io_scex_stackTop( sc_io_scex_stackTop ),
       .io_scex_memTop( sc_io_scex_memTop ),
       .io_illMem( sc_io_illMem ),
       .io_stall( sc_io_stall ),
       .io_fromCPU_M_Cmd( T31 ),
       .io_fromCPU_M_Addr( io_master_M_Addr ),
       .io_fromCPU_M_Data( io_master_M_Data ),
       .io_fromCPU_M_ByteEn( io_master_M_ByteEn ),
       .io_fromCPU_S_Resp( sc_io_fromCPU_S_Resp ),
       .io_fromCPU_S_Data( sc_io_fromCPU_S_Data ),
       .io_toMemory_M_Cmd( sc_io_toMemory_M_Cmd ),
       .io_toMemory_M_Addr( sc_io_toMemory_M_Addr ),
       .io_toMemory_M_Data( sc_io_toMemory_M_Data ),
       .io_toMemory_M_DataValid( sc_io_toMemory_M_DataValid ),
       .io_toMemory_M_DataByteEn( sc_io_toMemory_M_DataByteEn ),
       .io_toMemory_S_Resp( T30 ),
       .io_toMemory_S_Data( burstReadBus2_io_slave_S_Data ),
       .io_toMemory_S_CmdAccept( burstReadBus2_io_slave_S_CmdAccept ),
       .io_toMemory_S_DataAccept( burstReadBus2_io_slave_S_DataAccept ),
       .io_perf_spill( sc_io_perf_spill ),
       .io_perf_fill( sc_io_perf_fill )
  );
  NullCache bp(.clk(clk), .reset(reset),
       .io_master_M_Cmd( T26 ),
       .io_master_M_Addr( io_master_M_Addr ),
       .io_master_M_Data( io_master_M_Data ),
       .io_master_M_ByteEn( io_master_M_ByteEn ),
       .io_master_S_Resp( bp_io_master_S_Resp ),
       .io_master_S_Data( bp_io_master_S_Data ),
       .io_slave_M_Cmd( bp_io_slave_M_Cmd ),
       .io_slave_M_Addr( bp_io_slave_M_Addr ),
       .io_slave_M_Data( bp_io_slave_M_Data ),
       .io_slave_M_DataValid( bp_io_slave_M_DataValid ),
       .io_slave_M_DataByteEn( bp_io_slave_M_DataByteEn ),
       .io_slave_S_Resp( T24 ),
       .io_slave_S_Data( burstReadBus1_io_slave_S_Data ),
       .io_slave_S_CmdAccept( burstReadBus1_io_slave_S_CmdAccept ),
       .io_slave_S_DataAccept( burstReadBus1_io_slave_S_DataAccept )
       //.io_invalidate(  )
       //.io_perf_hit(  )
       //.io_perf_miss(  )
  );
  OcpBurstBus burstReadBus1(
       .io_master_M_Cmd( burstReadBus1_io_master_M_Cmd ),
       .io_master_M_Addr( burstReadBus1_io_master_M_Addr ),
       .io_master_M_Data( burstReadBus1_io_master_M_Data ),
       .io_master_M_DataValid( burstReadBus1_io_master_M_DataValid ),
       .io_master_M_DataByteEn( burstReadBus1_io_master_M_DataByteEn ),
       .io_master_S_Resp( T22 ),
       .io_master_S_Data( burstReadBus2_io_slave_S_Data ),
       .io_master_S_CmdAccept( burstReadBus2_io_slave_S_CmdAccept ),
       .io_master_S_DataAccept( burstReadBus2_io_slave_S_DataAccept ),
       .io_slave_M_Cmd( T21 ),
       .io_slave_M_Addr( T20 ),
       .io_slave_M_Data( T19 ),
       .io_slave_M_DataValid( T18 ),
       .io_slave_M_DataByteEn( T12 ),
       .io_slave_S_Resp( burstReadBus1_io_slave_S_Resp ),
       .io_slave_S_Data( burstReadBus1_io_slave_S_Data ),
       .io_slave_S_CmdAccept( burstReadBus1_io_slave_S_CmdAccept ),
       .io_slave_S_DataAccept( burstReadBus1_io_slave_S_DataAccept )
  );
  OcpBurstBus burstReadBus2(
       .io_master_M_Cmd( burstReadBus2_io_master_M_Cmd ),
       .io_master_M_Addr( burstReadBus2_io_master_M_Addr ),
       .io_master_M_Data( burstReadBus2_io_master_M_Data ),
       .io_master_M_DataValid( burstReadBus2_io_master_M_DataValid ),
       .io_master_M_DataByteEn( burstReadBus2_io_master_M_DataByteEn ),
       .io_master_S_Resp( wc_io_readMaster_S_Resp ),
       .io_master_S_Data( wc_io_readMaster_S_Data ),
       .io_master_S_CmdAccept( wc_io_readMaster_S_CmdAccept ),
       .io_master_S_DataAccept( wc_io_readMaster_S_DataAccept ),
       .io_slave_M_Cmd( T11 ),
       .io_slave_M_Addr( T10 ),
       .io_slave_M_Data( T9 ),
       .io_slave_M_DataValid( T8 ),
       .io_slave_M_DataByteEn( T2 ),
       .io_slave_S_Resp( burstReadBus2_io_slave_S_Resp ),
       .io_slave_S_Data( burstReadBus2_io_slave_S_Data ),
       .io_slave_S_CmdAccept( burstReadBus2_io_slave_S_CmdAccept ),
       .io_slave_S_DataAccept( burstReadBus2_io_slave_S_DataAccept )
  );
  WriteNoBuffer wc(.clk(clk), .reset(reset),
       .io_readMaster_M_Cmd( burstReadBus2_io_master_M_Cmd ),
       .io_readMaster_M_Addr( burstReadBus2_io_master_M_Addr ),
       .io_readMaster_M_Data( burstReadBus2_io_master_M_Data ),
       .io_readMaster_M_DataValid( burstReadBus2_io_master_M_DataValid ),
       .io_readMaster_M_DataByteEn( burstReadBus2_io_master_M_DataByteEn ),
       .io_readMaster_S_Resp( wc_io_readMaster_S_Resp ),
       .io_readMaster_S_Data( wc_io_readMaster_S_Data ),
       .io_readMaster_S_CmdAccept( wc_io_readMaster_S_CmdAccept ),
       .io_readMaster_S_DataAccept( wc_io_readMaster_S_DataAccept ),
       .io_writeMaster_M_Cmd( T0 ),
       .io_writeMaster_M_Addr( io_master_M_Addr ),
       .io_writeMaster_M_Data( io_master_M_Data ),
       .io_writeMaster_M_ByteEn( io_master_M_ByteEn ),
       .io_writeMaster_M_AddrSpace( io_master_M_AddrSpace ),
       .io_writeMaster_S_Resp( wc_io_writeMaster_S_Resp ),
       //.io_writeMaster_S_Data(  )
       .io_slave_M_Cmd( wc_io_slave_M_Cmd ),
       .io_slave_M_Addr( wc_io_slave_M_Addr ),
       .io_slave_M_Data( wc_io_slave_M_Data ),
       .io_slave_M_DataValid( wc_io_slave_M_DataValid ),
       .io_slave_M_DataByteEn( wc_io_slave_M_DataByteEn ),
       .io_slave_S_Resp( io_slave_S_Resp ),
       .io_slave_S_Data( io_slave_S_Data ),
       .io_slave_S_CmdAccept( io_slave_S_CmdAccept ),
       .io_slave_S_DataAccept( io_slave_S_DataAccept ),
       .io_perf_hit( wc_io_perf_hit ),
       .io_perf_miss( wc_io_perf_miss )
  );

  always @(posedge clk) begin
    if(T7) begin
      R5 <= 1'h0;
    end else if(T6) begin
      R5 <= 1'h1;
    end
    if(T17) begin
      R15 <= 1'h0;
    end else if(T16) begin
      R15 <= 1'h1;
    end
    if(T39) begin
      selDCReg <= selDC;
    end
    if(T39) begin
      selSCReg <= selSC;
    end
  end
endmodule

module NoMemoryManagement(
    //input [2:0] io_ctrl_M_Cmd
    //input [31:0] io_ctrl_M_Addr
    //input [31:0] io_ctrl_M_Data
    //input [3:0] io_ctrl_M_ByteEn
    //output[1:0] io_ctrl_S_Resp
    //output[31:0] io_ctrl_S_Data
    input  io_superMode,
    input  io_exec,
    input [2:0] io_virt_M_Cmd,
    input [31:0] io_virt_M_Addr,
    input [31:0] io_virt_M_Data,
    input  io_virt_M_DataValid,
    input [3:0] io_virt_M_DataByteEn,
    output[1:0] io_virt_S_Resp,
    output[31:0] io_virt_S_Data,
    output io_virt_S_CmdAccept,
    output io_virt_S_DataAccept,
    output[2:0] io_phys_M_Cmd,
    output[26:0] io_phys_M_Addr,
    output[31:0] io_phys_M_Data,
    output io_phys_M_DataValid,
    output[3:0] io_phys_M_DataByteEn,
    input [1:0] io_phys_S_Resp,
    input [31:0] io_phys_S_Data,
    input  io_phys_S_CmdAccept,
    input  io_phys_S_DataAccept
);

  wire[26:0] T0;


`ifndef SYNTHESIS
// synthesis translate_off
//  assign io_ctrl_S_Data = {1{$random}};
//  assign io_ctrl_S_Resp = {1{$random}};
// synthesis translate_on
`endif
  assign io_phys_M_DataByteEn = io_virt_M_DataByteEn;
  assign io_phys_M_DataValid = io_virt_M_DataValid;
  assign io_phys_M_Data = io_virt_M_Data;
  assign io_phys_M_Addr = T0;
  assign T0 = io_virt_M_Addr[5'h1a:1'h0];
  assign io_phys_M_Cmd = io_virt_M_Cmd;
  assign io_virt_S_DataAccept = io_phys_S_DataAccept;
  assign io_virt_S_CmdAccept = io_phys_S_CmdAccept;
  assign io_virt_S_Data = io_phys_S_Data;
  assign io_virt_S_Resp = io_phys_S_Resp;
endmodule

module PatmosCore(input clk, input reset,
    output io_superMode,
    output[2:0] io_comConf_M_Cmd,
    output[31:0] io_comConf_M_Addr,
    output[31:0] io_comConf_M_Data,
    output[3:0] io_comConf_M_ByteEn,
    output io_comConf_M_RespAccept,
    input [1:0] io_comConf_S_Resp,
    input [31:0] io_comConf_S_Data,
    input  io_comConf_S_CmdAccept,
    input  io_comConf_S_Reset_n,
    input [1:0] io_comConf_S_Flag,
    output[2:0] io_comSpm_M_Cmd,
    output[31:0] io_comSpm_M_Addr,
    output[31:0] io_comSpm_M_Data,
    output[3:0] io_comSpm_M_ByteEn,
    input [1:0] io_comSpm_S_Resp,
    input [31:0] io_comSpm_S_Data,
    output[2:0] io_memPort_M_Cmd,
    output[26:0] io_memPort_M_Addr,
    output[31:0] io_memPort_M_Data,
    output io_memPort_M_DataValid,
    output[3:0] io_memPort_M_DataByteEn,
    input [1:0] io_memPort_S_Resp,
    input [31:0] io_memPort_S_Data,
    input  io_memPort_S_CmdAccept,
    input  io_memPort_S_DataAccept,
    output io_uartPins_tx,
    input  io_uartPins_rx,
    output[2:0] io_nexys4DDRIOPins_MCmd,
    output[15:0] io_nexys4DDRIOPins_MAddr,
    output[31:0] io_nexys4DDRIOPins_MData,
    output[3:0] io_nexys4DDRIOPins_MByteEn,
    input [1:0] io_nexys4DDRIOPins_SResp,
    input [31:0] io_nexys4DDRIOPins_SData,
    output[2:0] io_fpuCtrlPins_MCmd,
    output[15:0] io_fpuCtrlPins_MAddr,
    output[31:0] io_fpuCtrlPins_MData,
    output[3:0] io_fpuCtrlPins_MByteEn,
    input [1:0] io_fpuCtrlPins_SResp,
    input [31:0] io_fpuCtrlPins_SData,
    output[2:0] io_bRamCtrlPins_MCmd,
    output[15:0] io_bRamCtrlPins_MAddr,
    output[31:0] io_bRamCtrlPins_MData,
    output[3:0] io_bRamCtrlPins_MByteEn,
    input [1:0] io_bRamCtrlPins_SResp,
    input [31:0] io_bRamCtrlPins_SData,
    output[2:0] io_icapCtrlPins_MCmd,
    output[15:0] io_icapCtrlPins_MAddr,
    output[31:0] io_icapCtrlPins_MData,
    output[3:0] io_icapCtrlPins_MByteEn,
    input [1:0] io_icapCtrlPins_SResp,
    input [31:0] io_icapCtrlPins_SData,
    input [31:0] io_cpuInfoPins_id,
    input [31:0] io_cpuInfoPins_cnt
);

  reg  enableReg;
  wire enable;
  wire T0;
  wire T1;
  wire selICache;
  wire T2;
  wire T3;
  wire T4;
  reg  R5;
  wire T6;
  wire T7;
  wire[3:0] T8;
  wire T9;
  wire[31:0] T10;
  wire[31:0] T11;
  wire[2:0] T12;
  wire T13;
  wire[1:0] T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  wire[1:0] T25;
  wire T26;
  wire T27;
  wire execute_io_brflush;
  wire[4:0] execute_io_exmem_rd_0_addr;
  wire[31:0] execute_io_exmem_rd_0_data;
  wire execute_io_exmem_rd_0_valid;
  wire execute_io_exmem_mem_load;
  wire execute_io_exmem_mem_store;
  wire execute_io_exmem_mem_hword;
  wire execute_io_exmem_mem_byte;
  wire execute_io_exmem_mem_zext;
  wire[1:0] execute_io_exmem_mem_typ;
  wire[31:0] execute_io_exmem_mem_addr;
  wire[31:0] execute_io_exmem_mem_data;
  wire execute_io_exmem_mem_call;
  wire execute_io_exmem_mem_ret;
  wire execute_io_exmem_mem_brcf;
  wire execute_io_exmem_mem_trap;
  wire execute_io_exmem_mem_xcall;
  wire execute_io_exmem_mem_xret;
  wire[4:0] execute_io_exmem_mem_xsrc;
  wire execute_io_exmem_mem_illOp;
  wire[31:0] execute_io_exmem_mem_callRetAddr;
  wire[31:0] execute_io_exmem_mem_callRetBase;
  wire execute_io_exmem_mem_nonDelayed;
  wire[29:0] execute_io_exmem_pc;
  wire[29:0] execute_io_exmem_base;
  wire[29:0] execute_io_exmem_relPc;
  wire execute_io_exicache_doCallRet;
  wire[31:0] execute_io_exicache_callRetBase;
  wire[31:0] execute_io_exicache_callRetAddr;
  wire execute_io_exfe_doBranch;
  wire[29:0] execute_io_exfe_branchPc;
  wire[2:0] execute_io_exsc_op;
  wire[31:0] execute_io_exsc_opData;
  wire[31:0] execute_io_exsc_opOff;
  wire memory_io_ena_out;
  wire memory_io_flush;
  wire[4:0] memory_io_memwb_rd_0_addr;
  wire[31:0] memory_io_memwb_rd_0_data;
  wire memory_io_memwb_rd_0_valid;
  wire[29:0] memory_io_memwb_pc;
  wire memory_io_memfe_doCallRet;
  wire[29:0] memory_io_memfe_callRetPc;
  wire[29:0] memory_io_memfe_callRetBase;
  wire memory_io_memfe_store;
  wire[31:0] memory_io_memfe_addr;
  wire[31:0] memory_io_memfe_data;
  wire[4:0] memory_io_exResult_0_addr;
  wire[31:0] memory_io_exResult_0_data;
  wire memory_io_exResult_0_valid;
  wire[2:0] memory_io_localInOut_M_Cmd;
  wire[31:0] memory_io_localInOut_M_Addr;
  wire[31:0] memory_io_localInOut_M_Data;
  wire[3:0] memory_io_localInOut_M_ByteEn;
  wire[2:0] memory_io_globalInOut_M_Cmd;
  wire[31:0] memory_io_globalInOut_M_Addr;
  wire[31:0] memory_io_globalInOut_M_Data;
  wire[3:0] memory_io_globalInOut_M_ByteEn;
  wire[1:0] memory_io_globalInOut_M_AddrSpace;
  wire memory_io_exc_call;
  wire memory_io_exc_ret;
  wire[4:0] memory_io_exc_src;
  wire memory_io_exc_exc;
  wire[29:0] memory_io_exc_excBase;
  wire[29:0] memory_io_exc_excAddr;
  wire[4:0] writeback_io_rfWrite_0_addr;
  wire[31:0] writeback_io_rfWrite_0_data;
  wire writeback_io_rfWrite_0_valid;
  wire[4:0] writeback_io_memResult_0_addr;
  wire[31:0] writeback_io_memResult_0_data;
  wire writeback_io_memResult_0_valid;
  wire[1:0] exc_io_ocp_S_Resp;
  wire[31:0] exc_io_ocp_S_Data;
  wire exc_io_excdec_exc;
  wire[29:0] exc_io_excdec_excBase;
  wire[29:0] exc_io_excdec_excAddr;
  wire exc_io_excdec_intr;
  wire[31:0] exc_io_excdec_addr;
  wire[4:0] exc_io_excdec_src;
  wire exc_io_excdec_local;
  wire exc_io_superMode;
  wire exc_io_invalICache;
  wire exc_io_invalDCache;
  wire[2:0] burstBus_io_master_M_Cmd;
  wire[31:0] burstBus_io_master_M_Addr;
  wire[31:0] burstBus_io_master_M_Data;
  wire burstBus_io_master_M_DataValid;
  wire[3:0] burstBus_io_master_M_DataByteEn;
  wire[1:0] burstBus_io_slave_S_Resp;
  wire[31:0] burstBus_io_slave_S_Data;
  wire burstBus_io_slave_S_CmdAccept;
  wire burstBus_io_slave_S_DataAccept;
  wire[1:0] mmu_io_virt_S_Resp;
  wire[31:0] mmu_io_virt_S_Data;
  wire mmu_io_virt_S_CmdAccept;
  wire mmu_io_virt_S_DataAccept;
  wire[2:0] mmu_io_phys_M_Cmd;
  wire[26:0] mmu_io_phys_M_Addr;
  wire[31:0] mmu_io_phys_M_Data;
  wire mmu_io_phys_M_DataValid;
  wire[3:0] mmu_io_phys_M_DataByteEn;
  wire[31:0] fetch_io_fedec_instr_a;
  wire[31:0] fetch_io_fedec_instr_b;
  wire[29:0] fetch_io_fedec_pc;
  wire[29:0] fetch_io_fedec_base;
  wire[31:0] fetch_io_fedec_reloc;
  wire[29:0] fetch_io_fedec_relPc;
  wire[29:0] fetch_io_feex_pc;
  wire[31:0] fetch_io_feicache_addrEven;
  wire[31:0] fetch_io_feicache_addrOdd;
  wire[29:0] decode_io_decex_pc;
  wire[29:0] decode_io_decex_base;
  wire[29:0] decode_io_decex_relPc;
  wire[3:0] decode_io_decex_pred_0;
  wire[3:0] decode_io_decex_aluOp_0_func;
  wire decode_io_decex_aluOp_0_isMul;
  wire decode_io_decex_aluOp_0_isCmp;
  wire decode_io_decex_aluOp_0_isPred;
  wire decode_io_decex_aluOp_0_isBCpy;
  wire decode_io_decex_aluOp_0_isMTS;
  wire decode_io_decex_aluOp_0_isMFS;
  wire[1:0] decode_io_decex_predOp_0_func;
  wire[2:0] decode_io_decex_predOp_0_dest;
  wire[3:0] decode_io_decex_predOp_0_s1Addr;
  wire[3:0] decode_io_decex_predOp_0_s2Addr;
  wire decode_io_decex_jmpOp_branch;
  wire[29:0] decode_io_decex_jmpOp_target;
  wire[31:0] decode_io_decex_jmpOp_reloc;
  wire decode_io_decex_memOp_load;
  wire decode_io_decex_memOp_store;
  wire decode_io_decex_memOp_hword;
  wire decode_io_decex_memOp_byte;
  wire decode_io_decex_memOp_zext;
  wire[1:0] decode_io_decex_memOp_typ;
  wire[2:0] decode_io_decex_stackOp;
  wire[4:0] decode_io_decex_rsAddr_1;
  wire[4:0] decode_io_decex_rsAddr_0;
  wire[31:0] decode_io_decex_rsData_1;
  wire[31:0] decode_io_decex_rsData_0;
  wire[4:0] decode_io_decex_rdAddr_0;
  wire[31:0] decode_io_decex_immVal_0;
  wire decode_io_decex_immOp_0;
  wire decode_io_decex_wrRd_0;
  wire[31:0] decode_io_decex_callAddr;
  wire decode_io_decex_call;
  wire decode_io_decex_ret;
  wire decode_io_decex_brcf;
  wire decode_io_decex_trap;
  wire decode_io_decex_xcall;
  wire decode_io_decex_xret;
  wire[4:0] decode_io_decex_xsrc;
  wire decode_io_decex_nonDelayed;
  wire decode_io_decex_illOp;
  wire icache_io_ena_out;
  wire[31:0] icache_io_icachefe_instrEven;
  wire[31:0] icache_io_icachefe_instrOdd;
  wire[31:0] icache_io_icachefe_base;
  wire[9:0] icache_io_icachefe_relBase;
  wire[10:0] icache_io_icachefe_relPc;
  wire[31:0] icache_io_icachefe_reloc;
  wire[1:0] icache_io_icachefe_memSel;
  wire[2:0] icache_io_ocp_port_M_Cmd;
  wire[31:0] icache_io_ocp_port_M_Addr;
  wire[31:0] icache_io_ocp_port_M_Data;
  wire icache_io_ocp_port_M_DataValid;
  wire[3:0] icache_io_ocp_port_M_DataByteEn;
  wire icache_io_illMem;
  wire icache_io_perf_hit;
  wire icache_io_perf_miss;
  wire[1:0] iocomp_io_memInOut_S_Resp;
  wire[31:0] iocomp_io_memInOut_S_Data;
  wire[2:0] iocomp_io_comConf_M_Cmd;
  wire[31:0] iocomp_io_comConf_M_Addr;
  wire[31:0] iocomp_io_comConf_M_Data;
  wire[3:0] iocomp_io_comConf_M_ByteEn;
  wire iocomp_io_comConf_M_RespAccept;
  wire[2:0] iocomp_io_comSpm_M_Cmd;
  wire[31:0] iocomp_io_comSpm_M_Addr;
  wire[31:0] iocomp_io_comSpm_M_Data;
  wire[3:0] iocomp_io_comSpm_M_ByteEn;
  wire[2:0] iocomp_io_excInOut_M_Cmd;
  wire[31:0] iocomp_io_excInOut_M_Addr;
  wire[31:0] iocomp_io_excInOut_M_Data;
  wire[3:0] iocomp_io_excInOut_M_ByteEn;
  wire iocomp_io_intrs_15;
  wire iocomp_io_intrs_14;
  wire iocomp_io_intrs_13;
  wire iocomp_io_intrs_12;
  wire iocomp_io_intrs_11;
  wire iocomp_io_intrs_10;
  wire iocomp_io_intrs_9;
  wire iocomp_io_intrs_8;
  wire iocomp_io_intrs_7;
  wire iocomp_io_intrs_6;
  wire iocomp_io_intrs_5;
  wire iocomp_io_intrs_4;
  wire iocomp_io_intrs_3;
  wire iocomp_io_intrs_2;
  wire iocomp_io_intrs_1;
  wire iocomp_io_intrs_0;
  wire iocomp_io_uartPins_tx;
  wire[2:0] iocomp_io_nexys4DDRIOPins_MCmd;
  wire[15:0] iocomp_io_nexys4DDRIOPins_MAddr;
  wire[31:0] iocomp_io_nexys4DDRIOPins_MData;
  wire[3:0] iocomp_io_nexys4DDRIOPins_MByteEn;
  wire[2:0] iocomp_io_fpuCtrlPins_MCmd;
  wire[15:0] iocomp_io_fpuCtrlPins_MAddr;
  wire[31:0] iocomp_io_fpuCtrlPins_MData;
  wire[3:0] iocomp_io_fpuCtrlPins_MByteEn;
  wire[2:0] iocomp_io_bRamCtrlPins_MCmd;
  wire[15:0] iocomp_io_bRamCtrlPins_MAddr;
  wire[31:0] iocomp_io_bRamCtrlPins_MData;
  wire[3:0] iocomp_io_bRamCtrlPins_MByteEn;
  wire[2:0] iocomp_io_icapCtrlPins_MCmd;
  wire[15:0] iocomp_io_icapCtrlPins_MAddr;
  wire[31:0] iocomp_io_icapCtrlPins_MData;
  wire[3:0] iocomp_io_icapCtrlPins_MByteEn;
  wire[1:0] dcache_io_master_S_Resp;
  wire[31:0] dcache_io_master_S_Data;
  wire[2:0] dcache_io_slave_M_Cmd;
  wire[31:0] dcache_io_slave_M_Addr;
  wire[31:0] dcache_io_slave_M_Data;
  wire dcache_io_slave_M_DataValid;
  wire[3:0] dcache_io_slave_M_DataByteEn;
  wire[31:0] dcache_io_scIO_scex_stackTop;
  wire[31:0] dcache_io_scIO_scex_memTop;
  wire dcache_io_scIO_illMem;
  wire dcache_io_scIO_stall;
  wire dcache_io_dcPerf_hit;
  wire dcache_io_dcPerf_miss;
  wire dcache_io_scPerf_spill;
  wire dcache_io_scPerf_fill;
  wire dcache_io_wcPerf_hit;
  wire dcache_io_wcPerf_miss;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    enableReg = {1{$random}};
    R5 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign enable = T1 & T0;
  assign T0 = dcache_io_scIO_stall ^ 1'h1;
  assign T1 = memory_io_ena_out & icache_io_ena_out;
  assign selICache = T2;
  assign T2 = T3 ^ 1'h1;
  assign T3 = T7 ? 1'h0 : T4;
  assign T4 = T6 ? 1'h1 : R5;
  assign T6 = dcache_io_slave_M_Cmd != 3'h0;
  assign T7 = icache_io_ocp_port_M_Cmd != 3'h0;
  assign T8 = T3 ? dcache_io_slave_M_DataByteEn : icache_io_ocp_port_M_DataByteEn;
  assign T9 = T3 ? dcache_io_slave_M_DataValid : icache_io_ocp_port_M_DataValid;
  assign T10 = T3 ? dcache_io_slave_M_Data : icache_io_ocp_port_M_Data;
  assign T11 = T3 ? dcache_io_slave_M_Addr : icache_io_ocp_port_M_Addr;
  assign T12 = dcache_io_slave_M_Cmd | icache_io_ocp_port_M_Cmd;
  assign T13 = memory_io_ena_out & icache_io_ena_out;
  assign T14 = T15 ? 2'h0 : burstBus_io_slave_S_Resp;
  assign T15 = R5 ^ 1'h1;
  assign T16 = T18 & T17;
  assign T17 = io_memPort_S_CmdAccept == 1'h1;
  assign T18 = io_memPort_M_Cmd == 3'h1;
  assign T19 = T21 & T20;
  assign T20 = io_memPort_S_CmdAccept == 1'h1;
  assign T21 = io_memPort_M_Cmd == 3'h2;
  assign T22 = icache_io_ena_out & T23;
  assign T23 = dcache_io_scIO_stall ^ 1'h1;
  assign T24 = memory_io_flush | execute_io_brflush;
  assign T25 = R5 ? 2'h0 : burstBus_io_slave_S_Resp;
  assign T26 = memory_io_ena_out & T27;
  assign T27 = dcache_io_scIO_stall ^ 1'h1;
  assign io_icapCtrlPins_MByteEn = iocomp_io_icapCtrlPins_MByteEn;
  assign io_icapCtrlPins_MData = iocomp_io_icapCtrlPins_MData;
  assign io_icapCtrlPins_MAddr = iocomp_io_icapCtrlPins_MAddr;
  assign io_icapCtrlPins_MCmd = iocomp_io_icapCtrlPins_MCmd;
  assign io_bRamCtrlPins_MByteEn = iocomp_io_bRamCtrlPins_MByteEn;
  assign io_bRamCtrlPins_MData = iocomp_io_bRamCtrlPins_MData;
  assign io_bRamCtrlPins_MAddr = iocomp_io_bRamCtrlPins_MAddr;
  assign io_bRamCtrlPins_MCmd = iocomp_io_bRamCtrlPins_MCmd;
  assign io_fpuCtrlPins_MByteEn = iocomp_io_fpuCtrlPins_MByteEn;
  assign io_fpuCtrlPins_MData = iocomp_io_fpuCtrlPins_MData;
  assign io_fpuCtrlPins_MAddr = iocomp_io_fpuCtrlPins_MAddr;
  assign io_fpuCtrlPins_MCmd = iocomp_io_fpuCtrlPins_MCmd;
  assign io_nexys4DDRIOPins_MByteEn = iocomp_io_nexys4DDRIOPins_MByteEn;
  assign io_nexys4DDRIOPins_MData = iocomp_io_nexys4DDRIOPins_MData;
  assign io_nexys4DDRIOPins_MAddr = iocomp_io_nexys4DDRIOPins_MAddr;
  assign io_nexys4DDRIOPins_MCmd = iocomp_io_nexys4DDRIOPins_MCmd;
  assign io_uartPins_tx = iocomp_io_uartPins_tx;
  assign io_memPort_M_DataByteEn = mmu_io_phys_M_DataByteEn;
  assign io_memPort_M_DataValid = mmu_io_phys_M_DataValid;
  assign io_memPort_M_Data = mmu_io_phys_M_Data;
  assign io_memPort_M_Addr = mmu_io_phys_M_Addr;
  assign io_memPort_M_Cmd = mmu_io_phys_M_Cmd;
  assign io_comSpm_M_ByteEn = iocomp_io_comSpm_M_ByteEn;
  assign io_comSpm_M_Data = iocomp_io_comSpm_M_Data;
  assign io_comSpm_M_Addr = iocomp_io_comSpm_M_Addr;
  assign io_comSpm_M_Cmd = iocomp_io_comSpm_M_Cmd;
  assign io_comConf_M_RespAccept = iocomp_io_comConf_M_RespAccept;
  assign io_comConf_M_ByteEn = iocomp_io_comConf_M_ByteEn;
  assign io_comConf_M_Data = iocomp_io_comConf_M_Data;
  assign io_comConf_M_Addr = iocomp_io_comConf_M_Addr;
  assign io_comConf_M_Cmd = iocomp_io_comConf_M_Cmd;
  assign io_superMode = exc_io_superMode;
  MCache icache(.clk(clk), .reset(reset),
       .io_ena_out( icache_io_ena_out ),
       .io_ena_in( T26 ),
       .io_invalidate( exc_io_invalICache ),
       .io_feicache_addrEven( fetch_io_feicache_addrEven ),
       .io_feicache_addrOdd( fetch_io_feicache_addrOdd ),
       .io_exicache_doCallRet( execute_io_exicache_doCallRet ),
       .io_exicache_callRetBase( execute_io_exicache_callRetBase ),
       .io_exicache_callRetAddr( execute_io_exicache_callRetAddr ),
       .io_icachefe_instrEven( icache_io_icachefe_instrEven ),
       .io_icachefe_instrOdd( icache_io_icachefe_instrOdd ),
       .io_icachefe_base( icache_io_icachefe_base ),
       .io_icachefe_relBase( icache_io_icachefe_relBase ),
       .io_icachefe_relPc( icache_io_icachefe_relPc ),
       .io_icachefe_reloc( icache_io_icachefe_reloc ),
       .io_icachefe_memSel( icache_io_icachefe_memSel ),
       .io_ocp_port_M_Cmd( icache_io_ocp_port_M_Cmd ),
       .io_ocp_port_M_Addr( icache_io_ocp_port_M_Addr ),
       .io_ocp_port_M_Data( icache_io_ocp_port_M_Data ),
       .io_ocp_port_M_DataValid( icache_io_ocp_port_M_DataValid ),
       .io_ocp_port_M_DataByteEn( icache_io_ocp_port_M_DataByteEn ),
       .io_ocp_port_S_Resp( T25 ),
       .io_ocp_port_S_Data( burstBus_io_slave_S_Data ),
       .io_ocp_port_S_CmdAccept( burstBus_io_slave_S_CmdAccept ),
       .io_ocp_port_S_DataAccept( burstBus_io_slave_S_DataAccept ),
       .io_illMem( icache_io_illMem ),
       .io_perf_hit( icache_io_perf_hit ),
       .io_perf_miss( icache_io_perf_miss )
  );
  Fetch fetch(.clk(clk), .reset(reset),
       .io_ena( enable ),
       .io_fedec_instr_a( fetch_io_fedec_instr_a ),
       .io_fedec_instr_b( fetch_io_fedec_instr_b ),
       .io_fedec_pc( fetch_io_fedec_pc ),
       .io_fedec_base( fetch_io_fedec_base ),
       .io_fedec_reloc( fetch_io_fedec_reloc ),
       .io_fedec_relPc( fetch_io_fedec_relPc ),
       .io_feex_pc( fetch_io_feex_pc ),
       .io_exfe_doBranch( execute_io_exfe_doBranch ),
       .io_exfe_branchPc( execute_io_exfe_branchPc ),
       .io_memfe_doCallRet( memory_io_memfe_doCallRet ),
       .io_memfe_callRetPc( memory_io_memfe_callRetPc ),
       .io_memfe_callRetBase( memory_io_memfe_callRetBase ),
       .io_memfe_store( memory_io_memfe_store ),
       .io_memfe_addr( memory_io_memfe_addr ),
       .io_memfe_data( memory_io_memfe_data ),
       .io_feicache_addrEven( fetch_io_feicache_addrEven ),
       .io_feicache_addrOdd( fetch_io_feicache_addrOdd ),
       .io_icachefe_instrEven( icache_io_icachefe_instrEven ),
       .io_icachefe_instrOdd( icache_io_icachefe_instrOdd ),
       .io_icachefe_base( icache_io_icachefe_base ),
       .io_icachefe_relBase( icache_io_icachefe_relBase ),
       .io_icachefe_relPc( icache_io_icachefe_relPc ),
       .io_icachefe_reloc( icache_io_icachefe_reloc ),
       .io_icachefe_memSel( icache_io_icachefe_memSel )
  );
  Decode decode(.clk(clk), .reset(reset),
       .io_ena( enable ),
       .io_flush( T24 ),
       .io_fedec_instr_a( fetch_io_fedec_instr_a ),
       .io_fedec_instr_b( fetch_io_fedec_instr_b ),
       .io_fedec_pc( fetch_io_fedec_pc ),
       .io_fedec_base( fetch_io_fedec_base ),
       .io_fedec_reloc( fetch_io_fedec_reloc ),
       .io_fedec_relPc( fetch_io_fedec_relPc ),
       .io_decex_pc( decode_io_decex_pc ),
       .io_decex_base( decode_io_decex_base ),
       .io_decex_relPc( decode_io_decex_relPc ),
       .io_decex_pred_0( decode_io_decex_pred_0 ),
       .io_decex_aluOp_0_func( decode_io_decex_aluOp_0_func ),
       .io_decex_aluOp_0_isMul( decode_io_decex_aluOp_0_isMul ),
       .io_decex_aluOp_0_isCmp( decode_io_decex_aluOp_0_isCmp ),
       .io_decex_aluOp_0_isPred( decode_io_decex_aluOp_0_isPred ),
       .io_decex_aluOp_0_isBCpy( decode_io_decex_aluOp_0_isBCpy ),
       .io_decex_aluOp_0_isMTS( decode_io_decex_aluOp_0_isMTS ),
       .io_decex_aluOp_0_isMFS( decode_io_decex_aluOp_0_isMFS ),
       .io_decex_predOp_0_func( decode_io_decex_predOp_0_func ),
       .io_decex_predOp_0_dest( decode_io_decex_predOp_0_dest ),
       .io_decex_predOp_0_s1Addr( decode_io_decex_predOp_0_s1Addr ),
       .io_decex_predOp_0_s2Addr( decode_io_decex_predOp_0_s2Addr ),
       .io_decex_jmpOp_branch( decode_io_decex_jmpOp_branch ),
       .io_decex_jmpOp_target( decode_io_decex_jmpOp_target ),
       .io_decex_jmpOp_reloc( decode_io_decex_jmpOp_reloc ),
       .io_decex_memOp_load( decode_io_decex_memOp_load ),
       .io_decex_memOp_store( decode_io_decex_memOp_store ),
       .io_decex_memOp_hword( decode_io_decex_memOp_hword ),
       .io_decex_memOp_byte( decode_io_decex_memOp_byte ),
       .io_decex_memOp_zext( decode_io_decex_memOp_zext ),
       .io_decex_memOp_typ( decode_io_decex_memOp_typ ),
       .io_decex_stackOp( decode_io_decex_stackOp ),
       .io_decex_rsAddr_1( decode_io_decex_rsAddr_1 ),
       .io_decex_rsAddr_0( decode_io_decex_rsAddr_0 ),
       .io_decex_rsData_1( decode_io_decex_rsData_1 ),
       .io_decex_rsData_0( decode_io_decex_rsData_0 ),
       .io_decex_rdAddr_0( decode_io_decex_rdAddr_0 ),
       .io_decex_immVal_0( decode_io_decex_immVal_0 ),
       .io_decex_immOp_0( decode_io_decex_immOp_0 ),
       .io_decex_wrRd_0( decode_io_decex_wrRd_0 ),
       .io_decex_callAddr( decode_io_decex_callAddr ),
       .io_decex_call( decode_io_decex_call ),
       .io_decex_ret( decode_io_decex_ret ),
       .io_decex_brcf( decode_io_decex_brcf ),
       .io_decex_trap( decode_io_decex_trap ),
       .io_decex_xcall( decode_io_decex_xcall ),
       .io_decex_xret( decode_io_decex_xret ),
       .io_decex_xsrc( decode_io_decex_xsrc ),
       .io_decex_nonDelayed( decode_io_decex_nonDelayed ),
       .io_decex_illOp( decode_io_decex_illOp ),
       .io_rfWrite_0_addr( writeback_io_rfWrite_0_addr ),
       .io_rfWrite_0_data( writeback_io_rfWrite_0_data ),
       .io_rfWrite_0_valid( writeback_io_rfWrite_0_valid ),
       .io_exc_exc( exc_io_excdec_exc ),
       .io_exc_excBase( exc_io_excdec_excBase ),
       .io_exc_excAddr( exc_io_excdec_excAddr ),
       .io_exc_intr( exc_io_excdec_intr ),
       .io_exc_addr( exc_io_excdec_addr ),
       .io_exc_src( exc_io_excdec_src ),
       .io_exc_local( exc_io_excdec_local )
  );
  Execute execute(.clk(clk), .reset(reset),
       .io_ena( enable ),
       .io_flush( memory_io_flush ),
       .io_brflush( execute_io_brflush ),
       .io_decex_pc( decode_io_decex_pc ),
       .io_decex_base( decode_io_decex_base ),
       .io_decex_relPc( decode_io_decex_relPc ),
       .io_decex_pred_0( decode_io_decex_pred_0 ),
       .io_decex_aluOp_0_func( decode_io_decex_aluOp_0_func ),
       .io_decex_aluOp_0_isMul( decode_io_decex_aluOp_0_isMul ),
       .io_decex_aluOp_0_isCmp( decode_io_decex_aluOp_0_isCmp ),
       .io_decex_aluOp_0_isPred( decode_io_decex_aluOp_0_isPred ),
       .io_decex_aluOp_0_isBCpy( decode_io_decex_aluOp_0_isBCpy ),
       .io_decex_aluOp_0_isMTS( decode_io_decex_aluOp_0_isMTS ),
       .io_decex_aluOp_0_isMFS( decode_io_decex_aluOp_0_isMFS ),
       .io_decex_predOp_0_func( decode_io_decex_predOp_0_func ),
       .io_decex_predOp_0_dest( decode_io_decex_predOp_0_dest ),
       .io_decex_predOp_0_s1Addr( decode_io_decex_predOp_0_s1Addr ),
       .io_decex_predOp_0_s2Addr( decode_io_decex_predOp_0_s2Addr ),
       .io_decex_jmpOp_branch( decode_io_decex_jmpOp_branch ),
       .io_decex_jmpOp_target( decode_io_decex_jmpOp_target ),
       .io_decex_jmpOp_reloc( decode_io_decex_jmpOp_reloc ),
       .io_decex_memOp_load( decode_io_decex_memOp_load ),
       .io_decex_memOp_store( decode_io_decex_memOp_store ),
       .io_decex_memOp_hword( decode_io_decex_memOp_hword ),
       .io_decex_memOp_byte( decode_io_decex_memOp_byte ),
       .io_decex_memOp_zext( decode_io_decex_memOp_zext ),
       .io_decex_memOp_typ( decode_io_decex_memOp_typ ),
       .io_decex_stackOp( decode_io_decex_stackOp ),
       .io_decex_rsAddr_1( decode_io_decex_rsAddr_1 ),
       .io_decex_rsAddr_0( decode_io_decex_rsAddr_0 ),
       .io_decex_rsData_1( decode_io_decex_rsData_1 ),
       .io_decex_rsData_0( decode_io_decex_rsData_0 ),
       .io_decex_rdAddr_0( decode_io_decex_rdAddr_0 ),
       .io_decex_immVal_0( decode_io_decex_immVal_0 ),
       .io_decex_immOp_0( decode_io_decex_immOp_0 ),
       .io_decex_wrRd_0( decode_io_decex_wrRd_0 ),
       .io_decex_callAddr( decode_io_decex_callAddr ),
       .io_decex_call( decode_io_decex_call ),
       .io_decex_ret( decode_io_decex_ret ),
       .io_decex_brcf( decode_io_decex_brcf ),
       .io_decex_trap( decode_io_decex_trap ),
       .io_decex_xcall( decode_io_decex_xcall ),
       .io_decex_xret( decode_io_decex_xret ),
       .io_decex_xsrc( decode_io_decex_xsrc ),
       .io_decex_nonDelayed( decode_io_decex_nonDelayed ),
       .io_decex_illOp( decode_io_decex_illOp ),
       .io_exmem_rd_0_addr( execute_io_exmem_rd_0_addr ),
       .io_exmem_rd_0_data( execute_io_exmem_rd_0_data ),
       .io_exmem_rd_0_valid( execute_io_exmem_rd_0_valid ),
       .io_exmem_mem_load( execute_io_exmem_mem_load ),
       .io_exmem_mem_store( execute_io_exmem_mem_store ),
       .io_exmem_mem_hword( execute_io_exmem_mem_hword ),
       .io_exmem_mem_byte( execute_io_exmem_mem_byte ),
       .io_exmem_mem_zext( execute_io_exmem_mem_zext ),
       .io_exmem_mem_typ( execute_io_exmem_mem_typ ),
       .io_exmem_mem_addr( execute_io_exmem_mem_addr ),
       .io_exmem_mem_data( execute_io_exmem_mem_data ),
       .io_exmem_mem_call( execute_io_exmem_mem_call ),
       .io_exmem_mem_ret( execute_io_exmem_mem_ret ),
       .io_exmem_mem_brcf( execute_io_exmem_mem_brcf ),
       .io_exmem_mem_trap( execute_io_exmem_mem_trap ),
       .io_exmem_mem_xcall( execute_io_exmem_mem_xcall ),
       .io_exmem_mem_xret( execute_io_exmem_mem_xret ),
       .io_exmem_mem_xsrc( execute_io_exmem_mem_xsrc ),
       .io_exmem_mem_illOp( execute_io_exmem_mem_illOp ),
       .io_exmem_mem_callRetAddr( execute_io_exmem_mem_callRetAddr ),
       .io_exmem_mem_callRetBase( execute_io_exmem_mem_callRetBase ),
       .io_exmem_mem_nonDelayed( execute_io_exmem_mem_nonDelayed ),
       .io_exmem_pc( execute_io_exmem_pc ),
       .io_exmem_base( execute_io_exmem_base ),
       .io_exmem_relPc( execute_io_exmem_relPc ),
       .io_exicache_doCallRet( execute_io_exicache_doCallRet ),
       .io_exicache_callRetBase( execute_io_exicache_callRetBase ),
       .io_exicache_callRetAddr( execute_io_exicache_callRetAddr ),
       .io_feex_pc( fetch_io_feex_pc ),
       .io_exResult_0_addr( memory_io_exResult_0_addr ),
       .io_exResult_0_data( memory_io_exResult_0_data ),
       .io_exResult_0_valid( memory_io_exResult_0_valid ),
       .io_memResult_0_addr( writeback_io_memResult_0_addr ),
       .io_memResult_0_data( writeback_io_memResult_0_data ),
       .io_memResult_0_valid( writeback_io_memResult_0_valid ),
       .io_exfe_doBranch( execute_io_exfe_doBranch ),
       .io_exfe_branchPc( execute_io_exfe_branchPc ),
       .io_exsc_op( execute_io_exsc_op ),
       .io_exsc_opData( execute_io_exsc_opData ),
       .io_exsc_opOff( execute_io_exsc_opOff ),
       .io_scex_stackTop( dcache_io_scIO_scex_stackTop ),
       .io_scex_memTop( dcache_io_scIO_scex_memTop )
  );
  Memory memory(.clk(clk), .reset(reset),
       .io_ena_out( memory_io_ena_out ),
       .io_ena_in( T22 ),
       .io_flush( memory_io_flush ),
       .io_exmem_rd_0_addr( execute_io_exmem_rd_0_addr ),
       .io_exmem_rd_0_data( execute_io_exmem_rd_0_data ),
       .io_exmem_rd_0_valid( execute_io_exmem_rd_0_valid ),
       .io_exmem_mem_load( execute_io_exmem_mem_load ),
       .io_exmem_mem_store( execute_io_exmem_mem_store ),
       .io_exmem_mem_hword( execute_io_exmem_mem_hword ),
       .io_exmem_mem_byte( execute_io_exmem_mem_byte ),
       .io_exmem_mem_zext( execute_io_exmem_mem_zext ),
       .io_exmem_mem_typ( execute_io_exmem_mem_typ ),
       .io_exmem_mem_addr( execute_io_exmem_mem_addr ),
       .io_exmem_mem_data( execute_io_exmem_mem_data ),
       .io_exmem_mem_call( execute_io_exmem_mem_call ),
       .io_exmem_mem_ret( execute_io_exmem_mem_ret ),
       .io_exmem_mem_brcf( execute_io_exmem_mem_brcf ),
       .io_exmem_mem_trap( execute_io_exmem_mem_trap ),
       .io_exmem_mem_xcall( execute_io_exmem_mem_xcall ),
       .io_exmem_mem_xret( execute_io_exmem_mem_xret ),
       .io_exmem_mem_xsrc( execute_io_exmem_mem_xsrc ),
       .io_exmem_mem_illOp( execute_io_exmem_mem_illOp ),
       .io_exmem_mem_callRetAddr( execute_io_exmem_mem_callRetAddr ),
       .io_exmem_mem_callRetBase( execute_io_exmem_mem_callRetBase ),
       .io_exmem_mem_nonDelayed( execute_io_exmem_mem_nonDelayed ),
       .io_exmem_pc( execute_io_exmem_pc ),
       .io_exmem_base( execute_io_exmem_base ),
       .io_exmem_relPc( execute_io_exmem_relPc ),
       .io_memwb_rd_0_addr( memory_io_memwb_rd_0_addr ),
       .io_memwb_rd_0_data( memory_io_memwb_rd_0_data ),
       .io_memwb_rd_0_valid( memory_io_memwb_rd_0_valid ),
       .io_memwb_pc( memory_io_memwb_pc ),
       .io_memfe_doCallRet( memory_io_memfe_doCallRet ),
       .io_memfe_callRetPc( memory_io_memfe_callRetPc ),
       .io_memfe_callRetBase( memory_io_memfe_callRetBase ),
       .io_memfe_store( memory_io_memfe_store ),
       .io_memfe_addr( memory_io_memfe_addr ),
       .io_memfe_data( memory_io_memfe_data ),
       .io_exResult_0_addr( memory_io_exResult_0_addr ),
       .io_exResult_0_data( memory_io_exResult_0_data ),
       .io_exResult_0_valid( memory_io_exResult_0_valid ),
       .io_localInOut_M_Cmd( memory_io_localInOut_M_Cmd ),
       .io_localInOut_M_Addr( memory_io_localInOut_M_Addr ),
       .io_localInOut_M_Data( memory_io_localInOut_M_Data ),
       .io_localInOut_M_ByteEn( memory_io_localInOut_M_ByteEn ),
       .io_localInOut_S_Resp( iocomp_io_memInOut_S_Resp ),
       .io_localInOut_S_Data( iocomp_io_memInOut_S_Data ),
       .io_globalInOut_M_Cmd( memory_io_globalInOut_M_Cmd ),
       .io_globalInOut_M_Addr( memory_io_globalInOut_M_Addr ),
       .io_globalInOut_M_Data( memory_io_globalInOut_M_Data ),
       .io_globalInOut_M_ByteEn( memory_io_globalInOut_M_ByteEn ),
       .io_globalInOut_M_AddrSpace( memory_io_globalInOut_M_AddrSpace ),
       .io_globalInOut_S_Resp( dcache_io_master_S_Resp ),
       .io_globalInOut_S_Data( dcache_io_master_S_Data ),
       .io_icacheIllMem( icache_io_illMem ),
       .io_scacheIllMem( dcache_io_scIO_illMem ),
       .io_exc_call( memory_io_exc_call ),
       .io_exc_ret( memory_io_exc_ret ),
       .io_exc_src( memory_io_exc_src ),
       .io_exc_exc( memory_io_exc_exc ),
       .io_exc_excBase( memory_io_exc_excBase ),
       .io_exc_excAddr( memory_io_exc_excAddr )
  );
  WriteBack writeback(
       .io_ena( enable ),
       .io_memwb_rd_0_addr( memory_io_memwb_rd_0_addr ),
       .io_memwb_rd_0_data( memory_io_memwb_rd_0_data ),
       .io_memwb_rd_0_valid( memory_io_memwb_rd_0_valid ),
       .io_memwb_pc( memory_io_memwb_pc ),
       .io_rfWrite_0_addr( writeback_io_rfWrite_0_addr ),
       .io_rfWrite_0_data( writeback_io_rfWrite_0_data ),
       .io_rfWrite_0_valid( writeback_io_rfWrite_0_valid ),
       .io_memResult_0_addr( writeback_io_memResult_0_addr ),
       .io_memResult_0_data( writeback_io_memResult_0_data ),
       .io_memResult_0_valid( writeback_io_memResult_0_valid )
  );
  Exceptions exc(.clk(clk), .reset(reset),
       .io_ena( enable ),
       .io_ocp_M_Cmd( iocomp_io_excInOut_M_Cmd ),
       .io_ocp_M_Addr( iocomp_io_excInOut_M_Addr ),
       .io_ocp_M_Data( iocomp_io_excInOut_M_Data ),
       .io_ocp_M_ByteEn( iocomp_io_excInOut_M_ByteEn ),
       .io_ocp_S_Resp( exc_io_ocp_S_Resp ),
       .io_ocp_S_Data( exc_io_ocp_S_Data ),
       .io_intrs_15( iocomp_io_intrs_15 ),
       .io_intrs_14( iocomp_io_intrs_14 ),
       .io_intrs_13( iocomp_io_intrs_13 ),
       .io_intrs_12( iocomp_io_intrs_12 ),
       .io_intrs_11( iocomp_io_intrs_11 ),
       .io_intrs_10( iocomp_io_intrs_10 ),
       .io_intrs_9( iocomp_io_intrs_9 ),
       .io_intrs_8( iocomp_io_intrs_8 ),
       .io_intrs_7( iocomp_io_intrs_7 ),
       .io_intrs_6( iocomp_io_intrs_6 ),
       .io_intrs_5( iocomp_io_intrs_5 ),
       .io_intrs_4( iocomp_io_intrs_4 ),
       .io_intrs_3( iocomp_io_intrs_3 ),
       .io_intrs_2( iocomp_io_intrs_2 ),
       .io_intrs_1( iocomp_io_intrs_1 ),
       .io_intrs_0( iocomp_io_intrs_0 ),
       .io_excdec_exc( exc_io_excdec_exc ),
       .io_excdec_excBase( exc_io_excdec_excBase ),
       .io_excdec_excAddr( exc_io_excdec_excAddr ),
       .io_excdec_intr( exc_io_excdec_intr ),
       .io_excdec_addr( exc_io_excdec_addr ),
       .io_excdec_src( exc_io_excdec_src ),
       .io_excdec_local( exc_io_excdec_local ),
       .io_memexc_call( memory_io_exc_call ),
       .io_memexc_ret( memory_io_exc_ret ),
       .io_memexc_src( memory_io_exc_src ),
       .io_memexc_exc( memory_io_exc_exc ),
       .io_memexc_excBase( memory_io_exc_excBase ),
       .io_memexc_excAddr( memory_io_exc_excAddr ),
       .io_superMode( exc_io_superMode ),
       .io_invalICache( exc_io_invalICache ),
       .io_invalDCache( exc_io_invalDCache )
  );
  InOut iocomp(.clk(clk), .reset(reset),
       .io_memInOut_M_Cmd( memory_io_localInOut_M_Cmd ),
       .io_memInOut_M_Addr( memory_io_localInOut_M_Addr ),
       .io_memInOut_M_Data( memory_io_localInOut_M_Data ),
       .io_memInOut_M_ByteEn( memory_io_localInOut_M_ByteEn ),
       .io_memInOut_S_Resp( iocomp_io_memInOut_S_Resp ),
       .io_memInOut_S_Data( iocomp_io_memInOut_S_Data ),
       .io_comConf_M_Cmd( iocomp_io_comConf_M_Cmd ),
       .io_comConf_M_Addr( iocomp_io_comConf_M_Addr ),
       .io_comConf_M_Data( iocomp_io_comConf_M_Data ),
       .io_comConf_M_ByteEn( iocomp_io_comConf_M_ByteEn ),
       .io_comConf_M_RespAccept( iocomp_io_comConf_M_RespAccept ),
       .io_comConf_S_Resp( io_comConf_S_Resp ),
       .io_comConf_S_Data( io_comConf_S_Data ),
       .io_comConf_S_CmdAccept( io_comConf_S_CmdAccept ),
       .io_comConf_S_Reset_n( io_comConf_S_Reset_n ),
       .io_comConf_S_Flag( io_comConf_S_Flag ),
       .io_comSpm_M_Cmd( iocomp_io_comSpm_M_Cmd ),
       .io_comSpm_M_Addr( iocomp_io_comSpm_M_Addr ),
       .io_comSpm_M_Data( iocomp_io_comSpm_M_Data ),
       .io_comSpm_M_ByteEn( iocomp_io_comSpm_M_ByteEn ),
       .io_comSpm_S_Resp( io_comSpm_S_Resp ),
       .io_comSpm_S_Data( io_comSpm_S_Data ),
       .io_excInOut_M_Cmd( iocomp_io_excInOut_M_Cmd ),
       .io_excInOut_M_Addr( iocomp_io_excInOut_M_Addr ),
       .io_excInOut_M_Data( iocomp_io_excInOut_M_Data ),
       .io_excInOut_M_ByteEn( iocomp_io_excInOut_M_ByteEn ),
       .io_excInOut_S_Resp( exc_io_ocp_S_Resp ),
       .io_excInOut_S_Data( exc_io_ocp_S_Data ),
       //.io_mmuInOut_M_Cmd(  )
       //.io_mmuInOut_M_Addr(  )
       //.io_mmuInOut_M_Data(  )
       //.io_mmuInOut_M_ByteEn(  )
       //.io_mmuInOut_S_Resp(  )
       //.io_mmuInOut_S_Data(  )
       .io_intrs_15( iocomp_io_intrs_15 ),
       .io_intrs_14( iocomp_io_intrs_14 ),
       .io_intrs_13( iocomp_io_intrs_13 ),
       .io_intrs_12( iocomp_io_intrs_12 ),
       .io_intrs_11( iocomp_io_intrs_11 ),
       .io_intrs_10( iocomp_io_intrs_10 ),
       .io_intrs_9( iocomp_io_intrs_9 ),
       .io_intrs_8( iocomp_io_intrs_8 ),
       .io_intrs_7( iocomp_io_intrs_7 ),
       .io_intrs_6( iocomp_io_intrs_6 ),
       .io_intrs_5( iocomp_io_intrs_5 ),
       .io_intrs_4( iocomp_io_intrs_4 ),
       .io_intrs_3( iocomp_io_intrs_3 ),
       .io_intrs_2( iocomp_io_intrs_2 ),
       .io_intrs_1( iocomp_io_intrs_1 ),
       .io_intrs_0( iocomp_io_intrs_0 ),
       .io_superMode( exc_io_superMode ),
       .io_internalIO_perf_ic_hit( icache_io_perf_hit ),
       .io_internalIO_perf_ic_miss( icache_io_perf_miss ),
       .io_internalIO_perf_dc_hit( dcache_io_dcPerf_hit ),
       .io_internalIO_perf_dc_miss( dcache_io_dcPerf_miss ),
       .io_internalIO_perf_sc_spill( dcache_io_scPerf_spill ),
       .io_internalIO_perf_sc_fill( dcache_io_scPerf_fill ),
       .io_internalIO_perf_wc_hit( dcache_io_wcPerf_hit ),
       .io_internalIO_perf_wc_miss( dcache_io_wcPerf_miss ),
       .io_internalIO_perf_mem_read( T19 ),
       .io_internalIO_perf_mem_write( T16 ),
       .io_uartPins_tx( iocomp_io_uartPins_tx ),
       .io_uartPins_rx( io_uartPins_rx ),
       .io_nexys4DDRIOPins_MCmd( iocomp_io_nexys4DDRIOPins_MCmd ),
       .io_nexys4DDRIOPins_MAddr( iocomp_io_nexys4DDRIOPins_MAddr ),
       .io_nexys4DDRIOPins_MData( iocomp_io_nexys4DDRIOPins_MData ),
       .io_nexys4DDRIOPins_MByteEn( iocomp_io_nexys4DDRIOPins_MByteEn ),
       .io_nexys4DDRIOPins_SResp( io_nexys4DDRIOPins_SResp ),
       .io_nexys4DDRIOPins_SData( io_nexys4DDRIOPins_SData ),
       .io_fpuCtrlPins_MCmd( iocomp_io_fpuCtrlPins_MCmd ),
       .io_fpuCtrlPins_MAddr( iocomp_io_fpuCtrlPins_MAddr ),
       .io_fpuCtrlPins_MData( iocomp_io_fpuCtrlPins_MData ),
       .io_fpuCtrlPins_MByteEn( iocomp_io_fpuCtrlPins_MByteEn ),
       .io_fpuCtrlPins_SResp( io_fpuCtrlPins_SResp ),
       .io_fpuCtrlPins_SData( io_fpuCtrlPins_SData ),
       .io_bRamCtrlPins_MCmd( iocomp_io_bRamCtrlPins_MCmd ),
       .io_bRamCtrlPins_MAddr( iocomp_io_bRamCtrlPins_MAddr ),
       .io_bRamCtrlPins_MData( iocomp_io_bRamCtrlPins_MData ),
       .io_bRamCtrlPins_MByteEn( iocomp_io_bRamCtrlPins_MByteEn ),
       .io_bRamCtrlPins_SResp( io_bRamCtrlPins_SResp ),
       .io_bRamCtrlPins_SData( io_bRamCtrlPins_SData ),
       .io_icapCtrlPins_MCmd( iocomp_io_icapCtrlPins_MCmd ),
       .io_icapCtrlPins_MAddr( iocomp_io_icapCtrlPins_MAddr ),
       .io_icapCtrlPins_MData( iocomp_io_icapCtrlPins_MData ),
       .io_icapCtrlPins_MByteEn( iocomp_io_icapCtrlPins_MByteEn ),
       .io_icapCtrlPins_SResp( io_icapCtrlPins_SResp ),
       .io_icapCtrlPins_SData( io_icapCtrlPins_SData ),
       .io_cpuInfoPins_id( io_cpuInfoPins_id ),
       .io_cpuInfoPins_cnt( io_cpuInfoPins_cnt )
  );
  DataCache dcache(.clk(clk), .reset(reset),
       .io_master_M_Cmd( memory_io_globalInOut_M_Cmd ),
       .io_master_M_Addr( memory_io_globalInOut_M_Addr ),
       .io_master_M_Data( memory_io_globalInOut_M_Data ),
       .io_master_M_ByteEn( memory_io_globalInOut_M_ByteEn ),
       .io_master_M_AddrSpace( memory_io_globalInOut_M_AddrSpace ),
       .io_master_S_Resp( dcache_io_master_S_Resp ),
       .io_master_S_Data( dcache_io_master_S_Data ),
       .io_slave_M_Cmd( dcache_io_slave_M_Cmd ),
       .io_slave_M_Addr( dcache_io_slave_M_Addr ),
       .io_slave_M_Data( dcache_io_slave_M_Data ),
       .io_slave_M_DataValid( dcache_io_slave_M_DataValid ),
       .io_slave_M_DataByteEn( dcache_io_slave_M_DataByteEn ),
       .io_slave_S_Resp( T14 ),
       .io_slave_S_Data( burstBus_io_slave_S_Data ),
       .io_slave_S_CmdAccept( burstBus_io_slave_S_CmdAccept ),
       .io_slave_S_DataAccept( burstBus_io_slave_S_DataAccept ),
       .io_scIO_ena_in( T13 ),
       .io_scIO_exsc_op( execute_io_exsc_op ),
       .io_scIO_exsc_opData( execute_io_exsc_opData ),
       .io_scIO_exsc_opOff( execute_io_exsc_opOff ),
       .io_scIO_scex_stackTop( dcache_io_scIO_scex_stackTop ),
       .io_scIO_scex_memTop( dcache_io_scIO_scex_memTop ),
       .io_scIO_illMem( dcache_io_scIO_illMem ),
       .io_scIO_stall( dcache_io_scIO_stall ),
       .io_invalDCache( exc_io_invalDCache ),
       .io_dcPerf_hit( dcache_io_dcPerf_hit ),
       .io_dcPerf_miss( dcache_io_dcPerf_miss ),
       .io_scPerf_spill( dcache_io_scPerf_spill ),
       .io_scPerf_fill( dcache_io_scPerf_fill ),
       .io_wcPerf_hit( dcache_io_wcPerf_hit ),
       .io_wcPerf_miss( dcache_io_wcPerf_miss )
  );
  OcpBurstBus burstBus(
       .io_master_M_Cmd( burstBus_io_master_M_Cmd ),
       .io_master_M_Addr( burstBus_io_master_M_Addr ),
       .io_master_M_Data( burstBus_io_master_M_Data ),
       .io_master_M_DataValid( burstBus_io_master_M_DataValid ),
       .io_master_M_DataByteEn( burstBus_io_master_M_DataByteEn ),
       .io_master_S_Resp( mmu_io_virt_S_Resp ),
       .io_master_S_Data( mmu_io_virt_S_Data ),
       .io_master_S_CmdAccept( mmu_io_virt_S_CmdAccept ),
       .io_master_S_DataAccept( mmu_io_virt_S_DataAccept ),
       .io_slave_M_Cmd( T12 ),
       .io_slave_M_Addr( T11 ),
       .io_slave_M_Data( T10 ),
       .io_slave_M_DataValid( T9 ),
       .io_slave_M_DataByteEn( T8 ),
       .io_slave_S_Resp( burstBus_io_slave_S_Resp ),
       .io_slave_S_Data( burstBus_io_slave_S_Data ),
       .io_slave_S_CmdAccept( burstBus_io_slave_S_CmdAccept ),
       .io_slave_S_DataAccept( burstBus_io_slave_S_DataAccept )
  );
  NoMemoryManagement mmu(
       //.io_ctrl_M_Cmd(  )
       //.io_ctrl_M_Addr(  )
       //.io_ctrl_M_Data(  )
       //.io_ctrl_M_ByteEn(  )
       //.io_ctrl_S_Resp(  )
       //.io_ctrl_S_Data(  )
       .io_superMode( exc_io_superMode ),
       .io_exec( selICache ),
       .io_virt_M_Cmd( burstBus_io_master_M_Cmd ),
       .io_virt_M_Addr( burstBus_io_master_M_Addr ),
       .io_virt_M_Data( burstBus_io_master_M_Data ),
       .io_virt_M_DataValid( burstBus_io_master_M_DataValid ),
       .io_virt_M_DataByteEn( burstBus_io_master_M_DataByteEn ),
       .io_virt_S_Resp( mmu_io_virt_S_Resp ),
       .io_virt_S_Data( mmu_io_virt_S_Data ),
       .io_virt_S_CmdAccept( mmu_io_virt_S_CmdAccept ),
       .io_virt_S_DataAccept( mmu_io_virt_S_DataAccept ),
       .io_phys_M_Cmd( mmu_io_phys_M_Cmd ),
       .io_phys_M_Addr( mmu_io_phys_M_Addr ),
       .io_phys_M_Data( mmu_io_phys_M_Data ),
       .io_phys_M_DataValid( mmu_io_phys_M_DataValid ),
       .io_phys_M_DataByteEn( mmu_io_phys_M_DataByteEn ),
       .io_phys_S_Resp( io_memPort_S_Resp ),
       .io_phys_S_Data( io_memPort_S_Data ),
       .io_phys_S_CmdAccept( io_memPort_S_CmdAccept ),
       .io_phys_S_DataAccept( io_memPort_S_DataAccept )
  );

  always @(posedge clk) begin
    enableReg <= enable;
    if(T7) begin
      R5 <= 1'h0;
    end else if(T6) begin
      R5 <= 1'h1;
    end
  end
endmodule

module MemBridge(
    //input  io_superMode
    input [2:0] io_ocp_M_Cmd,
    input [31:0] io_ocp_M_Addr,
    input [31:0] io_ocp_M_Data,
    input  io_ocp_M_DataValid,
    input [3:0] io_ocp_M_DataByteEn,
    output[1:0] io_ocp_S_Resp,
    output[31:0] io_ocp_S_Data,
    output io_ocp_S_CmdAccept,
    output io_ocp_S_DataAccept,
    output[2:0] io_memBridgePins_M_Cmd,
    output[31:0] io_memBridgePins_M_Addr,
    output[31:0] io_memBridgePins_M_Data,
    output io_memBridgePins_M_DataValid,
    output[3:0] io_memBridgePins_M_DataByteEn,
    input [1:0] io_memBridgePins_S_Resp,
    input [31:0] io_memBridgePins_S_Data,
    input  io_memBridgePins_S_CmdAccept,
    input  io_memBridgePins_S_DataAccept
);



  assign io_memBridgePins_M_DataByteEn = io_ocp_M_DataByteEn;
  assign io_memBridgePins_M_DataValid = io_ocp_M_DataValid;
  assign io_memBridgePins_M_Data = io_ocp_M_Data;
  assign io_memBridgePins_M_Addr = io_ocp_M_Addr;
  assign io_memBridgePins_M_Cmd = io_ocp_M_Cmd;
  assign io_ocp_S_DataAccept = io_memBridgePins_S_DataAccept;
  assign io_ocp_S_CmdAccept = io_memBridgePins_S_CmdAccept;
  assign io_ocp_S_Data = io_memBridgePins_S_Data;
  assign io_ocp_S_Resp = io_memBridgePins_S_Resp;
endmodule

module Patmos(input clk, input reset,
    output[2:0] io_comConf_M_Cmd,
    output[31:0] io_comConf_M_Addr,
    output[31:0] io_comConf_M_Data,
    output[3:0] io_comConf_M_ByteEn,
    output io_comConf_M_RespAccept,
    input [1:0] io_comConf_S_Resp,
    input [31:0] io_comConf_S_Data,
    input  io_comConf_S_CmdAccept,
    input  io_comConf_S_Reset_n,
    input [1:0] io_comConf_S_Flag,
    output[2:0] io_comSpm_M_Cmd,
    output[31:0] io_comSpm_M_Addr,
    output[31:0] io_comSpm_M_Data,
    output[3:0] io_comSpm_M_ByteEn,
    input [1:0] io_comSpm_S_Resp,
    input [31:0] io_comSpm_S_Data,
    output[2:0] io_memBridgePins_M_Cmd,
    output[31:0] io_memBridgePins_M_Addr,
    output[31:0] io_memBridgePins_M_Data,
    output io_memBridgePins_M_DataValid,
    output[3:0] io_memBridgePins_M_DataByteEn,
    input [1:0] io_memBridgePins_S_Resp,
    input [31:0] io_memBridgePins_S_Data,
    input  io_memBridgePins_S_CmdAccept,
    input  io_memBridgePins_S_DataAccept,
    output io_uartPins_tx,
    input  io_uartPins_rx,
    output[2:0] io_nexys4DDRIOPins_MCmd,
    output[15:0] io_nexys4DDRIOPins_MAddr,
    output[31:0] io_nexys4DDRIOPins_MData,
    output[3:0] io_nexys4DDRIOPins_MByteEn,
    input [1:0] io_nexys4DDRIOPins_SResp,
    input [31:0] io_nexys4DDRIOPins_SData,
    output[2:0] io_fpuCtrlPins_MCmd,
    output[15:0] io_fpuCtrlPins_MAddr,
    output[31:0] io_fpuCtrlPins_MData,
    output[3:0] io_fpuCtrlPins_MByteEn,
    input [1:0] io_fpuCtrlPins_SResp,
    input [31:0] io_fpuCtrlPins_SData,
    output[2:0] io_bRamCtrlPins_MCmd,
    output[15:0] io_bRamCtrlPins_MAddr,
    output[31:0] io_bRamCtrlPins_MData,
    output[3:0] io_bRamCtrlPins_MByteEn,
    input [1:0] io_bRamCtrlPins_SResp,
    input [31:0] io_bRamCtrlPins_SData,
    output[2:0] io_icapCtrlPins_MCmd,
    output[15:0] io_icapCtrlPins_MAddr,
    output[31:0] io_icapCtrlPins_MData,
    output[3:0] io_icapCtrlPins_MByteEn,
    input [1:0] io_icapCtrlPins_SResp,
    input [31:0] io_icapCtrlPins_SData,
    input [31:0] io_cpuInfoPins_id,
    input [31:0] io_cpuInfoPins_cnt
);

  wire[31:0] T0;
  wire[1:0] ramCtrl_io_ocp_S_Resp;
  wire[31:0] ramCtrl_io_ocp_S_Data;
  wire ramCtrl_io_ocp_S_CmdAccept;
  wire ramCtrl_io_ocp_S_DataAccept;
  wire[2:0] ramCtrl_io_memBridgePins_M_Cmd;
  wire[31:0] ramCtrl_io_memBridgePins_M_Addr;
  wire[31:0] ramCtrl_io_memBridgePins_M_Data;
  wire ramCtrl_io_memBridgePins_M_DataValid;
  wire[3:0] ramCtrl_io_memBridgePins_M_DataByteEn;
  wire[2:0] core_io_comConf_M_Cmd;
  wire[31:0] core_io_comConf_M_Addr;
  wire[31:0] core_io_comConf_M_Data;
  wire[3:0] core_io_comConf_M_ByteEn;
  wire core_io_comConf_M_RespAccept;
  wire[2:0] core_io_comSpm_M_Cmd;
  wire[31:0] core_io_comSpm_M_Addr;
  wire[31:0] core_io_comSpm_M_Data;
  wire[3:0] core_io_comSpm_M_ByteEn;
  wire[2:0] core_io_memPort_M_Cmd;
  wire[26:0] core_io_memPort_M_Addr;
  wire[31:0] core_io_memPort_M_Data;
  wire core_io_memPort_M_DataValid;
  wire[3:0] core_io_memPort_M_DataByteEn;
  wire core_io_uartPins_tx;
  wire[2:0] core_io_nexys4DDRIOPins_MCmd;
  wire[15:0] core_io_nexys4DDRIOPins_MAddr;
  wire[31:0] core_io_nexys4DDRIOPins_MData;
  wire[3:0] core_io_nexys4DDRIOPins_MByteEn;
  wire[2:0] core_io_fpuCtrlPins_MCmd;
  wire[15:0] core_io_fpuCtrlPins_MAddr;
  wire[31:0] core_io_fpuCtrlPins_MData;
  wire[3:0] core_io_fpuCtrlPins_MByteEn;
  wire[2:0] core_io_bRamCtrlPins_MCmd;
  wire[15:0] core_io_bRamCtrlPins_MAddr;
  wire[31:0] core_io_bRamCtrlPins_MData;
  wire[3:0] core_io_bRamCtrlPins_MByteEn;
  wire[2:0] core_io_icapCtrlPins_MCmd;
  wire[15:0] core_io_icapCtrlPins_MAddr;
  wire[31:0] core_io_icapCtrlPins_MData;
  wire[3:0] core_io_icapCtrlPins_MByteEn;


  assign T0 = {5'h0, core_io_memPort_M_Addr};
  assign io_icapCtrlPins_MByteEn = core_io_icapCtrlPins_MByteEn;
  assign io_icapCtrlPins_MData = core_io_icapCtrlPins_MData;
  assign io_icapCtrlPins_MAddr = core_io_icapCtrlPins_MAddr;
  assign io_icapCtrlPins_MCmd = core_io_icapCtrlPins_MCmd;
  assign io_bRamCtrlPins_MByteEn = core_io_bRamCtrlPins_MByteEn;
  assign io_bRamCtrlPins_MData = core_io_bRamCtrlPins_MData;
  assign io_bRamCtrlPins_MAddr = core_io_bRamCtrlPins_MAddr;
  assign io_bRamCtrlPins_MCmd = core_io_bRamCtrlPins_MCmd;
  assign io_fpuCtrlPins_MByteEn = core_io_fpuCtrlPins_MByteEn;
  assign io_fpuCtrlPins_MData = core_io_fpuCtrlPins_MData;
  assign io_fpuCtrlPins_MAddr = core_io_fpuCtrlPins_MAddr;
  assign io_fpuCtrlPins_MCmd = core_io_fpuCtrlPins_MCmd;
  assign io_nexys4DDRIOPins_MByteEn = core_io_nexys4DDRIOPins_MByteEn;
  assign io_nexys4DDRIOPins_MData = core_io_nexys4DDRIOPins_MData;
  assign io_nexys4DDRIOPins_MAddr = core_io_nexys4DDRIOPins_MAddr;
  assign io_nexys4DDRIOPins_MCmd = core_io_nexys4DDRIOPins_MCmd;
  assign io_uartPins_tx = core_io_uartPins_tx;
  assign io_memBridgePins_M_DataByteEn = ramCtrl_io_memBridgePins_M_DataByteEn;
  assign io_memBridgePins_M_DataValid = ramCtrl_io_memBridgePins_M_DataValid;
  assign io_memBridgePins_M_Data = ramCtrl_io_memBridgePins_M_Data;
  assign io_memBridgePins_M_Addr = ramCtrl_io_memBridgePins_M_Addr;
  assign io_memBridgePins_M_Cmd = ramCtrl_io_memBridgePins_M_Cmd;
  assign io_comSpm_M_ByteEn = core_io_comSpm_M_ByteEn;
  assign io_comSpm_M_Data = core_io_comSpm_M_Data;
  assign io_comSpm_M_Addr = core_io_comSpm_M_Addr;
  assign io_comSpm_M_Cmd = core_io_comSpm_M_Cmd;
  assign io_comConf_M_RespAccept = core_io_comConf_M_RespAccept;
  assign io_comConf_M_ByteEn = core_io_comConf_M_ByteEn;
  assign io_comConf_M_Data = core_io_comConf_M_Data;
  assign io_comConf_M_Addr = core_io_comConf_M_Addr;
  assign io_comConf_M_Cmd = core_io_comConf_M_Cmd;
  PatmosCore core(.clk(clk), .reset(reset),
       //.io_superMode(  )
       .io_comConf_M_Cmd( core_io_comConf_M_Cmd ),
       .io_comConf_M_Addr( core_io_comConf_M_Addr ),
       .io_comConf_M_Data( core_io_comConf_M_Data ),
       .io_comConf_M_ByteEn( core_io_comConf_M_ByteEn ),
       .io_comConf_M_RespAccept( core_io_comConf_M_RespAccept ),
       .io_comConf_S_Resp( io_comConf_S_Resp ),
       .io_comConf_S_Data( io_comConf_S_Data ),
       .io_comConf_S_CmdAccept( io_comConf_S_CmdAccept ),
       .io_comConf_S_Reset_n( io_comConf_S_Reset_n ),
       .io_comConf_S_Flag( io_comConf_S_Flag ),
       .io_comSpm_M_Cmd( core_io_comSpm_M_Cmd ),
       .io_comSpm_M_Addr( core_io_comSpm_M_Addr ),
       .io_comSpm_M_Data( core_io_comSpm_M_Data ),
       .io_comSpm_M_ByteEn( core_io_comSpm_M_ByteEn ),
       .io_comSpm_S_Resp( io_comSpm_S_Resp ),
       .io_comSpm_S_Data( io_comSpm_S_Data ),
       .io_memPort_M_Cmd( core_io_memPort_M_Cmd ),
       .io_memPort_M_Addr( core_io_memPort_M_Addr ),
       .io_memPort_M_Data( core_io_memPort_M_Data ),
       .io_memPort_M_DataValid( core_io_memPort_M_DataValid ),
       .io_memPort_M_DataByteEn( core_io_memPort_M_DataByteEn ),
       .io_memPort_S_Resp( ramCtrl_io_ocp_S_Resp ),
       .io_memPort_S_Data( ramCtrl_io_ocp_S_Data ),
       .io_memPort_S_CmdAccept( ramCtrl_io_ocp_S_CmdAccept ),
       .io_memPort_S_DataAccept( ramCtrl_io_ocp_S_DataAccept ),
       .io_uartPins_tx( core_io_uartPins_tx ),
       .io_uartPins_rx( io_uartPins_rx ),
       .io_nexys4DDRIOPins_MCmd( core_io_nexys4DDRIOPins_MCmd ),
       .io_nexys4DDRIOPins_MAddr( core_io_nexys4DDRIOPins_MAddr ),
       .io_nexys4DDRIOPins_MData( core_io_nexys4DDRIOPins_MData ),
       .io_nexys4DDRIOPins_MByteEn( core_io_nexys4DDRIOPins_MByteEn ),
       .io_nexys4DDRIOPins_SResp( io_nexys4DDRIOPins_SResp ),
       .io_nexys4DDRIOPins_SData( io_nexys4DDRIOPins_SData ),
       .io_fpuCtrlPins_MCmd( core_io_fpuCtrlPins_MCmd ),
       .io_fpuCtrlPins_MAddr( core_io_fpuCtrlPins_MAddr ),
       .io_fpuCtrlPins_MData( core_io_fpuCtrlPins_MData ),
       .io_fpuCtrlPins_MByteEn( core_io_fpuCtrlPins_MByteEn ),
       .io_fpuCtrlPins_SResp( io_fpuCtrlPins_SResp ),
       .io_fpuCtrlPins_SData( io_fpuCtrlPins_SData ),
       .io_bRamCtrlPins_MCmd( core_io_bRamCtrlPins_MCmd ),
       .io_bRamCtrlPins_MAddr( core_io_bRamCtrlPins_MAddr ),
       .io_bRamCtrlPins_MData( core_io_bRamCtrlPins_MData ),
       .io_bRamCtrlPins_MByteEn( core_io_bRamCtrlPins_MByteEn ),
       .io_bRamCtrlPins_SResp( io_bRamCtrlPins_SResp ),
       .io_bRamCtrlPins_SData( io_bRamCtrlPins_SData ),
       .io_icapCtrlPins_MCmd( core_io_icapCtrlPins_MCmd ),
       .io_icapCtrlPins_MAddr( core_io_icapCtrlPins_MAddr ),
       .io_icapCtrlPins_MData( core_io_icapCtrlPins_MData ),
       .io_icapCtrlPins_MByteEn( core_io_icapCtrlPins_MByteEn ),
       .io_icapCtrlPins_SResp( io_icapCtrlPins_SResp ),
       .io_icapCtrlPins_SData( io_icapCtrlPins_SData ),
       .io_cpuInfoPins_id( io_cpuInfoPins_id ),
       .io_cpuInfoPins_cnt( io_cpuInfoPins_cnt )
  );
  MemBridge ramCtrl(
       //.io_superMode(  )
       .io_ocp_M_Cmd( core_io_memPort_M_Cmd ),
       .io_ocp_M_Addr( T0 ),
       .io_ocp_M_Data( core_io_memPort_M_Data ),
       .io_ocp_M_DataValid( core_io_memPort_M_DataValid ),
       .io_ocp_M_DataByteEn( core_io_memPort_M_DataByteEn ),
       .io_ocp_S_Resp( ramCtrl_io_ocp_S_Resp ),
       .io_ocp_S_Data( ramCtrl_io_ocp_S_Data ),
       .io_ocp_S_CmdAccept( ramCtrl_io_ocp_S_CmdAccept ),
       .io_ocp_S_DataAccept( ramCtrl_io_ocp_S_DataAccept ),
       .io_memBridgePins_M_Cmd( ramCtrl_io_memBridgePins_M_Cmd ),
       .io_memBridgePins_M_Addr( ramCtrl_io_memBridgePins_M_Addr ),
       .io_memBridgePins_M_Data( ramCtrl_io_memBridgePins_M_Data ),
       .io_memBridgePins_M_DataValid( ramCtrl_io_memBridgePins_M_DataValid ),
       .io_memBridgePins_M_DataByteEn( ramCtrl_io_memBridgePins_M_DataByteEn ),
       .io_memBridgePins_S_Resp( io_memBridgePins_S_Resp ),
       .io_memBridgePins_S_Data( io_memBridgePins_S_Data ),
       .io_memBridgePins_S_CmdAccept( io_memBridgePins_S_CmdAccept ),
       .io_memBridgePins_S_DataAccept( io_memBridgePins_S_DataAccept )
  );
endmodule

