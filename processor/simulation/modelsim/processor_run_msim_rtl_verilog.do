transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/processor.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/flopenable.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/pcbranch.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/datapath {/export/home/016/a0163072/CPU/git/datapath/mux3.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/controller {/export/home/016/a0163072/CPU/git/controller/controller.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/controller {/export/home/016/a0163072/CPU/git/controller/maindec.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/controller {/export/home/016/a0163072/CPU/git/controller/aludec.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/adder.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/mux2.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/regfile.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/signext.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/flopr.v}
vlog -vlog01compat -work work +incdir+/export/home/016/a0163072/CPU/git/processor {/export/home/016/a0163072/CPU/git/processor/ALU.v}

