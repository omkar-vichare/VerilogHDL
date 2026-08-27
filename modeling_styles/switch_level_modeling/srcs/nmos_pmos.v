module nmos_pmos (
	input  wire d_in,
	input  wire gate_in,

	output wire nmos_out,
	output wire pmos_out
);

	nmos U0 (nmos_out, d_in, gate_in);
	pmos U1 (pmos_out, d_in, gate_in);

endmodule : nmos_pmos