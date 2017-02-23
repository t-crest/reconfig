
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity recon_wire is
	port(
		led_in   : in std_logic_vector(7 downto 0);
		led_out   : out std_logic_vector(7 downto 0)
	);
end recon_wire;

architecture rtl of recon_wire is

begin

led_out <= not (led_in);

end rtl;
