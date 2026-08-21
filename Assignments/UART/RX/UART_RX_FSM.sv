module UART_RX_FSM (
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
    output reg data_valid,
    output reg soft_rst
);
    // flags needed for the operation
    wire bit_transition = edge_cnt == prescale - 1; //RX_IN will send another bit
    wire [4:0] middleCnt = prescale >> 1; // we have reached the middle of the cycles during one bit of RX_IN 
    wire data_sampled_flag = edge_cnt == middleCnt + 2; // We have sampled the bit from data_sampling block
    // Define the states 
    typedef enum logic [2:0] {
        idle  = 'b000, // waiting RX_IN to be Zero
        start = 'b001, // Checking that is Start bit
        data  = 'b011, // Getting the Data on the P_DATA Bus also assert deser_en
        parity = 'b010, // check parity bit is correct or not
        stop = 'b110, // check the stop bit is correct or not
        valid = 'b100 // check the data is frame is correct or not
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
        nextState = idle; // set the default to be idle state
        case (currentState)
            idle: 
                if (!RX_IN) begin
                    nextState = start; // ready to start getting the frame
                end
                else begin
                    nextState = idle; // no frame is being recieved
                end
            start:
                if(bit_transition && !strt_glitch) begin // the start bit recieved is correct and we will get the data bits 
                    nextState = data;
                end
                else if (!RX_IN && strt_glitch && bit_transition) begin // the start bit recieved is incorrect but there is another frame will start
                    nextState = start;
                end
                else if (RX_IN && strt_glitch && bit_transition) begin // the start bit recieved is incorrect and we will be idle again
                    nextState = idle;
                end
                else begin
                    nextState = start; // stay here until the bit is sampled and have got all edges
                end
            data:
                if (PAR_EN && (bit_cnt == 8)) begin // Collected the data and there is parity bit so go to parity state
                    nextState = parity; 
                end
                else if (!PAR_EN && (bit_cnt == 8)) begin // Collected the data and there isn't parity bit so go to stop state
                    nextState = stop;
                end
                else begin
                    nextState = data; // Collecting the data rightnow
                end
            parity:
                if (bit_transition) begin // we have checked the parity bit and will go to stop state
                    nextState = stop; 
                end
                else begin
                    nextState = parity; // Checking parity bit
                end
            stop:
                if (bit_transition) begin // Done Checking stop state and move to valid state
                    nextState = valid;
                end
                else begin
                    nextState = stop; // Checking stop state
                end
            valid:
                if (RX_IN) begin // return to idle  
                    nextState = idle; 
                end
                else if (!RX_IN) begin // return to start
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
        data_valid = (currentState == valid) && (!PAR_EN || !par_err) && (!stp_err);
    end
    always @(*) begin
        soft_rst = currentState == start;
    end
endmodule //UART_RX_FSM