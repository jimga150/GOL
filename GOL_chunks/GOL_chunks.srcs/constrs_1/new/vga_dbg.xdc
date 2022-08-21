



create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list top_inst/clk_mmcm_inst/inst/clk_out_vga]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 9 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {top_inst/field_inst/s1_chunk_x[0]} {top_inst/field_inst/s1_chunk_x[1]} {top_inst/field_inst/s1_chunk_x[2]} {top_inst/field_inst/s1_chunk_x[3]} {top_inst/field_inst/s1_chunk_x[4]} {top_inst/field_inst/s1_chunk_x[5]} {top_inst/field_inst/s1_chunk_x[6]} {top_inst/field_inst/s1_chunk_x[7]} {top_inst/field_inst/s1_chunk_x[8]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {top_inst/field_inst/s1_chunk_y[0]} {top_inst/field_inst/s1_chunk_y[1]} {top_inst/field_inst/s1_chunk_y[2]} {top_inst/field_inst/s1_chunk_y[3]} {top_inst/field_inst/s1_chunk_y[4]} {top_inst/field_inst/s1_chunk_y[5]} {top_inst/field_inst/s1_chunk_y[6]} {top_inst/field_inst/s1_chunk_y[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list top_inst/s0_hsync]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list top_inst/s0_vsync]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_clk_out_vga]
