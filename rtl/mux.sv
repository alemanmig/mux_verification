//=================================================
//
// Ejercicio de Verificacion de Sistemas Digitales
// Miguel Aleman
// mux.sv 
// 21/06/2024
// Descripcion: Modulo de multiplexor de 5 entradas parametrizable
//
//=================================================

module mux5 #(
    parameter WIDTH = 32
)(
    input  logic [WIDTH-1:0] in0,
    input  logic [WIDTH-1:0] in1,
    input  logic [WIDTH-1:0] in2,
    input  logic [WIDTH-1:0] in3,
    input  logic [WIDTH-1:0] in4,
    input  logic [2:0]       sel,

    output logic [WIDTH-1:0] out
);

assign out = (sel == 3'd0) ? in0 :
             (sel == 3'd1) ? in1 :
             (sel == 3'd2) ? in2 :
             (sel == 3'd3) ? in3 :
             (sel == 3'd4) ? in4 :
                             '0;

endmodule