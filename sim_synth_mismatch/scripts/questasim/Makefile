#--------------------------------------------------------------
# how to use an Makefile.
# 1. Specify FILE=<mention_file_name>
# 2. Select target, by default Makefile will choose "all".
# 3. Example:
#	 make src FILE=fixed_array_initialization 
#--------------------------------------------------------------
FILE:=

all: src sim

src: 
	vlog -work work ${FILE}.sv

sim: 
	vsim -c -work work work.${FILE}

clean: 
	rm -rf work transcript .nfs* 