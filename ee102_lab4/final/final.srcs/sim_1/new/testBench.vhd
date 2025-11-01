library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is
    -- Component Declaration for ALU
    component alu
        Port (
            A       : in  STD_LOGIC_VECTOR (3 downto 0);
            B       : in  STD_LOGIC_VECTOR (3 downto 0);
            Opcode  : in  STD_LOGIC_VECTOR (2 downto 0);
            Result  : out STD_LOGIC_VECTOR (3 downto 0);
            Carry   : out STD_LOGIC
        );
    end component;

    -- Signals for connecting to ALU
    signal A_tb      : STD_LOGIC_VECTOR (3 downto 0);
    signal B_tb      : STD_LOGIC_VECTOR (3 downto 0);
    signal Opcode_tb : STD_LOGIC_VECTOR (2 downto 0);
    signal Result_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal Carry_tb  : STD_LOGIC;

begin
    -- Instantiate the ALU
    UUT: alu port map(
        A      => A_tb,
        B      => B_tb,
        Opcode => Opcode_tb,
        Result => Result_tb,
        Carry  => Carry_tb
    );

    -- Stimulus Process
    process
    begin
        -- Iterate over all possible values of A, B, and Opcode
        for Opcode_int in 0 to 7 loop  -- Opcode ranges from 000 to 111 (0 to 7)
            for A_int in 0 to 15 loop  -- A ranges from 0000 to 1111 (0 to 15)
                for B_int in 0 to 15 loop  -- B ranges from 0000 to 1111 (0 to 15)
                
                    A_tb      <= std_logic_vector(to_unsigned(B_int, 4));
                    B_tb      <= std_logic_vector(to_unsigned(A_int, 4));
                    Opcode_tb <= std_logic_vector(to_unsigned(Opcode_int, 3));

                    wait for 10 ns;  -- Wait time for signal stabilization
                end loop; 
            end loop;
        end loop;

        wait;  -- Stop simulation
    end process;
end Behavioral;

