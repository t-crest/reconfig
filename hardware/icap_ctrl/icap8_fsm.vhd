-----------------------------------------------------------------
-- icap8_fsm
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.icap_ctrl_defs.all

entity ICAP_VIRTEX6_X8_fsm is
	port(
		-- Common
		clk         : in  std_logic;
		rst         : in  std_logic;

		-- Control
		CTRL_m : in;
		CTRL_s : out ;

		-- BRAM interface
		OCP_m	: out ocp_core_m;
		OCP_s	: in ocp_core_s; 
--		BRAM_addr   : out std_logic_vector((ADDR_WIDTH - 1) downto 0);
--		BRAM_data_i : in  std_logic_vector(31 downto 0);
--		BRAM_we     : out std_logic_vector(3 downto 0);
--		BRAM_data_o : out std_logic_vector(31 downto 0);

		-- ICAP (name directions referrend to the FPGA interface)
		ICAP_BUSY   : in  std_logic;    -- 1-bit output: Busy/Ready output
		ICAP_O      : in  std_logic_vector(31 downto 0); -- 32-bit output: Configuration data output bus	
		ICAP_CLK    : out std_logic;    -- 1-bit input: Clock Input
		ICAP_CSB    : out std_logic;    -- 1-bit input: Active-Low ICAP input Enable
		ICAP_I      : out std_logic_vector(31 downto 0); -- 32-bit input: Configuration data input bus
		ICAP_RDWRB  : out std_logic     -- 1-bit input: Read/Write Select input
	);
end ICAP_VIRTEX6_X8_fsm;

architecture rtl of ICAP_VIRTEX6_X8_fsm is
	signal count, next_count : std_logic_vector(31 downto 0);
	signal max_count, next_max_count : std_logic_vector(31 downto 0);

	type state_type is (RESET, READ_STATUS, CHECK_STATUS, READ_COUNT, RECON_1, RECON_2, RECON_3, RECON_4, WAIT_DONE, DONE);
	signal state, next_state : state_type;

	signal ICAP_I_int : std_logic_vector(31 downto 0);
begin

	ICAP_I(31 downto 8) <= (others => '0');
	--To be written better
	ICAP_I(0) <= ICAP_I_int(7);
	ICAP_I(1) <= ICAP_I_int(6);
	ICAP_I(2) <= ICAP_I_int(5);
	ICAP_I(3) <= ICAP_I_int(4);
	ICAP_I(4) <= ICAP_I_int(3);
	ICAP_I(5) <= ICAP_I_int(2);
	ICAP_I(6) <= ICAP_I_int(1);
	ICAP_I(7) <= ICAP_I_int(0);
	

	--Control Moore FSM		
	process(state, count, bram_data_i, max_count, ICAP_O)
	begin
		next_state  <= state;
		bram_addr   <= (others => '0');
		bram_data_o <= x"00000000";
		bram_we     <= "0000";
		next_count  <= count;
		next_max_count <= max_count;
		ICAP_CSB <= '1';
		ICAP_I_int <= (others => '0');

		case state is
			when RESET =>
				bram_addr   <= (others => '1');
				bram_data_o <= x"00000000";
				bram_we     <= "1111";
				next_state  <= READ_STATUS;
				
			when READ_STATUS =>
				bram_addr  <= (others => '1');-- addr of the status
				next_count <= (others => '0');
				next_state <= CHECK_STATUS;
				
			when CHECK_STATUS =>
				bram_addr((ADDR_WIDTH - 1) downto 1) <= (others => '1');-- addr of the maxcount
				bram_addr(0) <= '0';
				if (bram_data_i(0) = '0') then
					next_state <= READ_STATUS;
				else
					next_state <= READ_COUNT;
				end if;

			when READ_COUNT =>
				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
				next_count  <= count +1;
				next_max_count <= bram_data_i;
				next_state <= RECON_1;

			when RECON_1 =>
				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
				next_count  <= count +1;
				ICAP_I_int(7 downto 0) <= bram_data_i(31 downto 24);
				ICAP_CSB <= '0';
				if (count = max_count) then
					next_state <= WAIT_DONE;
				else
					next_state <= RECON_2;
				end if;
				
			when RECON_2 =>
				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
				next_count  <= count + 1;
				ICAP_I_int(7 downto 0) <= bram_data_i(23 downto 16);
				ICAP_CSB <= '0';
				if (count = max_count) then
					next_state <= WAIT_DONE;
				else
					next_state <= RECON_3;
				end if;
				
			when RECON_3 =>
				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
				next_count  <= count + 1;
				ICAP_I_int(7 downto 0) <= bram_data_i(15 downto 8);
				ICAP_CSB <= '0';
				if (count = max_count) then
					next_state <= WAIT_DONE;
				else
					next_state <= RECON_4;
				end if;
				
			when RECON_4 =>
				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
				next_count  <= count + 1;
				ICAP_I_int(7 downto 0) <= bram_data_i(7 downto 0);
				ICAP_CSB <= '0';
				if (count = max_count) then
					next_state <= WAIT_DONE;
				else
					next_state <= RECON_1;
				end if;
				
		when WAIT_DONE =>
				bram_addr   <= (others => '1');
				bram_data_o <= x"00000004";
				bram_we     <= "1111";
				ICAP_CSB <= '0';
				if (ICAP_O(7 downto 4)=x"9") then --the configuration is terminated
					next_state  <= DONE;
				else
					next_state  <= WAIT_DONE;
				end if;
			when DONE =>
				bram_addr   <= (others => '1');
				bram_data_o <= x"00000002";
				bram_we     <= "1111";
				next_state  <= READ_STATUS;
		end case;
	end process;




	-- General pourpose registers
	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				state <= RESET;
				count <= (others => '0');
				max_count <= (others => '0');
			else
				state <= next_state;
				count <= next_count;
				max_count <= next_max_count;
			end if;
		end if;
	end process;

end rtl;
