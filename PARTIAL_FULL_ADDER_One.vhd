library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PARTIAL_FULL_ADDER is
    Port ( 
			--	Inputs
				INP_A 	: in  std_logic;	-- Operand A
				INP_B 	: in  std_logic;	--	Operand B
				C_IN 	: in  std_logic;		-- Carry in
			
			-- Outputs
				SUM 	: out  std_logic;		--	Sum output
				PRO 	: out  std_logic; 	-- Propogated output
				C_OUT	: out std_logic		-- Carry out
		);
end PARTIAL_FULL_ADDER;


architecture Behavioral of PARTIAL_FULL_ADDER is

begin

	SUM <= (INP_A XOR (INP_B XOR C_IN)) XOR C_IN;
	PRO <= INP_A XOR INP_B;
	C_OUT <= ((INP_A XOR INP_B) AND C_IN) OR (INP_A AND INP_B);
	
end Behavioral;

