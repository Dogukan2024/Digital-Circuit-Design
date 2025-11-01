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
    component adder 
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0);  -- ✅ Fixed to 4-bit width
           Carry : out STD_LOGIC  -- ✅ Carry added back for adder_subtractor and arithmetic_unit
         );
    end component; 
    
    component substractor
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0);  -- ✅ Fixed to 4-bit width
           Carry : out STD_LOGIC  -- ✅ Carry added back for adder_subtractor and arithmetic_unit
         );
    end component;
    
    component one_adder 
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0);  -- ✅ Fixed to 4-bit width
           Carry : out STD_LOGIC  -- ✅ Carry added back for adder_subtractor and arithmetic_unit
         );
    end component; 
    
    component one_substractor
       Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0);  -- ✅ Fixed to 4-bit width
           Carry : out STD_LOGIC  -- ✅ Carry added back for adder_subtractor and arithmetic_unit
         );
    end component;
    
        -- Internal Signals
    signal adder_result, substractor_result, one_adder_result, one_substractor_result : STD_LOGIC_VECTOR (3 downto 0);
    signal adder_carry, substractor_carry, one_adder_carry, one_substractor_carry : STD_LOGIC;
    
    
begin
    -- ✅ Instantiate Components (Carry included where needed)
    U1: adder port map(A => A, B => B, Opcode => Opcode, Result => adder_result, Carry => adder_carry);

    U2: substractor port map(A => A, B => B, Opcode => Opcode, Result => substractor_result);

    U3: one_adder port map(A => A, B => B, Opcode => Opcode, Result => one_adder_result, Carry => one_adder_carry);

    U4: one_substractor port map(A => A, B => B, Opcode => Opcode, Result => one_substractor_result);

    -- ✅ ALU Process: Selecting Result and Carry based on Opcode
    process (A, B, Opcode, adder_result, substractor_result, one_adder_result, one_substractor_result, adder_carry, substractor_carry, one_adder_carry, one_substractor_carry)
    begin
        -- ✅ Assign Default Values Before the Case Statement
        Result <= (others => '0');  
        Carry <= '0';  
        case Opcode is
            when "000"  =>  
                Result <= adder_result;
                Carry <= adder_carry;

            when "001"  =>
                Result <= substractor_result;

            when "010"  =>
                Result <= one_adder_result;
                Carry <= one_adder_carry;  

            when "011"  =>
                Result <= one_substractor_result;

            when others =>
                Result <= (others => 'X');
                Carry <= 'X';
        end case;
    end process;

end Behavioral;



