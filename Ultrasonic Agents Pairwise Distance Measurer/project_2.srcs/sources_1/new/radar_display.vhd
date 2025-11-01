library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity radar_display is
    Port (
        clk          : in  std_logic;
        distance1    : in  std_logic_vector(15 downto 0);
        distance2    : in  std_logic_vector(15 downto 0);
        distance3    : in  std_logic_vector(15 downto 0);
        d12          : in  std_logic_vector(15 downto 0);
        d13          : in  std_logic_vector(15 downto 0);
        d23          : in  std_logic_vector(15 downto 0);
        x            : in  unsigned(9 downto 0);
        y            : in  unsigned(9 downto 0);
        video_on     : in  std_logic;
        payload_btn : in std_logic;
        red          : out std_logic;
        green        : out std_logic;
        blue         : out std_logic
    );
end radar_display;

architecture Behavioral of radar_display is

    constant CENTER_X   : integer := 320;
    constant CENTER_Y   : integer := 240;
    constant SCALE      : integer := 2;
    constant DOT_RADIUS : integer := 4;

    signal pix_x, pix_y : integer;
    signal green_dot, green_text : std_logic;

    signal d1, d2, d3, d_12, d_13, d_23 : integer;
    signal a, k, m : integer;
    signal x1, y1, x2, y2, x3, y3 : integer;

    -- Reduced digit width: 3 characters → 3 * 8 = 24 bits
    signal digits_d1, digits_d2, digits_d3 : std_logic_vector(15 downto 0);
    signal digits_d12, digits_d13, digits_d23 : std_logic_vector(15 downto 0);

    type font_array is array(0 to 9, 0 to 7) of std_logic_vector(7 downto 0);
    constant font : font_array := (
        ("00111100","01000010","01000110","01001010","01010010","01100010","01000010","00111100"),
        ("00010000","00110000","00010000","00010000","00010000","00010000","00010000","00111000"),
        ("00111100","01000010","00000010","00000100","00001000","00010000","00100000","01111110"),
        ("00111100","01000010","00000010","00011100","00000010","00000010","01000010","00111100"),
        ("00000100","00001100","00010100","00100100","01000100","01111110","00000100","00000100"),
        ("01111110","01000000","01000000","01111100","00000010","00000010","01000010","00111100"),
        ("00111100","01000010","01000000","01111100","01000010","01000010","01000010","00111100"),
        ("01111110","00000010","00000100","00001000","00010000","00100000","00100000","00100000"),
        ("00111100","01000010","01000010","00111100","01000010","01000010","01000010","00111100"),
        ("00111100","01000010","01000010","01000010","00111110","00000010","01000010","00111100")
    );

    function isqrt(x : integer) return integer is
        variable res : integer := 0;
        variable bit : integer := 2 ** 14;
        variable x_copy : integer := x;
    begin
        while bit > 0 loop
            if res + bit <= x_copy / (res + bit) then
                res := res + bit;
            end if;
            bit := bit / 2;
        end loop;
        return res;
    end function;
    
    function edge(x0, y0, x1, y1, px, py: integer) return integer is
    begin
        return (px - x0) * (y1 - y0) - (py - y0) * (x1 - x0);
    end function;
    
    
    procedure int_to_digits3(val : in integer; signal out_digits : out std_logic_vector(15 downto 0)) is
        variable d : integer := val;
    begin
        out_digits(15 downto 8)  <= std_logic_vector(to_unsigned((d / 10)  mod 10 + 48, 8));
        out_digits(7 downto 0)   <= std_logic_vector(to_unsigned((d mod 10) + 48, 8));
    end procedure;

begin

    process(clk)
        variable k_temp, m_temp : integer;
        variable d13_sq, d23_sq : integer;
    begin
        if rising_edge(clk) then
            d1   <= to_integer(unsigned(distance1));
            d2   <= to_integer(unsigned(distance2));
            d3   <= to_integer(unsigned(distance3));
            d_12 <= to_integer(unsigned(d12));
            d_13 <= to_integer(unsigned(d13));
            d_23 <= to_integer(unsigned(d23));

            d13_sq := d_13 * d_13;
            d23_sq := d_23 * d_23;
            a      <= d_12;

            if a /= 0 then
                k_temp := (a * a - (d23_sq - d13_sq)) / (2 * a);
            else
                k_temp := 0;
            end if;

            m_temp := isqrt(d13_sq - k_temp * k_temp);

            k <= k_temp;
            m <= m_temp;

            x1 <= CENTER_X;
            y1 <= CENTER_Y;

            x2 <= CENTER_X + a * SCALE;
            y2 <= CENTER_Y;

            x3 <= CENTER_X + k * SCALE;
            y3 <= CENTER_Y - m * SCALE;

            pix_x <= to_integer(x);
            pix_y <= to_integer(y);

            int_to_digits3(d1, digits_d1);
            int_to_digits3(d2, digits_d2);
            int_to_digits3(d3, digits_d3);
            int_to_digits3(d_12, digits_d12);
            int_to_digits3(d_13, digits_d13);
            int_to_digits3(d_23, digits_d23);
        end if;
    end process;
    
    process(clk)
        variable row_idx, col_idx, char_code : integer;
        variable char_pixels : std_logic_vector(7 downto 0);
        variable w0, w1, w2 : integer;
        variable in_triangle : boolean;
    begin
        if rising_edge(clk) then
            green_dot  <= '0';
            green_text <= '0';
            in_triangle := false;
    
            if video_on = '1' then
                -- Triangle highlight if payload is active
                if payload_btn = '1' then
                    w0 := (pix_x - x2) * (y3 - y2) - (pix_y - y2) * (x3 - x2);
                    w1 := (pix_x - x3) * (y1 - y3) - (pix_y - y3) * (x1 - x3);
                    w2 := (pix_x - x1) * (y2 - y1) - (pix_y - y1) * (x2 - x1);
    
                    if (w0 >= 0 and w1 >= 0 and w2 >= 0) or
                       (w0 <= 0 and w1 <= 0 and w2 <= 0) then
                        in_triangle := true;
                    end if;
                end if;
    
                -- Dot highlights
                if ((pix_x - x1)**2 + (pix_y - y1)**2 <= DOT_RADIUS**2) or
                   ((pix_x - x2)**2 + (pix_y - y2)**2 <= DOT_RADIUS**2) or
                   ((pix_x - x3)**2 + (pix_y - y3)**2 <= DOT_RADIUS**2) then
                    green_dot <= '1';
                end if;
    
                -- Text rendering
                for row in 0 to 5 loop
                    for i in 0 to 1 loop  -- Only 2 digits shown
                        if (pix_y >= 10 + row * 12 and pix_y < 18 + row * 12) and
                           (pix_x >= 10 + i * 8 and pix_x < 18 + i * 8) then
    
                            row_idx := pix_y - (10 + row * 12);
                            col_idx := pix_x - (10 + i * 8);
    
                            case row is
                                when 0 => char_code := to_integer(unsigned(digits_d1(15 - i*8 downto 8 - i*8)));
                                when 1 => char_code := to_integer(unsigned(digits_d2(15 - i*8 downto 8 - i*8)));
                                when 2 => char_code := to_integer(unsigned(digits_d3(15 - i*8 downto 8 - i*8)));
                                when 3 => char_code := to_integer(unsigned(digits_d12(15 - i*8 downto 8 - i*8)));
                                when 4 => char_code := to_integer(unsigned(digits_d13(15 - i*8 downto 8 - i*8)));
                                when 5 => char_code := to_integer(unsigned(digits_d23(15 - i*8 downto 8 - i*8)));
                                when others => char_code := 32;
                            end case;
    
                            if char_code >= 48 and char_code <= 57 then
                                char_pixels := font(char_code - 48, row_idx);
                                if char_pixels(7 - col_idx) = '1' then
                                    green_text <= '1';
                                end if;
                            end if;
                        end if;
                    end loop;
                end loop;
            end if;
    
            -- FINAL COLOR OUTPUT
            if pix_x <= 2 or pix_x >= 637 or pix_y <= 2 or pix_y >= 477 then
                red   <= '1';
                green <= '0';
                blue  <= '0';
            elsif in_triangle then
                red   <= '1';
                green <= '1';
                blue  <= '1';
            else
                red   <= '0';
                green <= green_dot or green_text;
                blue  <= '0';
            end if;
        end if;
    end process;
    

end Behavioral;



