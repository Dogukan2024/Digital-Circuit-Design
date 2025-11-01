library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench is
end testbench;

architecture TB of testbench is
    signal A, B, Sum : STD_LOGIC_VECTOR (3 downto 0);

    -- Instantiate the adder component
    component adder
        Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
               B : in  STD_LOGIC_VECTOR (3 downto 0);
               Sum : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;

begin
    UUT: adder port map (A => A, B => B, Sum => Sum);

    process
    begin
        -- Test case 1
        A <= "0011"; B <= "0101"; -- 3 + 5 = 8
        wait for 10 ns;

        -- Test case 2
        A <= "0001"; B <= "0001"; -- 1 + 1 = 2
        wait for 10 ns;

        -- Test case 3
        A <= "0110"; B <= "0010"; -- 6 + 2 = 8
        wait for 10 ns;

        wait;
    end process;
end TB;
