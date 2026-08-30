onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_RST_SYNC/NUM_STAGES
add wave -noupdate /tb_RST_SYNC/CLK_PERIOD
add wave -noupdate /tb_RST_SYNC/NUM_RANDOM_ITER
add wave -noupdate /tb_RST_SYNC/CLK
add wave -noupdate -color Magenta /tb_RST_SYNC/RST
add wave -noupdate -color Cyan /tb_RST_SYNC/SYNC_RST
add wave -noupdate /tb_RST_SYNC/errors
add wave -noupdate /tb_RST_SYNC/i
add wave -noupdate /tb_RST_SYNC/DUT/Synchronizer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {410579 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
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
WaveRestoreZoom {319129 ps} {518766 ps}
