onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/CLK_PERIOD
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/CLK
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/RST
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/dataValid
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/parEn
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/parTyp
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/pData
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/txOut
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/busy
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/testCount
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/passCount
add wave -noupdate -expand -group Top_Signals /UART_TX_TOP_tb/failCount
add wave -noupdate -expand -group FSM /UART_TX_TOP_tb/dut/FSM_Block/serDone
add wave -noupdate -expand -group FSM /UART_TX_TOP_tb/dut/FSM_Block/serEn
add wave -noupdate -expand -group FSM /UART_TX_TOP_tb/dut/FSM_Block/busy
add wave -noupdate -expand -group FSM /UART_TX_TOP_tb/dut/FSM_Block/regData
add wave -noupdate -expand -group FSM /UART_TX_TOP_tb/dut/FSM_Block/muxSel
add wave -noupdate -expand -group FSM /UART_TX_TOP_tb/dut/FSM_Block/currentState
add wave -noupdate -expand -group FSM /UART_TX_TOP_tb/dut/FSM_Block/nextState
add wave -noupdate -expand -group Serializer /UART_TX_TOP_tb/dut/Serializer_Block/serEn
add wave -noupdate -expand -group Serializer /UART_TX_TOP_tb/dut/Serializer_Block/regData
add wave -noupdate -expand -group Serializer /UART_TX_TOP_tb/dut/Serializer_Block/serData
add wave -noupdate -expand -group Serializer /UART_TX_TOP_tb/dut/Serializer_Block/serDone
add wave -noupdate -expand -group Serializer /UART_TX_TOP_tb/dut/Serializer_Block/pDataReg
add wave -noupdate -expand -group Serializer /UART_TX_TOP_tb/dut/Serializer_Block/counter
add wave -noupdate -expand -group Serializer /UART_TX_TOP_tb/dut/Serializer_Block/counterMax
add wave -noupdate -expand -group Parity /UART_TX_TOP_tb/dut/Parity_Calc_Block/regData
add wave -noupdate -expand -group Parity /UART_TX_TOP_tb/dut/Parity_Calc_Block/parBit
add wave -noupdate -expand -group Parity /UART_TX_TOP_tb/dut/Parity_Calc_Block/oddCount
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {415565 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 380
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
WaveRestoreZoom {0 ps} {424200 ps}
