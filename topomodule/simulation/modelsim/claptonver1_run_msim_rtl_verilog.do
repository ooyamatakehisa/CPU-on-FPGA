transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/claptonver1 {/export/home/016/a0163072/CPU/git/claptonver1/claptonver1.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/controller {/export/home/016/a0163072/CPU/git/controller/flopenableEX.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/claptonver1 {/export/home/016/a0163072/CPU/git/claptonver1/switch.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/claptonver1 {/export/home/016/a0163072/CPU/git/claptonver1/chat.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/processor.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/controller {/export/home/016/a0163072/CPU/git/controller/controller.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/controller {/export/home/016/a0163072/CPU/git/controller/maindec.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/controller {/export/home/016/a0163072/CPU/git/controller/aludec.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/flopenablepc.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/adder.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/claptonver1 {/export/home/016/a0163072/CPU/git/claptonver1/mux2.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/flopenable.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/regfile.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/signext.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/mux3.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/ALU.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/claptonver1 {/export/home/016/a0163072/CPU/git/claptonver1/flopr.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/pcbranch.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/hazard.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git {/export/home/016/a0163072/CPU/git/IM.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git {/export/home/016/a0163072/CPU/git/DM.v}

vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/claptonver1/simulation/modelsim {/export/home/016/a0163072/CPU/git/claptonver1/simulation/modelsim/claptonver1_test1.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  claptonver1_vlg_tst

add wave *
view structure
view signals
run -all
