module dut(
 interface blk_ram_ms_if, interface blk_ram_slv_if
);

assign blk_ram_ms_if.DATAO  	= blk_ram_slv_if.DATAO;
//assign blk_ram_ms_if.DATAO  	= 16'h01;
assign blk_ram_slv_if.READ  	= blk_ram_ms_if.READ;
assign blk_ram_slv_if.WRITE 	= blk_ram_ms_if.WRITE;
assign blk_ram_slv_if.ADDR		=	blk_ram_ms_if.ADDR;
assign blk_ram_slv_if.DATAI		= blk_ram_ms_if.DATAI;	

initial begin
	$display("WAITING READ/WRITE COMMAND........");
end

endmodule
