library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity icap_ctrl_tb is
end;

architecture bench of icap_ctrl_tb is

  component icap_ctrl
  	port(
  		clk   : in  std_logic;
  		reset      : in  std_logic;
  		config_m   : in  ocp_core_m;
  		config_s   : out ocp_core_s;
  		ram_addr   : out std_logic_vector(RAM_ADDR_WIDTH - 1 downto 0);
  		ram_data_i : in  std_logic_vector(31 downto 0);
  		ram_re     : out std_logic;
  		icap_BUSY  : in  std_logic;
  		icap_O     : in  std_logic_vector(31 downto 0);
  		icap_CE    : out std_logic;
  		icap_CLK   : out std_logic;
  		icap_I     : out std_logic_vector(31 downto 0);
  		icap_WRITE : out std_logic
  	);
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal config_m: ocp_core_m;
  signal config_s: ocp_core_s;
  signal ram_addr: std_logic_vector(RAM_ADDR_WIDTH - 1 downto 0);
  signal ram_data_i: std_logic_vector(31 downto 0);
  signal ram_re: std_logic;
  signal icap_BUSY: std_logic;
  signal icap_O: std_logic_vector(31 downto 0);
  signal icap_CE: std_logic;
  signal icap_CLK: std_logic;
  signal icap_I: std_logic_vector(31 downto 0);
  signal icap_WRITE: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: icap_ctrl port map ( clk        => clk,
                            reset      => reset,
                            config_m   => config_m,
                            config_s   => config_s,
                            ram_addr   => ram_addr,
                            ram_data_i => ram_data_i,
                            ram_re     => ram_re,
                            icap_BUSY  => icap_BUSY,
                            icap_O     => icap_O,
                            icap_CE    => icap_CE,
                            icap_CLK   => icap_CLK,
                            icap_I     => icap_I,
                            icap_WRITE => icap_WRITE );

  stimulus: process
  begin
  
    -- Put initialisation code here

    start_ram_stream <= '1';
    wait for 5 ns;
    start_ram_stream <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
