----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 07:46:46 PM
-- Design Name: 
-- Module Name: Full_Adder_TB - Behavioral
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

entity Full_Adder_TB is
end Full_Adder_TB;

architecture testbench of Full_Adder_TB is
    signal A, B, Cin, Sum, Cout : STD_LOGIC := '0';
   
    
    component Full_Adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;
   
begin
    
    UUT: Full_Adder
        port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => Sum,
            Cout => Cout
        );
   
    
    process
    begin
        
        A <= '0'; B <= '0'; Cin <= '0';
        wait for 10 ns;
       
        
        A <= '0'; B <= '0'; Cin <= '1';
        wait for 10 ns;
       
        
        A <= '0'; B <= '1'; Cin <= '0';
        wait for 10 ns;
       
        
        A <= '0'; B <= '1'; Cin <= '1';
        wait for 10 ns;
       
        
        A <= '1'; B <= '0'; Cin <= '0';
        wait for 10 ns;
       
        
        A <= '1'; B <= '0'; Cin <= '1';
        wait for 10 ns;
       
        
        A <= '1'; B <= '1'; Cin <= '0';
        wait for 10 ns;
       
        
        A <= '1'; B <= '1'; Cin <= '1';
        wait for 10 ns;
       
        
        wait;
    end process;
   
end testbench;
