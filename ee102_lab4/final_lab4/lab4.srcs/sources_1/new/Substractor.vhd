----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:16:14 PM
-- Design Name: 
-- Module Name: Substractor - Behavioral
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

entity Subtractor is
    Port (
        A    : in  STD_LOGIC_VECTOR (3 downto 0);
        B    : in  STD_LOGIC_VECTOR (3 downto 0);
        Diff : out STD_LOGIC_VECTOR (3 downto 0);
        Bout : out STD_LOGIC
    );
end Subtractor;

architecture Behavioral of Subtractor is
    component Ripple_Carry_Adder
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC_VECTOR (3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;
   
    signal B_complement : STD_LOGIC_VECTOR (3 downto 0);
    signal CarryOut : STD_LOGIC;
   
begin
    
    B_complement <= NOT B;
   
    
    RCA: Ripple_Carry_Adder
        port map (
            A    => A,
            B    => B_complement,
            Cin  => '1', 
            Sum  => Diff,
            Cout => CarryOut
        );
   
    
    Bout <= NOT CarryOut;
   
end Behavioral;