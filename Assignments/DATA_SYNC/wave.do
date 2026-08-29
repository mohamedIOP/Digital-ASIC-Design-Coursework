onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DATA_SYNC_tb/CLK
add wave -noupdate /DATA_SYNC_tb/RST
add wave -noupdate /DATA_SYNC_tb/sync_bus
add wave -noupdate /DATA_SYNC_tb/unsync_bus
add wave -noupdate -color Magenta /DATA_SYNC_tb/bus_enable
add wave -noupdate -color Cyan /DATA_SYNC_tb/enable_pulse
add wave -noupdate /DATA_SYNC_tb/test_case_cnt
add wave -noupdate /DATA_SYNC_tb/pass_cnt
add wave -noupdate /DATA_SYNC_tb/fail_cnt
add wave -noupdate -color {Blue Violet} /DATA_SYNC_tb/NUM_STAGES
add wave -noupdate -color {Blue Violet} /DATA_SYNC_tb/BUS_WIDTH
add wave -noupdate -color {Blue Violet} /DATA_SYNC_tb/CLK_PERIOD
add wave -noupdate -expand -group Inner_Structure /DATA_SYNC_tb/dut/Multi_Flip_Flop_Synchronizer
add wave -noupdate -expand -group Inner_Structure /DATA_SYNC_tb/dut/Pulse_Gen_Flop
add wave -noupdate -expand -group Inner_Structure /DATA_SYNC_tb/dut/Pulse_Gen_Output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 320
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {138600 ps}
