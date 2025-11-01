library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_alu is
end testbench_alu;

architecture behavior of testbench_alu is
    -- Component Declaration for the Unit Under Test (UUT)
    component alu
        Port (
            A : in  STD_LOGIC_VECTOR (3 downto 0);
            B : in  STD_LOGIC_VECTOR (3 downto 0);
            Opcode : in  STD_LOGIC_VECTOR (2 downto 0);
            Result : out STD_LOGIC_VECTOR (3 downto 0);
            Carry : out STD_LOGIC
        );
    end component;

    -- Signals for stimulus
    signal A, B, Result : STD_LOGIC_VECTOR (3 downto 0);
    signal Opcode : STD_LOGIC_VECTOR (2 downto 0);
    signal Carry : STD_LOGIC;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: alu port map (
        A => A,
        B => B,
        Opcode => Opcode,
        Result => Result,
        Carry => Carry
    );

    -- Stimulus process
    stim_proc: process
    begin


        -- Iterate over all possible 4-bit values of A and B
        for op in 0 to 7 loop
            for i in 0 to 15 loop
                for j in 0 to 15 loop
                  -- Iterate over all Opcode values (3-bit)
                    -- ✅ Apply test vectors
                    A <= std_logic_vector(to_unsigned(j, 4));
                    B <= std_logic_vector(to_unsigned(i, 4));
                    Opcode <= std_logic_vector(to_unsigned(op, 3));

                    wait for 10 ns;  -- Allow time for output to settle
                end loop;
            end loop;
        end loop;

        wait;  -- Stop simulation
    end process;

end behavior;
