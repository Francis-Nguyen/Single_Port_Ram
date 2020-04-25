`ifndef BLOCK_RAM_DRIVER
`define BLOCK_RAM_DRIVER

  class block_ram_driver extends uvm_driver #(block_ram_sequence_item);
	  				block_ram_sequence_item 		req_item;
	  				block_ram_sequence_item 		rsp_item;
		virtual block_ram_if 								blk_ram_if;
		virtual block_ram_if 								slv_ram_if;
		bit [`DATA_WIDTH-1:0] mem [2**`ADDR_WIDTH:0];
		block_ram_configuration m_config;
		`uvm_component_utils(block_ram_driver)

		function new (string name = "block_ram_driver", uvm_component parent = null);
		  super.new(name, parent);
		endfunction: new

		function void build_phase(uvm_phase phase);
		  super.build_phase(phase);
			`uvm_info(this.get_name(), "BUILD PHASE ENTER", UVM_LOW)
			 this.req_item = block_ram_sequence_item::type_id::create("req_item", this);
			 this.rsp_item = block_ram_sequence_item::type_id::create("rsp_item", this);
			`uvm_info(this.get_name(), "BUILD PHASE EXIT", UVM_LOW)
		endfunction: build_phase

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			`uvm_info(this.get_name(), "RUN PHASE ENTER", UVM_LOW)
		   this.m_config.print();
			 fork
			  begin
			    if(this.m_config.is_master == 1'b1)
			   	 begin
			        if(!uvm_config_db#(virtual block_ram_if)::get(this, "", "master_ram_if", this.blk_ram_if))
			        begin
			     		 `uvm_error(this.get_name(), " Need configuration for master_ram_if")
			     	 end
			        fork
			          while(1) 
			         	 begin
			            this.seq_item_port.get_next_item(this.req_item);
		              this.req_item.print();
			          	this.send_to_if(this.req_item, this.rsp_item);
			            this.seq_item_port.item_done();	
			          	this.rsp_item.set_id_info(this.req_item);
			          	this.seq_item_port.put_response(this.rsp_item);
			          end
			        join_none
			   	 end
				 end
				 begin
			     if(this.m_config.is_slaver == 1'b1)
			    	 begin
			         if(!uvm_config_db#(virtual block_ram_if)::get(this, "", "slaver_ram_if", this.slv_ram_if))
			         begin
			      		 `uvm_error(this.get_name(), " Need configuration for slaver_ram_if")
			      	 end
			    	   
			    	   fork
			    		   while(1)
			    				 begin
			    				   receive_from_if();
			    				 end
			    		 join_none
			    	 end
					end
				join
			`uvm_info(this.get_name(), "RUN PHASE EXIT", UVM_LOW)
		endtask: run_phase

		task send_to_if(block_ram_sequence_item in_item, ref block_ram_sequence_item out_item);
			begin
			  if(in_item.trans_type.name() == "READ")
			  	begin
						fork
							begin
								for(int i=0; i<in_item.trans_length; i=i+1)
								begin
			  					this.blk_ram_if.bram_en 			= 1'b1;
			  					this.blk_ram_if.bram_wen			= 1'b0;
			  					this.blk_ram_if.bram_addr			= in_item.trans_addr[i];
			  					this.blk_ram_if.bram_datai		=	in_item.trans_datai[i];
			  					@(posedge this.blk_ram_if.clk);
								end
							end
							begin
			  				@(posedge this.blk_ram_if.clk);
								for(int j=0; j<in_item.trans_length; j=j+1)
								begin
			  					@(posedge this.blk_ram_if.clk);
			  					in_item.trans_datao.push_back(this.blk_ram_if.bram_datao);
								end
							end
						join
						// After complete read request, clear input signals
			  		this.blk_ram_if.bram_en 			= 1'b0;
			  		this.blk_ram_if.bram_wen 			= 1'b0;
			  		this.blk_ram_if.bram_addr 		= 'h0;
			  		this.blk_ram_if.bram_datai 		= 'h0;
			  	end
			  else
			  if(in_item.trans_type.name() == "WRITE")
			  	begin
						for(int i=0; i<in_item.trans_length; i=i+1)
							begin
			  	  		this.blk_ram_if.bram_en 		= 1'b1;
			  	  		this.blk_ram_if.bram_wen		= 1'b1;
			  	  		this.blk_ram_if.bram_addr		= in_item.trans_addr[i];
			  	  		this.blk_ram_if.bram_datai	=	in_item.trans_datai[i];
								@(posedge this.blk_ram_if.clk);
							end
						// After complete write request, clear input signals
			  	  this.blk_ram_if.bram_en			= 1'b0;
			  	  this.blk_ram_if.bram_wen		= 1'b0;
			  		this.blk_ram_if.bram_addr 	= 'h0;
			  	  this.blk_ram_if.bram_datai	=	'h0;
			  	end
					
					// transaction respond is out_item
					out_item.copy(in_item);
			end

		endtask: send_to_if

		task receive_from_if();
			begin
					fork
					  begin
				      wait(this.slv_ram_if.bram_en == 1'b1 && this.slv_ram_if.bram_wen == 1'b0);
				    	  this.slv_ram_if.bram_datao = this.mem[this.slv_ram_if.bram_addr];
				    	  @(posedge this.slv_ram_if.clk);
						end
						begin
						  wait(this.slv_ram_if.bram_en == 1'b1 && this.slv_ram_if.bram_wen == 1'b1);
							this.mem[this.slv_ram_if.bram_addr] = this.slv_ram_if.bram_datai; 
							@(posedge this.slv_ram_if.clk);
						end
					join_any
					disable fork;
			end
		endtask: receive_from_if
	endclass: block_ram_driver
`endif
