onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ASYNC_FIFO/DATA_WIDTH
add wave -noupdate /tb_ASYNC_FIFO/WCLK_PERIOD
add wave -noupdate /tb_ASYNC_FIFO/RCLK_PERIOD
add wave -noupdate /tb_ASYNC_FIFO/FIFO_DEPTH
add wave -noupdate /tb_ASYNC_FIFO/W_CLK
add wave -noupdate /tb_ASYNC_FIFO/W_RST
add wave -noupdate /tb_ASYNC_FIFO/W_INC
add wave -noupdate /tb_ASYNC_FIFO/R_CLK
add wave -noupdate /tb_ASYNC_FIFO/R_RST
add wave -noupdate /tb_ASYNC_FIFO/R_INC
add wave -noupdate /tb_ASYNC_FIFO/WR_DATA
add wave -noupdate /tb_ASYNC_FIFO/FULL
add wave -noupdate /tb_ASYNC_FIFO/EMPTY
add wave -noupdate /tb_ASYNC_FIFO/RD_DATA
add wave -noupdate /tb_ASYNC_FIFO/total_checks
add wave -noupdate /tb_ASYNC_FIFO/passed_checks
add wave -noupdate /tb_ASYNC_FIFO/failed_checks
add wave -noupdate /tb_ASYNC_FIFO/total_scenarios
add wave -noupdate /tb_ASYNC_FIFO/scenario_num
add wave -noupdate /tb_ASYNC_FIFO/scenario_start_t
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 283
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
WaveRestoreZoom {0 ps} {1611754 ps}
