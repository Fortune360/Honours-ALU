-- Original design by Charles Babbage
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity CARRY_SKIP_ADDER is
	Generic (
						N	: integer := 8									-- 8-bit Carry skip adder
		);
	Port (
				-- Inputs
					INP_A : in std_logic_vector(N-1 downto 0);	-- Operand A
					INP_B	: in std_logic_vector(N-1 downto 0);	-- Operand B
					C_IN 	: in std_logic;								-- Carry in to set Adder to 'subtraction mode'.
					
				-- Outputs
					SUM 	: out std_logic_vector(N-1 downto 0);	-- Result.
					C_OUT : out std_logic								--	Carry out.
		);
end CARRY_SKIP_ADDER;

architecture Behavioral of CARRY_SKIP_ADDER is

	component PARTIAL_CARRY_SKIP_ADDER
		Generic (
						N	: integer := 4									-- 4-bit block size.
			);
		Port ( 	INP_A : in std_logic_vector(N-1 downto 0);
					INP_B	: in std_logic_vector(N-1 downto 0);
					C_IN 	: in std_logic;
					
					SUM 	: out std_logic_vector(N-1 downto 0);
					C_OUT : out std_logic
			);
	end component;

	constant SIZE : integer := 8;																		-- 8-bit CSA

	signal C1		: std_logic;																		-- Carry out value of first block Carry Skip Adder.
	signal SUM1		: std_logic_vector((N/2)-1 downto 0); 										-- SUM1(3:0) LOW
	signal SUM2		: std_logic_vector((N/2)-1 downto 0);										--	SUM2(7:4) HIGH
	
	alias INP_A1	: std_logic_vector((N/2)-1 downto 0) is INP_A(N-1 downto N/2);		-- INP_A(7:4) HIGH
	alias INP_A2	: std_logic_vector((N/2)-1 downto 0) is INP_A((N/2)-1 downto 0);	-- INP_A(3:0) LOW
	alias INP_B1	: std_logic_vector((N/2)-1 downto 0) is INP_B(N-1 downto N/2);		-- INP_B(7:4) HIGH
	alias INP_B2	: std_logic_vector((N/2)-1 downto 0) is INP_B((N/2)-1 downto 0);	-- INP_B(3:0) LOW

begin

	PCSA1: PARTIAL_CARRY_SKIP_ADDER PORT MAP(INP_A2, INP_B2, C_IN, SUM2, C1);
	PCSA2: PARTIAL_CARRY_SKIP_ADDER PORT MAP(INP_A1, INP_B1, C1, SUM1, C_OUT);
	
	SUM <= SUM1 & SUM2; -- concetenation of bits (7:4) and bits (3:0).

end Behavioral;

