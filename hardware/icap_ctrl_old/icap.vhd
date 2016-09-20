-----------------------------------------------------------------
-- ICAP_interface for the XILINX FPGAs up to the family 6 
-- Author: Luca Pezzarossa (lpez@dtu.dk)
--
-- Notes:
--  - the bit ordering is not swapped, the swapping is expected to be done via software to the bit-files
--
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.vcomponents.all;
use work.icap_ctrl_defs.all;

entity icap is
	port(
		BUSY  : out std_logic;
		O     : out std_logic_vector(31 downto 0); -- 32-bit data output
		CE    : in  std_logic;          -- Clock enable input
		CLK   : in  std_logic;          -- Clock input
		I     : in  std_logic_vector(31 downto 0); -- 32-bit data input
		WRITE : in  std_logic           -- Write input
	);
end entity icap;

architecture RTL of icap is
begin

	GEN_ICAP_SPARTAN3A : if (FPGA = SPARTAN3A) generate
		ICAP_inst : ICAP_SPARTAN3A
			port map(
				BUSY  => BUSY,          -- Busy output
				O     => O,             -- 8-bit data output
				CE    => CE,            -- Clock enable input
				CLK   => CLK,           -- Clock input
				I     => I,             -- 8-bit data input
				WRITE => WRITE          -- Write input
			);
	end generate GEN_ICAP_SPARTAN3A;

	GEN_ICAP_SPARTAN6 : if (FPGA = SPARTAN6) generate
		ICAP_inst : ICAP_SPARTAN6
			generic map(
				DEVICE_ID         => X"4000093", -- Specifies the pre-programmed Device ID value
				SIM_CFG_FILE_NAME => "NONE" -- Specifies the Raw Bitstream (RBT) file to be parsed by the simulation model
			)
			port map(
				BUSY  => BUSY,          -- 1-bit output: Busy/Ready output
				O     => O,             -- 16-bit output: Configuartion data output bus
				CE    => CE,            -- 1-bit input: Active-Low ICAP Enable input
				CLK   => CLK,           -- 1-bit input: Clock input
				I     => I,             -- 16-bit input: Configuration data input bus
				WRITE => WRITE          -- 1-bit input: Read/Write control input
			);
	end generate GEN_ICAP_SPARTAN6;

	GEN_ICAP_VIRTEX4 : if (FPGA = VIRTEX4) generate
		ICAP_inst : ICAP_VIRTEX4
			generic map(
				ICAP_WIDTH => ICAP_WIDTH)     -- "X8" or "X32" 
			port map(
				BUSY  => BUSY,          -- Busy output
				O     => O,             -- 32-bit data output
				CE    => CE,            -- Clock enable input
				CLK   => CLK,           -- Clock input
				I     => I,             -- 32-bit data input
				WRITE => WRITE          -- Write input
			);
	end generate GEN_ICAP_VIRTEX4;

	GEN_ICAP_VIRTEX5 : if (FPGA = VIRTEX5) generate
		ICAP_inst : ICAP_VIRTEX5
			generic map(
				ICAP_WIDTH => ICAP_WIDTH)     -- "X8", "X16" or "X32" 
			port map(
				BUSY  => BUSY,          -- Busy output
				O     => O,             -- 32-bit data output
				CE    => CE,            -- Clock enable input
				CLK   => CLK,           -- Clock input
				I     => I,             -- 32-bit data input
				WRITE => WRITE          -- Write input
			);
	end generate GEN_ICAP_VIRTEX5;

	GEN_ICAP_VIRTEX6 : if (FPGA = VIRTEX6) generate
		ICAP_inst : ICAP_VIRTEX6
			generic map(
				DEVICE_ID         => X"4244093", -- Specifies the pre-programmed Device ID value
				ICAP_WIDTH        => ICAP_WIDTH, -- Specifies the input and output data width to be used with the ICAP_VIRTEX6.
				SIM_CFG_FILE_NAME => "NONE" -- Specifies the Raw Bitstream (RBT) file to be parsed by the simulation model
			)
			port map(
				BUSY  => BUSY,          -- 1-bit output: Busy/Ready output
				O     => O,             -- 32-bit output: Configuration data output bus
				CLK   => CLK,           -- 1-bit input: Clock Input
				CSB   => CE,            -- 1-bit input: Active-Low ICAP input Enable
				I     => I,             -- 32-bit input: Configuration data input bus
				RDWRB => WRITE          -- 1-bit input: Read/Write Select input
			);
	end generate GEN_ICAP_VIRTEX6;

end architecture RTL;
