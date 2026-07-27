module Automatic_Garage_Door_Controller (
    input UP_Max,DN_Max,
    input Activate,
    input CLK,RST,
    output UP_M,DN_M
);
    localparam [1:0] IDLE_state = 0,
                Mv_Up_state = 1,
                Mv_Dn_state = 2;
    reg [1:0] next_state,current_state;
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            current_state <= IDLE_state;
        end
        else
            current_state <= next_state;
    end
    assign UP_M = current_state == Mv_Up_state;
    assign DN_M = current_state == Mv_Dn_state;
    always @(*) begin
        next_state = IDLE_state;
        case (current_state)
            IDLE_state: 
                if (!Activate) begin
                    next_state = IDLE_state;
                end
                else if (UP_Max && !DN_Max) begin
                    next_state = Mv_Dn_state;
                end
                else if (!UP_Max && DN_Max) begin
                    next_state = Mv_Up_state;
                end
                else
                    next_state = IDLE_state;
            Mv_Up_state: 
                if (UP_Max) begin
                    next_state = IDLE_state;
                end
                else
                    next_state = Mv_Up_state;
            Mv_Dn_state: 
                if (DN_Max) begin
                    next_state = IDLE_state;
                end
                else
                    next_state = Mv_Dn_state;
        endcase
    end
endmodule //Automatic_Garage_Door_Controller