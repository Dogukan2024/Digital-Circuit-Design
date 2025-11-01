----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:07:16 PM
-- Design Name: 
-- Module Name: Ripple_Carry_Adder_TB - Behavioral
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

entity Ripple_Carry_Adder_TB is
end Ripple_Carry_Adder_TB;

architecture testbench of Ripple_Carry_Adder_TB is
    signal A, B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal Cin  : STD_LOGIC := '0';
    signal Sum  : STD_LOGIC_VECTOR (3 downto 0);
    signal Cout : STD_LOGIC;
   
    
    component Ripple_Carry_Adder
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC_VECTOR (3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;
   
begin
    
    UUT: Ripple_Carry_Adder
        port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => Sum,
            Cout => Cout
        );
   
    
    process
    begin
        
        A <= "0000"; B <= "0000"; Cin <= '0';
        wait for 10 ns;
       
        
        A <= "0001"; B <= "0001"; Cin <= '0';
        wait for 10 ns;
       
        
        A <= "0010"; B <= "0011"; Cin <= '0';
        wait for 10 ns;
       
        
        A <= "0111"; B <= "0001"; Cin <= '0';
        wait for 10 ns;
       
        
        A <= "0110"; B <= "0010"; Cin <= '1';
        wait for 10 ns;
       
        
        A <= "1111"; B <= "1111"; Cin <= '0';
        wait for 10 ns;
       
        
        A <= "1111"; B <= "0001"; Cin <= '1';
        wait for 10 ns;
       
        
        wait;
    end process;
   
end testbench;
