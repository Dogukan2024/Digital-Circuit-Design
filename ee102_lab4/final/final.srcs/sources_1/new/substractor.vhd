library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtractor is
    Port (
        A      : in  STD_LOGIC_VECTOR (3 downto 0);
        B      : in  STD_LOGIC_VECTOR (3 downto 0);
        Opcode : in  STD_LOGIC_VECTOR (2 downto 0);
        Result : out STD_LOGIC_VECTOR (3 downto 0);
        Carry  : out STD_LOGIC
    );
end subtractor;

architecture Behavioral of subtractor is
    signal B_complement : STD_LOGIC_VECTOR (3 downto 0);
    signal Carry_internal : STD_LOGIC_VECTOR (4 downto 0);
begin
    process (A, B)
    begin
        Carry_internal(0) <= '1';
        B_complement <= NOT B;

        for i in 0 to 3 loop
            Result(i)     <= A(i) XOR B_complement(i) XOR Carry_internal(i);
            Carry_internal(i+1) <= (A(i) AND B_complement(i)) OR (A(i) AND Carry_internal(i)) OR (B_complement(i) AND Carry_internal(i));
        end loop;

        Carry <= Carry_internal(4);
    end process;
end Behavioral;
