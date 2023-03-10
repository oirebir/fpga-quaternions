# TCL File Generated by Component Editor 13.0sp1
# Wed Dec 21 02:42:55 BRST 2022
# DO NOT MODIFY


# 
# web_fpu "web_fpu" v2.0
#  2022.12.21.02:42:54
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module web_fpu
# 
set_module_property DESCRIPTION ""
set_module_property NAME web_fpu
set_module_property VERSION 2.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME web_fpu
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL web_interface
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file web_interface.vhd VHDL PATH vhdl/web_interface/web_interface.vhd TOP_LEVEL_FILE
add_fileset_file reg_32.vhd VHDL PATH vhdl/reg_32/reg_32.vhd
add_fileset_file addsub_28.vhd VHDL PATH fpu/addsub_28.vhd
add_fileset_file comppack.vhd VHDL PATH fpu/comppack.vhd
add_fileset_file fpu.vhd VHDL PATH fpu/fpu.vhd
add_fileset_file fpupack.vhd VHDL PATH fpu/fpupack.vhd
add_fileset_file mul_24.vhd VHDL PATH fpu/mul_24.vhd
add_fileset_file post_norm_addsub.vhd VHDL PATH fpu/post_norm_addsub.vhd
add_fileset_file post_norm_div.vhd VHDL PATH fpu/post_norm_div.vhd
add_fileset_file post_norm_mul.vhd VHDL PATH fpu/post_norm_mul.vhd
add_fileset_file post_norm_sqrt.vhd VHDL PATH fpu/post_norm_sqrt.vhd
add_fileset_file pre_norm_addsub.vhd VHDL PATH fpu/pre_norm_addsub.vhd
add_fileset_file pre_norm_div.vhd VHDL PATH fpu/pre_norm_div.vhd
add_fileset_file pre_norm_mul.vhd VHDL PATH fpu/pre_norm_mul.vhd
add_fileset_file pre_norm_sqrt.vhd VHDL PATH fpu/pre_norm_sqrt.vhd
add_fileset_file serial_div.vhd VHDL PATH fpu/serial_div.vhd
add_fileset_file serial_mul.vhd VHDL PATH fpu/serial_mul.vhd
add_fileset_file sqrt.vhd VHDL PATH fpu/sqrt.vhd

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL web_interface
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file web_interface.vhd VHDL PATH vhdl/web_interface/web_interface.vhd
add_fileset_file reg_32.vhd VHDL PATH vhdl/reg_32/reg_32.vhd
add_fileset_file addsub_28.vhd VHDL PATH fpu/addsub_28.vhd
add_fileset_file comppack.vhd VHDL PATH fpu/comppack.vhd
add_fileset_file fpu.vhd VHDL PATH fpu/fpu.vhd
add_fileset_file fpupack.vhd VHDL PATH fpu/fpupack.vhd
add_fileset_file mul_24.vhd VHDL PATH fpu/mul_24.vhd
add_fileset_file post_norm_addsub.vhd VHDL PATH fpu/post_norm_addsub.vhd
add_fileset_file post_norm_div.vhd VHDL PATH fpu/post_norm_div.vhd
add_fileset_file post_norm_mul.vhd VHDL PATH fpu/post_norm_mul.vhd
add_fileset_file post_norm_sqrt.vhd VHDL PATH fpu/post_norm_sqrt.vhd
add_fileset_file pre_norm_addsub.vhd VHDL PATH fpu/pre_norm_addsub.vhd
add_fileset_file pre_norm_div.vhd VHDL PATH fpu/pre_norm_div.vhd
add_fileset_file pre_norm_mul.vhd VHDL PATH fpu/pre_norm_mul.vhd
add_fileset_file pre_norm_sqrt.vhd VHDL PATH fpu/pre_norm_sqrt.vhd
add_fileset_file serial_div.vhd VHDL PATH fpu/serial_div.vhd
add_fileset_file serial_mul.vhd VHDL PATH fpu/serial_mul.vhd
add_fileset_file sqrt.vhd VHDL PATH fpu/sqrt.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock_sink
set_interface_property avalon_slave_0 associatedReset reset_sink
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 CS chipselect Input 1
add_interface_port avalon_slave_0 ADD address Input 4
add_interface_port avalon_slave_0 WRITEDATA writedata Input 32
add_interface_port avalon_slave_0 READDATA readdata Output 32
add_interface_port avalon_slave_0 READ_EN read Input 1
add_interface_port avalon_slave_0 WRITE_EN write Input 1
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink CLK clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink RST reset_n Input 1

