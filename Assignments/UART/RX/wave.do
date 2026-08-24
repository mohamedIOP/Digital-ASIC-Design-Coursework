onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group FSM_States -color {Orange Red} /UART_RX_tb/DUT/UART_RX_FSM_Block/currentState
add wave -noupdate -expand -group FSM_States -color {Orange Red} /UART_RX_tb/DUT/UART_RX_FSM_Block/nextState
add wave -noupdate /UART_RX_tb/RX_IN
add wave -noupdate /UART_RX_tb/Prescale
add wave -noupdate /UART_RX_tb/PAR_EN
add wave -noupdate /UART_RX_tb/PAR_TYP
add wave -noupdate /UART_RX_tb/P_DATA
add wave -noupdate /UART_RX_tb/parity_Error
add wave -noupdate /UART_RX_tb/Stop_Error
add wave -noupdate /UART_RX_tb/CLK_PERIOD
add wave -noupdate -color Magenta /UART_RX_tb/data_valid
add wave -noupdate -color Magenta /UART_RX_tb/captured_valid
add wave -noupdate -color Magenta /UART_RX_tb/captured_parity_err
add wave -noupdate -color Magenta /UART_RX_tb/captured_stop_err
add wave -noupdate /UART_RX_tb/captured_p_data
add wave -noupdate /UART_RX_tb/total_cases
add wave -noupdate /UART_RX_tb/passed_cases
add wave -noupdate /UART_RX_tb/failed_cases
add wave -noupdate /UART_RX_tb/test_start_time
add wave -noupdate /UART_RX_tb/test_end_time
add wave -noupdate /UART_RX_tb/prescales
add wave -noupdate /UART_RX_tb/p_idx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {147425060 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 319
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
WaveRestoreZoom {2329478520 ps} {2451440491 ps}
