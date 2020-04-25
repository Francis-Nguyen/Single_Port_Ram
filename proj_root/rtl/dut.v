module blk_ram(
	clk,
	rst,
	en,
	wen,
	addr,
	datai,
	datao
);

parameter	DWIDTH	= 8;
parameter	AWIDTH	= 8;
parameter	MEMDEPTH = 256;

input									clk;
input									rst;
input									en;
input									wen;
input									addr;
input		[DWIDTH-1:0]	datai;
output	[DWIDTH-1:0]	datao;

reg			[DWIDTH-1:0]	r_data;
reg			[DWIDTH-1:0]	mem[MEM_DEPTH];


always@(posedge clk or posedge rst)
	begin
		if(rst==1'b1)
			r_data <= 'h0;
		else
		begin
			if(en == 1'b1)
				begin
					if(wen == 1'b1)
						mem[addr] <= datai;
					else
						r_data		<= mem[addr];
				end
			else
						r_data		<= 'h0;
		end
	end

assign datao = r_data;

endmodule
