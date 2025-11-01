----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 09:39:05 PM
-- Design Name: 
-- Module Name: ALU_FPGA - Behavioral
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

entity ALU_FPGA is
    Port (
        SW   : in  STD_LOGIC_VECTOR (10 downto 0); 
        LED  : out STD_LOGIC_VECTOR (4 downto 0)  
    );
end ALU_FPGA;

architecture Behavioral of ALU_FPGA is
    component ALU
        Port (
            A      : in  STD_LOGIC_VECTOR (3 downto 0);
            B      : in  STD_LOGIC_VECTOR (3 downto 0);
            Sel    : in  STD_LOGIC_VECTOR (2 downto 0);
            Result : out STD_LOGIC_VECTOR (3 downto 0);
            Cout   : out STD_LOGIC
        );
    end component;
   
    signal A, B : STD_LOGIC_VECTOR (3 downto 0);
    signal Sel  : STD_LOGIC_VECTOR (2 downto 0);
    signal Result : STD_LOGIC_VECTOR (3 downto 0);
    signal Cout   : STD_LOGIC;
   
begin
    
    Sel  <= SW(2 downto 0);   
     A   <= SW(6 downto 3);   
     B <= SW(10 downto 7);  
   
    
    ALU_INST: ALU
        port map (
            A      => A,
            B      => B,
            Sel    => Sel,
            Result => Result,
            Cout   => Cout
        );
   
    
    LED(3 downto 0) <= Result;  
    LED(4) <= Cout;             
   
end Behavioral;