#!/bin/bash

quartus_cpf -c ../QUARTUS-SoC/output_files/DE1_SOC_Linux_FB.sof ./soc_system.rbf
#scp ./soc_system.rbf root@129.22.143.88:/media/root/5459-A1D61/soc_system.rbf

scp ./soc_system.rbf root@129.22.143.88:/root/bootdrive/socfpga.rbf