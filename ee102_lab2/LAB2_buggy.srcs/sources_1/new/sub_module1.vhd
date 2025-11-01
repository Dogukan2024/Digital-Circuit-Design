library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sub_module1 is
	Port (
		i_input_byte  : in  STD_LOGIC_VECTOR (7 downto 0);
		o_output_byte : out STD_LOGIC_VECTOR (7 downto 0)
	);
end sub_module1;

architecture Structural_sub1 of sub_module1 is

begin
	o_output_byte(0)          <= i_input_byte(0) or i_input_byte(1); --Change these three operators according to the table in the lab document
	o_output_byte(1)          <= i_input_byte(2) or i_input_byte(3);
	o_output_byte(2)          <= i_input_byte(4) xor i_input_byte(5);
	o_output_byte(5 downto 3) <= "010";
	o_output_byte(7 downto 6) <= (others => '0');

end Structural_sub1;
