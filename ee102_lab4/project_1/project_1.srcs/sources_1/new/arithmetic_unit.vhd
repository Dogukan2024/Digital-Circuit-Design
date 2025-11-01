library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity arithmetic_unit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0);
           Carry : out STD_LOGIC
           );
end arithmetic_unit;

architecture Behavioral of arithmetic_unit is
    signal temp_result : UNSIGNED(4 downto 0); -- 5-bit sum
begin
    process (A, Opcode)
    begin
                -- ✅ Force Default Assignments to Prevent Latch Effect
        temp_result <= (others => '0');
        Result <= (others => '0');
        Carry <= '0';
        case Opcode is
            when "010" => -- Increment A
                temp_result <= unsigned('0' & A) + 1;
            when "011" => -- Decrement A
                temp_result <= unsigned('0' & A) - 1;
            when others =>
                temp_result <= (others => '0');
        end case;

        -- ✅ Assign outputs
        Result <= std_logic_vector(temp_result(3 downto 0));
        Carry <= temp_result(4);
    end process;
end Behavioral;

       