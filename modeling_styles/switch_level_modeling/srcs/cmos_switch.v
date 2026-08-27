module cmos_switch (
	input  wire d_in,
	input  wire gate_in,
	output wire d_out
);
 
 	wire not_out;

 	not_gate U0 (.d_in(gate_in), .not_out(not_out));	

	pmos U1 (d_out, d_in, not_out);
	nmos U2 (d_out, d_in, gate_in);

endmodule : cmos_switch