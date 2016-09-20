-----------------------------------------------------------------
-- Recon buffer
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity recon_buffer is
	generic(
		ADDR_WIDTH : natural 
	);
	port(
		clk       : in  std_logic;
		rst       : in  std_logic;

		-- OCP interface (slave) for Patmos
		MCmd      : in  std_logic_vector(2 downto 0);
		MAddr     : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
		MData     : in  std_logic_vector(31 downto 0);
		MByteEn   : in  std_logic_vector(3 downto 0);
		SResp     : out std_logic_vector(1 downto 0);
		SData     : out std_logic_vector(31 downto 0);

		-- Bram interface for ICAP controller 
		bram_addr   : in std_logic_vector((ADDR_WIDTH - 1) downto 0);
		bram_data_o : out std_logic_vector(31 downto 0);
		bram_we     : in std_logic_vector(3 downto 0);
		bram_data_i : in  std_logic_vector(31 downto 0)
	);
end recon_buffer;

architecture rtl of recon_buffer is
	component ocp_to_bram is
		generic(
			DATA_WIDTH : natural;
			ADDR_WIDTH : natural
		);
		port(
			clk        : in  std_logic;
			rst        : in  std_logic;

			-- OCP IN (slave)
			MCmd       : in  std_logic_vector(2 downto 0);
			MAddr      : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
			MData      : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
			MByteEn    : in  std_logic_vector(3 downto 0);
			SResp      : out std_logic_vector(1 downto 0);
			SData      : out std_logic_vector((DATA_WIDTH - 1) downto 0);

			-- Ram OUT (byte based)
			ram_addr   : out std_logic_vector((ADDR_WIDTH - 1) downto 0);
			ram_data_o : out std_logic_vector((DATA_WIDTH - 1) downto 0);
			ram_we     : out std_logic_vector(3 downto 0);
			ram_data_i : in  std_logic_vector((DATA_WIDTH - 1) downto 0)
		);
	end component;

	component tdp_sc_bram is
		generic(
			DATA_WIDTH : natural;
			ADDR_WIDTH : natural
		);
		port(
			clk      : in  std_logic;
			addr_a   : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
			addr_b   : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
			data_a_i : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
			data_b_i : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
			we_a     : in  std_logic;
			we_b     : in  std_logic;
			data_a_o : out std_logic_vector((DATA_WIDTH - 1) downto 0);
			data_b_o : out std_logic_vector((DATA_WIDTH - 1) downto 0)
		);
	end component;

	signal addr_a_int   : std_logic_vector((ADDR_WIDTH - 1) downto 0);
--	signal addr_b_int   : std_logic_vector((ADDR_WIDTH - 1) downto 0);
	signal data_a_i_int : std_logic_vector(31 downto 0);
--	signal data_b_i_int : std_logic_vector(31 downto 0);
	signal we_a_int     : std_logic_vector(3 downto 0);
--	signal we_b_int     : std_logic;
	signal data_a_o_int : std_logic_vector(31 downto 0);
--	signal data_b_o_int : std_logic_vector(31 downto 0);

begin 

ocp_to_bram_comp_0 : ocp_to_bram 
    generic map
	(
		DATA_WIDTH => 32,
		ADDR_WIDTH => ADDR_WIDTH
	) port map (
		clk        => clk,
		rst        => rst,

		-- OCP IN (slave)
		MCmd       => MCmd,
		MAddr      => MAddr,
		MData      => MData,
		MByteEn    => MByteEn,
		SResp      => SResp,
		SData      => SData,

		-- Ram OUT (byte based)
		ram_addr   => addr_a_int,
		ram_data_o => data_a_i_int,
		ram_we     => we_a_int,
		ram_data_i => data_a_o_int
	);


tdp_sc_bram_comp_0 : tdp_sc_bram -- Byte 0 LSB 
    generic map (
        DATA_WIDTH => 8,
        ADDR_WIDTH => ADDR_WIDTH
    )
    port map (
        clk => clk,
        addr_a => addr_a_int,
        addr_b => bram_addr,
        data_a_i => data_a_i_int(7 downto 0),
        data_b_i => bram_data_i(7 downto 0),
        we_a => we_a_int(0),
        we_b => bram_we(0),
        data_a_o => data_a_o_int(7 downto 0),
        data_b_o => bram_data_o(7 downto 0)
    );

tdp_sc_bram_comp_1 : tdp_sc_bram -- Byte 1 LSB 
    generic map (
        DATA_WIDTH => 8,
        ADDR_WIDTH => ADDR_WIDTH
    )
    port map (
        clk => clk,
        addr_a => addr_a_int,
        addr_b => bram_addr,
        data_a_i => data_a_i_int(15 downto 8),
        data_b_i => bram_data_i(15 downto 8),
        we_a => we_a_int(1),
        we_b => bram_we(1),
        data_a_o => data_a_o_int(15 downto 8),
        data_b_o => bram_data_o(15 downto 8)
    );

tdp_sc_bram_comp_2 : tdp_sc_bram -- Byte 2 LSB 
    generic map (
        DATA_WIDTH => 8,
        ADDR_WIDTH => ADDR_WIDTH
    )
    port map (
        clk => clk,
        addr_a => addr_a_int,
        addr_b => bram_addr,
        data_a_i => data_a_i_int(23 downto 16),
        data_b_i => bram_data_i(23 downto 16),
        we_a => we_a_int(2),
        we_b => bram_we(2),
        data_a_o => data_a_o_int(23 downto 16),
        data_b_o => bram_data_o(23 downto 16)
    );

tdp_sc_bram_comp_3 : tdp_sc_bram -- Byte 3 LSB 
    generic map (
        DATA_WIDTH => 8,
        ADDR_WIDTH => ADDR_WIDTH
    )
    port map (
        clk => clk,
        addr_a => addr_a_int,
        addr_b => bram_addr,
        data_a_i => data_a_i_int(31 downto 24),
        data_b_i => bram_data_i(31 downto 24),
        we_a => we_a_int(3),
        we_b => bram_we(3),
        data_a_o => data_a_o_int(31 downto 24),
        data_b_o => bram_data_o(31 downto 24)
    );

end rtl;
