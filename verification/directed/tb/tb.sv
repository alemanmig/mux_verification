module tb;

    timeunit      1ns;
    timeprecision 100ps;

    localparam WIDTH = 32;

    //-----------------------------------------
    // Clock de verificación
    //-----------------------------------------

    logic clk;

    initial clk = 0;

    always #5 clk = ~clk;

    //-----------------------------------------
    // Interfaz
    //-----------------------------------------

    vif_if #(
        .WIDTH(WIDTH)
    ) vif (.Clk_i(clk)
    );

        //-----------------------------------------
    // Test
    //-----------------------------------------

    test #(
        .WIDTH(WIDTH)
    ) u_test (
        .vif(vif)
    );

    //-----------------------------------------
    // DUT
    //-----------------------------------------

    mux5 #(
        .WIDTH(WIDTH)
    ) dut (
        .in0(vif.in0),
        .in1(vif.in1),
        .in2(vif.in2),
        .in3(vif.in3),
        .in4(vif.in4),
        .sel(vif.sel),
        .out(vif.out)
    );

    //-----------------------------------------
    // Assertions
    //-----------------------------------------

    mux5_sva #(
        .WIDTH(WIDTH)
    ) u_mux5_sva (
        .clk(clk),
        .in0(vif.in0),
        .in1(vif.in1),
        .in2(vif.in2),
        .in3(vif.in3),
        .in4(vif.in4),
        .sel(vif.sel),
        .out(vif.out)
    );


endmodule

  
