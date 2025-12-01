----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:43:47 PM
-- Design Name: 
-- Module Name: Logic_Operations_TB - Behavioral
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

entity Logic_Operations_TB is
end Logic_Operations_TB;

architecture testbench of Logic_Operations_TB is
    signal A, B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal AND_Result, OR_Result, XOR_Result : STD_LOGIC_VECTOR (3 downto 0);
   
    
    component Logic_Operations
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            AND_Result : out STD_LOGIC_VECTOR (3 downto 0);
            OR_Result  : out STD_LOGIC_VECTOR (3 downto 0);
            XOR_Result : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
   
begin
    
    UUT: Logic_Operations
        port map (
            A    => A,
            B    => B,
            AND_Result => AND_Result,
            OR_Result  => OR_Result,
            XOR_Result => XOR_Result
        );
   
    
    process
    begin
        
        A <= "0000"; B <= "0000";
        wait for 10 ns;
       
        
        A <= "0101"; B <= "0011";
        wait for 10 ns;
       
        
        A <= "1010"; B <= "0101";
        wait for 10 ns;
       
        
        A <= "1111"; B <= "0000";
        wait for 10 ns;
       
        
        A <= "1111"; B <= "1111";
        wait for 10 ns;
       
        
        A <= "1100"; B <= "1010";
        wait for 10 ns;
       
        
        wait;
    end process;
   
end testbench;
