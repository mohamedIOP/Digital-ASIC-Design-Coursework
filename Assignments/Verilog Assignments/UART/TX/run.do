vlib work
vlog *.*v
vsim -gui work.UART_TX_TOP_tb
# vsim -gui work.UART_TX_TOP_tb 
# Start time: 00:50:05 on Aug 06,2026
# Loading sv_std.std
# Loading work.UART_TX_TOP_tb
# Loading work.UART_TX_TOP
# Loading work.UART_TX_FSM
# Loading work.Serializer
# Loading work.Parity_Calc
# Loading work.Mux_4X1
do wave.do
run -all