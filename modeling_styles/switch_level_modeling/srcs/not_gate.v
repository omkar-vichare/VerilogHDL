module not_gate (
	input  wire d_in,
	output wire not_out
);
	supply1 VDD;
	supply0 VSS;
 	
	pmos U1 (not_out, VDD, d_in);
	nmos U0 (not_out, VSS, d_in);

endmodule : not_gate