############################## 基础配置#############################
#退出当前仿真
# quit -sim
#清除命令和信息
.main clear

##############################编译和仿真文件#############################
# 创建库
vlib work

# 编译文件
# vlog "../rtl/inc/array.v"
vlog "./tb/tb_tic_tac_toe.v"
vlog "../rtl/src/tic_tac_toe.v"



vsim -gui -novopt work.tb_tic_tac_toe

# Set the window types
view wave
view structure
view signals

################################添加波形#############################


#添加波形区分说明
add wave -divider {tb_tic_tac_toe}
add wave tb_tic_tac_toe/*

add wave -divider {tic_tac_toe}
add wave tb_tic_tac_toe/uut/*
# add wave VGA_read/u_Matrix_Generate/*


################################运行仿真#############################

run 2us
# quit -sim


# vopt +acc tb_tic_tac_toe.tic_tac_toe -o tic_tac_toe_opt -debugdb
# vsim -debugdb work.tic_tac_toe
# view Schematic
