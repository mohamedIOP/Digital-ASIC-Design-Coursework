
####################################################################################
# Constraints
# ----------------------------------------------------------------------------
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. #set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################

#################################### FUNC Clocks ###################################

#1. Master Clocks
set CLK_NAME CLK
set CLK_PER 50
set CLK_SETUP_SKEW 0.2
set CLK_HOLD_SKEW 0.1

create_clock -name $CLK_NAME -period $CLK_PER -waveform "0 [expr $CLK_PER/2]" [get_ports CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks $CLK_NAME]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks $CLK_NAME]


#2. Generated clocks

create_generated_clock -master_clock $CLK_NAME -source [get_ports CLK] \
                       -name "REG_CLK" [get_port U0_ClkDiv/o_div_clk] \
                       -divide_by 2

create_generated_clock -master_clock $CLK_NAME -source [get_ports CLK] \
                       -name "ALU_CLK" [get_port U0_CLK_GATE/GATED_CLK] \
                       -divide_by 1

#################################### SCAN Clocks ###################################
set DFT_CLK_NAME DFTCLK
set DFT_CLK_PER 200
set DFT_CLK_SETUP_SKEW 0.2
set DFT_CLK_HOLD_SKEW 0.1
set DFT_CLK_LAT 0
set DFT_CLK_RISE 0.05
set DFT_CLK_FALL 0.05

create_clock -name $DFT_CLK_NAME -period $DFT_CLK_PER -waveform "0 [expr $DFT_CLK_PER/2]" [get_ports scan_clk]
set_clock_uncertainty -setup $DFT_CLK_SETUP_SKEW [get_clocks $DFT_CLK_NAME]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks $DFT_CLK_NAME]
set_clock_transition -rise $DFT_CLK_RISE  [get_clocks $DFT_CLK_NAME]
set_clock_transition -fall $DFT_CLK_FALL  [get_clocks $DFT_CLK_NAME]
set_clock_latency $DFT_CLK_LAT [get_clocks $DFT_CLK_NAME]

set_dont_touch_network "$CLK_NAME $DFT_CLK_NAME REG_CLK ALU_CLK"

####################################################################################
           #########################################################
                  #### Section 2 : Clocks Relationships ####
           #########################################################
####################################################################################

set_clock_groups -logically_exclusive -group [get_clocks "$CLK_NAME"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

set_clock_groups -logically_exclusive -group [get_clocks "REG_CLK"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

set_clock_groups -logically_exclusive -group [get_clocks "ALU_CLK"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

####################################################################################
           #########################################################
             #### Section 3 : #set input/output delay on ports ####
           #########################################################
####################################################################################

set in_delay  [expr 0.2*$CLK_PER]
set out_delay [expr 0.2*$CLK_PER]

set in2_delay  [expr 0.2*$DFT_CLK_PER]
set out2_delay [expr 0.2*$DFT_CLK_PER]

#Constrain Input Paths
set_input_delay $in_delay -clock $CLK_NAME [get_port CLKG_EN]
set_input_delay $in_delay -clock $CLK_NAME [get_port CLKDIV_EN]
set_input_delay $in_delay -clock $CLK_NAME [get_port WrEn]
set_input_delay $in_delay -clock $CLK_NAME [get_port RdEn]
set_input_delay $in_delay -clock $CLK_NAME [get_port Address]
set_input_delay $in_delay -clock $CLK_NAME [get_port WrData]
set_input_delay $in_delay -clock $CLK_NAME [get_port ALU_FUN]
set_input_delay $in_delay -clock $CLK_NAME [get_port ALU_Enable]

#Constrain Scan Input Paths
set_input_delay $in2_delay -clock $DFT_CLK_NAME [get_port test_mode]
set_input_delay $in2_delay -clock $DFT_CLK_NAME [get_port SI]
set_input_delay $in2_delay -clock $DFT_CLK_NAME [get_port SE]

#Constrain Output Paths
set_output_delay $out_delay -clock $CLK_NAME [get_port RdData]
set_output_delay $out_delay -clock $CLK_NAME [get_port ALU_VLD]
set_output_delay $out_delay -clock $CLK_NAME [get_port ALU_OUT]

#Constrain Scan Output Paths
set_output_delay $out2_delay -clock $DFT_CLK_NAME [get_port SO]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port CLKG_EN]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port CLKDIV_EN]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port WrEn]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port RdEn]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port Address]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port WrData]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port ALU_FUN]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port ALU_Enable]

#scan ports
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port test_mode]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SI]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SE]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.5 [get_port RdData]
set_load 0.5 [get_port ALU_VLD]
set_load 0.5 [get_port ALU_OUT]

#scan ports
set_load 0.5  [get_port SO]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################
           #########################################################
                  #### Section 8 : Case Analysis ####
           #########################################################
####################################################################################

set_case_analysis 0 [get_port test_mode]

####################################################################################

