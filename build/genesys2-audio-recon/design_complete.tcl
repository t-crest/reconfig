###############################################################
###   Tcl Variables
###############################################################
#set tclParams [list <param1> <value> <param2> <value> ... <paramN> <value>]
set tclParams [list hd.visual 0]

#Define custom location for "Tcl" directory. Defaults to "./tcl"
set tclHome "./tcl"
if {[file exists $tclHome]} {
   set tclDir $tclHome
} elseif {[file exists "./tcl"]} {
   set tclDir  "./tcl"
} else {
   error "ERROR: No valid location found for required Tcl scripts. Set \$tclDir in design.tcl to a valid location."
}

####Source required Tcl Procs
source $tclDir/design_utils.tcl
source $tclDir/log_utils.tcl
source $tclDir/synth_utils.tcl
source $tclDir/impl_utils.tcl
source $tclDir/pr_utils.tcl
source $tclDir/hd_floorplan_utils.tcl

###############################################################
### Define Part, Package, Speedgrade
###############################################################
set device       "xc7k325t"
set package      "ffg900"
set speed        "-2"
set part         $device$package$speed
check_part $part

### Removing single files add warning
set_param project.singleFileAddWarning.Threshold 500

###############################################################
###  Setup Variables
###############################################################
#set tclParams [list <param1> <value> <param2> <value> ... <paramN> <value>]

####flow control
set run.topSynth       1
set run.rmSynth        1
set run.prImpl         1
set run.prVerify       1
set run.writeBitstream 1

####Report and DCP controls - values: 0-required min; 1-few extra; 2-all
set verbose      1
set dcpLevel     1

####Output Directories
set synthDir  "./synth"
set implDir   "./implement"
set dcpDir    "./checkpoint"
set bitDir    "./bitstreams"

####Input Directories
set srcDir     "./sources"
set rtlDir     "$srcDir/hdl"
set tcrestDir  "./../../.."
set ipDir      "$srcDir/ip"
set prjDir     "$srcDir/prj"
set xdcDir     "$srcDir/xdc"
set coreDir    "$srcDir/cores"
set netlistDir "$srcDir/netlist"
set scriptDir  "$srcDir/scripts"

###############################################################
### Top Definition
###############################################################
#set top "top"
#set static "Static"
#add_module $static
#set_attribute module $static moduleName    $top
#set_attribute module $static top_level     1
#set_attribute module $static vlog          [list [glob $rtlDir/$top/*.v]]
#set_attribute module $static synth         ${run.topSynth}

set top "aegean_top"
set static "Static"
add_module $static
set_attribute module $static moduleName    $top
set_attribute module $static top_level     1

set_attribute module $static vlog          [list $tcrestDir/aegean/build/genesys2-audio-4cores/Arbiter.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/patmosMasterGenesys2AudioPatmosCore.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/patmosSlaveGenesys2AudioPatmosCore.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager_clk_wiz.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_bank_state.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_arb_row_col.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_arb_mux.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_rank_cntrl.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_bank_queue.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_mc.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_bank_compare.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_round_robin_arb.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_rank_mach.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_rank_common.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_bank_common.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_bank_cntrl.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_bank_mach.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_col_mach.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/controller/mig_7series_v4_0_arb_select.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_rdlvl.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_byte_lane.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_poc_tap_base.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_skip_calib_tap.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_prbs_gen.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_data.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_poc_pd.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_poc_top.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_lim.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_poc_edge_store.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_calib_top.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_edge.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_prbs_rdlvl.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_mux.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_tempmon.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_mc_phy.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_of_pre_fifo.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_samp.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrcal.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ck_addr_cmd_delay.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_if_post_fifo.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_po_cntlr.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal_hr.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_poc_cc.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_top.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_oclkdelay_cal.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_cntlr.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_init.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_4lanes.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_poc_meta.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_mc_phy_wrapper.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl_off_delay.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/phy/mig_7series_v4_0_ddr_byte_group_io.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ecc/mig_7series_v4_0_ecc_gen.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ecc/mig_7series_v4_0_ecc_dec_fix.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ecc/mig_7series_v4_0_ecc_buf.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ecc/mig_7series_v4_0_ecc_merge_enc.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ecc/mig_7series_v4_0_fi_xor.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ip_top/mig_7series_v4_0_mem_intfc.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ip_top/mig_7series_v4_0_memc_ui_top_std.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/clocking/mig_7series_v4_0_infrastructure.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/clocking/mig_7series_v4_0_clk_ibuf.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/clocking/mig_7series_v4_0_iodelay_ctrl.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/clocking/mig_7series_v4_0_tempmon.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ui/mig_7series_v4_0_ui_cmd.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ui/mig_7series_v4_0_ui_top.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ui/mig_7series_v4_0_ui_wr_data.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ui/mig_7series_v4_0_ui_rd_data.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ddr3_ctrl.v \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/rtl/ddr3_ctrl_mig.v \
                                           ]

set_attribute module $static vhdl          [list $tcrestDir/patmos/hardware/vivado/vhdl/filter_lp.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/filter_hp.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/filter_bp.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/pipe.vhd work \
                                                 $tcrestDir/reconfig/hardware/icap_ctrl/icap_ctrl_config.vhd work \
                                                 $tcrestDir/reconfig/hardware/icap_ctrl/icap_ctrl.vhd work \
                                                 $tcrestDir/reconfig/hardware/icap_ctrl/icap_ctrl_defs.vhd work \
                                                 $tcrestDir/reconfig/hardware/icap_ctrl/recon_spm.vhd work \
                                                 $tcrestDir/reconfig/hardware/icap_ctrl/tdp_sc_bram.vhd work \
                                                 $tcrestDir/reconfig/hardware/icap_ctrl/ocp_to_bram.vhd work \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/new/ocp_burst_to_ddr3_ctrl.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/ADAU1761_i2c_bridge.vhdl work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/I2S_seri_deseri_cdc.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/audio_buffer.vhdl work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/fifo.vhdl work \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/aegean_top.vhd work \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/noc.vhd work \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/config.vhd work \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/aegean.vhd work \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/ocp_config.vhd work \
                                                 $tcrestDir/argo/src/ni/network_interface.vhd work \
                                                 $tcrestDir/argo/src/routers/synchronous/hpu.vhd work \
                                                 $tcrestDir/argo/src/ocp/ocp.vhd work \
                                                 $tcrestDir/argo/src/mem/com_spm.vhd work \
                                                 $tcrestDir/argo/src/ni/irq_fifo.vhd work \
                                                 $tcrestDir/argo/src/ni/rx_unit.vhd work \
                                                 $tcrestDir/argo/src/ni/TDM_controller.vhd work \
                                                 $tcrestDir/argo/src/routers/synchronous/router.vhd work \
                                                 $tcrestDir/argo/src/routers/synchronous/xbar.vhd work \
                                                 $tcrestDir/argo/src/ni/schedule_table.vhd work \
                                                 $tcrestDir/argo/src/noc_defs.vhd work \
                                                 $tcrestDir/argo/src/config_types.vhd work \
                                                 $tcrestDir/argo/src/noc_interface.vhd work \
                                                 $tcrestDir/argo/src/mem/tdp_bram.vhd work \
                                                 $tcrestDir/argo/src/ni/MC_controller.vhd work \
                                                 $tcrestDir/argo/src/ni/config_bus.vhd work \
                                                 $tcrestDir/argo/src/mem/tdp_ram.vhd work \
                                                 $tcrestDir/argo/src/util/math_util.vhd work \
                                                 $tcrestDir/argo/src/ni/packet_manager.vhd work \
                                                 $tcrestDir/argo/src/argo_types.vhd work \
                                                 $tcrestDir/argo/src/ni/spm_bus.vhd work \
                                                 $tcrestDir/argo/src/noc/synchronous/noc_node.vhd work \
                                           ]

                                                 #$tcrestDir/patmos/hardware/vivado/vhdl/filter_rr_bp.vhd work \

#set_attribute module $static prj           [list $prjDir/ddr2_ctrl/mig_a.prj \
#                                                 $prjDir/ddr2_ctrl/mig_b.prj \
#                                           ]

#set_attribute module $static ip            [list $ipDir/clk_manager/clk_manager.xci \
#                                                 $ipDir/ddr2_ctrl/ddr2_ctrl.xci \
#                                                 $ipDir/ddr2_ctrl/mig_a.prj \
#                                                 $ipDir/ddr2_ctrl/mig_b.prj \
#                                                 $ipDir/clk_manager/clk_manager.xci \
#                                           ]

set_attribute module $static synthXDC      [list $xdcDir/genesys2.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl_ooc.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager.xdc \
                                           ]

set_attribute module $static synth         ${run.topSynth}
#set_attribute module $static ipRepo        " ../../../../../../output/export/rtf/ip/xilinx/"

####################################################################
### RP Module Definitions
####################################################################
set module1 "filter_rr"

set module1_variant1 "filter_rr_pass"
set variant $module1_variant1
add_module $variant
set_attribute module $variant moduleName   $module1
set_attribute module $variant vhdl         [list $tcrestDir/patmos/hardware/vivado/vhdl/filter_rr_pass.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/pipe.vhd work \
                                           ]
set_attribute module $variant synth        ${run.rmSynth}

set module1_variant2 "filter_rr_hp"
set variant $module1_variant2
add_module $variant
set_attribute module $variant moduleName   $module1
set_attribute module $variant vhdl         [list $tcrestDir/patmos/hardware/vivado/vhdl/filter_rr_hp.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/filter_hp.vhd work \
                                           ]
set_attribute module $variant synth        ${run.rmSynth}

set module1_variant3 "filter_rr_lp"
set variant $module1_variant3
add_module $variant
set_attribute module $variant moduleName   $module1
set_attribute module $variant vhdl         [list $tcrestDir/patmos/hardware/vivado/vhdl/filter_rr_lp.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/filter_lp.vhd work \
                                           ]
set_attribute module $variant synth        ${run.rmSynth}

set module1_variant4 "filter_rr_bp"
set variant $module1_variant4
add_module $variant
set_attribute module $variant moduleName   $module1
set_attribute module $variant vhdl         [list $tcrestDir/patmos/hardware/vivado/vhdl/filter_rr_bp.vhd work \
                                                 $tcrestDir/patmos/hardware/vivado/vhdl/filter_bp.vhd work \
                                           ]
set_attribute module $variant synth        ${run.rmSynth}

set module1_inst "filter_rr_inst_0"

########################################################################
### Configuration (Implementation) Definition - Replicate for each Config
########################################################################
set state "implement"
set config "config_${module1_variant1}_${state}"

add_implementation $config
set_attribute impl $config top             $top
set_attribute impl $config implXDC         [list $xdcDir/genesys2.xdc \
                                                 $xdcDir/pblocks.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl_ooc.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager.xdc \
                                           ]
set_attribute impl $config partitions      [list [list $static           $top          $state   ] \
                                                 [list $module1_variant1 $module1_inst implement] \
                                           ]
set_attribute impl $config pr.impl         1
set_attribute impl $config impl            ${run.prImpl}
set_attribute impl $config verify     	   ${run.prVerify}
set_attribute impl $config bitstream  	   ${run.writeBitstream}
set_attribute impl $config bitstream_settings  [list "BITSTREAM.GENERAL.COMPRESS        TRUE" \
                                               ]
set_attribute impl $config bitstream_options   [list "-bin_file" \
                                               ]


########################################################################
### Configuration (Implementation) Definition - Replicate for each Config
########################################################################
set state "import"
set config "config_${module1_variant2}_${state}"

add_implementation $config
set_attribute impl $config top             $top
set_attribute impl $config implXDC         [list $xdcDir/genesys2.xdc \
                                                 $xdcDir/pblocks.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl_ooc.xdc \
                                                 $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager.xdc \
                                           ]

# $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager_ooc.xdc \
# $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager_late.xdc \
# $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager_board.xdc \

set_attribute impl $config impl            ${run.prImpl}
set_attribute impl $config partitions      [list [list $static           $top          $state   ] \
                                                 [list $module1_variant2 $module1_inst implement] \
                                           ]
set_attribute impl $config pr.impl         1
set_attribute impl $config impl            ${run.prImpl}
set_attribute impl $config verify     	   ${run.prVerify}
set_attribute impl $config bitstream  	   ${run.writeBitstream}
set_attribute impl $config bitstream_settings  [list "BITSTREAM.GENERAL.COMPRESS        TRUE" \
                                               ]
set_attribute impl $config bitstream_options   [list "-bin_file" \
                                               ]

########################################################################
### Configuration (Implementation) Definition - Replicate for each Config
########################################################################
set state "import"
set config "config_${module1_variant3}_${state}"

add_implementation $config
set_attribute impl $config top             $top
set_attribute impl $config implXDC         [list $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.xdc \
                                                $xdcDir/pblocks.xdc \
                                                $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl.xdc \
                                                $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl_ooc.xdc \
                                                $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager.xdc \
                                          ]
set_attribute impl $config impl            ${run.prImpl}
set_attribute impl $config partitions      [list [list $static           $top          $state   ] \
                                                [list $module1_variant3 $module1_inst implement] \
                                          ]
set_attribute impl $config pr.impl         1
set_attribute impl $config impl            ${run.prImpl}
set_attribute impl $config verify     	   ${run.prVerify}
set_attribute impl $config bitstream  	   ${run.writeBitstream}
set_attribute impl $config bitstream_settings  [list "BITSTREAM.GENERAL.COMPRESS        TRUE" \
                                              ]
set_attribute impl $config bitstream_options   [list "-bin_file" \
                                              ]

########################################################################
### Configuration (Implementation) Definition - Replicate for each Config
########################################################################
set state "import"
set config "config_${module1_variant4}_${state}"

add_implementation $config
set_attribute impl $config top             $top
set_attribute impl $config implXDC         [list $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.xdc \
                                                $xdcDir/pblocks.xdc \
                                                $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl.xdc \
                                                $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/ddr3_ctrl/ddr3_ctrl/user_design/constraints/ddr3_ctrl_ooc.xdc \
                                                $tcrestDir/aegean/build/genesys2-audio-4cores/vivado/genesys2.srcs/sources_1/ip/clk_manager/clk_manager.xdc \
                                          ]
set_attribute impl $config impl            ${run.prImpl}
set_attribute impl $config partitions      [list [list $static           $top          $state   ] \
                                                [list $module1_variant4 $module1_inst implement] \
                                          ]
set_attribute impl $config pr.impl         1
set_attribute impl $config impl            ${run.prImpl}
set_attribute impl $config verify     	   ${run.prVerify}
set_attribute impl $config bitstream  	   ${run.writeBitstream}
set_attribute impl $config bitstream_settings  [list "BITSTREAM.GENERAL.COMPRESS        TRUE" \
                                              ]
set_attribute impl $config bitstream_options   [list "-bin_file" \
                                              ]

########################################################################
### Task / flow portion
########################################################################
# Build the designs
source $tclDir/run.tcl
#exit
