library ieee;
use ieee.std_logic_1164.all;

package icap_ctrl_config is

	--ICAP interface paramenters
	type fpga_type is (SPARTAN3A, SPARTAN6, VIRTEX4, VIRTEX5, VIRTEX6);
	constant FPGA : fpga_type := VIRTEX6;
	
	constant ICAP_WIDTH : string := "X32";-- "X8", "X16" or "X32" 
	
	constant ESCAPE : std_logic_vector(31 downto 0) := x"00000001";
	
	--Status and control register SCreg

	--The netto numer of bits that describe the status
	constant ICAP_STATUS_WIDTH : natural := 5;
	constant CTRL_STATUS_WIDTH : natural := 3;
	
	constant STATUS_WIDTH : natural := ICAP_STATUS_WIDTH+16;

	--Status bit position in the 32 bit word written by the CPU
	constant ICAP_CFG_ERR_BIT     : natural := 4;
	constant ICAP_DATA_SYNC_BIT   : natural := 3;
	constant ICAP_READ_I_P_BIT    : natural := 2;
	constant ICAP_ABORT_I_P_BIT   : natural := 1;
	constant ICAP_BUSY_BIT		  : natural := 0;

	constant READY_STATUS             : std_logic_vector(CTRL_STATUS_WIDTH - 1 downto 0) := "000";
	constant READY_AND_DONE_STATUS    : std_logic_vector(CTRL_STATUS_WIDTH - 1 downto 0) := "001";
	constant READY_AND_FAIL_STATUS    : std_logic_vector(CTRL_STATUS_WIDTH - 1 downto 0) := "010";
	constant WAIT_BUSY_ICAP_STATUS    : std_logic_vector(CTRL_STATUS_WIDTH - 1 downto 0) := "011";
	constant WRITE_IN_PROGRESS_STATUS : std_logic_vector(CTRL_STATUS_WIDTH - 1 downto 0) := "100";
	constant WAIT_END_STATUS          : std_logic_vector(CTRL_STATUS_WIDTH - 1 downto 0) := "101";
	constant ABORT_IN_PROGRESS_STATUS : std_logic_vector(CTRL_STATUS_WIDTH - 1 downto 0) := "110";
	constant ND_STATUS                : std_logic_vector(CTRL_STATUS_WIDTH - 1 downto 0) := "111";

	--The netto numer of bits that describe the control
	constant COMMAND_WIDTH      : natural := 2;

	--COMMANDs taht can be written by the CPU
	constant SW_RESET_COMMAND          : std_logic_vector(COMMAND_WIDTH-1 downto 0) := "00";
	constant ABORT_COMMAND             : std_logic_vector(COMMAND_WIDTH-1 downto 0) := "01";
	constant START_CPU_STREAM_COMMAND  : std_logic_vector(COMMAND_WIDTH-1 downto 0) := "10";
	constant START_RAM_STREAM_COMMAND  : std_logic_vector(COMMAND_WIDTH-1 downto 0) := "11";
	
	constant REG_TABLE_ADDR_WIDTH       : natural := 3;

	--this is the bit size of the maximum lenght of a bit-file
	constant CNT_WIDTH     : natural := 14;--in words
	
	constant RUN_CNT_WIDTH     : natural := 8;
	
	constant RAM_ADDR_WIDTH       : natural := 16;--bytes based addr
	
	--type icap_width_type is (SPARTAN3A, SPARTAN6, VIRTEX4, VIRTEX5, VIRTEX6);
	

--
--  -- SPM
--  constant DATA_WIDTH         : integer := 32;
--  constant SPM_CMD_WIDTH      : integer := 1;  -- 8 possible cmds --> 2
--  constant SPM_DATA_WIDTH     : integer := 64;
--  constant BLK_CNT            : integer := 14;
--  constant SPM_ADDR_WIDTH_MAX : integer := 16;  -- SPM addr width cannot be more than 16 bits -> 256kb
--
--  -- async network
--  --constant PHIT_WIDTH : integer := 35;        -- see packet format -->32 + 3 control bits
--  constant LINK_WIDTH : integer := 35;            -- 32 bit data + 1 type bit 1
--                                                  -- SOP and 1 EOP
--  constant PHIT_WIDTH : integer := LINK_WIDTH-1;  -- phit without the type bit
--  constant ARITY      : integer := 5;
--
--  -- scheduling
--  constant ADDR_SLT_WIDTH : integer := log2up(PRD_LENGTH-1);
--  --constant PRD_LENGTH : integer := 2**ADDR_SLT_WIDTH; -- 2^6 = 64 -- 2^3 = 8
--
--  constant MAX_PERIOD : integer := 128;
--
--  -- DMA
--  constant DMA_IND_WIDTH : integer := log2up(NODES-1);
--  --constant NODES              : integer := 2**DMA_IND_WIDTH;  -- 2^2 = 4 nodes
--  constant DMA_WIDTH     : integer := 64;
--  --DMA banks sizes
--  constant BANK0_W       : integer := 16;
--  constant BANK1_W       : integer := 32;
--  constant BANK2_W       : integer := 16;
--
--
--
--  --addressing
--  constant ADDR_MASK_W : integer                                  := 8;
--  --starting address of DMA table (0,1) -unprotected 00100000 xxxx...
--  constant DMA_MASK    : std_logic_vector(ADDR_MASK_W-1 downto 0) := x"E0";  --"11100000";
--  --starting address of DMA route table (2) -protected 00010000 xxx.....
--  constant DMA_P_MASK  : std_logic_vector(ADDR_MASK_W-1 downto 0) := x"E1";  --"11100001";
--  --starting address of slot-table -protected 00011000 xxx.....
--  constant ST_MASK     : std_logic_vector(ADDR_MASK_W-1 downto 0) := x"E2";  --"11100010";
--
--  --configuration options
--  constant CNULL        : std_logic_vector(3 downto 0) := "0000";
--  constant ST_ACCESS    : std_logic_vector(3 downto 0) := "1000";
--  constant DMA_R_ACCESS : std_logic_vector(3 downto 0) := "0001";
--  constant DMA_H_ACCESS : std_logic_vector(3 downto 0) := "0100";
--  constant DMA_L_ACCESS : std_logic_vector(3 downto 0) := "0010";
--
--  --for reconfigurable slot table
--  type sltt_type is array (PRD_LENGTH-1 downto 0) of std_logic_vector (DMA_IND_WIDTH-1 downto 0);
--
----------------------------------------------------router-----------------------
--
--  -- types for network
--  subtype link_t is std_logic_vector(LINK_WIDTH-1 downto 0);
--  subtype type_t is std_logic;
--  subtype phit_t is std_logic_vector(PHIT_WIDTH-1 downto 0);
--  subtype onehot_sel is std_logic_vector(ARITY-1 downto 0);
--
--
--  constant LINE_ZERO : link_t := (others => '0');
--
--
--  -- Channels for bundled-data communication
--  type channel_forward is record
--    req  : std_logic;
--    data : link_t;
--  end record channel_forward;
--
--  type channel_backward is record
--    ack : std_logic;
--  end record channel_backward;
--
----      type channel is record
----              forward : channel_forward;
----              backward : channel_backward;
----      end record channel;
--
--  -- Types to make design generic
--  type switch_sel_t is array (ARITY-1 downto 0) of onehot_sel;
--  type chs_f is array (ARITY-1 downto 0) of channel_forward;
--  type chs_b is array (ARITY-1 downto 0) of channel_backward;
--  type bars_t is array (ARITY-1 downto 0, ARITY-1 downto 0) of link_t;
--
--  --constant delay : time := 0.3 ns; -- Migrated to delays.vhd
--
--  

end package icap_ctrl_config;





