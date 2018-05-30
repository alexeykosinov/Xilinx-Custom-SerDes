----------------------------------------------------------------------------------
-- Company			: Research Institute of Precision Instruments
-- Engineer			: Kosinov Alexey
-- Create Date		: 16:35:00 21/05/2018
-- Target Devices	: Virtex-6 (XC6VSX315T-2FF1759)
-- Tool versions	: ISE Design 14.7
-- Description		: GTX Multiplication
----------------------------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	use work.s2package.all;

ENTITY gtx_init IS
	PORT(
		GTX_LOOPBACK_IN			: in   transceiver_loopback(3 downto 0);
		GTX_RXPOWERDOWN_IN		: in   std_logic_vector(3 downto 0);
		GTX_TXPOWERDOWN_IN		: in   std_logic_vector(3 downto 0);
		GTX_RXCOMMADET_OUT		: out  std_logic_vector(3 downto 0);
		GTX_RXSLIDE_IN			: in   std_logic_vector(3 downto 0);
		GTX_RXDATA_OUT			: out  transceiver_data(3 downto 0);
		GTX_TXDATA_IN			: in   transceiver_data(3 downto 0);
		GTX_RXUSRCLK_IN			: in   std_logic_vector(3 downto 0);
		GTX_RXUSRCLK2_IN		: in   std_logic_vector(3 downto 0);
		GTX_TXOUTCLK_OUT		: out  std_logic_vector(3 downto 0);
		GTX_TXUSRCLK_IN			: in   std_logic_vector(3 downto 0);
		GTX_TXUSRCLK2_IN		: in   std_logic_vector(3 downto 0);
		GTX_RXEQMIX_IN			: in   transceiver_rxeqmix(3 downto 0);
		GTX_RXN_IN				: in   std_logic_vector(3 downto 0);
		GTX_RXP_IN				: in   std_logic_vector(3 downto 0);
		GTX_RXBUFSTATUS_OUT		: out  transceiver_rxbufstatus(3 downto 0);
		GTX_TXBUFSTATUS_OUT		: out  transceiver_txbufstatus(3 downto 0);		
		GTX_GTXRXRESET_IN		: in   std_logic_vector(3 downto 0);
		GTX_RXRESET_IN			: in   std_logic_vector(3 downto 0);
		GTX_GTXTXRESET_IN		: in   std_logic_vector(3 downto 0);		
		GTX_RXRESETDONE_OUT		: out  std_logic_vector(3 downto 0);
		GTX_TXRESETDONE_OUT		: out  std_logic_vector(3 downto 0);		
		GTX_TXN_OUT				: out  std_logic_vector(3 downto 0);
		GTX_TXP_OUT				: out  std_logic_vector(3 downto 0);
		GTX_RXPLLLKDET_OUT		: out  std_logic_vector(3 downto 0);	
		GTX_TXPLLLKDET_OUT		: out  std_logic_vector(3 downto 0);			
		GTX_MGTREFCLKRX_IN		: in   std_logic
	);
end entity;
    
architecture rtl of gtx_init is

	component gtx_gt
		port(
			loopback_in		: in   std_logic_vector(2 downto 0);
			rxpowerdown_in	: in   std_logic_vector(1 downto 0);
			txpowerdown_in	: in   std_logic_vector(1 downto 0);
			rxcommadet_out	: out  std_logic;
			rxslide_in		: in   std_logic;
			rxdata_out		: out  std_logic_vector(31 downto 0);
			txdata_in		: in  std_logic_vector(31 downto 0);		
			rxusrclk_in		: in   std_logic;
			rxusrclk2_in	: in   std_logic;
			txoutclk_out	: out  std_logic;
			txusrclk_in		: in   std_logic;
			txusrclk2_in	: in   std_logic;		
			rxeqmix_in		: in   std_logic_vector(2 downto 0);
			rxn_in			: in   std_logic;
			rxp_in			: in   std_logic;
			rxbufstatus_out	: out  std_logic_vector(2 downto 0);
			txbufstatus_out	: out  std_logic_vector(1 downto 0);		
			gtxrxreset_in	: in   std_logic;
			rxreset_in		: in   std_logic;
			gtxtxreset_in	: in   std_logic;		
			mgtrefclkrx_in	: in   std_logic_vector(1 downto 0);
			mgtrefclktx_in	: in   std_logic_vector(1 downto 0);
			pllrxreset_in	: in   std_logic;
			txplllkdet_out	: out  std_logic;
			rxplllkdet_out	: out  std_logic;
			rxresetdone_out	: out  std_logic;
			txresetdone_out	: out  std_logic;
			txn_out			: out  std_logic;
			txp_out			: out  std_logic
		);
	end component;

	signal gtx_mgtrefclkrx_i 	: std_logic_vector(1 downto 0);

	signal gtx_rxpd_i 			: transceiver_powerdown(3 downto 0);
	signal gtx_txpd_i 			: transceiver_powerdown(3 downto 0);

begin                       

	gtx_mgtrefclkrx_i 		<= ('0' & GTX_MGTREFCLKRX_IN);


	gtx_channel: for i in 0 to 3 generate
	begin
		gtx_i: gtx_gt
			port map(
				LOOPBACK_IN		=> GTX_LOOPBACK_IN(i),
				RXPOWERDOWN_IN	=> gtx_rxpd_i(i),
				TXPOWERDOWN_IN	=> gtx_txpd_i(i),
				RXSLIDE_IN		=> GTX_RXSLIDE_IN(i),
				RXCOMMADET_OUT	=> GTX_RXCOMMADET_OUT(i),
				RXDATA_OUT		=> GTX_RXDATA_OUT(i),
				TXDATA_IN		=> GTX_TXDATA_IN(i),
				RXUSRCLK_IN		=> GTX_RXUSRCLK_IN(i),
				RXUSRCLK2_IN	=> GTX_RXUSRCLK2_IN(i),
				TXOUTCLK_OUT	=> GTX_TXOUTCLK_OUT(i),
				TXUSRCLK_IN		=> GTX_TXUSRCLK_IN(i),
				TXUSRCLK2_IN	=> GTX_TXUSRCLK2_IN(i),
				RXEQMIX_IN		=> GTX_RXEQMIX_IN(i),		
				RXN_IN			=> GTX_RXN_IN(i),
				RXP_IN			=> GTX_RXP_IN(i),
				RXBUFSTATUS_OUT	=> GTX_RXBUFSTATUS_OUT(i),
				TXBUFSTATUS_OUT	=> GTX_TXBUFSTATUS_OUT(i),				
				GTXRXRESET_IN	=> GTX_GTXRXRESET_IN(i),
				RXRESET_IN		=> GTX_RXRESET_IN(i),
				GTXTXRESET_IN	=> GTX_GTXTXRESET_IN(i),				
				MGTREFCLKRX_IN	=> gtx_mgtrefclkrx_i,
				MGTREFCLKTX_IN	=> gtx_mgtrefclkrx_i,				
				PLLRXRESET_IN	=> '0',
				RXPLLLKDET_OUT	=> GTX_RXPLLLKDET_OUT(i),
				TXPLLLKDET_OUT	=> GTX_TXPLLLKDET_OUT(i),				
				RXRESETDONE_OUT	=> GTX_RXRESETDONE_OUT(i),
				TXRESETDONE_OUT	=> GTX_TXRESETDONE_OUT(i),				
				TXN_OUT			=> GTX_TXN_OUT(i),
				TXP_OUT			=> GTX_TXP_OUT(i)
			);
	end generate;

	gtx_rxpd_i(0) 		<= "11" when GTX_RXPOWERDOWN_IN(0) = '1' else "00";
	gtx_rxpd_i(1) 		<= "11" when GTX_RXPOWERDOWN_IN(1) = '1' else "00";
	gtx_rxpd_i(2)		<= "11" when GTX_RXPOWERDOWN_IN(2) = '1' else "00";
	gtx_rxpd_i(3) 		<= "11" when GTX_RXPOWERDOWN_IN(3) = '1' else "00";

	gtx_txpd_i(0) 		<= "11" when GTX_TXPOWERDOWN_IN(0) = '1' else "00";
	gtx_txpd_i(1) 		<= "11" when GTX_TXPOWERDOWN_IN(1) = '1' else "00";
	gtx_txpd_i(2)		<= "11" when GTX_TXPOWERDOWN_IN(2) = '1' else "00";
	gtx_txpd_i(3) 		<= "11" when GTX_TXPOWERDOWN_IN(3) = '1' else "00";

end architecture;
