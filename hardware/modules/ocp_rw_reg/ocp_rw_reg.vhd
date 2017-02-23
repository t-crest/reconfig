-----------------------------------------------------------------
-- OCP to BRAM bridge
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ocp_rw_reg is

	port(
		clk        : in  std_logic;
		rst        : in  std_logic;

		-- OCP IN (slave)
		MCmd       : in  std_logic_vector(2 downto 0);
		MAddr      : in  std_logic_vector((16 - 1) downto 0);
		MData      : in  std_logic_vector((32 - 1) downto 0);
		MByteEn    : in  std_logic_vector(3 downto 0);
		SResp      : out std_logic_vector(1 downto 0);
		SData      : out std_logic_vector((32 - 1) downto 0)
	);
end ocp_rw_reg;

architecture rtl of ocp_rw_reg is
	signal next_SResp : std_logic_vector(1 downto 0);
	signal data_reg, data_next: std_logic_vector(31 downto 0);

begin
	SData <= data_reg;

	--Control mux
	process(MCmd, MData, data_reg)
	begin
	next_SResp <= "00";
	data_next <= data_reg;
		case MCmd is
			when "001" =>               -- write
				data_next <= MData;
				next_SResp <= "01";
			when "010" =>               -- read
				next_SResp <= "01";
			when others =>              -- idle
				next_SResp <= "00";
		end case;
	end process;

	--Register
	process(clk, rst)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				SResp <= (others => '0');
				data_reg <= (others => '0');
			else
				SResp <= next_SResp;
				data_reg <= data_next;
			end if;
		end if;
	end process;

end rtl;
