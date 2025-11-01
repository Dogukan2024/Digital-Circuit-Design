----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 09:10:19 PM
-- Design Name: 
-- Module Name: ALU_TB - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity ALU_TB is
end ALU_TB;

architecture testbench of ALU_TB is
    signal A, B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal Sel : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal Result : STD_LOGIC_VECTOR (3 downto 0);
    signal Cout : STD_LOGIC;
   
    
    component ALU
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            Sel  : in  STD_LOGIC_VECTOR (2 downto 0);
            Result : out STD_LOGIC_VECTOR (3 downto 0);
            Cout   : out STD_LOGIC
        );
    end component;
   
begin
    
    UUT: ALU
        port map (
            A    => A,
            B    => B,
            Sel  => Sel,
            Result => Result,
            Cout   => Cout
        );
   
    
    stim_proc: process
    begin
        for s_s in 0 to 7 loop
            for a_s in 0 to 15 loop
                for b_s in 0 to 15 loop
                    Sel <= std_logic_vector(to_unsigned(s_s, 3));
                    A <= std_logic_vector(to_unsigned(a_s, 4));
                    B <= std_logic_vector(to_unsigned(b_s, 4));
                    
                    wait for 10 ns;
                end loop;
                end loop;
                end loop;

        wait;
    end process;
   
end testbench;
