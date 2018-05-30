----------------------------------------------------------------------------------
-- Company			: Research Institute of Precision Instruments
-- Engineer			: Kosinov Alexey
-- Create Date		: 09:14:00 28/03/2018 
-- Target Devices	: Virtex-6 (XC6VSX315T-2FF1759)
-- Tool versions	: ISE Design 14.7
-- Description		: Byte alignment tool for GTX/GTP Transceivers
----------------------------------------------------------------------------------
library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
	USE IEEE.std_logic_unsigned.all;

entity rx_byte_align is
	generic(
		DATA_WIDTH	: integer := 32;
		COMMA     	: std_logic_vector(31 downto 0):= x"0605047c"
	);
	port(
		CLK_IN		: in  std_logic;
		ENABLE_IN	: in  std_logic;
		DATA_IN		: in  std_logic_vector((data_width - 1) downto 0);
		RST_OUT		: out std_logic; -- Connect to GTXRXRESET or RXRESET (reset pulse after unsuccessful alignment)
		RXSLIDE_OUT	: out std_logic
	);
end entity;

architecture rtl of rx_byte_align is

	type STATE is (ST_IDLE, ST_START, ST_STOP);
	signal next_state : STATE := ST_IDLE;

	attribute keep : string;
	signal rx_data_r : std_logic_vector((DATA_WIDTH - 1) downto 0);
	attribute keep of rx_data_r : signal is "true";

	signal sel 				: std_logic;
	signal ct_wait_done_i 	: std_logic;
	signal slider_count_r 	: std_logic_vector(7 downto 0) := (others => '0');
	signal slide_detected_i : std_logic;

begin

	process(CLK_IN)
	begin
		if (rising_edge(CLK_IN)) then
			rx_data_r  <= DATA_IN;
		end if;
	end process;

	-- Finding which one of position comma is
	process(CLK_IN, ENABLE_IN)
	begin
		if (ENABLE_IN = '0') then
			sel <= '0';
		elsif (rising_edge(CLK_IN)) then
			if (rx_data_r = COMMA) then 
				sel <= '0';
			else
				sel <= '1';
			end if;
		end if;
	end process;

	process (CLK_IN, ENABLE_IN)
		variable ct_wait_i : integer range 0 to 63;
	begin
		if (ENABLE_IN = '0') then
			ct_wait_i	:= 0;
			next_state 	<= ST_IDLE;	
		elsif (rising_edge(CLK_IN)) then
			case next_state is
				when ST_IDLE =>
					if (sel /= '0') then
						ct_wait_done_i 	<= '0';
						ct_wait_i		:= 0;
						next_state		<= ST_START;
					else
						ct_wait_done_i 	<= '0';
						ct_wait_i		:= 0;
						next_state		<= ST_IDLE;
					end if;

				when ST_START =>
					if (ct_wait_i /= 31) then 
						ct_wait_i 		:= ct_wait_i + 1;
						ct_wait_done_i 	<= '0';
					elsif (sel = '0') then
						next_state		<= ST_IDLE;
					else
						ct_wait_done_i 	<= '1';
						next_state		<= ST_STOP;
					end if;						

				when ST_STOP => 
					ct_wait_done_i 	<= '0';
					ct_wait_i		:= 0;
					next_state		<= ST_IDLE;

			end case;
		end if;
	end process;

	slide_detected_i <= '1' when (next_state = ST_STOP) and (ct_wait_done_i = '1') else '0';

	process (CLK_IN, ENABLE_IN, slider_count_r)
	begin
		if (ENABLE_IN = '0' or slider_count_r = x"80") then
			slider_count_r <= (others => '0');
		elsif rising_edge(CLK_IN) then
			if (slide_detected_i = '1') then
				slider_count_r <= slider_count_r + 1;
			end if;
		end if;
	end process;

	RST_OUT <= '1' when (slider_count_r = x"7F") else '0';
	RXSLIDE_OUT <= '1' when ct_wait_done_i = '1' and slider_count_r /= x"7E" and slider_count_r /= x"7F" else '0';

end architecture;