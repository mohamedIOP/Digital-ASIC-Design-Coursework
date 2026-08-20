module UART_Rx_FSM (
    input RX_IN,
    input PAR_EN,par_err,
    input [5:0] prescale,
    input [4:0] edge_cnt,
    input [3:0] bit_cnt,
    input strt_glitch,stp_err,
    input CLK,RST,
    output reg par_chk_en,strt_chk_en,stp_chk_en,
    output reg deser_en,
    output reg edge_bit_cnt_enable,
    output reg dat_samp_en,
    output reg data_valid
);
    wire bit_transition = edge_cnt == prescale - 1;
    wire [4:0] middleCnt = prescale >> 1; 
    wire data_sampled_flag = edge_cnt == middleCnt + 2;
    // Define the states 
    typedef enum logic [2:0] {
        idle  = 'b000,
        start = 'b001,
        data  = 'b011,
        parity = 'b010,
        stop = 'b110,
        valid = 'b100
} state_t;
    state_t currentState,nextState;
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            currentState <= idle;
        end
        else begin
            currentState <= nextState;
        end
    end
    always @(*) begin
        nextState = idle;
        case (currentState)
            idle: 
                if (!RX_IN) begin
                    nextState = start;
                end
                else begin
                    nextState = idle;
                end
            start:
                if(bit_transition && !strt_glitch) begin
                    nextState = data;
                end
                else if (!RX_IN && strt_glitch && bit_transition) begin
                    nextState = start;
                end
                else if (RX_IN && strt_glitch && bit_transition) begin
                    nextState = idle;
                end
                else begin
                    nextState = start;
                end
            data:
                if (PAR_EN && (bit_cnt == 8)) begin
                    nextState = parity;
                end
                else if (!PAR_EN && (bit_cnt == 8)) begin
                    nextState = stop;
                end
                else begin
                    nextState = data;
                end
            parity:
                if (bit_transition) begin
                    nextState = stop;
                end
                else begin
                    nextState = parity;
                end
            stop:
                if (bit_transition) begin
                    nextState = valid;
                end
                else begin
                    nextState = stop;
                end
            valid:
                if (RX_IN) begin
                    nextState = idle;
                end
                else if (!RX_IN) begin
                    nextState = start;
                end
                else begin
                    nextState = idle;
                end
            default: nextState = idle; 
        endcase
    end
    always @(*) begin
        edge_bit_cnt_enable = (currentState != idle && currentState != valid);
        dat_samp_en = (currentState != idle && currentState != valid) && ((edge_cnt == middleCnt) || (edge_cnt == middleCnt - 1) || (edge_cnt == middleCnt + 1));
        strt_chk_en = (currentState == start) && (data_sampled_flag);
        deser_en = (currentState == data) && (data_sampled_flag);
        par_chk_en = (currentState == parity) && (data_sampled_flag);
        stp_chk_en = (currentState == stop) && (data_sampled_flag);
        data_valid = (currentState == valid) && (!par_err) && (!stp_err);
    end
endmodule //UART_Rx_FSM