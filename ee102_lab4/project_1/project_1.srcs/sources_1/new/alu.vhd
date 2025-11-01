library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0);  -- ✅ Fixed to 4-bit width
           Carry : out STD_LOGIC  -- ✅ Carry added back for adder_subtractor and arithmetic_unit
         );
end alu;

architecture Behavioral of alu is
    -- ✅ Component Declarations
    component adder_subtractor 
        port (A_adder : in STD_LOGIC_VECTOR (3 downto 0);
              B_adder : in STD_LOGIC_VECTOR (3 downto 0);
              Opcode_adder : in STD_LOGIC_VECTOR (2 downto 0);
              Result_adder : out STD_LOGIC_VECTOR (3 downto 0);  -- ✅ Fixed width
              Carry_adder : out STD_LOGIC);
    end component; 
    
    component logic_unit
        port (A : in STD_LOGIC_VECTOR (3 downto 0);
              B : in STD_LOGIC_VECTOR (3 downto 0);
              Opcode : in STD_LOGIC_VECTOR (2 downto 0);
              Result : out STD_LOGIC_VECTOR (3 downto 0));  -- ✅ Fixed width
    end component;
    
    component shift_operator 
        port (A : in STD_LOGIC_VECTOR (3 downto 0);
              B : in STD_LOGIC_VECTOR (3 downto 0);
              Opcode : in STD_LOGIC_VECTOR (2 downto 0);
              Result : out STD_LOGIC_VECTOR (3 downto 0);
              Carry : out STD_LOGIC);  -- ✅ Carry added for shift
    end component; 
    
    component arithmetic_unit
        port (A : in STD_LOGIC_VECTOR (3 downto 0);
              B : in STD_LOGIC_VECTOR (3 downto 0);
              Opcode : in STD_LOGIC_VECTOR (2 downto 0);
              Result : out STD_LOGIC_VECTOR (3 downto 0);
              Carry : out STD_LOGIC);  -- ✅ Fixed width and added carry
    end component;

    -- Internal Signals
    signal arith_result, logic_result, add_result, shift_result : STD_LOGIC_VECTOR (3 downto 0);
    signal carry_arith, carry_logic, carry_add, carry_shift : STD_LOGIC;

begin
    -- ✅ Instantiate Components (Carry included where needed)
    U1: adder_subtractor port map(A_adder => A, B_adder => B, Opcode_adder => Opcode, 
                                  Result_adder => add_result, Carry_adder => carry_add);

    U2: logic_unit port map(A => A, B => B, Opcode => Opcode, 
                            Result => logic_result);

    U3: arithmetic_unit port map(A => A, B => B, Opcode => Opcode, 
                                 Result => arith_result, Carry => carry_arith);

    U4: shift_operator port map(A => A, B => B, Opcode => Opcode, 
                                Result => shift_result, Carry => carry_shift);

    -- ✅ ALU Process: Selecting Result and Carry based on Opcode
    process (A, B, Opcode, arith_result, logic_result, add_result, shift_result, carry_add, carry_arith, carry_shift)
    begin
        -- ✅ Assign Default Values Before the Case Statement
        Result <= (others => '0');  
        Carry <= '0';  
        case Opcode is
            when "000" | "001" =>  
                Result <= add_result;
                Carry <= carry_add;

            when "010" | "011" =>
                Result <= arith_result;
                Carry <= carry_arith;

            when "100" | "101" =>
                Result <= logic_result;
                Carry <= '0';  -- ✅ Logic operations do not use Carry

            when "110" | "111" =>
                Result <= shift_result;
                Carry <= carry_shift;

            when others =>
                Result <= (others => 'X');
                Carry <= 'X';
        end case;
    end process;

end Behavioral;


