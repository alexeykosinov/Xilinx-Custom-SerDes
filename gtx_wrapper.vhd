----------------------------------------------------------------------------------
-- Company			: Research Institute of Precision Instruments
-- Engineer			: Kosinov Alexey
-- Create Date		: 16:35:00 21/05/2018
-- Target Devices	: Virtex-6 (XC6VSX315T-2FF1759)
-- Tool versions	: ISE Design 14.7
-- Description		: GTX Wrapper (Reference clock are 180 MHz)
----------------------------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;	
	use ieee.numeric_std.all;
library unisim;
	use unisim.vcomponents.all;
	use work.s2package.all;

entity gtx_wrapper is
	port(
		GTX_LOOPBACK_IN				: in  transceiver_loopback(3 downto 0);
		GTX_RXEQMIX_IN 				: in  transceiver_rxeqmix(3 downto 0);
		GTX_RXCOMMADET_OUT			: out std_logic_vector(3 downto 0);
		GTX_RXSLIDE_IN				: in  std_logic_vector(3 downto 0);		
		GTX_RXBUFSTATUS_OUT 		: out transceiver_rxbufstatus(3 downto 0);
		GTX_TXBUFSTATUS_OUT 		: out transceiver_txbufstatus(3 downto 0);
		GTX_RXPD_IN 				: in  std_logic_vector(3 downto 0);
		GTX_TXPD_IN 				: in  std_logic_vector(3 downto 0);
		RXP_IN, RXN_IN				: in  std_logic_vector(3 downto 0);
		TXN_OUT, TXP_OUT			: out std_logic_vector(3 downto 0);
		GTX_GTXRXRESET_IN			: in  std_logic_vector(3 downto 0);
		GTX_RXRESET_IN				: in  std_logic_vector(3 downto 0);	
		GTX_GTXTXRESET_IN			: in  std_logic_vector(3 downto 0);			
		GTX_RXDATA_OUT	 			: out transceiver_data(3 downto 0);
		GTX_TXDATA_IN	 			: in  transceiver_data(3 downto 0);
		GTX_RXRESETDONE_OUT			: out std_logic_vector(3 downto 0);		
		GTX_TXRESETDONE_OUT			: out std_logic_vector(3 downto 0);
		GTX_MMCM_LOCKED_TX_OUT		: out std_logic;	
		GTX_TX180CLK_OUT			: out std_logic;	
 		Q3_CLK1_MGTREFCLK_PAD_P_IN	: in  std_logic;
		Q3_CLK1_MGTREFCLK_PAD_N_IN	: in  std_logic
	);
end entity;

architecture rtl of gtx_wrapper is

	component gtx_init
		port(
			gtx_loopback_in			: in   transceiver_loopback(3 downto 0);
			gtx_rxpowerdown_in		: in   std_logic_vector(3 downto 0);
			gtx_txpowerdown_in		: in   std_logic_vector(3 downto 0);
			gtx_rxcommadet_out		: out  std_logic_vector(3 downto 0);
			gtx_rxslide_in			: in   std_logic_vector(3 downto 0);
			gtx_rxdata_out			: out  transceiver_data(3 downto 0);
			gtx_txdata_in			: in   transceiver_data(3 downto 0);
			gtx_rxusrclk_in			: in   std_logic_vector(3 downto 0);
			gtx_rxusrclk2_in		: in   std_logic_vector(3 downto 0);
			gtx_txoutclk_out		: out  std_logic_vector(3 downto 0);
			gtx_txusrclk_in			: in   std_logic_vector(3 downto 0);
			gtx_txusrclk2_in		: in   std_logic_vector(3 downto 0);
			gtx_rxeqmix_in			: in   transceiver_rxeqmix(3 downto 0);
			gtx_rxn_in				: in   std_logic_vector(3 downto 0);
			gtx_rxp_in				: in   std_logic_vector(3 downto 0);
			gtx_rxbufstatus_out		: out  transceiver_rxbufstatus(3 downto 0);
			gtx_txbufstatus_out		: out  transceiver_txbufstatus(3 downto 0);		
			gtx_gtxrxreset_in		: in   std_logic_vector(3 downto 0);
			gtx_rxreset_in			: in   std_logic_vector(3 downto 0);
			gtx_gtxtxreset_in		: in   std_logic_vector(3 downto 0);		
			gtx_rxresetdone_out		: out  std_logic_vector(3 downto 0);
			gtx_txresetdone_out		: out  std_logic_vector(3 downto 0);		
			gtx_txn_out				: out  std_logic_vector(3 downto 0);
			gtx_txp_out				: out  std_logic_vector(3 downto 0);
			gtx_rxplllkdet_out		: out  std_logic_vector(3 downto 0);	
			gtx_txplllkdet_out		: out  std_logic_vector(3 downto 0);			
			gtx_mgtrefclkrx_in		: in   std_logic
		);
	end component;

	component mmcm_source
		port(
			MMCM_RESET_IN   : in  std_logic;	
			MMCM_CLK_IN     : in  std_logic; 
			MGTREFCLK_P_IN	: in  std_logic;
			MGTREFCLK_N_IN	: in  std_logic; 
			MGTREFCLK_OUT	: out std_logic;
			MMCM_LOCK_OUT   : out std_logic;              
			MMCM_CLK0_OUT   : out std_logic;	
			MMCM_CLK1_OUT   : out std_logic
		);	
	end component;

	signal q3_clk1_refclk_i  		: std_logic;
	signal gtx_txoutclk_i 			: std_logic_vector(3 downto 0); 
	signal gtx_txplllkdet			: std_logic_vector(3 downto 0); 
	signal gtx_rxplllkdet			: std_logic_vector(3 downto 0); 

	attribute KEEP: string;

	signal gtx_txusrclk2_i	 : std_logic; 
	signal gtx_txusrclk_i	 : std_logic; 

	attribute KEEP of gtx_txusrclk2_i	: signal is "TRUE";
	attribute KEEP of gtx_txusrclk_i	: signal is "TRUE";

begin

	mmcm_i : mmcm_source
		port map(
			MMCM_RESET_IN   => '0',
			MMCM_CLK_IN     => gtx_txoutclk_i(0), 
			MGTREFCLK_P_IN	=> Q3_CLK1_MGTREFCLK_PAD_P_IN,
			MGTREFCLK_N_IN	=> Q3_CLK1_MGTREFCLK_PAD_N_IN,
			MGTREFCLK_OUT	=> q3_clk1_refclk_i,
			MMCM_LOCK_OUT   => GTX_MMCM_LOCKED_TX_OUT,         
			MMCM_CLK0_OUT   => gtx_txusrclk2_i,	
			MMCM_CLK1_OUT   => gtx_txusrclk_i
		);

	gtx_init_i: gtx_init 
		port map(
			GTX_LOOPBACK_IN			=> GTX_LOOPBACK_IN,
			gtx_rxpowerdown_in		=> GTX_RXPD_IN,
			gtx_txpowerdown_in		=> GTX_TXPD_IN,
			gtx_rxcommadet_out		=> GTX_RXCOMMADET_OUT,
			gtx_rxslide_in			=> GTX_RXSLIDE_IN,
			gtx_rxdata_out			=> GTX_RXDATA_OUT,
			gtx_txdata_in			=> GTX_TXDATA_IN,
			gtx_rxusrclk_in(0)		=> gtx_txusrclk_i,
			gtx_rxusrclk_in(1)		=> gtx_txusrclk_i,
			gtx_rxusrclk_in(2)		=> gtx_txusrclk_i,
			gtx_rxusrclk_in(3)		=> gtx_txusrclk_i,
			gtx_rxusrclk2_in(0)		=> gtx_txusrclk2_i,
			gtx_rxusrclk2_in(1)		=> gtx_txusrclk2_i,	
			gtx_rxusrclk2_in(2)		=> gtx_txusrclk2_i,
			gtx_rxusrclk2_in(3)		=> gtx_txusrclk2_i,	
			gtx_txoutclk_out		=> gtx_txoutclk_i,
			gtx_txusrclk_in(0)		=> gtx_txusrclk_i,
			gtx_txusrclk_in(1)		=> gtx_txusrclk_i,
			gtx_txusrclk_in(2)		=> gtx_txusrclk_i,
			gtx_txusrclk_in(3)		=> gtx_txusrclk_i,
			gtx_txusrclk2_in(0)		=> gtx_txusrclk2_i,
			gtx_txusrclk2_in(1)		=> gtx_txusrclk2_i,	
			gtx_txusrclk2_in(2)		=> gtx_txusrclk2_i,
			gtx_txusrclk2_in(3)		=> gtx_txusrclk2_i,
			gtx_rxeqmix_in			=> GTX_RXEQMIX_IN,
			gtx_rxn_in				=> RXN_IN,
			gtx_rxp_in				=> RXP_IN,
			gtx_rxbufstatus_out		=> GTX_RXBUFSTATUS_OUT,
			gtx_txbufstatus_out		=> GTX_TXBUFSTATUS_OUT,
			gtx_gtxrxreset_in		=> GTX_GTXRXRESET_IN,
			gtx_gtxtxreset_in		=> GTX_GTXTXRESET_IN,
			gtx_rxresetdone_out		=> GTX_RXRESETDONE_OUT,
			gtx_rxreset_in			=> GTX_RXRESET_IN,
			gtx_txresetdone_out		=> GTX_TXRESETDONE_OUT,
			gtx_txn_out				=> TXN_OUT,
			gtx_txp_out				=> TXP_OUT,
			gtx_rxplllkdet_out		=> gtx_rxplllkdet,
			gtx_txplllkdet_out		=> gtx_txplllkdet,
			gtx_mgtrefclkrx_in		=> q3_clk1_refclk_i
		);

	GTX_TX180CLK_OUT <= gtx_txusrclk2_i;

end architecture;
