module test (
    parameter WIDTH = 32;
    vif_if vif  
    );

    initial begin   
    // Initial values
    $display("Begin Of Simulation.");





    // Drain time
    #(10000ns);
    $display("End Of Simulation.");
    $finish;
    end

    // ======================= TASKS ======================== //
    // ===== Definicion o generacion de señales del test ==== //

    task automatic check_mux(
        input logic [2:0]       sel_i,
        input logic [WIDTH-1:0] exp_i
    );
    begin

        @(posedge clk);

        sel = sel_i;

        #1;

        assert(out === exp_i)
        else
            $error(
                "ERROR: sel=%0d out=%h expected=%h",
                sel_i,
                out,
                exp_i
            );

    end
    endtask

    //-----------------------------------------
    // Stimulus
    //-----------------------------------------

    initial begin

        in0 = 32'hAAAA_0000;
        in1 = 32'hBBBB_1111;
        in2 = 32'hCCCC_2222;
        in3 = 32'hDDDD_3333;
        in4 = 32'hEEEE_4444;

        sel = 0;

        check_mux(3'd0, in0);
        check_mux(3'd1, in1);
        check_mux(3'd2, in2);
        check_mux(3'd3, in3);
        check_mux(3'd4, in4);

        check_mux(3'd5, '0);
        check_mux(3'd6, '0);
        check_mux(3'd7, '0);

        repeat(2) @(posedge clk);

        $display("TEST PASSED");

        $stop;// permite que run.do continúe

    end

endmodule
  
