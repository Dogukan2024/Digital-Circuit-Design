----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:57:19 PM
-- Design Name: 
-- Module Name: Shift_Operations_TB - Behavioral
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

entity Shift_Operations_TB is
end Shift_Operations_TB;

architecture testbench of Shift_Operations_TB is
    signal A : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal LSL_Result, LSR_Result, ASR_Result : STD_LOGIC_VECTOR (3 downto 0);
   
    
    component Shift_Operations
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            LSL_Result : out STD_LOGIC_VECTOR (3 downto 0);
            LSR_Result : out STD_LOGIC_VECTOR (3 downto 0);
            ASR_Result : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
   
begin
    
    UUT: Shift_Operations
        port map (
            A    => A,
            LSL_Result => LSL_Result,
            LSR_Result => LSR_Result,
            ASR_Result => ASR_Result
        );
   
    
    process
    begin
        
        A <= "0001";
        wait for 10 ns;
       
        
        A <= "0101";
        wait for 10 ns;
       
        
        A <= "1001";
        wait for 10 ns;
       
        
        A <= "1110";
        wait for 10 ns;
       
        
        A <= "0110";
        wait for 10 ns;
       
        
        A <= "1010";
        wait for 10 ns;
       
        
        wait;
    end process;
   
end testbench;