----------------------------------------------------------------------------------
-- Company			: Research Institute of Precision Instruments
-- Engineer			: Kosinov Alexey
-- Create Date		: 16:35:00 21/05/2018
-- Target Devices	: Virtex-6 (XC6VSX315T-2FF1759)
-- Tool versions	: ISE Design 14.7
-- Description		: My library for S-2-349A
----------------------------------------------------------------------------------
library IEEE; 
	use IEEE.STD_LOGIC_1164.ALL; 
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.NUMERIC_STD.ALL;

package s2package is 
	type transceiver_data 			is array (natural range <>) of std_logic_vector(31 downto 0);
	type transceiver_loopback 		is array (natural range <>) of std_logic_vector(2 downto 0);
	type transceiver_powerdown 		is array (natural range <>) of std_logic_vector(1 downto 0);
	type transceiver_cursor 		is array (natural range <>) of std_logic_vector(4 downto 0);
	type transceiver_diffctrl 		is array (natural range <>) of std_logic_vector(3 downto 0);
	type transceiver_rxeqmix 		is array (natural range <>) of std_logic_vector(2 downto 0);
	type transceiver_txbufstatus 	is array (natural range <>) of std_logic_vector(1 downto 0);
	type transceiver_rxbufstatus 	is array (natural range <>) of std_logic_vector(2 downto 0);
	type transceiver_mgtrefclkrx 	is array (natural range <>) of std_logic_vector(1 downto 0);
	type optical_36b_data_vector	is array (natural range <>) of std_logic_vector(35 downto 0);
	type optical_32b_data_vector	is array (natural range <>) of std_logic_vector(31 downto 0);
	type detector_ct_error			is array (natural range <>) of std_logic_vector(12 downto 0);
end s2package; 

package body s2package is 
end s2package; 

