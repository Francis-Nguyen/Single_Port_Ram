# Single_Port_Ram
This project to create Single Port Ram
- Build as a VIP (Verification IP)
- Build an example UVM evironment to use this VIP
- Run on Questasim

# source
Reference document:
URL:

# Simulation run
1. ./setup_proj
2. cd sim
3. make clean
4. make all TEST_NAME=bram_write_00

# View Waveform
1. Open Questasim
2. In Questasim terminal do command: 
		cd $PROJ_ROOT/sim
3. add -view vsim.wlf
