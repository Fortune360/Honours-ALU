library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity PARTIAL_CARRY_SKIP_ADDER is
	Generic (
					N	: integer := 4									-- 4-bit block size.
		);
	Port ( 	
			-- Inputs
				INP_A : in std_logic_vector(N-1 downto 0);	--	Operand A
				INP_B	: in std_logic_vector(N-1 downto 0);	-- Operand B
				C_IN 	: in std_logic;								-- Carry in
				
			-- Outputs
				SUM 	: out std_logic_vector(N-1 downto 0);	--	Result
				C_OUT : out std_logic								-- Carry out
		);
end PARTIAL_CARRY_SKIP_ADDER;

architecture Behavioral of PARTIAL_CARRY_SKIP_ADDER is

	component PARTIAL_RIPPLE_CARRY
		Generic (
						N	: integer := 4 							-- 4-bit block size.
			);
		Port ( 	INP_A : in std_logic_vector(N-1 downto 0);
					INP_B	: in std_logic_vector(N-1 downto 0);
					C_IN 	: in std_logic;
					
					SUM 	: out std_logic_vector(N-1 downto 0);
					PRO	: out std_logic_vector(N-1 downto 0);
					C_OUT : out std_logic
			);
	end component;
	
	constant SIZE	: integer := 4;
	signal P_OUT 	: std_logic_vector(SIZE-1 downto 0); 	-- The four propagated values, output from the Partial Ripple Carry Adder
	signal C1		: std_logic;										-- The Carry out of the Partial Ripple Carry Adder
	
begin

	PCSA: PARTIAL_RIPPLE_CARRY PORT MAP(INP_A, INP_B, C_IN, SUM, P_OUT, C1);

	-- Skip Logic
	C_OUT <= ((P_OUT(0) AND P_OUT(1) AND P_OUT(2) AND P_OUT(3)) AND C_IN) OR C1;
	
end Behavioral;

