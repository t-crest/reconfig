#-------------------------------------------------
# pblock_ocp_rw_reg 
#            for pr instance ocp_rw_reg_inst_0
#-------------------------------------------------
create_pblock pblock_ocp_rw_reg
add_cells_to_pblock [get_pblocks pblock_ocp_rw_reg]  [get_cells -quiet [list ocp_rw_reg_inst_0]]
resize_pblock [get_pblocks pblock_ocp_rw_reg] -add {SLICE_X34Y100:SLICE_X37Y149}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_ocp_rw_reg]
set_property SNAPPING_MODE ON [get_pblocks pblock_ocp_rw_reg]

