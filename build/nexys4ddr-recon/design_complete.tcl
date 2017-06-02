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
set device       "xc7a100t"
set package      "csg324"
set speed        "-1"
set part         $device$package$speed
check_part $part

### Removing single files add warning
set_param project.singleFileAddWarning.Threshold 500

###############################################################
###  Setup Variables
###############################################################
#set tclParams [list <param1> <value> <param2> <value> ... <paramN> <value>]

####flow control
set run.topSynth       0
set run.rmSynth        0
set run.prImpl         0
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

set top "patmos_top"
set static "Static"
add_module $static
set_attribute module $static moduleName    $top
set_attribute module $static top_level     1

set_attribute module $static vlog          [list $rtlDir/Patmos.v \
                                                 $rtlDir/ddr2_ctrl/rtl/clocking/mig_7series_v4_0_clk_ibuf.v \
                                                 $rtlDir/ddr2_ctrl/rtl/clocking/mig_7series_v4_0_infrastructure.v \
                                                 $rtlDir/ddr2_ctrl/rtl/clocking/mig_7series_v4_0_iodelay_ctrl.v \
                                                 $rtlDir/ddr2_ctrl/rtl/clocking/mig_7series_v4_0_tempmon.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_arb_mux.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_arb_row_col.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_arb_select.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_bank_cntrl.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_bank_common.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_bank_compare.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_bank_mach.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_bank_queue.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_bank_state.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_col_mach.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_mc.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_rank_cntrl.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_rank_common.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_rank_mach.v \
                                                 $rtlDir/ddr2_ctrl/rtl/controller/mig_7series_v4_0_round_robin_arb.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ecc/mig_7series_v4_0_ecc_buf.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ecc/mig_7series_v4_0_ecc_dec_fix.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ecc/mig_7series_v4_0_ecc_gen.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ecc/mig_7series_v4_0_ecc_merge_enc.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ecc/mig_7series_v4_0_fi_xor.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ip_top/mig_7series_v4_0_mem_intfc.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ip_top/mig_7series_v4_0_memc_ui_top_std.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_byte_group_io.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_byte_lane.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_tempmon.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_calib_top.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_if_post_fifo.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_mc_phy.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_mc_phy_wrapper.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_of_pre_fifo.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_4lanes.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_init.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal_hr.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_oclkdelay_cal.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_prbs_rdlvl.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_rdlvl.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_top.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_wrcal.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl_off_delay.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_prbs_gen.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_ck_addr_cmd_delay.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_lim.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_poc_top.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_mux.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_data.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_samp.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_edge.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_cntlr.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_po_cntlr.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_poc_pd.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_poc_tap_base.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_poc_meta.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_poc_edge_store.v \
                                                 $rtlDir/ddr2_ctrl/rtl/phy/mig_7series_v4_0_poc_cc.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ui/mig_7series_v4_0_ui_cmd.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ui/mig_7series_v4_0_ui_rd_data.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ui/mig_7series_v4_0_ui_top.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ui/mig_7series_v4_0_ui_wr_data.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ddr2_ctrl_mig.v \
                                                 $rtlDir/ddr2_ctrl/rtl/ddr2_ctrl.v \
                                                 $rtlDir/clk_manager/clk_manager.v \
                                                 $rtlDir/clk_manager/clk_manager_clk_wiz.v \
                                           ]

set_attribute module $static vhdl          [list $rtlDir/ocp.vhd work \
                                                 $rtlDir/ocp_burst_to_ddr2_ctrl.vhd work \
                                                 $rtlDir/nexys4ddr_io.vhd work \
                                                 $rtlDir/icap_ctrl_config.vhd work \
                                                 $rtlDir/icap_ctrl.vhd work \
                                                 $rtlDir/ocp_to_bram.vhd work \
                                                 $rtlDir/recon_spm.vhd work \
                                                 $rtlDir/icap_ctrl_defs.vhd work \
                                                 $rtlDir/tdp_sc_bram.vhd work \
						 $rtlDir/patmos_nexys4ddr-recon.vhdl work \
                                           ]

#set_attribute module $static prj           [list $prjDir/ddr2_ctrl/mig_a.prj \
#                                                 $prjDir/ddr2_ctrl/mig_b.prj \
#                                           ]

#set_attribute module $static ip            [list $ipDir/clk_manager/clk_manager.xci \
#                                                 $ipDir/ddr2_ctrl/ddr2_ctrl.xci \
#                                                 $ipDir/ddr2_ctrl/mig_a.prj \
#                                                 $ipDir/ddr2_ctrl/mig_b.prj \
#                                                 $ipDir/clk_manager/clk_manager.xci \
#                                           ]

set_attribute module $static synthXDC      [list $xdcDir/nexys4ddr.xdc \
                                                 $rtlDir/clk_manager/clk_manager.xdc \
                                                 $rtlDir/ddr2_ctrl/constraints/ddr2_ctrl.xdc \
                                                 $rtlDir/ddr2_ctrl/constraints/ddr2_ctrl_ooc.xdc \
                                           ]

set_attribute module $static synth         ${run.topSynth}
#set_attribute module $static ipRepo        " ../../../../../../output/export/rtf/ip/xilinx/"

####################################################################
### RP Module Definitions
####################################################################
set module1 "ocp_rw_reg"

set module1_variant1 "ocp_rw_reg"
set variant $module1_variant1
add_module $variant
set_attribute module $variant moduleName   $module1
set_attribute module $variant vhdl         [list $rtlDir/ocp_rw_reg.vhd work \
                                           ]
set_attribute module $variant synth        ${run.rmSynth}

set module1_variant2 "ocp_rw_reg_n"
set variant $module1_variant2
add_module $variant
set_attribute module $variant moduleName   $module1
set_attribute module $variant vhdl         [list $rtlDir/ocp_rw_reg_n.vhd work \
                                           ]
set_attribute module $variant synth        ${run.rmSynth}

set module1_inst "ocp_rw_reg_inst_0"

########################################################################
### Configuration (Implementation) Definition - Replicate for each Config
########################################################################
set state "implement"
set config "config_${module1_variant1}_${state}" 

add_implementation $config
set_attribute impl $config top             $top
set_attribute impl $config implXDC         [list $xdcDir/nexys4ddr.xdc \
                                                 $xdcDir/pblocks.xdc \
                                                 $rtlDir/clk_manager/clk_manager.xdc \
                                                 $rtlDir/ddr2_ctrl/constraints/ddr2_ctrl.xdc \
                                                 $rtlDir/ddr2_ctrl/constraints/ddr2_ctrl_ooc.xdc \
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
set_attribute impl $config implXDC         [list $xdcDir/nexys4ddr.xdc \
                                                 $xdcDir/pblocks.xdc \
                                                 $rtlDir/clk_manager/clk_manager.xdc \
                                                 $rtlDir/ddr2_ctrl/constraints/ddr2_ctrl.xdc \
                                                 $rtlDir/ddr2_ctrl/constraints/ddr2_ctrl_ooc.xdc \
                                           ]
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
### Task / flow portion
########################################################################
# Build the designs
source $tclDir/run.tcl
#exit
