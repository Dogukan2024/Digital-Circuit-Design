----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:53:09 PM
-- Design Name: 
-- Module Name: Shift_Operations - Behavioral
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

entity Shift_Operations is
    Port (
        A    : in  STD_LOGIC_VECTOR (3 downto 0);
        LSL_Result : out STD_LOGIC_VECTOR (3 downto 0);
        LSR_Result : out STD_LOGIC_VECTOR (3 downto 0);
        ASR_Result : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Shift_Operations;

architecture Behavioral of Shift_Operations is
begin
    -- Logical Shift Left (LSL)
    LSL_Result <= A(2 downto 0) & '0';
   
    -- Logical Shift Right (LSR)
    LSR_Result <= '0' & A(3 downto 1);
   
    -- Arithmetic Shift Right (ASR)
    ASR_Result <= A(3) & A(3 downto 1); -- Ýþaret bitini korur
end Behavioral;
