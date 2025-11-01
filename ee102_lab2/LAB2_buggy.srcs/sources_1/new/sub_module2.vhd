library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sub_module2 is
    Port (
        i_switch_inputs : in  STD_LOGIC_VECTOR (7 downto 0);
        o_output_vector : out STD_LOGIC_VECTOR (7 downto 0)
    );
end sub_module2;
architecture Structural_sub2 of sub_module2 is
    component sub_module1 is
        port (
            i_input_byte  : in  STD_LOGIC_VECTOR (7 downto 0);
            o_output_byte : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component sub_module1;

    signal s_inv_input : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    s_inv_input <= not i_switch_inputs;

    sub_module1_1 : sub_module1
        port map (
            i_input_byte  => s_inv_input,
            o_output_byte => o_output_vector
        );
end Structural_sub2;
