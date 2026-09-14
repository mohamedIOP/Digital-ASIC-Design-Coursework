#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Sun Sep 13 11:29:31 2026                #
#                                                     #
#######################################################

#@(#)CDS: First Encounter v08.10-p004_1 (32bit) 11/04/2008 14:34 (Linux 2.6)
#@(#)CDS: NanoRoute v08.10-p008 NR081027-0018/USR58-UB (database version 2.30, 67.1.1) {superthreading v1.11}
#@(#)CDS: CeltIC v08.10-p002_1 (32bit) 10/23/2008 22:04:14 (Linux 2.6.9-67.0.10.ELsmp)
#@(#)CDS: CTE v08.10-p016_1 (32bit) Oct 26 2008 15:11:51 (Linux 2.6.9-67.0.10.ELsmp)
#@(#)CDS: CPE v08.10-p009

setUIVar rda_Input ui_topcell ALU_TOP
setUIVar rda_Input ui_netlist /home/ahesham/Labs/Lab_PNR_1/dft/ALU_TOP.v
setUIVar rda_Input ui_timelib,min /home/ahesham/Labs/Lab_PNR_1/std_cells/libs/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.lib
setUIVar rda_Input ui_timelib,max /home/ahesham/Labs/Lab_PNR_1/std_cells/libs/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.lib
setUIVar rda_Input ui_timelib /home/ahesham/Labs/Lab_PNR_1/std_cells/libs/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.lib
setUIVar rda_Input ui_leffile {/home/ahesham/Labs/Lab_PNR_1/std_cells/lef/tsmc13fsg_7lm_tech.lef /home/ahesham/Labs/Lab_PNR_1/std_cells/lef/tsmc13_m_macros.lef /home/ahesham/Labs/Lab_PNR_1/pnr/import/ALU.lef}
setUIVar rda_Input ui_captbl_file /home/ahesham/Labs/Lab_PNR_1/std_cells/captables/tsmc13fsg.capTbl
setUIVar rda_Input ui_timingcon_file /home/ahesham/Labs/Lab_PNR_1/dft/ALU_TOP_func.sdc
setUIVar rda_Input ui_pwrnet VDD
setUIVar rda_Input ui_gndnet VSS
commitConfig
create_library_set -name min_library -timing "../std_cells/libs/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.lib"
create_library_set -name max_library -timing "../std_cells/libs/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.lib"
create_library_set -name typ_library -timing "../std_cells/libs/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.lib"
create_constraint_mode -name func_mode -sdc_files {../dft/ALU_TOP_func.sdc}
create_constraint_mode -name scan_mode -sdc_files {../dft/ALU_TOP_scan.sdc}
create_constraint_mode -name capture_mode -sdc_files {../dft/ALU_TOP_capture.sdc}
create_rc_corner -name RCcorner -cap_table "../std_cells/captables/tsmc13fsg.capTbl"
create_delay_corner -name min_corner -library_set min_library -rc_corner RCcorner
create_delay_corner -name max_corner -library_set max_library -rc_corner RCcorner
create_analysis_view -name setup1_analysis_view -delay_corner max_corner -constraint_mode func_mode
create_analysis_view -name hold1_analysis_view  -delay_corner min_corner -constraint_mode func_mode
create_analysis_view -name setup2_analysis_view -delay_corner max_corner -constraint_mode scan_mode
create_analysis_view -name hold2_analysis_view  -delay_corner min_corner -constraint_mode scan_mode
create_analysis_view -name setup3_analysis_view -delay_corner max_corner -constraint_mode capture_mode
create_analysis_view -name hold3_analysis_view  -delay_corner min_corner -constraint_mode capture_mode
set_analysis_view -setup {setup1_analysis_view setup2_analysis_view setup3_analysis_view} -hold {hold1_analysis_view hold2_analysis_view hold3_analysis_view}
floorPlan -d 120.13 120.13 3.0 3.0 3.0 3.0
addRing -spacing_bottom 0.5 -width_left 1 -width_bottom 1 -width_top 1 -spacing_top 0.5 -layer_bottom METAL5 -center 1 -stacked_via_top_layer METAL7 -width_right 1 -around core -jog_distance 0.205 -offset_bottom 0.205 -layer_top METAL5 -threshold 0.205 -offset_left 0.205 -spacing_right 0.5 -spacing_left 0.5 -offset_right 0.205 -offset_top 0.205 -layer_right METAL6 -nets {VSS VDD } -stacked_via_bottom_layer METAL1 -layer_left METAL6
addRing -spacing_bottom 0.5 -width_left 1 -width_bottom 1 -width_top 1 -spacing_top 0.5 -layer_bottom METAL5 -center 1 -stacked_via_top_layer METAL7 -width_right 1 -around core -jog_distance 0.205 -offset_bottom 0.205 -layer_top METAL5 -threshold 0.205 -offset_left 0.205 -spacing_right 0.5 -spacing_left 0.5 -offset_right 0.205 -offset_top 0.205 -layer_right METAL6 -nets {VSS VDD } -stacked_via_bottom_layer METAL1 -layer_left METAL6
uiSetTool select
zoomBox -5.543 124.547 143.548 73.968
panPage 0 -1
panPage 0 -1
panPage 0 1
panPage 0 -1
panPage 0 1
zoomBox 127.615 22.841 101.038 -2.313
zoomBox 122.984 7.441 113.608 -1.582
uiSetTool ruler
addStripe -block_ring_top_layer_limit METAL3 -max_same_layer_jog_length 0.8 -padcore_ring_bottom_layer_limit METAL1 -set_to_set_distance 40 -stacked_via_top_layer METAL7 -padcore_ring_top_layer_limit METAL3 -spacing 0.42 -merge_stripes_value 0.205 -layer METAL2 -block_ring_bottom_layer_limit METAL1 -width 0.4 -nets {VSS VDD } -stacked_via_bottom_layer METAL1
addStripe -block_ring_top_layer_limit METAL3 -max_same_layer_jog_length 0.8 -padcore_ring_bottom_layer_limit METAL1 -set_to_set_distance 40 -stacked_via_top_layer METAL7 -padcore_ring_top_layer_limit METAL3 -spacing 0.42 -merge_stripes_value 0.205 -layer METAL2 -block_ring_bottom_layer_limit METAL1 -width 0.4 -nets {VSS VDD } -stacked_via_bottom_layer METAL1
undo
uiSetTool select
setLayerPreference allM6 -isVisible 0
setLayerPreference allM6 -isVisible 1
setLayerPreference allM5 -isVisible 0
setLayerPreference allM5 -isVisible 1
zoomBox 63.713 94.819 125.130 35.525
zoomBox 72.112 70.460 109.364 42.952
selectWire 83.2800 1.8900 83.6800 117.4200 2 VSS
selectWire 84.1000 0.3900 84.5000 118.9200 2 VDD
panPage -1 0
panPage -1 0
panPage 1 0
panPage 1 0
panPage -1 0
selectWire 43.2800 1.8900 43.6800 117.4200 2 VSS
selectWire 44.1000 0.3900 44.5000 118.9200 2 VDD
selectWire 4.1000 0.3900 4.5000 118.9200 2 VDD
selectWire 3.2800 1.8900 3.6800 117.4200 2 VSS
setSelectedStripBoxState 0 ROUTED
setSelectedStripBoxState 0 ROUTED
deselectAll
setLayerPreference allM6 -isVisible 0
setLayerPreference allM6 -isVisible 1
zoomBox 59.867 80.986 128.586 29.479
zoomBox 76.034 57.504 99.000 47.181
selectWire 84.1000 0.3900 84.5000 118.9200 2 VDD
setSelectedStripBoxState 0 ROUTED
deselectAll
selectWire 83.2800 1.8900 83.6800 117.4200 2 VSS
panCenter 83.588 50.595
zoomBox 83.573 48.314 83.510 48.325
zoomBox 20.144 71.585 129.513 40.601
zoomBox 28.265 61.076 105.746 48.968
selectWire 44.1000 0.3900 44.5000 118.9200 2 VDD
selectWire 43.2800 1.8900 43.6800 117.4200 2 VSS
setSelectedStripBoxState 0 ROUTED
windowSelect 47.680 48.633 48.986 47.821
selectWire 44.1000 0.3900 44.5000 118.9200 2 VDD
setSelectedStripBoxState 0 ROUTED
deselectAll
selectWire 83.2800 1.8900 83.6800 117.4200 2 VSS
setSelectedStripBoxState 0 ROUTED
deselectAll
panPage -1 0
panPage -1 0
panPage 1 0
panPage 1 0
panPage -1 0
selectWire 3.2800 1.8900 3.6800 117.4200 6 VSS
deleteSelectedFromFPlan
selectWire 4.1000 0.3900 4.5000 118.9200 2 VDD
deleteSelectedFromFPlan
zoomBox -15.871 123.489 136.001 -4.021
verifyConnectivity -type all -noAntenna -error 1000 -warning 50
zoomBox 13.494 72.127 143.048 49.641
zoomBox 35.450 62.773 97.719 50.732
selectMarker 1.8900 1.8900 118.2400 117.4200 -1 3 7
uiSetTool moveWire
uiSetTool moveWire
clearDrc
clearDrc
verifyConnectivity -type all -noAntenna -error 1000 -warning 50
zoomBox 27.824 74.630 109.122 39.939
zoomBox 34.084 65.173 55.825 56.691
selectMarker 1.8900 1.8900 118.2400 117.4200 -1 3 7
deselectAll
selectMarker 1.8900 1.8900 118.2400 117.4200 -1 3 7
panCenter 43.493 59.595
zoomBox -4.351 121.767 136.001 106.938
zoomBox 71.036 131.233 94.247 109.109
deselectAll
selectMarker 0.3900 0.3900 119.7400 118.9200 -1 3 7
deselectAll
selectMarker 0.3900 0.3900 119.7400 118.9200 -1 3 7
deselectAll
selectMarker 1.8900 1.8900 118.2400 117.4200 -1 3 7
zoomBox 81.278 119.506 87.485 113.898
deselectAll
selectMarker 1.8900 1.8900 118.2400 117.4200 -1 3 7
deselectAll
selectMarker 0.3900 0.3900 119.7400 118.9200 -1 3 7
panCenter 84.249 118.404
zoomBox 83.791 119.163 84.814 117.674
deselectAll
selectMarker 0.3900 0.3900 119.7400 118.9200 -1 3 7
deselectAll
selectMarker 0.3900 0.3900 119.7400 118.9200 -1 3 7
deselectAll
selectMarker 0.3900 0.3900 119.7400 118.9200 -1 3 7
editDuplicate
clearDrc
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
deselectAll
uiSetTool select
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
uiSetTool select
zoomBox 84.177 118.332 84.425 118.052
deselectAll
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
windowSelect 84.205 118.282 84.401 118.078
windowSelect 84.173 118.285 84.416 118.072
setLayerPreference allM4 -isVisible 0
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
windowSelect 84.194 118.280 84.401 118.081
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
deselectAll
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
setLayerPreference allM6Cont -isVisible 0
setLayerPreference allM6Cont -isVisible 1
setLayerPreference allM7Cont -isVisible 0
setLayerPreference allM7Cont -isVisible 1
setLayerPreference allM4 -isVisible 1
setLayerPreference allM4 -isVisible 0
setLayerPreference allM5Cont -isVisible 0
setLayerPreference allM5Cont -isVisible 1
setLayerPreference allM4 -isVisible 1
setLayerPreference allM5Cont -isVisible 0
setLayerPreference allM5Cont -isVisible 1
zoomBox 145.931 13.590 100.781 -1.637
zoomBox 115.488 4.454 123.201 -1.182
windowSelect 117.094 3.059 118.478 1.794
zoomBox 73.770 123.886 116.140 87.076
zoomBox 77.048 120.714 90.843 108.136
deselectAll
selectWire 83.2800 1.8900 83.6800 117.4200 6 VSS
deselectAll
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
deselectAll
selectWire 83.2800 1.8900 83.6800 117.4200 6 VSS
deselectAll
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
deselectAll
selectWire 83.2800 1.8900 83.6800 117.4200 6 VSS
deselectAll
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
deselectAll
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
deselectAll
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
windowSelect 82.981 119.681 86.032 116.580
windowSelect 81.986 119.416 85.427 115.043
zoomBox 80.839 119.479 85.754 115.219
deselectAll
selectWire 84.1000 0.3900 84.5000 118.9200 6 VDD
deleteSelectedFromFPlan
selectWire 83.2800 1.8900 83.6800 117.4200 6 VSS
deleteSelectedFromFPlan
selectWire 0.3900 117.9200 119.7400 118.9200 5 VDD
deselectAll
selectWire 0.3900 117.9200 119.7400 118.9200 5 VDD
panCenter 83.866 118.838
windowSelect 84.047 119.073 84.624 117.800
deleteSelectedFromFPlan
panPage 0 -1
panPage 0 1
panPage 0 -1
zoomBox 83.151 115.807 83.813 116.004
group
zoomBox 76.947 120.178 101.442 95.948
zoomBox 81.462 118.454 89.182 108.986
windowSelect 83.050 117.581 84.245 116.064
deleteSelectedFromFPlan
windowSelect 24.911 123.356 51.922 -2.299
zoomBox 30.869 87.341 83.965 51.988
deselectAll
selectWire 44.1000 0.3900 44.5000 118.9200 6 VDD
deleteSelectedFromFPlan
selectWire 43.2800 1.8900 43.6800 117.4200 6 VSS
deleteSelectedFromFPlan
zoomBox 75.226 6.308 93.498 -9.184
selectWire 1.8900 1.8900 118.2400 2.8900 5 VSS
deselectAll
windowSelect 82.787 3.498 84.137 1.434
deselectAll
windowSelect 83.174 1.667 83.981 3.421
deleteSelectedFromFPlan
windowSelect 83.951 0.161 84.835 1.760
deleteSelectedFromFPlan
panPage -1 0
panPage -1 0
panPage 1 0
windowSelect 43.121 1.651 43.913 3.157
deleteSelectedFromFPlan
windowSelect 43.991 0.099 44.891 1.527
deleteSelectedFromFPlan
panPage -1 0
panPage -1 0
panPage 1 0
windowSelect 3.208 1.620 3.875 3.048
deleteSelectedFromFPlan
panPage -1 0
zoomBox -6.338 123.621 178.107 87.341
zoomBox -0.288 122.875 16.854 106.993
windowSelect 3.151 117.512 4.074 115.953
deleteSelectedFromFPlan
panPage 1 0
panPage 1 0
panPage -1 0
windowSelect 42.892 117.496 44.913 115.523
deleteSelectedFromFPlan
windowSelect 43.783 117.687 45.008 119.708
deleteSelectedFromFPlan
addStripe -block_ring_top_layer_limit METAL7 -max_same_layer_jog_length 0.8 -padcore_ring_bottom_layer_limit METAL5 -set_to_set_distance 40 -stacked_via_top_layer METAL7 -padcore_ring_top_layer_limit METAL7 -spacing 0.42 -merge_stripes_value 0.205 -layer METAL6 -block_ring_bottom_layer_limit METAL5 -width 0.4 -nets {VSS VDD } -stacked_via_bottom_layer METAL1
zoomBox 67.944 124.151 96.941 88.003
zoomBox 79.817 120.674 88.183 109.627
zoomBox 30.472 124.151 71.651 93.697
zoomBox 37.437 120.825 49.734 111.975
zoomBox 40.140 120.267 46.871 115.371
verifyConnectivity -type all -noAntenna -error 1000 -warning 50
verifyGeometry -noMinArea
zoomBox -16.003 27.890 88.864 -4.815
zoomBox 12.232 7.142 84.803 -5.136
saveDesign /home/ahesham/Labs/Lab_PNR_1/pnr/ALU_TOP_Spacing_Violations.enc
selectWire 0.3900 0.3900 119.7400 1.3900 5 VDD
deselectAll
selectWire 0.3900 0.3900 119.7400 1.3900 5 VDD
uiSetTool cutWire
uiSetTool select
deselectAll
uiSetTool cutWire
zoomBox 21.688 -2.601 23.837 3.913
editCutWire -x1 22.361 -y1 0.121 -x2 22.361 -y2 1.596
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage -1 0
panPage -1 0
editCutWire -x1 67.455 -y1 0.1405 -x2 67.455 -y2 1.55
uiSetTool select
selectWire 22.3600 0.3900 67.4550 1.3900 5 VDD
zoomBox -6.470 24.712 83.567 -7.330
zoomBox 18.552 5.532 70.564 -4.928
panCenter 24.855 0.823
panPage 1 0
zoomBox 0.283 32.392 86.877 -6.801
zoomBox 18.509 5.655 73.701 -4.918
panCenter 23.714 0.746
setSelectedStripBoxState 0 ROUTED
deselectAll
zoomBox 16.569 23.388 75.755 -4.683
selectWire 0.3900 0.3900 22.3600 1.3900 5 VDD
zoomBox 19.174 4.064 26.543 -2.095
uiSetTool stretchWire
editStretch x 1.185 high
deselectAll
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
zoomBox 8.360 18.224 83.435 -9.979
selectWire 22.3600 0.3900 67.4550 1.3900 3 VDD
deselectAll
selectWire 67.4550 0.3900 119.7400 1.3900 5 VDD
uiSetTool stretchWire
editStretch x -1.085 low
zoomBox 14.072 6.243 26.419 -2.958
deselectAll
selectWire 0.3900 0.3900 23.5450 1.3900 5 VDD
deselectAll
selectWire 0.3900 0.3900 23.5450 1.3900 5 VDD
deselectAll
selectWire 22.3600 0.3900 67.4550 1.3900 3 VDD
uiSetTool stretchWire
editStretch x -0.8 low
zoomBox 21.716 1.643 23.210 0.140
deselectAll
uiSetTool defineArea pwrEpv:set_area_bbox
uiSetTool stretchWire
editPowerVia -bottom_layer METAL1 -area {21.9125 1.5015 23.253 0.253} -modify_vias 1 -top_layer METAL7
editPowerVia -bottom_layer METAL1 -area {21.9125 1.5015 23.253 0.253} -add_vias 1 -top_layer METAL7
editPowerVia -bottom_layer METAL1 -area {21.9125 1.5015 23.253 0.253} -add_vias 1 -top_layer METAL7
zoomBox 59.072 18.091 90.055 -7.860
zoomBox 62.511 4.596 70.468 -1.333
zoomBox 65.661 2.784 68.721 -0.591
uiSetTool stretchWire
selectWire 66.3700 0.3900 119.7400 1.3900 5 VDD
uiSetTool stretchWire
deselectAll
selectWire 66.3700 0.3900 119.7400 1.3900 5 VDD
uiSetTool select
uiSetTool stretchWire
deselectAll
selectWire 21.5600 0.3900 67.4550 1.3900 3 VDD
editStretch x 0.89 high
deselectAll
uiSetTool defineArea pwrEpv:set_area_bbox
zoomBox 66.847 1.587 68.041 0.204
uiSetTool stretchWire
editPowerVia -bottom_layer METAL1 -area {66.817 1.476 67.902 0.3135} -add_vias 1 -top_layer METAL7
editPowerVia -bottom_layer METAL1 -area {66.817 1.476 67.902 0.3135} -add_vias 1 -top_layer METAL7
selectWire 66.3700 0.3900 119.7400 1.3900 5 VDD
uiSetTool stretchWire
editStretch x 0.495 low
deselectAll
selectWire 66.8650 0.3900 119.7400 1.3900 5 VDD
deselectAll
selectWire 21.5600 0.3900 68.3450 1.3900 3 VDD
deselectAll
selectWire 66.8650 0.3900 119.7400 1.3900 5 VDD
uiSetTool stretchWire
editStretch x -0.07 low
uiSetTool stretchWire
deselectAll
zoomBox 13.921 26.831 34.047 3.394
panPage 0 -1
panPage 1 0
panPage 1 0
panPage -1 0
zoomBox 65.052 2.241 72.825 -3.677
uiSetTool defineArea pwrEpv:set_area_bbox
uiSetTool stretchWire
editPowerVia -bottom_layer METAL1 -area {66.9015 1.565 68.1945 0.124} -add_vias 1 -top_layer METAL7
editPowerVia -bottom_layer METAL1 -area {66.9015 1.565 68.1945 0.124} -add_vias 1 -top_layer METAL7
selectWire 66.7950 0.3900 119.7400 1.3900 5 VDD
uiSetTool select
zoomBox 66.463 1.601 68.591 -0.291
uiSetTool stretchWire
editStretch x 0.275 low
undo
deselectAll
selectWire 21.5600 0.3900 68.3450 1.3900 3 VDD
editStretch x -0.27 high
uiSetTool select
deselectAll
selectWire 66.7950 0.3900 119.7400 1.3900 5 VDD
deselectAll
selectWire 66.7950 0.3900 119.7400 1.3900 5 VDD
deselectAll
selectWire 66.7950 0.3900 119.7400 1.3900 5 VDD
uiSetTool stretchWire
editStretch x 0.175 low
deselectAll
selectWire 66.9700 0.3900 119.7400 1.3900 5 VDD
uiSetTool stretchWire
editStretch x 0.095 low
deselectAll
selectWire 67.0650 0.3900 119.7400 1.3900 5 VDD
deselectAll
selectWire 67.0650 0.3900 119.7400 1.3900 5 VDD
deselectAll
verifyConnectivity -type all -noAntenna -error 1000 -warning 50
verifyGeometry -noMinArea
zoomBox 0.018 16.370 101.310 -8.390
zoomBox 18.477 7.681 76.853 -3.532
zoomBox 70.098 5.160 65.497 -2.872
zoomBox 69.169 2.818 66.305 -0.603
panPage -1 0
panPage -1 0
panPage -1 0
panPage -1 0
panPage -1 0
panPage -1 0
selectWire 0.3900 0.3900 23.5450 1.3900 5 VDD
uiSetTool stretchWire
uiSetTool select
uiSetTool stretchWire
zoomBox 21.210 1.642 24.738 0.075
editStretch x -0.49 high
deselectAll
selectWire 0.3900 0.3900 23.0550 1.3900 5 VDD
deselectAll
selectWire 21.5600 0.3900 68.0750 1.3900 3 VDD
uiSetTool stretchWire
editStretch x 0.49 low
deselectAll
setDrawView ameba
setDrawView fplan
saveDesign /home/ahesham/Labs/Lab_PNR_1/pnr/ALU_TOP_power_ring_&_strips.enc
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { 1 6 } -blockPinTarget { nearestRingStripe nearestTarget } -padPinPortConnect { allPort oneGeom } -checkAlignedSecondaryPin 1 -blockPin useLef -allowJogging 1 -crossoverViaBottomLayer 1 -allowLayerChange 1 -targetViaTopLayer 7 -crossoverViaTopLayer 7 -targetViaBottomLayer 1 -nets { VSS VDD }
verifyConnectivity -type all -noAntenna -error 1000 -warning 50
verifyGeometry -noMinArea
setDrawView place
zoomBox -0.379 122.562 18.158 -9.184
zoomBox -28.140 79.130 137.534 6.789
zoomBox -19.989 49.526 141.459 14.731
zoomBox -15.428 19.919 14.728 -0.824
selectWire 3.2800 1.8900 3.6800 117.4200 6 VSS
deleteSelectedFromFPlan
selectWire 4.1000 0.3900 4.5000 118.9200 6 VDD
deleteSelectedFromFPlan
zoomBox 9.155 21.137 64.633 -4.285
zoomBox 25.852 5.828 38.410 -3.062
selectWire 29.3150 0.5900 30.9550 0.9900 6 VDD
panPage -1 0
deselectAll
selectWire 0.3900 0.3900 23.0550 1.3900 5 VDD
deselectAll
selectWire 0.3900 0.3900 23.0550 1.3900 5 VDD
windowSelect 18.976 0.911 19.047 0.911
panPage -1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage -1 0
selectWire 30.9550 0.5900 34.2350 0.9900 5 VDD
deleteSelectedFromFPlan
selectWire 34.2350 0.5900 35.8750 0.9900 6 VDD
deleteSelectedFromFPlan
selectWire 34.0350 0.5900 34.4350 0.9900 5 VDD
deleteSelectedFromFPlan
selectWire 35.8750 0.5900 44.3000 0.9900 5 VDD
deleteSelectedFromFPlan
selectWire 35.6750 0.5900 36.0750 0.9900 5 VDD
deleteSelectedFromFPlan
windowSelect 31.325 1.009 27.735 0.377
deleteSelectedFromFPlan
selectWire 0.3900 0.5900 29.3150 0.9900 5 VDD
deleteSelectedFromFPlan
panPage -1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage -1 0
zoomBox 17.496 18.489 83.302 -3.756
selectWire 44.1000 0.3900 44.5000 118.9200 6 VDD
panPage -1 0
panPage 0 1
panPage 0 1
panPage 0 1
panPage 0 1
panPage 1 0
panPage 1 0
panPage -1 0
panPage 0 -1
panPage 0 1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
verifyConnectivity -type all -noAntenna -error 1000 -warning 50
verifyGeometry -noMinArea
deselectAll
saveDesign /home/ahesham/Labs/Lab_PNR_1/pnr/ALU_TOP_special_route.enc
