library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity logic_unit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0);
           Carry : out STD_LOGIC
           );
           
end logic_unit;

architecture Behavioral of logic_unit is
    signal temp_result : UNSIGNED(4 downto 0); -- 5-bit sum
begin
    
    process (A, B, Opcode)
    begin
        case Opcode is
            when "100" => 
                Result <= A and B; 
                Carry <= '0';
            when "101" =>
                Result <= A or B; 
                Carry <= '0';
            when others =>
                Result <= (others => '0');
                Carry <= '0';
        end case;
    end process;
       
end Behavioral;
