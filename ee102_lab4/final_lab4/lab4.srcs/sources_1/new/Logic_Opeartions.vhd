----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:40:18 PM
-- Design Name: 
-- Module Name: Logic_Opeartions - Behavioral
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

entity Logic_Operations is
    Port (
        A    : in  STD_LOGIC_VECTOR (3 downto 0);
        B    : in  STD_LOGIC_VECTOR (3 downto 0);
        AND_Result : out STD_LOGIC_VECTOR (3 downto 0);
        OR_Result  : out STD_LOGIC_VECTOR (3 downto 0);
        XOR_Result : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Logic_Operations;

architecture Behavioral of Logic_Operations is
begin
    -- Bitwise AND
    AND_Result <= A AND B;
   
    -- Bitwise OR
    OR_Result <= A OR B;
   
    -- Bitwise XOR
    XOR_Result <= A XOR B;
end Behavioral;

