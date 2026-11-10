module test #(
    parameter int WIDTH = 32
)(
    vif_if vif
);

    timeunit      1ns;
    timeprecision 100ps;

    // ======================= TASKS ======================== //
    // ===== Definicion o generacion de señales del test ==== //

    task automatic check_mux(
        input logic [2:0]       sel_i,
        input logic [WIDTH-1:0] exp_i
    );
    begin

        @(posedge vif.Clk_i);

        vif.sel = sel_i;

        #1;

        assert(vif.out === exp_i)
        else
            $error(
                "ERROR: sel=%0d out=%h expected=%h",
                sel_i,
                vif.out,
                exp_i
            );

    end
    endtask

    //-----------------------------------------
    // Stimulus
    //-----------------------------------------

    initial begin

        $display("Begin Of Simulation.");

        vif.in0 = WIDTH'(32'hAAAA_0000);
        vif.in1 = WIDTH'(32'hBBBB_1111);
        vif.in2 = WIDTH'(32'hCCCC_2222);
        vif.in3 = WIDTH'(32'hDDDD_3333);
        vif.in4 = WIDTH'(32'hEEEE_4444);

        vif.sel = 0;

        check_mux(3'd0, vif.in0);
        check_mux(3'd1, vif.in1);
        check_mux(3'd2, vif.in2);
        check_mux(3'd3, vif.in3);
        check_mux(3'd4, vif.in4);

        check_mux(3'd5, '0);
        check_mux(3'd6, '0);
        check_mux(3'd7, '0);

        repeat(2) @(posedge vif.Clk_i);

        $display("End Of Simulation.");

        $finish;

    end

endmodule
