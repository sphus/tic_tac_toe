############################## 基础配置#############################
#退出当前仿真
# quit -sim
#清除命令和信息
.main clear

##############################编译和仿真文件#############################
# 创建库
vlib work

# 编译文件
vlog "./tb/tb_board.v"
vlog "../rtl/src/board.v"



vsim -gui -novopt work.tb_board

# Set the window types
view wave
view structure
view signals

################################添加波形#############################

#添加波形区分说明
add wave -divider {tb_board}
add wave tb_board/*

add wave -divider {board}
add wave tb_board/uut/*

################################运行仿真#############################

run 2us
# quit -sim

# vopt +acc tb_board.board -o board_opt -debugdb
# vsim -debugdb work.board
# view Schematic
