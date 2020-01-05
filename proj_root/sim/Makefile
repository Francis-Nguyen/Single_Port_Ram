TB_TOP  = $(PROJ_ROOT)/env

UVM_INC = +incdir+$(PROJ_ROOT)/uvm-1.2/src \
					$(PROJ_ROOT)/uvm-1.2/src/uvm.sv
VIP_INC	= +incdir+$(PROJ_ROOT)/vip_include \
					$(PROJ_ROOT)/vip_include/block_ram.sv

ENV_INC	= +incdir+$(PROJ_ROOT)/env \
					+incdir+$(PROJ_ROOT)/env/interface

RTL_INC	= +incdir+$(PROJ_ROOT)/rtl

comp:
	mkdir run_data;
	vlib work
	vlog +define+UVM_NO_DPI \
				$(UVM_INC) \
				$(VIP_INC) \
				$(ENV_INC) \
				$(RTL_INC) \
				$(TB_TOP)/tb_top.sv
sim:	comp
	vsim -c tb_top -l run_data/sim.log -do "run -all; quit"
all:	sim
clean:
	rm -rf work
	rm -rf run_data
