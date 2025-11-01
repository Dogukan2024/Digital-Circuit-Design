----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 09:06:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Port (
        A    : in  STD_LOGIC_VECTOR (3 downto 0);
        B    : in  STD_LOGIC_VECTOR (3 downto 0);
        Sel  : in  STD_LOGIC_VECTOR (2 downto 0);
        Result : out STD_LOGIC_VECTOR (3 downto 0);
        Cout   : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is
    component Ripple_Carry_Adder
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC_VECTOR (3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;
   
    component Subtractor
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            Diff : out STD_LOGIC_VECTOR (3 downto 0);
            Bout : out STD_LOGIC
        );
    end component;
   
    component Logic_Operations
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            AND_Result : out STD_LOGIC_VECTOR (3 downto 0);
            OR_Result  : out STD_LOGIC_VECTOR (3 downto 0);
            XOR_Result : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
   
    component Shift_Operations
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            LSL_Result : out STD_LOGIC_VECTOR (3 downto 0);
            LSR_Result : out STD_LOGIC_VECTOR (3 downto 0);
            ASR_Result : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
   
    signal Sum, Diff, AND_Out, OR_Out, XOR_Out, LSL_Out, LSR_Out, ASR_Out : STD_LOGIC_VECTOR (3 downto 0);
    signal CarryOut, BorrowOut : STD_LOGIC;
   
begin
    
    ADDER: Ripple_Carry_Adder port map (A, B, '0', Sum, CarryOut);
    SUB: Subtractor port map (A, B, Diff, BorrowOut);
    LOGIC: Logic_Operations port map (A, B, AND_Out, OR_Out, XOR_Out);
    SHIFT: Shift_Operations port map (A, LSL_Out, LSR_Out, ASR_Out);
   
    
    process (Sel, Sum, Diff, AND_Out, OR_Out, XOR_Out, LSL_Out, LSR_Out, ASR_Out)
    begin
        case Sel is
            when "000" => Result <= Sum;
            when "001" => Result <= Diff;
            when "010" => Result <= AND_Out;
            when "011" => Result <= OR_Out;
            when "100" => Result <= XOR_Out;
            when "101" => Result <= LSL_Out;
            when "110" => Result <= LSR_Out;
            when "111" => Result <= ASR_Out;
            when others => Result <= "0000";
        end case;
    end process;
   
    
    Cout <= CarryOut when Sel = "000" else
            BorrowOut when Sel = "001" else
            '0';
   
end Behavioral;