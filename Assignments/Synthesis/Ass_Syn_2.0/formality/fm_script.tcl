###################################################################
########################### Variables #############################
###################################################################



set SSLIB "/home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

###################################################################
############################ Guidance #############################
###################################################################

# Synopsys setup variable
set synopsys_auto_setup true

# Formality Setup File
set_svf /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/syn/UART_TX.svf
###################################################################
###################### Reference Container ########################
###################################################################

# Read Reference Design Verilog Files
read_verilog -container Ref /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/Mux_4X1.v
read_verilog -container Ref /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/parity_Calc.v
read_verilog -container Ref /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/Serializer.v
read_verilog -container Ref /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/UART_TX_TOP.v
read_sverilog -container Ref /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/UART_TX_FSM.sv

# Read Reference technology libraries
read_db -container Ref [list $SSLIB $TTLIB $FFLIB]


# set the top Reference Design 
set_reference_design UART_TX_TOP
set_top UART_TX_TOP


###################################################################
#################### Implementation Container #####################
###################################################################

# Read Implementation Design Files
read_verilog -container Imp /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/Mux_4X1.v
read_verilog -container Imp /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/parity_Calc.v
read_verilog -container Imp /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/Serializer.v
read_verilog -container Imp /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/UART_TX_TOP.v
read_sverilog -container Imp /home/ICer/Digital-ASIC-Design-Coursework/Assignments/Synthesis/Ass_Syn_2.0/rtl/UART_TX_FSM.sv
# Read Implementation technology libraries
read_db -container Imp [list $SSLIB $TTLIB $FFLIB]


# set the top Implementation Design
set_implementation_design UART_TX_TOP
set_top UART_TX_TOP

###################### Matching Compare points ####################

match

######################### Run Verification ########################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

########################### Reporting ############################# 
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui