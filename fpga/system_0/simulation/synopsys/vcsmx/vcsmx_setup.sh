
# (C) 2001-2022 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.0sp1 232 win32 2022.12.21.19:06:55

# ----------------------------------------
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="system_0"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="C:/altera/13.0sp1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/SD_CLK/
mkdir -p ./libraries/SD_DAT/
mkdir -p ./libraries/switch_pio/
mkdir -p ./libraries/button_pio/
mkdir -p ./libraries/led_green/
mkdir -p ./libraries/led_red/
mkdir -p ./libraries/lcd_16207_0/
mkdir -p ./libraries/timer_0/
mkdir -p ./libraries/uart_0/
mkdir -p ./libraries/jtag_uart_0/
mkdir -p ./libraries/epcs_controller/
mkdir -p ./libraries/sdram_0/
mkdir -p ./libraries/altera/
mkdir -p ./libraries/lpm/
mkdir -p ./libraries/sgate/
mkdir -p ./libraries/altera_mf/
mkdir -p ./libraries/altera_lnsim/
mkdir -p ./libraries/cycloneii/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/system_0_epcs_controller_boot_rom.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"        -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"    -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"       -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"    -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd" -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"            -work altera      
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                      -work lpm         
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                     -work lpm         
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                   -work sgate       
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                        -work sgate       
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"         -work altera_mf   
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                    -work altera_mf   
  vlogan +v2k -sverilog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                  -work altera_lnsim
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"      -work altera_lnsim
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.vhd"              -work cycloneii   
  vhdlan                "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_components.vhd"         -work cycloneii   
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_SD_CLK.vhd"                                                 -work SD_CLK         
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_SD_DAT.vhd"                                                 -work SD_DAT         
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_switch_pio.vhd"                                             -work switch_pio     
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_button_pio.vhd"                                             -work button_pio     
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_led_green.vhd"                                              -work led_green      
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_led_red.vhd"                                                -work led_red        
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_lcd_16207_0.vhd"                                            -work lcd_16207_0    
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_timer_0.vhd"                                                -work timer_0        
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_uart_0.vhd"                                                 -work uart_0         
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_jtag_uart_0.vhd"                                            -work jtag_uart_0    
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_epcs_controller.vhd"                                        -work epcs_controller
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_sdram_0.vhd"                                                -work sdram_0        
  vhdlan -xlrm "$QSYS_SIMDIR/submodules/system_0_sdram_0_test_component.vhd"                                 -work sdram_0        
  vhdlan -xlrm "$QSYS_SIMDIR/system_0.vhd"                                                                                        
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_width_adapter.vhd"                                                                          
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_width_adapter_001.vhd"                                                                      
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_width_adapter_002.vhd"                                                                      
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_width_adapter_003.vhd"                                                                      
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_burst_adapter.vhd"                                                                          
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_burst_adapter_001.vhd"                                                                      
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_rst_controller.vhd"                                                                         
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_rst_controller_002.vhd"                                                                     
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_cpu_0_jtag_debug_module_translator_avalon_universal_slave_0_agent.vhd"                      
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_sdram_0_s1_translator_avalon_universal_slave_0_agent.vhd"                                   
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_cfi_flash_0_uas_translator_avalon_universal_slave_0_agent.vhd"                              
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_cpu_0_instruction_master_translator.vhd"                                                    
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_cpu_0_data_master_translator.vhd"                                                           
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_cpu_0_jtag_debug_module_translator.vhd"                                                     
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_sdram_0_s1_translator.vhd"                                                                  
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_epcs_controller_epcs_control_port_translator.vhd"                                           
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_cfi_flash_0_uas_translator.vhd"                                                             
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_sysid_qsys_0_control_slave_translator.vhd"                                                  
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_quat_0_avalon_slave_0_translator.vhd"                                                       
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_jtag_uart_0_avalon_jtag_slave_translator.vhd"                                               
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_uart_0_s1_translator.vhd"                                                                   
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_timer_0_s1_translator.vhd"                                                                  
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_lcd_16207_0_control_slave_translator.vhd"                                                   
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_led_red_s1_translator.vhd"                                                                  
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_switch_pio_s1_translator.vhd"                                                               
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_isp1362_hc_translator.vhd"                                                                  
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_audio_0_avalon_slave_0_translator.vhd"                                                      
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_vga_0_avalon_slave_0_translator.vhd"                                                        
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_seg7_display_avalon_slave_0_translator.vhd"                                                 
  vhdlan -xlrm "$QSYS_SIMDIR/system_0_sram_0_avalon_slave_0_translator.vhd"                                                       
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  vcs -lca -t ps $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $USER_DEFINED_SIM_OPTIONS
fi
