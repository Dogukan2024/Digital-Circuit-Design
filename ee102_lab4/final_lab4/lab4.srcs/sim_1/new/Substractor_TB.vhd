----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:20:04 PM
-- Design Name: 
-- Module Name: Substractor_TB - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Subtractor_TB is
end Subtractor_TB;

architecture testbench of Subtractor_TB is
    signal A, B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal Diff : STD_LOGIC_VECTOR (3 downto 0);
    signal Bout : STD_LOGIC;
   
    
    component Subtractor
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            Diff : out STD_LOGIC_VECTOR (3 downto 0);
            Bout : out STD_LOGIC
        );
    end component;
   
begin
    
    UUT: Subtractor
        port map (
            A    => A,
            B    => B,
            Diff => Diff,
            Bout => Bout
        );
   
    
    process
    begin
        
        A <= "0000"; B <= "0000";
        wait for 10 ns;
       
        
        A <= "0101"; B <= "0011";
        wait for 10 ns;
       
        
        A <= "1000"; B <= "0100";
        wait for 10 ns;
       
        
        A <= "0111"; B <= "0111";
        wait for 10 ns;
       
        
        A <= "0001"; B <= "0010";
        wait for 10 ns;
       
        
        A <= "1111"; B <= "0001";
        wait for 10 ns;
       
        
        A <= "0110"; B <= "0010";
        wait for 10 ns;
       
        
        A <= "1010"; B <= "0101";
        wait for 10 ns;
       
        
        wait;
    end process;
   
end testbench;