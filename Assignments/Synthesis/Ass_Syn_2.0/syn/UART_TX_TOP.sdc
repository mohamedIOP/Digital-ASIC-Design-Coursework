###################################################################

# Created by write_sdc on Sun Sep 6 10:07:54 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {pData[7]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {pData[6]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {pData[5]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {pData[4]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {pData[3]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {pData[2]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {pData[1]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {pData[0]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports dataValid]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports parEn]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports parTyp]
set_load -pin_load 0.5 [get_ports txOut]
set_load -pin_load 0.5 [get_ports busy]
create_clock [get_ports CLK]  -period 8680  -waveform {0 4340}
set_clock_uncertainty -setup 0.25  [get_clocks CLK]
set_clock_uncertainty -hold 0.05  [get_clocks CLK]
set_clock_transition -max -rise 0.1 [get_clocks CLK]
set_clock_transition -max -fall 0.1 [get_clocks CLK]
set_clock_transition -min -rise 0.1 [get_clocks CLK]
set_clock_transition -min -fall 0.1 [get_clocks CLK]
group_path -name INOUT  -from [list [get_ports {pData[7]}] [get_ports {pData[6]}] [get_ports {pData[5]}] [get_ports {pData[4]}] [get_ports {pData[3]}] [get_ports {pData[2]}] [get_ports {pData[1]}] [get_ports {pData[0]}] [get_ports dataValid] [get_ports parEn] [get_ports parTyp] [get_ports CLK] [get_ports RST]]  -to [list [get_ports txOut] [get_ports busy]]
group_path -name INREG  -from [list [get_ports {pData[7]}] [get_ports {pData[6]}] [get_ports {pData[5]}] [get_ports {pData[4]}] [get_ports {pData[3]}] [get_ports {pData[2]}] [get_ports {pData[1]}] [get_ports {pData[0]}] [get_ports dataValid] [get_ports parEn] [get_ports parTyp] [get_ports CLK] [get_ports RST]]
group_path -name REGOUT  -to [list [get_ports txOut] [get_ports busy]]
set_input_delay -clock CLK  2604  [get_ports {pData[7]}]
set_input_delay -clock CLK  2604  [get_ports {pData[6]}]
set_input_delay -clock CLK  2604  [get_ports {pData[5]}]
set_input_delay -clock CLK  2604  [get_ports {pData[4]}]
set_input_delay -clock CLK  2604  [get_ports {pData[3]}]
set_input_delay -clock CLK  2604  [get_ports {pData[2]}]
set_input_delay -clock CLK  2604  [get_ports {pData[1]}]
set_input_delay -clock CLK  2604  [get_ports {pData[0]}]
set_input_delay -clock CLK  2604  [get_ports dataValid]
set_input_delay -clock CLK  2604  [get_ports parEn]
set_input_delay -clock CLK  2604  [get_ports parTyp]
set_output_delay -clock CLK  2604  [get_ports txOut]
set_output_delay -clock CLK  2604  [get_ports busy]
