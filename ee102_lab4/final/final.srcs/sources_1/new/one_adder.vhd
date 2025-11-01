library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity one_adder is
    Port (
        A      : in  STD_LOGIC_VECTOR (3 downto 0);
        B      : in  STD_LOGIC_VECTOR (3 downto 0);
        Opcode : in  STD_LOGIC_VECTOR (2 downto 0);
        Result : out STD_LOGIC_VECTOR (3 downto 0);
        Carry  : out STD_LOGIC
    );
end one_adder;

architecture Behavioral of one_adder is
    signal Carry_internal : STD_LOGIC_VECTOR (4 downto 0);
begin
    process (A)
    begin
        Carry_internal(0) <= '1';

        for i in 0 to 3 loop
            Result(i)     <= A(i) XOR Carry_internal(i);
            Carry_internal(i+1) <= A(i) AND Carry_internal(i);
        end loop;

        Carry <= Carry_internal(4);
    end process;
end Behavioral;
