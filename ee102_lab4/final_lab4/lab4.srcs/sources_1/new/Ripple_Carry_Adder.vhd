----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:02:22 PM
-- Design Name: 
-- Module Name: Ripple_Carry_Adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ripple_Carry_Adder is
    Port (
        A    : in  STD_LOGIC_VECTOR (3 downto 0);
        B    : in  STD_LOGIC_VECTOR (3 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR (3 downto 0);
        Cout : out STD_LOGIC
    );
end Ripple_Carry_Adder;

architecture Structural of Ripple_Carry_Adder is
    component Full_Adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;
   
    signal Carry : STD_LOGIC_VECTOR (3 downto 0);
   
begin
    
    FA0: Full_Adder port map (
        A    => A(0),
        B    => B(0),
        Cin  => Cin,
        Sum  => Sum(0),
        Cout => Carry(0)
    );
   
    
    FA1: Full_Adder port map (
        A    => A(1),
        B    => B(1),
        Cin  => Carry(0),
        Sum  => Sum(1),
        Cout => Carry(1)
    );
   
    
    FA2: Full_Adder port map (
        A    => A(2),
        B    => B(2),
        Cin  => Carry(1),
        Sum  => Sum(2),
        Cout => Carry(2)
    );
   
    
    FA3: Full_Adder port map (
        A    => A(3),
        B    => B(3),
        Cin  => Carry(2),
        Sum  => Sum(3),
        Cout => Cout
    );
   
end Structural;

