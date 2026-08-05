lappend search_path /home/ICer/Sawy/Synthesis/Labs/Session_1/Lab_Syn_1.1/std_cells
lappend search_path /home/ICer/Sawy/Synthesis/Labs/Session_1/Lab_Syn_1.1/rtl

set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"

set target_library [list $TTLIB]

set link_library [list * $TTLIB]


read_file -format verilog Up_Dn_Counter.v

link_library

compile

write_file -format verilog -output Up_Dn_Counter_netlist.v

exit