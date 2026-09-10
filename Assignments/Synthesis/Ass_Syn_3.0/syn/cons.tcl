
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
set CLK_NAME MASTER_CLK
set CLK_PER 10
set CLK_SETUP_SKEW 0.2
set CLK_HOLD_SKEW 0.1
set CLK_LAT 0
set CLK_RISE 0.05
set CLK_FALL 0.05

create_clock -name $CLK_NAME -period $CLK_PER -waveform "0 [expr $CLK_PER/2]" [get_ports clk]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks $CLK_NAME]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks $CLK_NAME]
set_clock_transition -rise $CLK_RISE  [get_clocks $CLK_NAME]
set_clock_transition -fall $CLK_FALL  [get_clocks $CLK_NAME]
set_clock_latency $CLK_LAT [get_clocks $CLK_NAME]
					   
set_dont_touch_network clk
set_dont_touch_network rst_n

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
     
set in_delay  [expr 0.2*$CLK_PER]
set out_delay [expr 0.2*$CLK_PER]

#Constrain Input Paths
set_input_delay $in_delay -clock MASTER_CLK [get_port mode]
set_input_delay $in_delay -clock MASTER_CLK [get_port add_en]
set_input_delay $in_delay -clock MASTER_CLK [get_port mul_en]
set_input_delay $in_delay -clock MASTER_CLK [get_port a]
set_input_delay $in_delay -clock MASTER_CLK [get_port b]

#Constrain Output Paths
set_output_delay $out_delay -clock MASTER_CLK [get_port result]
set_output_delay $out_delay -clock MASTER_CLK [get_port valid]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port mode]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port add_en]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port mul_en]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port a]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port b]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.5 [get_port result]
set_load 0.5 [get_port valid]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" \
                         -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" \
						 -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" \
						 -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
