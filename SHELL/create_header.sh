#!/bin/bash

sopc-create-header-files ../QUARTUS-SoC/CODE_qsys/soc_system.sopcinfo --single "./hps_soc_system.h" --module hps_0
# copy to the C folder
cp ./hps_soc_system.h "D:\GDrive\DS5_Workspace\asic_tx_de0nano_hdl2.0"
