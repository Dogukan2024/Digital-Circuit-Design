library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk100      : in  std_logic;
        rst_btn     : in  std_logic;
        btn_12      : in  std_logic;
        btn_13      : in  std_logic;
        btn_23      : in  std_logic;
        btn_payload : in  std_logic;  -- Payload activation button
        echo_1      : in  std_logic;
        echo_2      : in  std_logic;
        echo_3      : in  std_logic;
        trigger_1   : out std_logic;
        trigger_2   : out std_logic;
        trigger_3   : out std_logic;
        led_12      : out std_logic;
        led_13      : out std_logic;
        led_23      : out std_logic;
        led_ext     : out std_logic;
        hsync       : out std_logic;
        vsync       : out std_logic;
        red         : out std_logic;
        green       : out std_logic;
        blue        : out std_logic
    );
end top;

architecture Structural of top is

    signal clk25 : std_logic := '0';
    signal pixel_x, pixel_y : unsigned(9 downto 0);
    signal video_on : std_logic;

    -- Edge detection
    signal btn_12_d, btn_13_d, btn_23_d : std_logic := '0';
    signal re_12, re_13, re_23 : std_logic := '0';

    -- Trigger control
    signal trigger_cnt_1, trigger_cnt_2, trigger_cnt_3 : unsigned(7 downto 0) := (others => '0');
    signal trigger_1_int, trigger_2_int, trigger_3_int : std_logic := '0';

    -- FSM outputs
    signal dist_1, dist_2, dist_3 : std_logic_vector(15 downto 0);
    signal echo1_cnt, echo2_cnt, echo3_cnt : std_logic_vector(15 downto 0);
    signal done_1, done_2, done_3 : std_logic;

    -- Pairwise distances
    signal d12, d13, d23 : std_logic_vector(15 downto 0);

begin

    ------------------------------------------------------------
    -- 1. Clock Divider: 100 MHz → 25 MHz
    ------------------------------------------------------------
    process(clk100)
        variable div_cnt : integer := 0;
    begin
        if rising_edge(clk100) then
            if div_cnt = 1 then
                clk25 <= not clk25;
                div_cnt := 0;
            else
                div_cnt := div_cnt + 1;
            end if;
        end if;
    end process;

    led_ext <= rst_btn;

    ------------------------------------------------------------
    -- 2. Button Edge Detection & Trigger Generation
    ------------------------------------------------------------
    pulse_gen: process(clk25, rst_btn)
    begin
        if rst_btn = '1' then
            btn_12_d <= '0';
            btn_13_d <= '0';
            btn_23_d <= '0';
            trigger_cnt_1 <= (others => '0');
            trigger_cnt_2 <= (others => '0');
            trigger_cnt_3 <= (others => '0');
            trigger_1_int <= '0';
            trigger_2_int <= '0';
            trigger_3_int <= '0';
        elsif rising_edge(clk25) then
            re_12 <= btn_12 and not btn_12_d;
            re_13 <= btn_13 and not btn_13_d;
            re_23 <= btn_23 and not btn_23_d;

            btn_12_d <= btn_12;
            btn_13_d <= btn_13;
            btn_23_d <= btn_23;

            -- Sensor 1 Trigger
            if re_12 = '1' or re_13 = '1' then
                trigger_1_int <= '1';
                trigger_cnt_1 <= to_unsigned(1, 8);
            elsif trigger_cnt_1 > 0 and trigger_cnt_1 < to_unsigned(250, 8) then
                trigger_cnt_1 <= trigger_cnt_1 + 1;
            else
                trigger_1_int <= '0';
                trigger_cnt_1 <= (others => '0');
            end if;

            -- Sensor 2 Trigger
            if re_12 = '1' or re_23 = '1' then
                trigger_2_int <= '1';
                trigger_cnt_2 <= to_unsigned(1, 8);
            elsif trigger_cnt_2 > 0 and trigger_cnt_2 < to_unsigned(250, 8) then
                trigger_cnt_2 <= trigger_cnt_2 + 1;
            else
                trigger_2_int <= '0';
                trigger_cnt_2 <= (others => '0');
            end if;

            -- Sensor 3 Trigger
            if re_13 = '1' or re_23 = '1' then
                trigger_3_int <= '1';
                trigger_cnt_3 <= to_unsigned(1, 8);
            elsif trigger_cnt_3 > 0 and trigger_cnt_3 < to_unsigned(250, 8) then
                trigger_cnt_3 <= trigger_cnt_3 + 1;
            else
                trigger_3_int <= '0';
                trigger_cnt_3 <= (others => '0');
            end if;
        end if;
    end process;

    trigger_1 <= trigger_1_int;
    trigger_2 <= trigger_2_int;
    trigger_3 <= trigger_3_int;

    ------------------------------------------------------------
    -- 3. Ultrasonic FSMs
    ------------------------------------------------------------
    fsm_1: entity work.ultrasonic_fsm
        port map (
            clk        => clk25,
            rst        => rst_btn,
            run_enable => '0',
            trigger    => trigger_1_int,
            echo       => echo_1,
            distance   => dist_1,
            echo_out   => echo1_cnt,
            led_out    => led_12,
            done       => done_1
        );

    fsm_2: entity work.ultrasonic_fsm
        port map (
            clk        => clk25,
            rst        => rst_btn,
            run_enable => '0',
            trigger    => trigger_2_int,
            echo       => echo_2,
            distance   => dist_2,
            echo_out   => echo2_cnt,
            led_out    => led_13,
            done       => done_2
        );

    fsm_3: entity work.ultrasonic_fsm
        port map (
            clk        => clk25,
            rst        => rst_btn,
            run_enable => '0',
            trigger    => trigger_3_int,
            echo       => echo_3,
            distance   => dist_3,
            echo_out   => echo3_cnt,
            led_out    => led_23,
            done       => done_3
        );

    ------------------------------------------------------------
    -- 4. Pairwise Distance Calculation
    ------------------------------------------------------------
    process(clk25)
    begin
        if rising_edge(clk25) then
            if done_1 = '1' and done_2 = '1' then
                d12 <= std_logic_vector(resize(unsigned(dist_1) + unsigned(dist_2), 16));
            end if;
            if done_1 = '1' and done_3 = '1' then
                d13 <= std_logic_vector(resize(unsigned(dist_1) + unsigned(dist_3), 16));
            end if;
            if done_2 = '1' and done_3 = '1' then
                d23 <= std_logic_vector(resize(unsigned(dist_2) + unsigned(dist_3), 16));
            end if;
        end if;
    end process;

    ------------------------------------------------------------
    -- 5. VGA Timing & Display
    ------------------------------------------------------------
    vga_ctrl: entity work.vga_controller
        port map (
            clk25    => clk25,
            hsync    => hsync,
            vsync    => vsync,
            pixel_x  => pixel_x,
            pixel_y  => pixel_y,
            video_on => video_on
        );

    radar_display_inst: entity work.radar_display
        port map (
            clk          => clk25,
            distance1    => dist_1,
            distance2    => dist_2,
            distance3    => dist_3,
            d12          => d12,
            d13          => d13,
            d23          => d23,
            x            => pixel_x,
            y            => pixel_y,
            video_on     => video_on,
            payload_btn  => btn_payload,  -- ✅ Connected here
            red          => red,
            green        => green,
            blue         => blue
        );

end Structural;



