onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color {Orange Red} /ClkDiv_tb/i_ref_clk
add wave -noupdate -color Cyan /ClkDiv_tb/o_div_clk
add wave -noupdate -color Magenta /ClkDiv_tb/i_rst_n
add wave -noupdate -color Magenta /ClkDiv_tb/i_clk_en
add wave -noupdate -radix decimal /ClkDiv_tb/i_div_ratio
add wave -noupdate /ClkDiv_tb/test_count
add wave -noupdate /ClkDiv_tb/pass_count
add wave -noupdate /ClkDiv_tb/fail_count
add wave -noupdate /ClkDiv_tb/CLK_PERIOD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 192
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
WaveRestoreZoom {0 ps} {297084 ps}
