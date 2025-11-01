library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench is
end test_bench;

architecture behavior of test_bench is

    -- Component Declaration
    component main_design
        Port (
            clock_100Mhz     : in  STD_LOGIC;
            reset            : in  STD_LOGIC;
            Anode_Activate   : out STD_LOGIC_VECTOR (3 downto 0);
            LED_out          : out STD_LOGIC_VECTOR (6 downto 0);
            LED_BCD_out      : out STD_LOGIC_VECTOR (3 downto 0);
            displayed_out : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    -- Signals for inputs/outputs
    signal clock        : std_logic := '0';
    signal reset        : std_logic := '1';
    signal anodes       : std_logic_vector(3 downto 0);
    signal seg_outputs  : std_logic_vector(6 downto 0);
    signal led_bcd_val : std_logic_vector(3 downto 0);
    signal displayed_val : std_logic_vector(15 downto 0);

    -- Clock period (100 MHz = 10 ns)
    constant clock_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: main_design
        port map (
            clock_100Mhz   => clock,
            reset          => reset,
            Anode_Activate => anodes,
            LED_out        => seg_outputs,
            LED_BCD_out    => led_bcd_val,
            displayed_out => displayed_val
        );

    -- Clock generation
    clock_process : process
    begin
        while now < 5 ms loop  -- Simulate for 5ms
            clock <= '0';
            wait for clock_period / 2;
            clock <= '1';
            wait for clock_period / 2;
        end loop;
        wait; -- stop simulation
    end process;

    -- Reset process
    reset_process : process
    begin
        reset <= '0';
        wait for 700 ns;
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait;
    end process;

end behavior;
