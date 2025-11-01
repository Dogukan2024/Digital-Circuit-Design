library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity shift_operator is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0);
           Carry : out STD_LOGIC
           );
           
end shift_operator;

architecture Behavioral of shift_operator is
    signal temp_result : UNSIGNED(4 downto 0); -- 5-bit sum
begin
    
    process (A, B, Opcode)
    begin
        case Opcode is
            when "110" => 
                Result <= '0' & A(3 downto 1);
                Carry <= '0';
            when "111" =>
                Result <= A(3) & A(3 downto 1);
                Carry <= '0';
            when others =>
                Result <= (others => '0');
                Carry <= '0';
        end case;
    end process;
       
end Behavioral;
