########################### Define Top Module ############################

set top_module alu8_top

##################### Define Working Library Directory ######################

define_design_lib work -path ./work

######################## Output Directories Setup ############################
file mkdir results
file mkdir reports

set RESULTS_DIR results
set REPORTS_DIR reports

################## Design Compiler Library Files #setup ######################

lappend search_path /home/ICer/Labs/Ass_Syn_3.0/std_cells
lappend search_path /home/ICer/Labs/Ass_Syn_3.0/rtl

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries
set link_library [list * $SSLIB $TTLIB $FFLIB]

#echo "###############################################"
#echo "############# Reading RTL Files  ##############"
#echo "###############################################"

set file_format verilog
read_file -format $file_format alu8_top.v
read_file -format $file_format add_unit.v
read_file -format $file_format mult_unit.v

###################### Defining toplevel ###################################

current_design $top_module

#################### Linking All The Design Parts #########################

puts "###############################################"
puts "######## Linking All The Design Parts #########"
puts "###############################################"

link

#################### Checking Design Consistency ###########################

puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design > $REPORTS_DIR/check_design.rpt

############################### Path groups ################################

puts "###############################################"
puts "################ Path groups ##################"
puts "###############################################"

group_path -name INREG  -from [all_inputs]
group_path -name REGOUT -to   [all_outputs]
group_path -name INOUT  -from [all_inputs] -to [all_outputs]

#################### Define Design Constraints #########################

puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source -echo ./cons.tcl

###################### Mapping and optimization ########################

puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile -map_effort high

#############################################################################
# Write out Design after initial compile
# All synthesized design outputs (netlist, ddc db, sdc, sdf) go into
# $RESULTS_DIR so they're kept separate from the text reports below.
#############################################################################

puts "###############################################"
puts "########## Writing Design to results/ ##########"
puts "###############################################"
write_file -format verilog -hierarchy -output $RESULTS_DIR/ALU_TOP.v
write_file -format ddc     -hierarchy -output $RESULTS_DIR/ALU_TOP.ddc
write_sdc  -nosplit $RESULTS_DIR/ALU_TOP.sdc
write_sdf           $RESULTS_DIR/ALU_TOP.sdf

################# reporting #######################
# All analysis/QoR reports go into $REPORTS_DIR, grouped by category
# (area, power, timing min/max, clocks, constraint violations).
#####################################################

puts "###############################################"
puts "############## Writing Reports #################"
puts "###############################################"
report_area                                    -hierarchy   > $REPORTS_DIR/area.rpt
report_power                                   -hierarchy   > $REPORTS_DIR/power.rpt
report_timing -max_paths 100 -delay_type min                > $REPORTS_DIR/hold.rpt
report_timing -max_paths 100 -delay_type max                > $REPORTS_DIR/setup.rpt
report_clock  -attributes                                   > $REPORTS_DIR/clocks.rpt
report_constraint -all_violators                            > $REPORTS_DIR/constraints.rpt

################# starting graphical user interface #######################
#gui_start
exit
