library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_subtractor is
    Port ( A_adder : in STD_LOGIC_VECTOR (3 downto 0);
           B_adder : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode_adder : in STD_LOGIC_VECTOR (2 downto 0);
           Result_adder : out STD_LOGIC_VECTOR (3 downto 0);
           Carry_adder : out STD_LOGIC  -- ✅ Carry included
           );
end adder_subtractor;

architecture Behavioral of adder_subtractor is
    signal temp_result : UNSIGNED(4 downto 0); -- 5-bit sum to store carry
begin
    process (A_adder, B_adder, Opcode_adder)
    begin
                -- ✅ Force Default Assignments to Prevent Latch Effect
        temp_result <= (others => '0');
        Result_adder <= (others => '0');
        Carry_adder <= '0';
        case Opcode_adder is
            when "000" => 
                temp_result <= unsigned("0" & A_adder) + unsigned("0" & B_adder);
            when "001" =>
                temp_result <= unsigned("0" & A_adder) - unsigned("0" & B_adder);
            when others =>
                temp_result <= (others => '0');
        end case;

        -- ✅ Assign outputs after computation
        Result_adder <= std_logic_vector(temp_result(3 downto 0));  -- ✅ Only return lower 4 bits
        Carry_adder <= temp_result(4);  -- ✅ Carry is stored in MSB
    end process;
end Behavioral;
