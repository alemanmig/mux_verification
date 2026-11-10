module mux5_sva #(
    parameter WIDTH = 32
)(
    input logic clk,

    input logic [WIDTH-1:0] in0,
    input logic [WIDTH-1:0] in1,
    input logic [WIDTH-1:0] in2,
    input logic [WIDTH-1:0] in3,
    input logic [WIDTH-1:0] in4,

    input logic [2:0] sel,
    input logic [WIDTH-1:0] out
);

    ap_sel0:
    assert property (@(posedge clk)
        sel == 3'd0 |-> out === in0);

    ap_sel1:
    assert property (@(posedge clk)
        sel == 3'd1 |-> out === in1);

    ap_sel2:
    assert property (@(posedge clk)
        sel == 3'd2 |-> out === in2);

    ap_sel3:
    assert property (@(posedge clk)
        sel == 3'd3 |-> out === in3);

    ap_sel4:
    assert property (@(posedge clk)
        sel == 3'd4 |-> out === in4);

    ap_default:
    assert property (@(posedge clk)
        sel inside {[3'd5:3'd7]} |-> out === '0);

    ap_no_unknown:
    assert property (@(posedge clk)
        !$isunknown(out));

    cp_path0 : cover property (@(posedge clk) sel == 3'd0);
    cp_path1 : cover property (@(posedge clk) sel == 3'd1);
    cp_path2 : cover property (@(posedge clk) sel == 3'd2);
    cp_path3 : cover property (@(posedge clk) sel == 3'd3);
    cp_path4 : cover property (@(posedge clk) sel == 3'd4);
    cp_default : cover property (@(posedge clk) sel inside {[3'd5:3'd7]});

endmodule