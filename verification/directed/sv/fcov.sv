module mux5_cov #(
    parameter WIDTH = 32
)(
    input logic              clk,

    input logic [WIDTH-1:0]  in0,
    input logic [WIDTH-1:0]  in1,
    input logic [WIDTH-1:0]  in2,
    input logic [WIDTH-1:0]  in3,
    input logic [WIDTH-1:0]  in4,

    input logic [WIDTH-1:0]  out,
    input logic [2:0]        sel
);

    covergroup mux5_cg @(posedge clk);
 
        cp_sel : coverpoint sel {
            bins sel0 = {0};
            bins sel1 = {1};
            bins sel2 = {2};
            bins sel3 = {3};
            bins sel4 = {4};
            bins def  = {[5:7]};
        }

        cp_out_zero : coverpoint (out == '0) {
            bins zero     = {1};
            bins non_zero = {0};
        }

        sel_x_out : cross cp_sel, cp_out_zero;

    endgroup

    mux5_cg cg = new();

endmodule