library ieee;
	use ieee.std_logic_1164.all;	
	use ieee.numeric_std.all;
library unisim;
	use unisim.vcomponents.all;

entity mmcm_source is
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
end entity;

architecture rtl of mmcm_source is

    signal q3_clk1_refclk_i : std_logic;
	signal mmcm_to_bufg_i	: std_logic_vector(2 downto 0);
	signal bufg_to_mmcm_i	: std_logic_vector(1 downto 0);

begin

	ibufds_i : IBUFDS_GTXE1 
		port map(
			O 		=> MGTREFCLK_OUT, 
			ODIV2 	=> open, 
			CEB 	=> '0', 
			I 		=> MGTREFCLK_P_IN, 
			IB 		=> MGTREFCLK_N_IN
		);

    bufg_fb_i : BUFG 
        port map(
            I => mmcm_to_bufg_i(0), 
            O => bufg_to_mmcm_i(0)
        ); 

	bufg_clkin_i : BUFG 
        port map(
            I => MMCM_CLK_IN, 
            O => bufg_to_mmcm_i(1)
        );

	bufg_txusrclk2_i : BUFG 
        port map(
            I => mmcm_to_bufg_i(1), 
            O => MMCM_CLK0_OUT
        );

	bufg_txusrclk_i : BUFG 
        port map(
            I => mmcm_to_bufg_i(2), 
            O => MMCM_CLK1_OUT
        );

	mmcm_adv_i: MMCM_ADV
		generic map(
			COMPENSATION     =>  "ZHOLD",
			CLKFBOUT_MULT_F  =>  10.0,
			DIVCLK_DIVIDE    =>  5,
			CLKFBOUT_PHASE   =>  0.0,
			CLKIN1_PERIOD    =>  2.78,
			CLKIN2_PERIOD    =>  10.0,
			CLKOUT0_DIVIDE_F =>  4.0,
			CLKOUT0_PHASE    =>  0.0,
			CLKOUT1_DIVIDE   =>  2,
			CLKOUT1_PHASE    =>  0.0,
			CLKOUT2_DIVIDE   =>  2,
			CLKOUT2_PHASE    =>  0.0,
			CLKOUT3_DIVIDE   =>  2,
			CLKOUT3_PHASE    =>  0.0,
			CLOCK_HOLD       =>  TRUE         
		)
		port map(
			CLKIN1          =>  bufg_to_mmcm_i(1),
			CLKIN2          =>  '0',
			CLKINSEL        =>  '1',
			CLKFBIN         =>  bufg_to_mmcm_i(0),
			CLKOUT0         =>  mmcm_to_bufg_i(1),
			CLKOUT0B        =>  open,
			CLKOUT1         =>  mmcm_to_bufg_i(2),
			CLKOUT1B        =>  open,
			CLKOUT2         =>  open,
			CLKOUT2B        =>  open,
			CLKOUT3         =>  open,
			CLKOUT3B        =>  open,
			CLKOUT4         =>  open,
			CLKOUT5         =>  open,
			CLKOUT6         =>  open,
			CLKFBOUT        =>  mmcm_to_bufg_i(0),
			CLKFBOUTB       =>  open,
			CLKFBSTOPPED    =>  open,
			CLKINSTOPPED    =>  open,
			DO              =>  open,
			DRDY            =>  open,
			DADDR           =>  (others => '0'),
			DCLK            =>  '0',
			DEN             =>  '0',
			DI              =>  (others => '0'),
			DWE             =>  '0',
			LOCKED          =>  MMCM_LOCK_OUT,
			PSCLK           =>  '0',
			PSEN            =>  '0',        
			PSINCDEC        =>  '0', 
			PSDONE          =>  open,         
			PWRDWN          =>  '0',
			RST             =>  MMCM_RESET_IN     
		);

end architecture;

