// THIS IS ONLY FOR DE0-NANO-SoC PROJECT
`define ENABLE_HPS

module DE1_SOC_Linux_FB(
	// ADC
	output             ADC_CONVST,
	output             ADC_SCK,
	output             ADC_SDI,
	input              ADC_SDO,
	
	// ARDUINO
	inout       [15:0] ARDUINO_IO,
	inout              ARDUINO_RESET_N,
	
	// CLK
	output			CLK_I2C_SCL,
	inout			CLK_I2C_SDA,
	// output			FPGA_I2C_SCLK,
	// inout			FPGA_I2C_SDAT,
	
	/* AUD
	input			AUD_ADCDAT,
	inout			AUD_ADCLRCK,
	inout			AUD_BCLK,
	output			AUD_DACDAT,
	inout			AUD_DACLRCK,
	output			AUD_XCK,
	*/
	
	// CLOCKS
	input			FPGA_CLK1_50,
	input			FPGA_CLK2_50,
	input			FPGA_CLK3_50,
	// input			CLOCK4_50,
	
	/* DRAM
	output	[12:0]	DRAM_ADDR,
	output	[1:0]	DRAM_BA,
	output			DRAM_CAS_N,
	output			DRAM_CKE,
	output			DRAM_CLK,
	output			DRAM_CS_N,
	inout	[15:0]	DRAM_DQ,
	output			DRAM_LDQM,
	output			DRAM_RAS_N,
	output			DRAM_UDQM,
	output			DRAM_WE_N,
	*/
	
	/* FAN
	output			FAN_CTRL,
	*/
	


	// GPIO
	inout	[35:0]	GPIO_0,
	inout	[35:0]	GPIO_1,
 

	/* HEX
	output	[6:0]	HEX0,
	output	[6:0]	HEX1,
	output	[6:0]	HEX2,
	output	[6:0]	HEX3,
	output	[6:0]	HEX4,
	output	[6:0]	HEX5,
	*/
	
`ifdef ENABLE_HPS
	// HPS
	inout			HPS_CONV_USB_N,
	output	[14:0]	HPS_DDR3_ADDR,
	output	[2:0]	HPS_DDR3_BA,
	output			HPS_DDR3_CAS_N,
	output			HPS_DDR3_CKE,
	output			HPS_DDR3_CK_N,
	output			HPS_DDR3_CK_P,
	output			HPS_DDR3_CS_N,
	output	[3:0]	HPS_DDR3_DM,
	inout	[31:0]	HPS_DDR3_DQ,
	inout	[3:0]	HPS_DDR3_DQS_N,
	inout	[3:0]	HPS_DDR3_DQS_P,
	output			HPS_DDR3_ODT,
	output			HPS_DDR3_RAS_N,
	output			HPS_DDR3_RESET_N,
	input			HPS_DDR3_RZQ,
	output			HPS_DDR3_WE_N,
	output			HPS_ENET_GTX_CLK,
	inout			HPS_ENET_INT_N,
	output			HPS_ENET_MDC,
	inout			HPS_ENET_MDIO,
	input			HPS_ENET_RX_CLK,
	input	[3:0]	HPS_ENET_RX_DATA,
	input			HPS_ENET_RX_DV,
	output	[3:0]	HPS_ENET_TX_DATA,
	output			HPS_ENET_TX_EN,
	inout	[3:0]	HPS_FLASH_DATA,
	output			HPS_FLASH_DCLK,
	output			HPS_FLASH_NCSO,
	inout			HPS_GSENSOR_INT,
	inout			HPS_I2C0_SCLK,
	inout			HPS_I2C0_SDAT,
	inout			HPS_I2C1_SCLK,
	inout			HPS_I2C1_SDAT,
	// inout			HPS_I2C2_SCLK,
	// inout			HPS_I2C2_SDAT,
	inout			HPS_I2C_CONTROL,
	inout			HPS_KEY,
	inout			HPS_LED,
	inout			HPS_LTC_GPIO,
	output			HPS_SD_CLK,
	inout			HPS_SD_CMD,
	inout	[3:0]	HPS_SD_DATA,
	output			HPS_SPIM_CLK,
	input			HPS_SPIM_MISO,
	output			HPS_SPIM_MOSI,
	inout			HPS_SPIM_SS,
	input			HPS_UART_RX,
	output			HPS_UART_TX,
	input			HPS_USB_CLKOUT,
	inout	[7:0]	HPS_USB_DATA,
	input			HPS_USB_DIR,
	input			HPS_USB_NXT,
	output			HPS_USB_STP,
`endif /*ENABLE_HPS*/

	/* IRDA
	input			IRDA_RXD,
	output			IRDA_TXD,
	*/
	
	// KEY
	input	[1:0]	KEY,

	// LEDR
	output	[7:0]	LED,

	/* PS2
	inout			PS2_CLK,
	inout			PS2_CLK2,
	inout			PS2_DAT,
	inout			PS2_DAT2,
	*/
	
	// SW
	input	[3:0]	SW

	/* TD
	input			TD_CLK27,
	input	[7:0]	TD_DATA,
	input			TD_HS,
	output			TD_RESET_N,
	input			TD_VS,
	*/
	
	/* VGA
	output	[7:0]	VGA_B,
	output			VGA_BLANK_N,
	output			VGA_CLK,
	output	[7:0]	VGA_G,
	output			VGA_HS,
	output	[7:0]	VGA_R,
	output			VGA_SYNC_N,
	output			VGA_VS
	*/
	
);

	localparam PULSE_AND_DELAY_WIDTH = 32;
	localparam ECHOES_PER_SCAN_WIDTH = 32;
	localparam ADC_INIT_DELAY_WIDTH = 32;
	localparam SAMPLES_PER_ECHO_WIDTH = 32;
	localparam NMR_MAIN_TIMER_WIDTH = 32;
	localparam ADC_DATA_WIDTH = 16;
	localparam ADC_PHYS_WIDTH = 14; // ADC physical data width
	localparam ADC_LATENCY = 5;
	

//=======================================================
// REG/WIRE declarations
//=======================================================

	// control output signal
	wire			nmr_clk_gate_avln_cnt;	// nmr clock gate controlled by the avalon bus
	wire			activate_adc_avln_cnt;	// adc control signal to be activated from the avalon memory map bus / hard processor
	wire			adc_fifo_reset;
	wire			fsm_start;
	wire			phase_cycle;
	wire			enable_adc;
	wire			enable_rx;
	wire			enable_rx_dly;
	wire			dac_preamp_LDAC_n;
	wire			dac_preamp_CLR_n;

	// control input signal
	wire			pll_nmr_sys_locked;
	wire			pll_analyzer_locked;
	wire			fsmstat;

	// clock
	wire			pulseprog_clk;
	wire			adc_clk;
	wire			pll_analyzer_clk0;
	wire			pll_analyzer_clk1;
	wire			pll_analyzer_clk2;
	wire			pll_analyzer_clk3;
	
	
	// reset signals
	wire			pll_nmr_sys_reset;
	wire			pll_analyzer_reset;
	wire			nmr_controller_reset;
	
	// parameters
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_90deg;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_180deg;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		delay_nosig;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		delay_sig;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_t1;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		delay_t1;
	wire	[SAMPLES_PER_ECHO_WIDTH-1:0]	samples_per_echo;
	wire	[ECHOES_PER_SCAN_WIDTH-1:0]		echoes_per_scan;
	wire	[ADC_INIT_DELAY_WIDTH-1:0]		init_delay;

	// adc data
	wire	[ADC_DATA_WIDTH-1:0]			adc_data_in;
	wire	[ADC_DATA_WIDTH-1:0]			adc_data_out;
	
	wire									adc_data_valid;
	wire									nmr_rfout_p;
	wire									nmr_rfout_n;
	wire									en_pa;

	// VGA control
	wire		clk_65;
	wire [7:0]	vid_r,vid_g,vid_b;
	wire		vid_v_sync ;
	wire		vid_h_sync ;
	wire		vid_datavalid;
	wire		pll_vga_locked;
	
	// DAC preamp
	wire dac_preamp_MISO;
    wire dac_preamp_MOSI;
    wire dac_preamp_SCLK;
    wire dac_preamp_SS_n;
 
//=======================================================
// Structural coding
//=======================================================
	
	/*
	assign   VGA_BLANK_N          =     1'b1;
	assign   VGA_SYNC_N           =     1'b0;	
	assign   VGA_CLK              =     clk_65;
	assign  {VGA_B,VGA_G,VGA_R}   =     {vid_b,vid_g,vid_r};
	assign   VGA_VS               =     vid_v_sync;
	assign   VGA_HS               =     vid_h_sync;
	*/
	
	soc_system u0 (
		.clk_clk			(FPGA_CLK1_50),	// clk.clk
		.reset_reset_n		(1'b1),		// reset.reset_n

		// HPS ddr3
		.memory_mem_a		(HPS_DDR3_ADDR),	// memory.mem_a
		.memory_mem_ba		(HPS_DDR3_BA),		// .mem_ba
		.memory_mem_ck		(HPS_DDR3_CK_P),	// .mem_ck
		.memory_mem_ck_n	(HPS_DDR3_CK_N),	// .mem_ck_n
		.memory_mem_cke		(HPS_DDR3_CKE),		// .mem_cke
		.memory_mem_cs_n	(HPS_DDR3_CS_N),	// .mem_cs_n
		.memory_mem_ras_n	(HPS_DDR3_RAS_N),	// .mem_ras_n
		.memory_mem_cas_n	(HPS_DDR3_CAS_N),	// .mem_cas_n
		.memory_mem_we_n	(HPS_DDR3_WE_N),	// .mem_we_n
		.memory_mem_reset_n	(HPS_DDR3_RESET_N),	// .mem_reset_n
		.memory_mem_dq		(HPS_DDR3_DQ),		// .mem_dq
		.memory_mem_dqs		(HPS_DDR3_DQS_P),	// .mem_dqs
		.memory_mem_dqs_n	(HPS_DDR3_DQS_N),	// .mem_dqs_n
		.memory_mem_odt		(HPS_DDR3_ODT),		// .mem_odt
		.memory_mem_dm		(HPS_DDR3_DM),		// .mem_dm
		.memory_oct_rzqin	(HPS_DDR3_RZQ),		// .oct_rzqin

		// HPS ethernet
		.hps_0_hps_io_hps_io_emac1_inst_TX_CLK	(HPS_ENET_GTX_CLK),		// .hps_0_hps_io.hps_io_emac1_inst_TX_CLK
		.hps_0_hps_io_hps_io_emac1_inst_TXD0	(HPS_ENET_TX_DATA[0]),	// .hps_io_emac1_inst_TXD0
		.hps_0_hps_io_hps_io_emac1_inst_TXD1	(HPS_ENET_TX_DATA[1]),	// .hps_io_emac1_inst_TXD1
		.hps_0_hps_io_hps_io_emac1_inst_TXD2	(HPS_ENET_TX_DATA[2]),	// .hps_io_emac1_inst_TXD2
		.hps_0_hps_io_hps_io_emac1_inst_TXD3	(HPS_ENET_TX_DATA[3]),	// .hps_io_emac1_inst_TXD3
		.hps_0_hps_io_hps_io_emac1_inst_RXD0	(HPS_ENET_RX_DATA[0]),	// .hps_io_emac1_inst_RXD0
		.hps_0_hps_io_hps_io_emac1_inst_MDIO	(HPS_ENET_MDIO),		// .hps_io_emac1_inst_MDIO
		.hps_0_hps_io_hps_io_emac1_inst_MDC		(HPS_ENET_MDC),			// .hps_io_emac1_inst_MDC
		.hps_0_hps_io_hps_io_emac1_inst_RX_CTL	(HPS_ENET_RX_DV),		// .hps_io_emac1_inst_RX_CTL
		.hps_0_hps_io_hps_io_emac1_inst_TX_CTL	(HPS_ENET_TX_EN),		// .hps_io_emac1_inst_TX_CTL
		.hps_0_hps_io_hps_io_emac1_inst_RX_CLK	(HPS_ENET_RX_CLK),		// .hps_io_emac1_inst_RX_CLK
		.hps_0_hps_io_hps_io_emac1_inst_RXD1	(HPS_ENET_RX_DATA[1]),	// .hps_io_emac1_inst_RXD1
		.hps_0_hps_io_hps_io_emac1_inst_RXD2	(HPS_ENET_RX_DATA[2]),	// .hps_io_emac1_inst_RXD2
		.hps_0_hps_io_hps_io_emac1_inst_RXD3	(HPS_ENET_RX_DATA[3]),	// .hps_io_emac1_inst_RXD3

		// HPS QSPI
		//.hps_0_hps_io_hps_io_qspi_inst_IO0	(HPS_FLASH_DATA[0]),	// .hps_io_qspi_inst_IO0
		//.hps_0_hps_io_hps_io_qspi_inst_IO1	(HPS_FLASH_DATA[1]),	// .hps_io_qspi_inst_IO1
		//.hps_0_hps_io_hps_io_qspi_inst_IO2	(HPS_FLASH_DATA[2]),	// .hps_io_qspi_inst_IO2
		//.hps_0_hps_io_hps_io_qspi_inst_IO3	(HPS_FLASH_DATA[3]),	// .hps_io_qspi_inst_IO3
		//.hps_0_hps_io_hps_io_qspi_inst_SS0	(HPS_FLASH_NCSO),		// .hps_io_qspi_inst_SS0
		//.hps_0_hps_io_hps_io_qspi_inst_CLK	(HPS_FLASH_DCLK),		// .hps_io_qspi_inst_CLK
		
		
		// HPS SD card
		.hps_0_hps_io_hps_io_sdio_inst_CMD	(HPS_SD_CMD),		// .hps_io_sdio_inst_CMD
		.hps_0_hps_io_hps_io_sdio_inst_D0	(HPS_SD_DATA[0]),	// .hps_io_sdio_inst_D0
		.hps_0_hps_io_hps_io_sdio_inst_D1	(HPS_SD_DATA[1]),	// .hps_io_sdio_inst_D1
		.hps_0_hps_io_hps_io_sdio_inst_CLK	(HPS_SD_CLK),		// .hps_io_sdio_inst_CLK
		.hps_0_hps_io_hps_io_sdio_inst_D2	(HPS_SD_DATA[2]),	// .hps_io_sdio_inst_D2
		.hps_0_hps_io_hps_io_sdio_inst_D3	(HPS_SD_DATA[3]),	// .hps_io_sdio_inst_D3

		// HPS USB
		.hps_0_hps_io_hps_io_usb1_inst_D0	(HPS_USB_DATA[0]),	// .hps_io_usb1_inst_D0
		.hps_0_hps_io_hps_io_usb1_inst_D1	(HPS_USB_DATA[1]),	// .hps_io_usb1_inst_D1
		.hps_0_hps_io_hps_io_usb1_inst_D2	(HPS_USB_DATA[2]),	// .hps_io_usb1_inst_D2
		.hps_0_hps_io_hps_io_usb1_inst_D3	(HPS_USB_DATA[3]),	// .hps_io_usb1_inst_D3
		.hps_0_hps_io_hps_io_usb1_inst_D4	(HPS_USB_DATA[4]),	// .hps_io_usb1_inst_D4
		.hps_0_hps_io_hps_io_usb1_inst_D5	(HPS_USB_DATA[5]),	// .hps_io_usb1_inst_D5
		.hps_0_hps_io_hps_io_usb1_inst_D6	(HPS_USB_DATA[6]),	// .hps_io_usb1_inst_D6
		.hps_0_hps_io_hps_io_usb1_inst_D7	(HPS_USB_DATA[7]),	// .hps_io_usb1_inst_D7
		.hps_0_hps_io_hps_io_usb1_inst_CLK	(HPS_USB_CLKOUT),	// .hps_io_usb1_inst_CLK
		.hps_0_hps_io_hps_io_usb1_inst_STP	(HPS_USB_STP),		// .hps_io_usb1_inst_STP
		.hps_0_hps_io_hps_io_usb1_inst_DIR	(HPS_USB_DIR),		// .hps_io_usb1_inst_DIR
		.hps_0_hps_io_hps_io_usb1_inst_NXT	(HPS_USB_NXT),		// .hps_io_usb1_inst_NXT

		// HPS SPI
		.hps_0_hps_io_hps_io_spim1_inst_CLK		(HPS_SPIM_CLK),		// .hps_io_spim1_inst_CLK
		.hps_0_hps_io_hps_io_spim1_inst_MOSI	(HPS_SPIM_MOSI),	// .hps_io_spim1_inst_MOSI
		.hps_0_hps_io_hps_io_spim1_inst_MISO	(HPS_SPIM_MISO),	// .hps_io_spim1_inst_MISO
		.hps_0_hps_io_hps_io_spim1_inst_SS0		(HPS_SPIM_SS),		// .hps_io_spim1_inst_SS0

		// HPS UART
		.hps_0_hps_io_hps_io_uart0_inst_RX	(HPS_UART_RX),	// .hps_io_uart0_inst_RX
		.hps_0_hps_io_hps_io_uart0_inst_TX	(HPS_UART_TX),	// .hps_io_uart0_inst_TX

		// HPS I2C0
		.hps_0_hps_io_hps_io_i2c0_inst_SDA	(HPS_I2C0_SDAT),	// .hps_io_i2c0_inst_SDA
		.hps_0_hps_io_hps_io_i2c0_inst_SCL	(HPS_I2C0_SCLK),	// .hps_io_i2c0_inst_SCL

		// HPS I2C1
		.hps_0_hps_io_hps_io_i2c1_inst_SDA	(HPS_I2C1_SDAT),	// .hps_io_i2c1_inst_SDA
		.hps_0_hps_io_hps_io_i2c1_inst_SCL	(HPS_I2C1_SCLK),	// .hps_io_i2c1_inst_SCL

		// HPS GPIO
		.hps_0_hps_io_hps_io_gpio_inst_GPIO09	(HPS_CONV_USB_N),	// .hps_io_gpio_inst_GPIO09
		.hps_0_hps_io_hps_io_gpio_inst_GPIO35	(HPS_ENET_INT_N),	// .hps_io_gpio_inst_GPIO35
		.hps_0_hps_io_hps_io_gpio_inst_GPIO40	(HPS_LTC_GPIO),		// .hps_io_gpio_inst_GPIO40

		//.hps_0_hps_io_hps_io_gpio_inst_GPIO41	(HPS_GPIO[1]),		// .hps_io_gpio_inst_GPIO41
		.hps_0_hps_io_hps_io_gpio_inst_GPIO48	(HPS_I2C_CONTROL),	// .hps_io_gpio_inst_GPIO48
		.hps_0_hps_io_hps_io_gpio_inst_GPIO53	(HPS_LED),			// .hps_io_gpio_inst_GPIO53
		.hps_0_hps_io_hps_io_gpio_inst_GPIO54	(HPS_KEY),			// .hps_io_gpio_inst_GPIO54
		.hps_0_hps_io_hps_io_gpio_inst_GPIO61	(HPS_GSENSOR_INT),	// .hps_io_gpio_inst_GPIO61

		// hps reset
		.hps_0_h2f_reset_reset_n	(),			// hps_0_h2f_reset.reset_n

		// Parameters
		.samples_per_echo_export	(samples_per_echo),
		.echoes_per_scan_export		(echoes_per_scan),
		.delay_nosig_export			(delay_nosig),
		.delay_sig_export			(delay_sig),
		.pulse_180deg_export		(pulse_180deg),
		.pulse_90deg_export			(pulse_90deg),
		.init_delay_export			(init_delay),
		.rx_delay_export			(rx_delay),
		.pulse_t1_export			(pulse_t1),
        .delay_t1_export			(delay_t1),

		// Control Signals from/to HPS
		.ctrl_in_export ({
			pll_analyzer_locked,
			fsmstat,				// NMR sequence status (1 if the fsm is running and 0 if the fsm is stopped)
			pll_nmr_sys_locked		// PLL lock status for the NMR pulse programmer
		}),
		.ctrl_out_export({
			en_pa,
			nmr_controller_reset,
			pll_analyzer_reset,		// analyzer_pll_reset
			pll_nmr_sys_reset,		// nmr_system_pll reset for the FSM main controller clock
			activate_adc_avln_cnt,	// NOT IMPLEMENTED AT THIS POINT, BUT THE PURPOSE WAS: adc start control signal to be activated from the avalon memory map bus / hard processor
			nmr_clk_gate_avln_cnt,	// clock gate control signal to switch clock between main controller output and characterization clock output
			adc_fifo_reset,			// reset adc fifo control signal
			fsm_start,				// fsm start control signal
			phase_cycle,			// phase cycling control. 1 for 90 degrees and 0 for 270 degrees
			dac_preamp_LDAC_n,		// dac_ldac -> active low
			dac_preamp_CLR_n		// dac clear -> active low
		}),
		
		// I2C onboard
		.i2c_int_sda_in                            (i2c_int_sda_in),                            //                     i2c_int.sda_in
        .i2c_int_scl_in                            (i2c_int_scl_in),                            //                            .scl_in
        .i2c_int_sda_oe                            (i2c_int_sda_oe),                            //                            .sda_oe
        .i2c_int_scl_oe                            (i2c_int_scl_oe),                            //                            .scl_oe
        
		// I2C offboard
		.i2c_ext_sda_in                            (i2c_ext_sda_in),                            //                     i2c_ext.sda_in
        .i2c_ext_scl_in                            (i2c_ext_scl_in),                            //                            .scl_in
        .i2c_ext_sda_oe                            (i2c_ext_sda_oe),                            //                            .sda_oe
        .i2c_ext_scl_oe                            (i2c_ext_scl_oe),                            //                            .scl_oe
        
		// Dedicated SPI for DAC
		.dac_preamp_MISO                           (dac_preamp_MISO),                           //                  dac_preamp.MISO
        .dac_preamp_MOSI                           (dac_preamp_MOSI),                           //                            .MOSI
        .dac_preamp_SCLK                           (dac_preamp_SCLK),                           //                            .SCLK
        .dac_preamp_SS_n                           (dac_preamp_SS_n),
		
		// FIFO
		.adc_fifo_in_data			(adc_data_out),
		.adc_fifo_in_valid			(adc_data_valid),
		.adc_fifo_in_ready			(),
		.fifo_clk_bridge_in_clk		(adc_clk),
		.fifo_rst_reset				(adc_fifo_reset),
		
		// NMR system clock
		.nmr_sys_pll_outclk_clk   	(pulseprog_clk),
        .nmr_sys_pll_locked_export	(pll_nmr_sys_locked),
		.nmr_sys_pll_reset_reset	(pll_nmr_sys_reset),
		
		/* Analyzer PLL for performance characterization
		.analyzer_pll_reset_reset	(pll_analyzer_reset), 
        .analyzer_pll_locked_export	(pll_analyzer_locked),
		.analyzer_pll_outclk0_clk	(pll_analyzer_clk0),
		.analyzer_pll_outclk1_clk	(pll_analyzer_clk1),
		.analyzer_pll_outclk2_clk	(pll_analyzer_clk2),
		.analyzer_pll_outclk3_clk	(pll_analyzer_clk3),
		*/
		
		/* VGA PLL
		.pll_vga_clk65_clk			(clk_65),
        .pll_vga_locked_export		(pll_vga_locked),
		
		//itc
		.alt_vip_itc_0_clocked_video_vid_clk         (~clk_65),         					 	 // alt_vip_itc_0_clocked_video.vid_clk
        .alt_vip_itc_0_clocked_video_vid_data        ({vid_r,vid_g,vid_b}),        		 //                .vid_data
        .alt_vip_itc_0_clocked_video_underflow       (),                           		 //                .underflow
        .alt_vip_itc_0_clocked_video_vid_datavalid   (vid_datavalid),                   //                .vid_datavalid
        .alt_vip_itc_0_clocked_video_vid_v_sync      (vid_v_sync),      					 //                .vid_v_sync
        .alt_vip_itc_0_clocked_video_vid_h_sync      (vid_h_sync),      					 //                .vid_h_sync
        .alt_vip_itc_0_clocked_video_vid_f           (),           							 //                .vid_f
        .alt_vip_itc_0_clocked_video_vid_h           (),           							 //                .vid_h
        .alt_vip_itc_0_clocked_video_vid_v           (),
		*/
		
		/* SDRAM
		.sdram_clk_clk		(DRAM_CLK),                  //    
	    .sdram_wire_addr	(DRAM_ADDR),                //              sdram_wire.addr
		.sdram_wire_ba		(DRAM_BA),                  //                        .ba
		.sdram_wire_cas_n	(DRAM_CAS_N),               //                        .cas_n
		.sdram_wire_cke		(DRAM_CKE),                 //                        .cke
		.sdram_wire_cs_n	(DRAM_CS_N),                //                        .cs_n
		.sdram_wire_dq		(DRAM_DQ),                  //                        .dq
		.sdram_wire_dqm		({DRAM_UDQM,DRAM_LDQM}),                 //                        .dqm
		.sdram_wire_ras_n	(DRAM_RAS_N),               //                        .ras_n
		.sdram_wire_we_n	(DRAM_WE_N),                 //                              // 
		*/
		
		.switches_export	()                            //                    switches.export
	);
	
	
	
	// Clock Domain Crossing!!!
	reg	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_90deg_reg;
	reg	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_180deg_reg;
	reg	[PULSE_AND_DELAY_WIDTH-1:0]		delay_nosig_reg;
	reg	[PULSE_AND_DELAY_WIDTH-1:0]		delay_sig_reg;
	reg	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_t1_reg;
	reg	[PULSE_AND_DELAY_WIDTH-1:0]		delay_t1_reg;
	reg	[SAMPLES_PER_ECHO_WIDTH-1:0]	samples_per_echo_reg;
	reg	[ECHOES_PER_SCAN_WIDTH-1:0]		echoes_per_scan_reg;
	reg	[ADC_INIT_DELAY_WIDTH-1:0]		init_delay_reg;
	reg	[ADC_INIT_DELAY_WIDTH-1:0]		rx_delay_reg; 
	always @(posedge pulseprog_clk)
	begin
		pulse_90deg_reg      <= pulse_90deg;
		pulse_180deg_reg     <= pulse_180deg;
		delay_nosig_reg      <= delay_nosig;
		delay_sig_reg        <= delay_sig;
		pulse_t1_reg         <= pulse_t1;
		delay_t1_reg         <= delay_t1;
		samples_per_echo_reg <= samples_per_echo;
		echoes_per_scan_reg  <= echoes_per_scan;
		init_delay_reg       <= init_delay;
		rx_delay_reg		 <= rx_delay;
	end
	
	NMR_Controller
	#(
		.PULSE_AND_DELAY_WIDTH 	(PULSE_AND_DELAY_WIDTH),
		.ECHO_PER_SCAN_WIDTH	(ECHOES_PER_SCAN_WIDTH),
		.ADC_INIT_DELAY_WIDTH	(ADC_INIT_DELAY_WIDTH),
		.SAMPLES_PER_ECHO_WIDTH (SAMPLES_PER_ECHO_WIDTH),
		.NMR_MAIN_TIMER_WIDTH	(NMR_MAIN_TIMER_WIDTH),
		.ADC_DATA_WIDTH			(ADC_DATA_WIDTH),	// ADC interface to FIFO width
		.ADC_PHYS_WIDTH			(ADC_PHYS_WIDTH), 	// ADC physical data width
		.ADC_LATENCY			(ADC_LATENCY)			// check the datasheet of LTC1746 for this
	)
	NMR_Controller1
	(
		// control signals
		.START		(fsm_start),
		.FSMSTAT	(fsmstat),
		
		// nmr parameters
		.T1_PULSE180		(pulse_t1_reg),
		.T1_DELAY			(delay_t1_reg),
		.PULSE90			(pulse_90deg_reg),
		.DELAY_NO_ACQ		(delay_nosig_reg),
		.PULSE180			(pulse_180deg_reg),
		.DELAY_WITH_ACQ		(delay_sig_reg),
		.ECHO_PER_SCAN		(echoes_per_scan_reg),	// echo per scan integer number
		.SAMPLES_PER_ECHO	(samples_per_echo_reg),
		.ADC_INIT_DELAY		(init_delay_reg),
		.RX_DELAY			(rx_delay_reg),
		
		// nmr rf tx-output (differential)
		.RF_OUT_P			(nmr_rfout_p),
		.RF_OUT_N			(nmr_rfout_n),
		
		// nmr output enable
		.OUT_EN				(),
		
		// nmr control signals
		.PHASE_CYCLE		(phase_cycle),
		.EN_ADC				(enable_adc),
		.EN_RX				(enable_rx),
		.ACQ_WND_DLY		(enable_rx_dly), // for broadband board
		
		// ADC bus
		.Q_IN				(adc_data_in[ADC_PHYS_WIDTH-1:0]),
		.Q_IN_OV			(adc_data_in[ADC_PHYS_WIDTH]),
		
		// data output
		.ADC_OUT_DATA		(adc_data_out),
		.ADC_DATA_VALID		(adc_data_valid),
		
		// system signals
		.PULSEPROG_CLK		(pulseprog_clk),
		.ADC_CLK			(adc_clk),
		.RESET				(nmr_controller_reset)
	);


	/* PIN ASSIGNMENT
	assign GPIO_1[5]	= 1'b1; // I2C_EN_INT
	assign GPIO_1[16]	= 1'b1; // I2C_EN_EXT
	
	// assign dac_preamp_MISO = ; // DAC_MISO is not connected in this version
	assign GPIO_1[13] = dac_preamp_MOSI;
	assign GPIO_1[10] = dac_preamp_SCLK;
	assign GPIO_1[11] = dac_preamp_SS_n;
	assign GPIO_1[12] = dac_preamp_LDAC_n;
	assign GPIO_1[15] = dac_preamp_CLR_n;
	

	assign adc_clkout = GPIO_1[21];	// uncomment this if the shifted clock from the ADC is used instead of clk_25M below
	assign GPIO_1[19] = adc_clk;	// ADC high speed clock ENC
	assign GPIO_1[18] = 1'b0; 		// ADC2_OE is always on
	assign adc_data_in = {
							1'b0,
							GPIO_1[34],		// overflow sign
							GPIO_1[35],		// bit 13
							GPIO_1[32],		// bit 12
							GPIO_1[33],		// bit 11
							GPIO_1[30],		// bit 10
							GPIO_1[31],		// bit 9
							GPIO_1[28],		// bit 8
							GPIO_1[29],		// bit 7
							GPIO_1[26],		// bit 6
							GPIO_1[27],		// bit 5
							GPIO_1[24],		// bit 4
							GPIO_1[25],		// bit 3
							GPIO_1[22],		// bit 2
							GPIO_1[23],		// bit 1
							GPIO_1[20]		// bit 0
						};

	assign GPIO_1[1] = nmr_clk_gate_avln_cnt ? nmr_rfout_p : pll_analyzer_clk0;
	assign GPIO_1[0] = nmr_clk_gate_avln_cnt ? nmr_rfout_n : pll_analyzer_clk2;
	

	
	altiobuf i2c_int_io (
		.datain		( 2'b00 ),
		.oe			( {i2c_int_sda_oe , i2c_int_scl_oe} ),
		.dataio		( {GPIO_1[2],GPIO_1[3]} ),
		.dataout	( {i2c_int_sda_in , i2c_int_scl_in} )
	);
	
	altiobuf i2c_ext_io (
		.datain		( 2'b00 ),
		.oe			( {i2c_ext_sda_oe , i2c_ext_scl_oe} ),
		.dataio		( {GPIO_1[14],GPIO_1[17]} ),
		.dataout	( {i2c_ext_sda_in , i2c_ext_scl_in} )
	);
	*/
	
	// USEFUL SIMPLE STATUS SIGNALS
	assign LED[0] = 1'b1;
	assign LED[1] = 1'b0;
	assign LED[2] = pll_vga_locked;
	assign LED[3] = pll_nmr_sys_locked;
	assign LED[4] = pll_analyzer_locked;
	assign LED[5] = phase_cycle;
	assign LED[6] = fsmstat;
	assign LED[7] = nmr_controller_reset;
	
	
	//assign GPIO_0[19] = nmr_rfout_p;
	//assign GPIO_0[21] = nmr_rfout_n;
	//assign GPIO_0[23] = ~enable_rx;
	//assign GPIO_0[25] = enable_rx;
	//assign GPIO_0[27] = enable_rx_dly;
	//assign GPIO_0[29] = enable_adc;
	//assign GPIO_0[34] = fsm_start;
	//assign GPIO_0[35] = fsmstat;
	
	//assign GPIO_0[25] = en_pa;
	//assign GPIO_0[23] = en_pa;
	//assign GPIO_0[25] = enable_rx_dly;
	//assign GPIO_0[23] = enable_rx_dly;
	//assign GPIO_0[21] = nmr_rfout_p;
	//assign GPIO_0[19] = nmr_rfout_n;
	//assign GPIO_0[17] = nmr_rfout_n;
	//assign GPIO_0[15] = nmr_rfout_p;
	
	assign GPIO_0[29] = en_pa || SW[0];
	assign GPIO_0[26] = nmr_rfout_n;
	assign GPIO_0[27] = nmr_rfout_p;
	assign GPIO_0[34] = en_pa || SW[0];
	
	assign GPIO_1[29] = en_pa || SW[0];
	assign GPIO_1[26] = nmr_rfout_n;
	assign GPIO_1[27] = nmr_rfout_p;
	assign GPIO_1[34] = en_pa || SW[0];
	
	/* save power by disabling the seven segments
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	*/
	
	//assign GPIO_1[11] = 1'b0;
	//assign GPIO_1[13] = 1'b0;
	//assign GPIO_1[15] = SW[0];
	//assign GPIO_1[17] = SW[1];
	//assign GPIO_1[19] = SW[2];
	//assign GPIO_1[21] = SW[3];
	//
	//assign GPIO_1[14] = SW[0];
	//assign GPIO_1[16] = SW[1];
	//assign GPIO_1[18] = SW[2];
	//assign GPIO_1[20] = SW[3];
	
	
	
endmodule

 