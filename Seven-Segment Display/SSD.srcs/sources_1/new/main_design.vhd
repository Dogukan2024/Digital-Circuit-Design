library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main_design is
 Port ( 
    clock_100Mhz : in STD_LOGIC;
    reset : in STD_LOGIC;
    Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
    LED_out : out STD_LOGIC_VECTOR (6 downto 0);
    LED_BCD_out      : out STD_LOGIC_VECTOR (3 downto 0);
    displayed_out : out STD_LOGIC_VECTOR(15 downto 0)
 );
end main_design;

architecture Behavioral of main_design is

signal one_second_counter : STD_LOGIC_VECTOR (27 downto 0) := (others => '0');
signal one_second_enable  : std_logic;
signal displayed_number   : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal LED_BCD            : STD_LOGIC_VECTOR (3 downto 0);
signal refresh_counter    : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
signal LED_activating_counter : std_logic_vector(1 downto 0);

begin

-- 7 segment decoder
process(LED_BCD)
begin
 case LED_BCD is
 when "0000" => LED_out <= "0000001"; -- 0
 when "0001" => LED_out <= "1001111"; -- 1
 when "0010" => LED_out <= "0010010"; -- 2
 when "0011" => LED_out <= "0000110"; -- 3
 when "0100" => LED_out <= "1001100"; -- 4
 when "0101" => LED_out <= "0100100"; -- 5
 when "0110" => LED_out <= "0100000"; -- 6
 when "0111" => LED_out <= "0001111"; -- 7
 when "1000" => LED_out <= "0000000"; -- 8
 when "1001" => LED_out <= "0000100"; -- 9
 when "1010" => LED_out <= "0000010"; -- a
 when "1011" => LED_out <= "1100000"; -- b
 when "1100" => LED_out <= "0110001"; -- C
 when "1101" => LED_out <= "1000010"; -- d
 when "1110" => LED_out <= "0110000"; -- E
 when "1111" => LED_out <= "0111000"; -- F
 when others => LED_out <= "1111111";
 end case;

end process;

-- Refresh counter
process(clock_100Mhz, reset)
begin
 if(reset='1') then
   refresh_counter <= (others => '0');
 elsif rising_edge(clock_100Mhz) then
   refresh_counter <= std_logic_vector(unsigned(refresh_counter) + 1);
 end if;
end process;

LED_activating_counter <= refresh_counter(2 downto 1);

-- Digit selection
process(clock_100Mhz)
begin
 case LED_activating_counter is
 when "00" =>
   Anode_Activate <= "0111";
   LED_BCD <= displayed_number(15 downto 12);
 when "01" =>
   Anode_Activate <= "1011";
   LED_BCD <= displayed_number(11 downto 8);
 when "10" =>
   Anode_Activate <= "1101";
   LED_BCD <= displayed_number(7 downto 4);
 when "11" =>
   Anode_Activate <= "1110";
   LED_BCD <= displayed_number(3 downto 0);
 when others =>
   Anode_Activate <= "1111";
 end case;

end process;

-- 1 second counter
process(clock_100Mhz, reset)
begin
 if(reset='1') then
   one_second_counter <= (others => '0');
 elsif rising_edge(clock_100Mhz) then
   if unsigned(one_second_counter) >= to_unsigned(1000, one_second_counter'length) then
     one_second_counter <= (others => '0');
   else
     one_second_counter <= std_logic_vector(unsigned(one_second_counter) + 1);
   end if;
 end if;
end process;

one_second_enable <= '1' when unsigned(one_second_counter) = to_unsigned(1000, one_second_counter'length) else '0';

-- Displayed number increment
process(clock_100Mhz, reset)
begin
 if(reset='1') then
   displayed_number <= (others => '0');
 elsif rising_edge(clock_100Mhz) then
   if(one_second_enable = '1') then
     displayed_number <= std_logic_vector(unsigned(displayed_number) + 1);
   end if;
 end if;
end process;
LED_BCD_out <= LED_BCD;
displayed_out <= displayed_number;
end Behavioral;
