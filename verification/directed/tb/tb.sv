module tb;

    localparam WIDTH = 32;

    //-----------------------------------------
    // Señales
    //-----------------------------------------

    logic clk;

    logic [WIDTH-1:0] in0;
    logic [WIDTH-1:0] in1;
    logic [WIDTH-1:0] in2;
    logic [WIDTH-1:0] in3;
    logic [WIDTH-1:0] in4;

    logic [2:0]       sel;
    logic [WIDTH-1:0] out;

    logic [WIDTH-1:0] expected;

    //-----------------------------------------
    // Clock de verificación
    //-----------------------------------------

    initial clk = 0;

    always #5 clk = ~clk;

    //-----------------------------------------
    // DUT
    //-----------------------------------------

    mux5 #(
        .WIDTH(WIDTH)
    ) dut (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .sel(sel),
        .out(out)
    );

    //-----------------------------------------
    // Assertions
    //-----------------------------------------

    mux5_sva #(
        .WIDTH(WIDTH)
    ) u_mux5_sva (
        .clk(clk),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .sel(sel),
        .out(out)
    );

    //-----------------------------------------
    // Functional Coverage
    //-----------------------------------------

    mux5_cov u_mux5_cov (
        .clk(clk),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .sel(sel),
        .out(out)
    );

    //-----------------------------------------
    // Task de comprobación
    //-----------------------------------------

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
  
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars;

    end

endmodule
  
