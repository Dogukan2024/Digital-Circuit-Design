library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
end top_module;

architecture Structural of top_module is
    -- Signal declarations
    signal A : STD_LOGIC_VECTOR (3 downto 0) := "0011"; -- A = 3
    signal B : STD_LOGIC_VECTOR (3 downto 0) := "0101"; -- B = 5
    signal Sum : STD_LOGIC_VECTOR (3 downto 0);

    -- Component declaration
    component adder
        Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
               B : in  STD_LOGIC_VECTOR (3 downto 0);
               Sum : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;

begin
    -- Instantiate the adder module
    uut: adder port map (
        A => A,
        B => B,
        Sum => Sum
    );
end Structural;

