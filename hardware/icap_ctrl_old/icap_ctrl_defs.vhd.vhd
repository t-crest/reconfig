library ieee;
use ieee.std_logic_1164.all;

package icap_ctrl_defs is

	--ICAP interface paramenters
	type fpga_type is (SPARTAN3A, SPARTAN6, VIRTEX4, VIRTEX5, VIRTEX6);
	constant FPGA : fpga_type := VIRTEX6;
	
	constant ICAP_WIDTH : string := "X32";-- "X8", "X16" or "X32" 


	
	--type icap_width_type is (SPARTAN3A, SPARTAN6, VIRTEX4, VIRTEX5, VIRTEX6);
	

	-- CTRL
	constant CTRL_CMD_WIDTH  : integer := 3; -- 8 possible cmds --> 2
	constant CTRL_CMD_IDLE : std_logic_vector(CTRL_CMD_WIDTH - 1 downto 0) := "000";
	constant CTRL_CMD_START_W : std_logic_vector(CTRL_CMD_WIDTH - 1 downto 0) := "000";
	constant CTRL_CMD_CONTINUE_W : std_logic_vector(CTRL_CMD_WIDTH - 1 downto 0) := "000";
	constant CTRL_CMD_STOP_W : std_logic_vector(CTRL_CMD_WIDTH - 1 downto 0) := "000";

	type ctrl_m is record
		MStart  : std_logic;
--		MContinue
--		MStop
--		MAbort  : std_logic;
		MRW     : std_logic;
		MRaddr  : std_logic_vector(-1 downto 0);
		MWaddr  : std_logic_vector(-1 downto 0);
		MLength : std_logic_vector(-1 downto 0);
	end record;

	type ctrl_s is record
		SIdle  : std_logic;
		SPause : std_logic;
		SStatus : std_logic_vector(-1 downto 0);
	end record;

	-- OCP
	constant OCP_CMD_WIDTH  : integer := 3; -- 8 possible cmds --> 2
	constant OCP_ADDR_WIDTH : integer := 32; --32
	constant OCP_DATA_WIDTH : integer := 32;
	constant OCP_BYTE_WIDTH : integer := OCP_DATA_WIDTH / 8;
	constant OCP_RESP_WIDTH : integer := 2;

	constant OCP_CMD_IDLE : std_logic_vector(OCP_CMD_WIDTH - 1 downto 0) := "000";
	constant OCP_CMD_WR   : std_logic_vector(OCP_CMD_WIDTH - 1 downto 0) := "001";
	constant OCP_CMD_RD   : std_logic_vector(OCP_CMD_WIDTH - 1 downto 0) := "010";
	--constant OCP_CMD_RDEX : std_logic_vector(OCP_CMD_WIDTH-1 downto 0) := "011";
	--constant OCP_CMD_RDL  : std_logic_vector(OCP_CMD_WIDTH-1 downto 0) := "100";
	--constant OCP_CMD_WRNP : std_logic_vector(OCP_CMD_WIDTH-1 downto 0) := "101";
	--constant OCP_CMD_WRC  : std_logic_vector(OCP_CMD_WIDTH-1 downto 0) := "110";
	--constant OCP_CMD_BCST : std_logic_vector(OCP_CMD_WIDTH-1 downto 0) := "111";

	constant OCP_RESP_NULL : std_logic_vector(OCP_RESP_WIDTH - 1 downto 0) := "00";
	constant OCP_RESP_DVA  : std_logic_vector(OCP_RESP_WIDTH - 1 downto 0) := "01";
	constant OCP_RESP_FAIL : std_logic_vector(OCP_RESP_WIDTH - 1 downto 0) := "10";
	constant OCP_RESP_ERR  : std_logic_vector(OCP_RESP_WIDTH - 1 downto 0) := "11";

	type ocp_core_m is record
		MCmd    : std_logic_vector(OCP_CMD_WIDTH - 1 downto 0);
		MAddr   : std_logic_vector(OCP_ADDR_WIDTH - 1 downto 0);
		MData   : std_logic_vector(OCP_DATA_WIDTH - 1 downto 0);
		MByteEn : std_logic_vector(OCP_BYTE_WIDTH - 1 downto 0);
	end record;

	type ocp_core_s is record
		SResp : std_logic_vector(OCP_RESP_WIDTH - 1 downto 0);
		SData : std_logic_vector(OCP_DATA_WIDTH - 1 downto 0);
	end record;

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

end package icap_ctrl_defs;




