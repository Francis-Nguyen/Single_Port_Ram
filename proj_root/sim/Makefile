TB_TOP  = $(PROJ_ROOT)/env

UVM_INC = +incdir+$(PROJ_ROOT)/uvm-1.2/src \
					$(PROJ_ROOT)/uvm-1.2/src/uvm.sv
VIP_INC	= +incdir+$(PROJ_ROOT)/vip_include \
					$(PROJ_ROOT)/vip_include/block_ram.sv

ENV_INC	= +incdir+$(PROJ_ROOT)/env \
					+incdir+$(PROJ_ROOT)/env/interface \
					+incdir+$(PROJ_ROOT)/env/lib

RTL_INC	= +incdir+$(PROJ_ROOT)/rtl

SVA_INC = -f $(PROJ_ROOT)/sva/sva_list.f

COV_INC = -f $(PROJ_ROOT)/cov/cov_list.f

comp:
	mkdir run_data;
	vlib work
	vlog +define+UVM_NO_DPI \
				$(UVM_INC) \
				$(VIP_INC) \
				$(ENV_INC) \
				$(RTL_INC) \
				$(SVA_INC) \
				$(COV_INC) \
				$(TB_TOP)/tb_top.sv
sim:	comp
	vsim -c tb_top -l run_data/sim.log -do "run -all; quit"
all:	sim
clean:
	rm -rf work
	rm -rf run_data
