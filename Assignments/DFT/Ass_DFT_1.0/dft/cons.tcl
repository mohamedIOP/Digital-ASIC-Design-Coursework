
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
# 6. set input/output delay on ports
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
set CLK_NAME CLK
set CLK_PER 1000
set CLK_SETUP_SKEW 0.025
set CLK_HOLD_SKEW 0.01
set CLK_LAT 0
set CLK_RISE 0.05
set CLK_FALL 0.05

create_clock -name $CLK_NAME -period $CLK_PER [get_ports CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks $CLK_NAME]
set_clock_uncertainty -hold $CLK_HOLD_SKEW [get_clocks $CLK_NAME]
set_clock_transition -rise $CLK_RISE [get_clocks $CLK_NAME]
set_clock_transition -fall $CLK_FALL [get_clocks $CLK_NAME]

#################################### SCAN Clocks ###################################

set DFT_CLK_NAME DFTCLK
set DFT_CLK_PER 1000
set DFT_CLK_SETUP_SKEW 0.025
set DFT_CLK_HOLD_SKEW 0.01
set DFT_CLK_LAT 0
set DFT_CLK_RISE 0.05
set DFT_CLK_FALL 0.05

create_clock -name $DFT_CLK_NAME -period $DFT_CLK_PER -waveform "0 [expr $DFT_CLK_PER/2]" [get_ports scan_clk]
set_clock_uncertainty -setup $DFT_CLK_SETUP_SKEW [get_clocks $DFT_CLK_NAME]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks $DFT_CLK_NAME]
set_clock_transition -rise $DFT_CLK_RISE  [get_clocks $DFT_CLK_NAME]
set_clock_transition -fall $DFT_CLK_FALL  [get_clocks $DFT_CLK_NAME]
set_clock_latency $DFT_CLK_LAT [get_clocks $DFT_CLK_NAME]


set_dont_touch_network {CLK RST scan_clk}
####################################################################################
           #########################################################
                  #### Section 2 : Clocks Relationships ####
           #########################################################
####################################################################################

set_clock_groups -logically_exclusive -group [get_clocks "$CLK_NAME"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################

set in_delay  [expr 0.3*$CLK_PER]
set out_delay [expr 0.3*$CLK_PER]


#Constrain Input Paths
set_input_delay $in_delay -clock $CLK_NAME [get_port SI] 
set_input_delay $in_delay -clock $CLK_NAME [get_port SE] 
set_input_delay $in_delay -clock $CLK_NAME [get_port test_mode] 
set_input_delay $in_delay -clock $CLK_NAME [get_port scan_clk] 
set_input_delay $in_delay -clock $CLK_NAME [get_port scan_rst] 
set_input_delay $in_delay -clock $CLK_NAME [get_port pData] 
set_input_delay $in_delay -clock $CLK_NAME [get_port dataValid] 
set_input_delay $in_delay -clock $CLK_NAME [get_port parEn] 
set_input_delay $in_delay -clock $CLK_NAME [get_port parTyp]

#Constrain Output Paths
set_output_delay $out_delay -clock $CLK_NAME [get_port SO] 
set_output_delay $out_delay -clock $CLK_NAME [get_port busy] 
set_output_delay $out_delay -clock $CLK_NAME [get_port txOut] 
####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port pData]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port dataValid]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port parEn]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port parTyp]


set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SI]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SE]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port test_mode]
####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################
set_load 0.1 [get_port SO] 
set_load 0.1 [get_port txOut] 
set_load 0.1 [get_port busy]  

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


####################################################################################
           #########################################################
                  #### Section 8 : multicycle path ####
           #########################################################
####################################################################################


