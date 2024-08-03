	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/And.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/C1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/C2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataPath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DoneCheck.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/fullAdder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Memory.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/multiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux2to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux4to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUx16to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Not.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Or.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Reg.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/RELU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/S1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/S2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/SingleOr.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/TopLevel.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Xor.v
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	