-----------------------------------------------------------------
-- ICAP_controller
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.ocp.all;
use work.icap_ctrl_defs.all;
use work.icap_ctrl_config.all;

entity icap_ctrl is
	port(
		clk   : in  std_logic;
		reset      : in  std_logic;

		-- DMA Configuration Port - OCP
		config_m   : in  ocp_core_m;
		config_s   : out ocp_core_s;

		-- Bram interface for the BRAM buffer 
		ram_addr   : out std_logic_vector(RAM_ADDR_WIDTH - 1 downto 0);
		ram_data_i : in  std_logic_vector(31 downto 0);
		ram_re     : out std_logic;

		-- ICAP interface, the signals of this interface, despite their direction, have the name of the signals of the FPGA interface
		icap_BUSY  : in  std_logic;
		icap_O     : in  std_logic_vector(31 downto 0); -- 32-bit data output
		icap_CE    : out std_logic;     -- Clock enable input
		icap_CLK   : out std_logic;     -- Clock input
		icap_I     : out std_logic_vector(31 downto 0); -- 32-bit data input
		icap_WRITE : out std_logic      -- Write input
	);
end icap_ctrl;

architecture rtl of icap_ctrl is
	
	signal icap_status : std_logic_vector(ICAP_STATUS_WIDTH-1 downto 0);
	signal ctrl_status : std_logic_vector(CTRL_STATUS_WIDTH-1 downto 0);
	
	signal status : std_logic_vector(STATUS_WIDTH-1 downto 0);
	
	signal CNT_reg : std_logic_vector(CNT_WIDTH-1 downto 0);
	signal CNT_load, CNT_down : std_logic;

	signal RUN_CNT_reg : std_logic_vector(RUN_CNT_WIDTH-1 downto 0);
	signal RUN_CNT_load, RUN_CNT_down : std_logic;

	signal RAM_ADDR_reg : std_logic_vector(RAM_ADDR_WIDTH-1 downto 2);
	signal RAM_ADDR_load, RAM_ADDR_up : std_logic;
	
	signal sw_reset, abort, start_cpu_stream, start_ram_stream : std_logic;
	
	type state_type is (READY, READY_AND_DONE, READY_AND_FAIL, RAM_STREAM_0, RAM_STREAM_1, RAM_STREAM_2, RAM_STREAM_3, WAIT_END, RAM_STREAM_WAIT, CONFIG_ABORT, CPU_STREAM_WAIT, CPU_STREAM_0, CPU_STREAM_1, CPU_STREAM_2, CPU_STREAM_3, CPU_STREAM_4, CPU_STREAM_5, CPU_STREAM_6);
	signal STATE_reg, STATE_next : state_type;
	
	signal SResp_next : std_logic_vector(OCP_RESP_WIDTH-1 downto 0);
	signal SData_next : std_logic_vector(OCP_DATA_WIDTH-1 downto 0);
	
	signal sresp_dva_mux, sresp_dva_fsm : std_logic;
	signal new_cpu_stream : std_logic;
	
	signal CPU_stream_reg : std_logic_vector(31 downto 0);
	signal CPU_stream_flag, CPU_stream_flag_clear : std_logic;
	signal RUN_CNT_load_buff : std_logic;
	
begin

	status(ICAP_STATUS_WIDTH+16-1 downto 16) <= icap_status; 
	status(15 downto CTRL_STATUS_WIDTH) <= (others => '0');
	status(CTRL_STATUS_WIDTH-1 downto 0) <= ctrl_status;

	icap_CLK <= clk;
	
	--Just passing the status from the ICAP O
	icap_status(ICAP_CFG_ERR_BIT) <= icap_O(7);
	icap_status(ICAP_DATA_SYNC_BIT) <= icap_O(6);
	icap_status(ICAP_READ_I_P_BIT) <= icap_O(5);
	icap_status(ICAP_ABORT_I_P_BIT) <= icap_O(4);
	icap_status(ICAP_BUSY_BIT) <= icap_BUSY;

	SResp_next <= OCP_RESP_DVA when (sresp_dva_mux = '1' or sresp_dva_fsm = '1') else OCP_RESP_NULL;--this is controlled by both the ocp mux and the fsm (OR)

	ram_addr(RAM_ADDR_WIDTH-1 downto 2) <= RAM_ADDR_reg;
	ram_addr(1 downto 0) <= (others => '0');
		
	--Control mux
	OCP_RW_PROC : process(config_m.MCmd, config_m.MAddr, config_m.MData, status)
	begin
		sresp_dva_mux  <= '0';
		SData_next     <= (others => '0');
		CNT_load         <= '0';
		sw_reset         <= '0';
		abort            <= '0';
		start_cpu_stream <= '0';
		start_ram_stream <= '0';
		RAM_ADDR_load    <= '0';
		new_cpu_stream <= '0';
		case config_m.MCmd is
			when OCP_CMD_WR =>
				--SResp_next <= OCP_RESP_DVA;
				case (to_integer(unsigned(config_m.MAddr(REG_TABLE_ADDR_WIDTH + 2 - 1 downto 2)))) is
					when 0 =>
						sresp_dva_mux  <= '1';--SResp_next <= OCP_RESP_DVA;
					when 1 =>
						sresp_dva_mux  <= '1';--SResp_next <= OCP_RESP_DVA;
						--Decode command
						case config_m.MData(COMMAND_WIDTH - 1 downto 0) is
							when SW_RESET_COMMAND =>
								sw_reset <= '1';
							when ABORT_COMMAND =>
								abort <= '1';
							when START_CPU_STREAM_COMMAND =>
								start_cpu_stream <= '1';
							when START_RAM_STREAM_COMMAND =>
								start_ram_stream <= '1';
							when others =>
								--do nothing
						end case;
					when 2 =>
						--Load bitfile length into the counter
						sresp_dva_mux  <= '1';--SResp_next <= OCP_RESP_DVA;
						CNT_load <= '1';
					when 3 =>
						--Load start address
						sresp_dva_mux  <= '1';--SResp_next <= OCP_RESP_DVA;
						RAM_ADDR_load <= '1';
					when 4      =>
						--Stream interface
						new_cpu_stream <= '1';--resp is not ackonowledged
					when others =>
						sresp_dva_mux  <= '1';
						--do nothing
				end case;

			when OCP_CMD_RD =>
				sresp_dva_mux  <= '1';--SResp_next <= OCP_RESP_DVA;
				case (to_integer(unsigned(config_m.MAddr(REG_TABLE_ADDR_WIDTH + 2 - 1 downto 2)))) is
					when 0 =>
						--Read STATUS register
						SData_next(STATUS_WIDTH - 1 downto 0) <= status;
					when 5 =>
						SData_next <= X"01234567"; -- this is for debug purposes (to be removed)
					when 6 =>
						SData_next <= X"89ABCDEF"; -- this is for debug purposes (to be removed)
					when 7 =>
						SData_next <= X"AABBCCDD"; -- this is for debug purposes (to be removed)
					when others =>
				--do nothing
				end case;

			when others =>
		--do nothing
		end case;
	end process;

	--Control FSM		
	Control_FSM_PROC : process(STATE_reg, CNT_reg, RUN_CNT_reg, abort, icap_BUSY, icap_O(7 downto 4), ram_data_i, start_cpu_stream, start_ram_stream, CPU_stream_flag, CPU_stream_reg)
	begin
		STATE_next  <= STATE_reg;
		ctrl_status <= ND_STATUS;

		ram_re <= '0';
		
		RAM_ADDR_up <= '0';
		CNT_down <= '0';
		
		RUN_CNT_load <= '0';
		RUN_CNT_load_buff <= '0';
		RUN_CNT_down <= '0';
		
		icap_CE <= '1';
		icap_I <= ram_data_i; -- the default was this (others => '0'), nut multiplexing is saved in this way
		icap_WRITE <= '0';
		
		CPU_stream_flag_clear <= '0'; 
		sresp_dva_fsm <= '0';
		
		
		case STATE_reg is
			when READY =>
				ctrl_status <= READY_STATUS;
				if start_ram_stream = '1' then
					STATE_next <= RAM_STREAM_WAIT;
				elsif start_cpu_stream = '1' then
					STATE_next <= CPU_STREAM_WAIT;
				end if;
				
			when READY_AND_DONE =>
				ctrl_status <= READY_AND_DONE_STATUS;
				if start_ram_stream = '1' then
					STATE_next <= RAM_STREAM_WAIT;
				elsif start_cpu_stream = '1' then
					STATE_next <= CPU_STREAM_WAIT;
				end if;
				
			when READY_AND_FAIL =>
				ctrl_status <= READY_AND_FAIL_STATUS;
				if start_ram_stream = '1' then
					STATE_next <= RAM_STREAM_WAIT;
				elsif start_cpu_stream = '1' then
					STATE_next <= CPU_STREAM_WAIT;
				end if;
				
			when RAM_STREAM_WAIT =>
				ctrl_status <= WAIT_BUSY_ICAP_STATUS;
				if abort = '1' then
					STATE_next <= READY_AND_FAIL;
				elsif icap_BUSY = '1' then --if not busy, icap_BUSY=1
					STATE_next <= RAM_STREAM_0;
				end if;
					
			when RAM_STREAM_0 => --first step, never repeats
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				--ram_addr(RAM_ADDR_WIDTH-1 downto 2) <= RAM_ADDR_reg;
				ram_re <= '1';
				RAM_ADDR_up <= '1';
				CNT_down <= '1';
				if abort = '1' or (to_integer(unsigned(CNT_reg)) = 0) then
					STATE_next <= READY_AND_FAIL; --NOTHING WAS WRITTEN, I FAIL
				else
					STATE_next <= RAM_STREAM_1;
				end if;
								
			when RAM_STREAM_1 => --read ram
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				--ram_addr(RAM_ADDR_WIDTH-1 downto 2) <= RAM_ADDR_reg;
				if ram_data_i = ESCAPE then
					ram_re <= '1';
					--icap_I <= ram_data_i;
					--icap_CE <= '0';
					RAM_ADDR_up <= '1';
					CNT_down <= '1';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next  <= RAM_STREAM_2;
					end if;
				else
					ram_re <= '1';
					icap_I <= ram_data_i;
					icap_CE <= '0';
					RAM_ADDR_up <= '1';
					CNT_down <= '1';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					end if;
				end if;
				
			when RAM_STREAM_2 => --read ram
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				--ram_addr(RAM_ADDR_WIDTH-1 downto 2) <= RAM_ADDR_reg;
				ram_re <= '1';
				CNT_down <= '1';
				if ram_data_i = ESCAPE then --it was a double escape
					RAM_ADDR_up <= '1';
					icap_I <= ram_data_i;
					icap_CE <= '0';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next  <= RAM_STREAM_1;
					end if;
				else --I found a compressed run
					RAM_ADDR_up <= '0';-- added to correct a bug (test)
					RUN_CNT_load <= '1';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next <= RAM_STREAM_3;
					end if;
				end if;				
				
			when RAM_STREAM_3 => --read ram
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				--ram_addr(RAM_ADDR_WIDTH-1 downto 2) <= RAM_ADDR_reg;
				icap_I <= ram_data_i;
				icap_CE <= '0';
				if (to_integer(unsigned(RUN_CNT_reg)) = 2) then --it is the end, load the next (n.b leghts of less than 2 are not ammitted)
					ram_re <= '1';
					RAM_ADDR_up <= '1';
					CNT_down <= '1';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next  <= RAM_STREAM_1;
					end if;
				else --de-compressing a run
					--icap_CE <= '0';
					RUN_CNT_down <= '1';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					end if;
				end if;		

			when CPU_STREAM_WAIT =>
				ctrl_status <= WAIT_BUSY_ICAP_STATUS;
				if abort = '1' then
					STATE_next <= READY_AND_FAIL;
				elsif icap_BUSY = '1' then --if not busy, icap_BUSY=1
					STATE_next <= CPU_STREAM_0;
				end if;

			when CPU_STREAM_0 => --first step, never repeats
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				if abort = '1' or (to_integer(unsigned(CNT_reg)) = 0) then
					STATE_next <= READY_AND_FAIL; -- I wrote nothing, I faild
				elsif CPU_stream_flag = '1' then
					STATE_next <= CPU_STREAM_2;
					CNT_down <= '1';
					CPU_stream_flag_clear <= '1'; 
				end if;

			when CPU_STREAM_1 => -- waiting for an input
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				if abort = '1' then
					STATE_next <= CONFIG_ABORT;
				elsif CPU_stream_flag = '1' then
					STATE_next <= CPU_STREAM_1;
					CNT_down <= '1';
					CPU_stream_flag_clear <= '1'; 
				end if;

			when CPU_STREAM_2 => --read ram
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				sresp_dva_fsm <= '1';
				if CPU_stream_reg = ESCAPE then
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next  <= CPU_STREAM_3;
					end if;
				else
					icap_I <= CPU_stream_reg;
					icap_CE <= '0';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next  <= CPU_STREAM_1;
					end if;
				end if;
				
			when CPU_STREAM_3 => -- waiting for an input
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				if abort = '1' then
					STATE_next <= CONFIG_ABORT;
				elsif CPU_stream_flag = '1' then
					STATE_next <= CPU_STREAM_4;
					CNT_down <= '1';
					CPU_stream_flag_clear <= '1'; 
				end if;
				
			when CPU_STREAM_4 => --read ram
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				sresp_dva_fsm <= '1';
				if ram_data_i = ESCAPE then --it was a double escape
					icap_I <= CPU_stream_reg;
					icap_CE <= '0';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next  <= CPU_STREAM_1;
					end if;
				else --I found a compressed run
					RUN_CNT_load_buff <= '1'; --load form the buffer
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next <= CPU_STREAM_5;
					end if;
				end if;
				
			when CPU_STREAM_5 => -- waiting for an input
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				if abort = '1' then
					STATE_next <= CONFIG_ABORT;
				elsif CPU_stream_flag = '1' then
					STATE_next <= CPU_STREAM_6;
					CNT_down <= '1';
					CPU_stream_flag_clear <= '1'; 
				end if;				
				
			when CPU_STREAM_6 => --read ram
				ctrl_status <= WRITE_IN_PROGRESS_STATUS;
				icap_I <= CPU_stream_reg;
				if (to_integer(unsigned(RUN_CNT_reg)) = 0) then --it is the end, load the next
					sresp_dva_fsm <= '1';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					elsif (to_integer(unsigned(CNT_reg)) = 0) then
						STATE_next  <= WAIT_END;
					else
						STATE_next  <= CPU_STREAM_1;
					end if;
				else --de-compressing a run
					RUN_CNT_down <= '1';
					icap_CE <= '0';
					if abort = '1' then
						STATE_next <= CONFIG_ABORT;
					end if;
				end if;					
			
			when WAIT_END =>
				ctrl_status <= WAIT_END_STATUS;
				icap_CE <= '0';
				if abort = '1' then
					STATE_next <= CONFIG_ABORT;
				elsif (icap_O(7 downto 4)=x"9") then --the configuration is terminated
					STATE_next  <= READY_AND_DONE;
				elsif (icap_O(7 downto 4)=x"5" or icap_O(7 downto 4)=x"1") then
					STATE_next  <= READY_AND_FAIL;
				end if;
				
			when CONFIG_ABORT =>
				ctrl_status <= ABORT_IN_PROGRESS_STATUS;
				icap_CE <= '0';
				icap_WRITE <= '1';
				if icap_BUSY = '1' then
					STATE_next <= READY_AND_FAIL;
				end if;
				
		end case;
	end process;


  -- Counter register
  RUN_CNT_reg_PROC : process(clk)
  begin
  	if rising_edge(clk) then
  		if reset = '1' then
  			RUN_CNT_reg <= (others => '0');
  		else
  			if sw_reset = '1' then
  				RUN_CNT_reg <= (others => '0');
  			elsif RUN_CNT_load = '1' then
  				RUN_CNT_reg <= ram_data_i(RUN_CNT_WIDTH-1 downto 0);-- - 1; --this can be moved in software
  			elsif RUN_CNT_load_buff = '1' then
  					RUN_CNT_reg <= CPU_stream_reg(RUN_CNT_WIDTH-1 downto 0);-- - 1; --this can be moved in software
  			elsif RUN_CNT_down = '1' then
  				RUN_CNT_reg <= RUN_CNT_reg - 1;
  			end if;
  		end if;
  	end if;
  end process ;

  -- Counter register
  CNT_reg_PROC : process(clk)
  begin
  	if rising_edge(clk) then
  		if reset = '1' then
  			CNT_reg <= (others => '0');
  		else
  			if sw_reset = '1' then
  				CNT_reg <= (others => '0');
  			elsif CNT_load = '1' then
  				CNT_reg <= config_m.MData(CNT_WIDTH-1 downto 0);
  			elsif CNT_down = '1' then
  				CNT_reg <= CNT_reg - 1;
  			end if;
  		end if;
  	end if;
  end process ;
  
  -- RAM address register
  RAM_ADDR_reg_PROC : process(clk)
  begin
  	if rising_edge(clk) then
  		if reset = '1' then
  			RAM_ADDR_reg <= (others => '0');
  		else
  			if sw_reset = '1' then
  				RAM_ADDR_reg <= (others => '0');
  			elsif RAM_ADDR_load = '1' then
  				RAM_ADDR_reg <= config_m.MData(RAM_ADDR_WIDTH-1 downto 2);
  			elsif RAM_ADDR_up = '1' then
  				RAM_ADDR_reg <= RAM_ADDR_reg + 1;
  			end if;
  		end if;
  	end if;
  end process ;

  -- CPU stream buffer
  CPU_stream_reg_PROC : process(clk)
  begin
  	if rising_edge(clk) then
  		if reset = '1' then
  			CPU_stream_reg <= (others => '0');
  		else
  			if sw_reset = '1' then
  				CPU_stream_reg <= (others => '0');
  			elsif new_cpu_stream = '1' then
  				CPU_stream_reg <= config_m.MData(31 downto 0);
  			end if;
  		end if;
  	end if;
  end process;


  -- CPU stream flag
  CPU_stream_flag_PROC : process(clk)
  begin
  	if rising_edge(clk) then
  		if reset = '1' then
  			CPU_stream_flag <= '0';
  		else
  			if sw_reset = '1' or CPU_stream_flag_clear = '1' then
  				CPU_stream_flag <= '0';
  			elsif new_cpu_stream = '1' then
  				CPU_stream_flag <= '1';
  			end if;
  		end if;
  	end if;
  end process;

    -- General pourpose registers
  GP_reg_PROC : process(clk)
  begin
  	if rising_edge(clk) then
  		if reset = '1' then
  			STATE_reg <= READY;
  			config_s.SResp <= OCP_RESP_NULL;
  			config_s.SData <= (others => '0');
  		else
  			if sw_reset = '1' then
  				STATE_reg <= READY;
  				config_s.SResp <= OCP_RESP_NULL;
  				config_s.SData <= (others => '0');
  			else
  				STATE_reg <= STATE_next;
  				config_s.SResp <= SResp_next;
  				config_s.SData <= SData_next;
  			end if;
  		end if;
  	end if;
  end process;

end rtl;

--	ICAP_I(31 downto 8) <= (others => '0');
--	--To be written better
--	ICAP_I(0) <= ICAP_I_int(7);
--	ICAP_I(1) <= ICAP_I_int(6);
--	ICAP_I(2) <= ICAP_I_int(5);
--	ICAP_I(3) <= ICAP_I_int(4);
--	ICAP_I(4) <= ICAP_I_int(3);
--	ICAP_I(5) <= ICAP_I_int(2);
--	ICAP_I(6) <= ICAP_I_int(1);
--	ICAP_I(7) <= ICAP_I_int(0);
--	
--
--	--Control Moore FSM		
--	process(state, count, bram_data_i, max_count, ICAP_O)
--	begin
--		next_state  <= state;
--		bram_addr   <= (others => '0');
--		bram_data_o <= x"00000000";
--		bram_we     <= "0000";
--		next_count  <= count;
--		next_max_count <= max_count;
--		ICAP_CSB <= '1';
--		ICAP_I_int <= (others => '0');
--
--		case state is
--			when RESET =>
--				bram_addr   <= (others => '1');
--				bram_data_o <= x"00000000";
--				bram_we     <= "1111";
--				next_state  <= READ_STATUS;
--				
--			when READ_STATUS =>
--				bram_addr  <= (others => '1');
--				next_count <= (others => '0');
--				next_state <= CHECK_STATUS;
--				
--			when CHECK_STATUS =>
--				bram_addr((ADDR_WIDTH - 1) downto 1) <= (others => '1');
--				bram_addr(0) <= '0';
--				if (bram_data_i(0) = '0') then
--					next_state <= READ_STATUS;
--				else
--					next_state <= READ_COUNT;
--				end if;
--
--			when READ_COUNT =>
--				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
--				next_count  <= count +1;
--				next_max_count <= bram_data_i;
--				next_state <= RECON_1;
--
--			when RECON_1 =>
--				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
--				next_count  <= count +1;
--				ICAP_I_int(7 downto 0) <= bram_data_i(31 downto 24);
--				ICAP_CSB <= '0';
--				if (count = max_count) then
--					next_state <= WAIT_DONE;
--				else
--					next_state <= RECON_2;
--				end if;
--				
--			when RECON_2 =>
--				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
--				next_count  <= count + 1;
--				ICAP_I_int(7 downto 0) <= bram_data_i(23 downto 16);
--				ICAP_CSB <= '0';
--				if (count = max_count) then
--					next_state <= WAIT_DONE;
--				else
--					next_state <= RECON_3;
--				end if;
--				
--			when RECON_3 =>
--				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
--				next_count  <= count + 1;
--				ICAP_I_int(7 downto 0) <= bram_data_i(15 downto 8);
--				ICAP_CSB <= '0';
--				if (count = max_count) then
--					next_state <= WAIT_DONE;
--				else
--					next_state <= RECON_4;
--				end if;
--				
--			when RECON_4 =>
--				bram_addr <= count((ADDR_WIDTH + 1) downto 2);
--				next_count  <= count + 1;
--				ICAP_I_int(7 downto 0) <= bram_data_i(7 downto 0);
--				ICAP_CSB <= '0';
--				if (count = max_count) then
--					next_state <= WAIT_DONE;
--				else
--					next_state <= RECON_1;
--				end if;
--		when WAIT_DONE =>
--				bram_addr   <= (others => '1');
--				bram_data_o <= x"00000004";
--				bram_we     <= "1111";
--				ICAP_CSB <= '0';
--				if (ICAP_O(7 downto 4)=x"9") then --the configuration is terminated
--					next_state  <= DONE;
--				else
--					next_state  <= WAIT_DONE;
--				end if;
--			when DONE =>
--				bram_addr   <= (others => '1');
--				bram_data_o <= x"00000002";
--				bram_we     <= "1111";
--				next_state  <= READ_STATUS;
--		end case;
--	end process;



--	ram_addr <= MAddr;
--	ram_data_o <= MData;
--	SData <= ram_data_i;

