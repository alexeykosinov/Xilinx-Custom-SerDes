----------------------------------------------------------------------------------
-- Company			: Research Institute of Precision Instruments
-- Engineer			: Kosinov Alexey
-- Create Date		: 16:35:00 21/05/2018
-- Target Devices	: Virtex-6 (XC6VSX315T-2FF1759)
-- Tool versions	: ISE Design 14.7
-- Description		: GTX Instance, all Settings is here (5.76 Gb/s)
----------------------------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
library unisim;
	use unisim.vcomponents.all;

entity gtx_gt is
	port(
		LOOPBACK_IN		: in   std_logic_vector(2 downto 0);
		RXPOWERDOWN_IN	: in   std_logic_vector(1 downto 0);
		TXPOWERDOWN_IN	: in   std_logic_vector(1 downto 0);
		RXCOMMADET_OUT	: out  std_logic;
		RXSLIDE_IN		: in   std_logic;
		RXDATA_OUT		: out  std_logic_vector(31 downto 0);
		TXDATA_IN		: in   std_logic_vector(31 downto 0);		
		RXUSRCLK_IN		: in   std_logic;
		RXUSRCLK2_IN	: in   std_logic;
		TXOUTCLK_OUT	: out  std_logic;
		TXUSRCLK_IN		: in   std_logic;
		TXUSRCLK2_IN	: in   std_logic;		
		RXEQMIX_IN		: in   std_logic_vector(2 downto 0);
		RXN_IN			: in   std_logic;
		RXP_IN			: in   std_logic;
		RXBUFSTATUS_OUT	: out  std_logic_vector(2 downto 0);
		TXBUFSTATUS_OUT	: out  std_logic_vector(1 downto 0);		
		GTXRXRESET_IN	: in   std_logic;
		RXRESET_IN		: in   std_logic;
		GTXTXRESET_IN	: in   std_logic;		
		MGTREFCLKRX_IN	: in   std_logic_vector(1 downto 0);
		MGTREFCLKTX_IN	: in   std_logic_vector(1 downto 0);
		PLLRXRESET_IN	: in   std_logic;
		TXPLLLKDET_OUT	: out  std_logic;
		RXPLLLKDET_OUT	: out  std_logic;
		RXRESETDONE_OUT	: out  std_logic;
		TXRESETDONE_OUT	: out  std_logic;
		TXN_OUT			: out  std_logic;
		TXP_OUT			: out  std_logic
	);
end entity;

architecture rtl of gtx_gt is
                       
begin                      

	gtxe1_i : GTXE1
		generic map(
			-- Comma Detection and Alignment
			ALIGN_COMMA_WORD                        =>     (2),
			DEC_MCOMMA_DETECT                       =>     (FALSE),
			DEC_PCOMMA_DETECT                       =>     (FALSE),
			DEC_VALID_COMMA_ONLY                    =>     (FALSE),
			MCOMMA_DETECT                           =>     (TRUE),
			PCOMMA_DETECT                           =>     (TRUE),
			RX_DECODE_SEQ_MATCH                     =>     (FALSE),
			RX_SLIDE_AUTO_WAIT                      =>     (5),
			RX_SLIDE_MODE                           =>     ("PCS"),
			SHOW_REALIGN_COMMA                      =>     (TRUE),
			-- Double comma character : (15 downto 0) := "1000001101111100" or x"837C"
			COMMA_10B_ENABLE                        =>     ("0011111111"),
			MCOMMA_10B_VALUE                        =>     ("0010000011"),
			PCOMMA_10B_VALUE                        =>     ("0001111100"),
			COMMA_DOUBLE                            =>     (TRUE),
			-- Simulation
			SIM_RECEIVER_DETECT_PASS                =>     (TRUE),
			SIM_GTXRESET_SPEEDUP                    =>     (0),
			SIM_TX_ELEC_IDLE_LEVEL     				=>     ("X"),
			SIM_VERSION                             =>     ("2.0"),
			SIM_TXREFCLK_SOURCE        				=>     ("000"),
			SIM_RXREFCLK_SOURCE        				=>     ("000"),
			-- TX PLL
			TX_CLK_SOURCE                           =>     ("TXPLL"),
			TX_OVERSAMPLE_MODE                      =>     (FALSE),
			TXPLL_COM_CFG                           =>     (x"21680a"),
			TXPLL_CP_CFG                            =>     (x"0D"),
			TXPLL_DIVSEL_FB                         =>     (4),
			TXPLL_DIVSEL_OUT                        =>     (1),
			TXPLL_DIVSEL_REF                        =>     (1),
			TXPLL_DIVSEL45_FB                       =>     (4),
			TXPLL_LKDET_CFG                         =>     ("111"),
			TX_CLK25_DIVIDER                        =>     (8),
			TXPLL_SATA                              =>     ("00"),
			TX_TDCC_CFG                             =>     ("11"),
			PMA_CAS_CLK_EN                          =>     (FALSE),
			POWER_SAVE                              =>     ("0000110000"),
			-- TX Interface
			GEN_TXUSRCLK                            =>     (FALSE),
			TX_DATA_WIDTH                           =>     (32),
			TX_USRCLK_CFG                           =>     (x"00"),
			TXOUTCLK_CTRL                           =>     ("TXOUTCLKPMA_DIV2"),
			TXOUTCLK_DLY                            =>     ("0000000000"),
			-- TX Buffering and Phase Alignment
			TX_PMADATA_OPT                          =>     ('0'),
			PMA_TX_CFG                              =>     (x"80082"),
			TX_BUFFER_USE                           =>     (TRUE),
			TX_BYTECLK_CFG                          =>     (x"00"),
			TX_EN_RATE_RESET_BUF                    =>     (TRUE),
			TX_XCLK_SEL                             =>     ("TXOUT"),
			TX_DLYALIGN_CTRINC                      =>     ("0100"),
			TX_DLYALIGN_LPFINC                      =>     ("0110"),
			TX_DLYALIGN_MONSEL                      =>     ("000"),
			TX_DLYALIGN_OVRDSETTING                 =>     ("10000000"),
			-- TX Gearbox
			GEARBOX_ENDEC                           =>     ("000"),
			TXGEARBOX_USE                           =>     (FALSE),
			-- TX Driver and OOB Signalling
			TX_DRIVE_MODE                           =>     ("DIRECT"),
			TX_IDLE_ASSERT_DELAY                    =>     ("100"),
			TX_IDLE_DEASSERT_DELAY                  =>     ("010"),
			TXDRIVE_LOOPBACK_HIZ                    =>     (FALSE),
			TXDRIVE_LOOPBACK_PD                     =>     (FALSE),
			-- TX Pipe Control for PCI Express/SATA
			COM_BURST_VAL                           =>     ("1111"),
			-- TX Attributes for PCI Express
			TX_DEEMPH_0                             =>     ("11010"),
			TX_DEEMPH_1                             =>     ("10000"),
			TX_MARGIN_FULL_0                        =>     ("1001110"),
			TX_MARGIN_FULL_1                        =>     ("1001001"),
			TX_MARGIN_FULL_2                        =>     ("1000101"),
			TX_MARGIN_FULL_3                        =>     ("1000010"),
			TX_MARGIN_FULL_4                        =>     ("1000000"),
			TX_MARGIN_LOW_0                         =>     ("1000110"),
			TX_MARGIN_LOW_1                         =>     ("1000100"),
			TX_MARGIN_LOW_2                         =>     ("1000010"),
			TX_MARGIN_LOW_3                         =>     ("1000000"),
			TX_MARGIN_LOW_4                         =>     ("1000000"),
			-- RX PLL
			RX_OVERSAMPLE_MODE                      =>     (FALSE),
			RXPLL_COM_CFG                           =>     (x"21680a"),
			RXPLL_CP_CFG                            =>     (x"0D"),
			RXPLL_DIVSEL_FB                         =>     (4),
			RXPLL_DIVSEL_OUT                        =>     (1),
			RXPLL_DIVSEL_REF                        =>     (1),
			RXPLL_DIVSEL45_FB                       =>     (4),
			RXPLL_LKDET_CFG                         =>     ("111"),
			RX_CLK25_DIVIDER                        =>     (8),
			-- RX Interface
			GEN_RXUSRCLK                            =>     (FALSE),
			RX_DATA_WIDTH                           =>     (32),
			RXRECCLK_CTRL                           =>     ("RXRECCLKPMA_DIV2"),
			RXRECCLK_DLY                            =>     ("0000000000"),
			RXUSRCLK_DLY                            =>     (x"0000"),
			-- RX Driver,OOB signalling,Coupling and Eq.,CDR
			AC_CAP_DIS                              =>     (TRUE),
			CDR_PH_ADJ_TIME                         =>     ("10100"),
			OOBDETECT_THRESHOLD                     =>     ("011"),
			PMA_CDR_SCAN                            =>     (x"640404C"),
			PMA_RX_CFG                              =>     (x"05CE008"),
			RCV_TERM_GND                            =>     (FALSE),
			RCV_TERM_VTTRX                          =>     (TRUE),
			RX_EN_IDLE_HOLD_CDR                     =>     (FALSE),
			RX_EN_IDLE_RESET_FR                     =>     (FALSE),
			RX_EN_IDLE_RESET_PH                     =>     (FALSE),
			TX_DETECT_RX_CFG                        =>     (x"1832"),
			TERMINATION_CTRL                        =>     ("00000"),
			TERMINATION_OVRD                        =>     (FALSE),
			CM_TRIM                                 =>     ("01"),
			PMA_RXSYNC_CFG                          =>     (x"00"),
			PMA_CFG                                 =>     (x"0040000040000000003"),
			BGTEST_CFG                              =>     ("00"),
			BIAS_CFG                                =>     (x"00000"),
			-- RX Decision Feedback Equalizer(DFE)
			DFE_CAL_TIME                            =>     ("01100"),
			DFE_CFG                                 =>     ("00011011"),
			RX_EN_IDLE_HOLD_DFE                     =>     (TRUE),
			RX_EYE_OFFSET                           =>     (x"4C"),
			RX_EYE_SCANMODE                         =>     ("00"),
			-- PRBS Detection
			RXPRBSERR_LOOPBACK                      =>     ('0'),
			-- RX Loss-of-sync State Machine
			RX_LOS_INVALID_INCR                     =>     (8),
			RX_LOS_THRESHOLD                        =>     (128),
			RX_LOSS_OF_SYNC_FSM                     =>     (FALSE),
			-- RX Gearbox
			RXGEARBOX_USE                           =>     (FALSE),
			-- RX Elastic Buffer and Phase alignment
			RX_BUFFER_USE                           =>     (TRUE),
			RX_EN_IDLE_RESET_BUF                    =>     (FALSE),
			RX_EN_MODE_RESET_BUF                    =>     (TRUE),
			RX_EN_RATE_RESET_BUF                    =>     (TRUE),
			RX_EN_REALIGN_RESET_BUF                 =>     (FALSE),
			RX_EN_REALIGN_RESET_BUF2                =>     (FALSE),
			RX_FIFO_ADDR_MODE                       =>     ("FAST"),
			RX_IDLE_HI_CNT                          =>     ("1000"),
			RX_IDLE_LO_CNT                          =>     ("0000"),
			RX_XCLK_SEL                             =>     ("RXREC"),
			RX_DLYALIGN_CTRINC                      =>     ("1110"),
			RX_DLYALIGN_EDGESET                     =>     ("00010"),
			RX_DLYALIGN_LPFINC                      =>     ("1110"),
			RX_DLYALIGN_MONSEL                      =>     ("000"),
			RX_DLYALIGN_OVRDSETTING                 =>     ("10000000"),
			-- Clock Correction
			CLK_COR_ADJ_LEN                         =>     (2),
			CLK_COR_DET_LEN                         =>     (1),
			CLK_COR_INSERT_IDLE_FLAG                =>     (FALSE),
			CLK_COR_KEEP_IDLE                       =>     (FALSE),
			CLK_COR_MAX_LAT                         =>     (16),
			CLK_COR_MIN_LAT                         =>     (14),
			CLK_COR_PRECEDENCE                      =>     (TRUE),
			CLK_COR_REPEAT_WAIT                     =>     (0),
			CLK_COR_SEQ_1_1                         =>     ("0000000000"),
			CLK_COR_SEQ_1_2                         =>     ("0000000000"),
			CLK_COR_SEQ_1_3                         =>     ("0000000000"),
			CLK_COR_SEQ_1_4                         =>     ("0000000000"),
			CLK_COR_SEQ_1_ENABLE                    =>     ("1111"),
			CLK_COR_SEQ_2_1                         =>     ("0000000000"),
			CLK_COR_SEQ_2_2                         =>     ("0000000000"),
			CLK_COR_SEQ_2_3                         =>     ("0000000000"),
			CLK_COR_SEQ_2_4                         =>     ("0000000000"),
			CLK_COR_SEQ_2_ENABLE                    =>     ("1111"),
			CLK_COR_SEQ_2_USE                       =>     (FALSE),
			CLK_CORRECT_USE                         =>     (FALSE),
			-- Channel Bonding
			CHAN_BOND_1_MAX_SKEW                    =>     (1),
			CHAN_BOND_2_MAX_SKEW                    =>     (1),
			CHAN_BOND_KEEP_ALIGN                    =>     (FALSE),
			CHAN_BOND_SEQ_1_1                       =>     ("0000000000"),
			CHAN_BOND_SEQ_1_2                       =>     ("0000000000"),
			CHAN_BOND_SEQ_1_3                       =>     ("0000000000"),
			CHAN_BOND_SEQ_1_4                       =>     ("0000000000"),
			CHAN_BOND_SEQ_1_ENABLE                  =>     ("1111"),
			CHAN_BOND_SEQ_2_1                       =>     ("0000000000"),
			CHAN_BOND_SEQ_2_2                       =>     ("0000000000"),
			CHAN_BOND_SEQ_2_3                       =>     ("0000000000"),
			CHAN_BOND_SEQ_2_4                       =>     ("0000000000"),
			CHAN_BOND_SEQ_2_CFG                     =>     ("00000"),
			CHAN_BOND_SEQ_2_ENABLE                  =>     ("1111"),
			CHAN_BOND_SEQ_2_USE                     =>     (FALSE),
			CHAN_BOND_SEQ_LEN                       =>     (1),
			PCI_EXPRESS_MODE                        =>     (FALSE),
			-- RX Attributes for PCI Express/SATA/SAS
			SAS_MAX_COMSAS                          =>     (52),
			SAS_MIN_COMSAS                          =>     (40),
			SATA_BURST_VAL                          =>     ("100"),
			SATA_IDLE_VAL                           =>     ("100"),
			SATA_MAX_BURST                          =>     (9),
			SATA_MAX_INIT                           =>     (26),
			SATA_MAX_WAKE                           =>     (9),
			SATA_MIN_BURST                          =>     (5),
			SATA_MIN_INIT                           =>     (14),
			SATA_MIN_WAKE                           =>     (5),
			TRANS_TIME_FROM_P2                      =>     (x"03c"),
			TRANS_TIME_NON_P2                       =>     (x"19"),
			TRANS_TIME_RATE                         =>     (x"ff"),
			TRANS_TIME_TO_P2                        =>     (x"064")
		)
		port map(
			-- Loopback and Powerdown Ports
			LOOPBACK                        =>      LOOPBACK_IN,
			RXPOWERDOWN                     =>      RXPOWERDOWN_IN,
			TXPOWERDOWN                     =>      TXPOWERDOWN_IN,
			-- Receive Ports - 64b66b and 64b67b Gearbox Ports
			RXDATAVALID                     =>      open,
			RXGEARBOXSLIP                   =>      '0',
			RXHEADER                        =>      open,
			RXHEADERVALID                   =>      open,
			RXSTARTOFSEQ                    =>      open,
			-- Receive Ports - 8b10b Decoder
			RXCHARISCOMMA                   =>      open,
			RXCHARISK                       =>      open,
			RXDEC8B10BUSE                   =>      '0',
			RXDISPERR                       =>      open,
			RXNOTINTABLE                    =>      open,
			RXRUNDISP                       =>      open,
			USRCODEERR                      =>      '0',
			-- Receive Ports - Channel Bonding Ports
			RXCHANBONDSEQ                   =>      open,
			RXCHBONDI                       =>      (others => '0'),
			RXCHBONDLEVEL                   =>      (others => '0'),
			RXCHBONDMASTER                  =>      '0',
			RXCHBONDO                       =>      open,
			RXCHBONDSLAVE                   =>      '0',
			RXENCHANSYNC                    =>      '0',
			-- Receive Ports - Clock Correction Ports
			RXCLKCORCNT                     =>      open,
			-- Receive Ports - Comma Detection and Alignment 
			RXBYTEISALIGNED                 =>      open,
			RXBYTEREALIGN                   =>      open,
			RXCOMMADET                      =>      RXCOMMADET_OUT,
			RXCOMMADETUSE                   =>      '1',
			RXENMCOMMAALIGN                 =>      '0',
			RXENPCOMMAALIGN                 =>      '0',
			RXSLIDE                         =>      RXSLIDE_IN,
			-- Receive Ports - PRBS Detection 
			PRBSCNTRESET                    =>      '0',
			RXENPRBSTST                     =>      (others => '0'),
			RXPRBSERR                       =>      open,
			-- Receive Ports - RX Data Path interface
			RXDATA(31 downto 0)             =>      RXDATA_OUT,
			RXRECCLK                        =>      open,
			RXRECCLKPCS                     =>      open,
			RXRESET                         =>      RXRESET_IN,
			RXUSRCLK                        =>      RXUSRCLK_IN,
			RXUSRCLK2                       =>      RXUSRCLK2_IN,
			-- Receive Ports - RX Decision Feedback Equalizer(DFE)
			DFECLKDLYADJ                    =>      (others => '0'),
			DFECLKDLYADJMON                 =>      open,
			DFEDLYOVRD                      =>      '0',
			DFEEYEDACMON                    =>      open,
			DFESENSCAL                      =>      open,
			DFETAP1                         =>      (others => '0'),
			DFETAP1MONITOR                  =>      open,
			DFETAP2                         =>      (others => '0'),
			DFETAP2MONITOR                  =>      open,
			DFETAP3                         =>      (others => '0'),
			DFETAP3MONITOR                  =>      open,
			DFETAP4                         =>      (others => '0'),
			DFETAP4MONITOR                  =>      open,
			DFETAPOVRD                      =>      '1',
			-- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR
			GATERXELECIDLE                  =>      '1',
			IGNORESIGDET                    =>      '1',
			RXCDRRESET                      =>      '0',
			RXELECIDLE                      =>      open,
			RXEQMIX(9 downto 3)             =>      (others => '0'),
			RXEQMIX(2 downto 0)             =>      RXEQMIX_IN,
			RXN                             =>      RXN_IN,
			RXP                             =>      RXP_IN,
			-- Receive Ports - RX Elastic Buffer and Phase Alignment Ports 
			RXBUFRESET                      =>      '0',
			RXBUFSTATUS                     =>      RXBUFSTATUS_OUT,
			RXCHANISALIGNED                 =>      open,
			RXCHANREALIGN                   =>      open,
			RXDLYALIGNDISABLE               =>      '0',
			RXDLYALIGNMONENB                =>      '0',
			RXDLYALIGNMONITOR               =>      open,
			RXDLYALIGNOVERRIDE              =>      '1',
			RXDLYALIGNRESET                 =>      '0',
			RXDLYALIGNSWPPRECURB            =>      '1',
			RXDLYALIGNUPDSW                 =>      '0',
			RXENPMAPHASEALIGN               =>      '0',
			RXPMASETPHASE                   =>      '0',
			RXSTATUS                        =>      open,
			-- Receive Ports - RX Loss-of-sync State Machine 
			RXLOSSOFSYNC                    =>      open,
			-- Receive Ports - RX Oversampling 
			RXENSAMPLEALIGN                 =>      '0',
			RXOVERSAMPLEERR                 =>      open,
			-- Receive Ports - RX PLL Ports
			GREFCLKRX                       =>      '0',
			GTXRXRESET                      =>      GTXRXRESET_IN,
			MGTREFCLKRX                     =>      MGTREFCLKRX_IN,
			NORTHREFCLKRX                   =>      (others => '0'),
			PERFCLKRX                       =>      '0',
			PLLRXRESET                      =>      PLLRXRESET_IN,
			RXPLLLKDET                      =>      RXPLLLKDET_OUT,
			RXPLLLKDETEN                    =>      '1',
			RXPLLPOWERDOWN                  =>      '0',
			RXPLLREFSELDY                   =>      (others => '0'),
			RXRATE                          =>      (others => '0'),
			RXRATEDONE                      =>      open,
			RXRESETDONE                     =>      RXRESETDONE_OUT,
			SOUTHREFCLKRX                   =>      (others => '0'),
			-- Receive Ports - RX Pipe Control for PCI Express
			PHYSTATUS                       =>      open,
			RXVALID                         =>      open,
			-- Receive Ports - RX Polarity Control Ports
			RXPOLARITY                      =>      '0',
			-- Receive Ports - RX Ports for SATA
			COMINITDET                      =>      open,
			COMSASDET                       =>      open,
			COMWAKEDET                      =>      open,
			-- Shared Ports - Dynamic Reconfiguration Port (DRP)
			DADDR                           =>      (others => '0'),
			DCLK                            =>      '0',
			DEN                             =>      '0',
			DI                              =>      (others => '0'),
			DRDY                            =>      open,
			DRPDO                           =>      open,
			DWE                             =>      '0',
			-- Transmit Ports - 64b66b and 64b67b Gearbox Ports
			TXGEARBOXREADY                  =>      open,
			TXHEADER                        =>      (others => '0'),
			TXSEQUENCE                      =>      (others => '0'),
			TXSTARTSEQ                      =>      '0',
			-- Transmit Ports - 8b10b Encoder Control Ports 
			TXBYPASS8B10B                   =>      (others => '0'),
			TXCHARDISPMODE                  =>      (others => '0'),
			TXCHARDISPVAL                   =>      (others => '0'),
			TXCHARISK                       =>      (others => '0'),
			TXENC8B10BUSE                   =>      '0',
			TXKERR                          =>      open,
			TXRUNDISP                       =>      open,
			-- Transmit Ports - GTX Ports
			GTXTEST                         =>      "1000000000000",
			MGTREFCLKFAB                    =>      open,
			TSTCLK0                         =>      '0',
			TSTCLK1                         =>      '0',
			TSTIN                           =>      "11111111111111111111",
			TSTOUT                          =>      open,
			-- Transmit Ports - TX Data Path interface
			TXDATA                          =>      TXDATA_IN,
			TXOUTCLK                        =>      TXOUTCLK_OUT,
			TXOUTCLKPCS                     =>      open,
			TXRESET                         =>      '0',
			TXUSRCLK                        =>      TXUSRCLK_IN,
			TXUSRCLK2                       =>      TXUSRCLK2_IN,
			-- Transmit Ports - TX Driver and OOB signaling 
			TXBUFDIFFCTRL                   =>      "100",
			TXDIFFCTRL                      =>      (others => '0'),
			TXINHIBIT                       =>      '0',
			TXN                             =>      TXN_OUT,
			TXP                             =>      TXP_OUT,
			TXPOSTEMPHASIS                  =>      (others => '0'),
			-- Transmit Ports - TX Driver and OOB signalling 
			TXPREEMPHASIS                   =>      (others => '0'),
			-- Transmit Ports - TX Elastic Buffer and Phase Alignment
			TXBUFSTATUS                     =>      TXBUFSTATUS_OUT,
			-- Transmit Ports - TX Elastic Buffer and Phase Alignment Ports
			TXDLYALIGNDISABLE               =>      '1',
			TXDLYALIGNMONENB                =>      '0',
			TXDLYALIGNMONITOR               =>      open,
			TXDLYALIGNOVERRIDE              =>      '0',
			TXDLYALIGNRESET                 =>      '0',
			TXDLYALIGNUPDSW                 =>      '1',
			TXENPMAPHASEALIGN               =>      '0',
			TXPMASETPHASE                   =>      '0',
			-- Transmit Ports - TX PLL Ports
			GREFCLKTX                       =>      '0',
			GTXTXRESET                      =>      GTXTXRESET_IN,
			MGTREFCLKTX                     =>      MGTREFCLKTX_IN,
			NORTHREFCLKTX                   =>      (others => '0'),
			PERFCLKTX                       =>      '0',
			PLLTXRESET                      =>      '0',
			SOUTHREFCLKTX                   =>      (others => '0'),
			TXPLLLKDET                      =>      TXPLLLKDET_OUT,
			TXPLLLKDETEN                    =>      '1',
			TXPLLPOWERDOWN                  =>      '0',
			TXPLLREFSELDY                   =>      (others => '0'),
			TXRATE                          =>      (others => '0'),
			TXRATEDONE                      =>      open,
			TXRESETDONE                     =>      TXRESETDONE_OUT,
			-- Transmit Ports - TX PRBS Generator
			TXENPRBSTST                     =>      (others => '0'),
			TXPRBSFORCEERR                  =>      '0',
			-- Transmit Ports - TX Polarity Control
			TXPOLARITY                      =>      '0',
			-- Transmit Ports - TX Ports for PCI Express
			TXDEEMPH                        =>      '0',
			TXDETECTRX                      =>      '0',
			TXELECIDLE                      =>      '0',
			TXMARGIN                        =>      (others => '0'),
			TXPDOWNASYNCH                   =>      '0',
			TXSWING                         =>      '0',
			-- Transmit Ports - TX Ports for SATA
			COMFINISH                       =>      open,
			TXCOMINIT                       =>      '0',
			TXCOMSAS                        =>      '0',
			TXCOMWAKE                       =>      '0'
		);

end architecture;
