//--------------------------------------
//   Interfaz
//   archivo: vif_if.sv
//   Proyecto: lagarto_0
//
//--------------------------------------

interface vif_if(

    input logic Clk_i
); 

  timeunit      1ns;
  timeprecision 100ps;

  
  logic [WIDTH-1:0] in0;
  logic [WIDTH-1:0] in1;
  logic [WIDTH-1:0] in2;
  logic [WIDTH-1:0] in3;
  logic [WIDTH-1:0] in4;

  logic [2:0]       sel;
  logic [WIDTH-1:0] out;

endinterface : vif_if