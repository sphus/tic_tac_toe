############################## 基础配置#############################
#退出当前仿真
quit -sim
#清除命令和信息
.main clear

##############################编译和仿真文件#############################
# 创建库
vlib work

# 编译文件
# vlog "../rtl/inc/array.v"
vlog "./tb/tb_array.v"



vsim -gui -novopt work.tb_array

# Set the window types
view wave
view structure
view signals

################################添加波形#############################


#添加波形区分说明
add wave -divider {tb_array}

add wave tb_array/*

################################运行仿真#############################

run 5us
# quit -sim


