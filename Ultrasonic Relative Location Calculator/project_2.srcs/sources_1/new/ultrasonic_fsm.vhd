library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ultrasonic_fsm is
    Port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        run_enable : in  std_logic;
        trigger    : in  std_logic;                     -- one-shot pulse from top module
        echo       : in  std_logic;
        distance   : out std_logic_vector(15 downto 0); -- computed distance
        echo_out   : out std_logic_vector(15 downto 0); -- raw echo pulse count
        led_out    : out std_logic;                     -- LED ON during GAP
        done       : out std_logic                      -- NEW: signals when distance is updated
    );
end ultrasonic_fsm;

architecture Behavioral of ultrasonic_fsm is

    type state_type is (IDLE, WAIT_ECHO, GAP);
    signal state        : state_type := IDLE;

    signal cnt          : unsigned(31 downto 0) := (others => '0');
    signal echo_cnt     : unsigned(15 downto 0) := (others => '0');
    signal distance_val : unsigned(15 downto 0) := (others => '0');
    signal led_sig      : std_logic := '0';
    signal echo_reg     : std_logic := '0';
    signal done_sig     : std_logic := '0';  -- NEW

    constant GAP_CYCLES : unsigned(31 downto 0) := to_unsigned(2_500_000, 32);  -- 0.5s @ 25 MHz

begin

    distance <= std_logic_vector(distance_val);
    echo_out <= std_logic_vector(echo_cnt);
    led_out  <= led_sig;
    done     <= done_sig;

    process(clk, rst)
    begin
        if rst = '1' then
            state        <= IDLE;
            cnt          <= (others => '0');
            echo_cnt     <= (others => '0');
            distance_val <= (others => '0');
            led_sig      <= '0';
            echo_reg     <= '0';
            done_sig     <= '0';

        elsif rising_edge(clk) then
            echo_reg  <= echo;
            led_sig   <= '0';
            

            if run_enable = '0' then
                case state is

                    when IDLE =>
                        if trigger = '1' then
                            echo_cnt <= (others => '0');
                            state    <= WAIT_ECHO;
                        end if;

                    when WAIT_ECHO =>
                        if echo = '1' then
                            echo_cnt <= echo_cnt + 1;
                        elsif echo = '0' and echo_reg = '1' then
                            distance_val <= to_unsigned(to_integer(echo_cnt) * 34300 / 50_000_000, 16);
                            cnt          <= (others => '0');
                            done_sig     <= '1';  -- assert done for 1 clock cycle
                            state        <= GAP;
                        end if;

                    when GAP =>
                        if cnt < GAP_CYCLES/2 then
                            cnt     <= cnt + 1;
                            led_sig <= '1';
                        elsif cnt < GAP_CYCLES then
                            cnt <= cnt + 1;
                        else
                            cnt   <= (others => '0');
                            state <= IDLE;
                            done_sig  <= '0';  -- default LOW
                        end if;

                end case;
            end if;
        end if;
    end process;

end Behavioral;


