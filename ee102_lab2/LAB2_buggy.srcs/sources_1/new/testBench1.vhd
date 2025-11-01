library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testBench1 is
end testBench1;

architecture behavior of testBench1 is
    -- Component declaration for the Unit Under Test (UUT)
    component top_module is
        Port (
            i_SW  : in  STD_LOGIC_VECTOR (7 downto 0);
            o_LED : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    -- Signals for stimulus
    signal i_SW  : STD_LOGIC_VECTOR (7 downto 0);
    signal o_LED : STD_LOGIC_VECTOR (7 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: top_module port map (
        i_SW  => i_SW,
        o_LED => o_LED
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Iterate over all possible 8-bit input values
        for i in 0 to 255 loop
            i_SW <= std_logic_vector(to_unsigned(i, 8));  -- Apply test vector
            wait for 10 ns;  -- Wait for output to settle
        end loop;

        wait;  -- Stop simulation
    end process;

end behavior;
