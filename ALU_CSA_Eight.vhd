library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity ALU_CSA_Eight is
	Generic (
					N: integer := 8												-- ALU size
			);
			
	Port (	
			-- Inputs
				INP_A, INP_B 	: in std_logic_vector(N-1 downto 0); 	-- Inputs (8 bit)
				INP_SEL 			: in unsigned(2 downto 0); 				-- Function selection (3 bit)
				C_IN				: in std_logic;								-- Carry in (Used to 2s compliment B, making the CSA a subtractor).
				CLK				: in std_logic;								--	Clock
				ACT				: in std_logic;								--	Set if ALU is active
				
			-- Outputs
				OUT_RES 			: out std_logic_vector(N-1 downto 0);	-- Result (8 bit) 
				OUT_OC			: out std_logic := '0';						--	Overflow/Underflow/Carry flag (1 bit)
				OUT_ZE			: out std_logic := '0';						--	Zero flag (1 bit) - If OUT_RES is cleared, Zero flag is set.
				OUT_SI			: out std_logic := '0';						--	Sign flag (1 bit) - Positive is cleared, Negative is set.
				OUT_PA			: out std_logic := '0'						-- Pairity flag (1 bit) - If even pairity then set.
		);	
end ALU_CSA_Eight;

architecture Behavioral of ALU_CSA_Eight is

-- Components to be used in ALU (Custom Carry Skip Adder)

	component CARRY_SKIP_ADDER
		Generic (
						N	: integer := 8											-- 8-bit Carry skip adder
			);
		Port ( 	INP_A : in std_logic_vector(N-1 downto 0);
					INP_B	: in std_logic_vector(N-1 downto 0);
					C_IN 	: in std_logic;
					SUM 	: out std_logic_vector(N-1 downto 0);
					C_OUT : out std_logic
			);
	end component;
	
-- Constants and Signals

	constant SIZE 		: integer := 8; 														-- Size of the ALU
	constant ZERO		: integer := 0; 														-- Sets a unsigned signal which contains all cleared bits.
	constant MAX		: std_logic_vector(SIZE-1 downto 0) := (others => '1');	-- All bits set.
	constant MIN		: std_logic_vector(SIZE-1 downto 0) := (others => '0');	-- All bits cleared.

	signal RESULT 		: std_logic_vector(SIZE-1 downto 0) := (others => '0');	-- Initialized to all bits being cleared.
	
	signal TEMP_SUM	: std_logic_vector(SIZE-1 downto 0);							-- Stores output from CSA for calculation.
 	signal TEMP_COUT	: std_logic	:= '0';													-- Stores carry out from CSA.
	signal TEMP_OC		: std_logic := '0';													-- Overflow/Underflow/Carry for calculations.
	signal TEMP_SI		: std_logic := '0';													-- Sign signal for calculations before output.
	signal TEMP_PA		: std_logic	:= '0';													-- Pairity signal for calculations output.

	begin
	
		CSA: CARRY_SKIP_ADDER PORT MAP (
					INP_A => INP_A,
					INP_B => INP_B,
					C_IN	=> C_IN,
					SUM 	=> TEMP_SUM,
					C_OUT => TEMP_COUT
				);

		-- Final result output of the ALU.
		OUT_RES <= RESULT(SIZE-1 downto 0);
		
		-- If all bits in ALU output result are cleared, then Zero flag is set.
		OUT_ZE <= '1' when (RESULT = ZERO) else '0';
		
		-- First bit used to tell sign of result. Set for negative, cleared for positive.
		OUT_SI <= TEMP_SI;
		
		-- Overflow/Underflow/Carry flag; the Carry out of addition logic.
		OUT_OC <= TEMP_OC;
		
		-- Pairity bit; set if even, clear if odd. [Needs work] <----------------------------------------------------------
--		xors: for i in (SIZE-1) downto 0 generate 
--			TEMP_PA <= TEMP_PA XOR RESULT(i);
--		end generate;
--		OUT_PA <= TEMP_PA;
		
		process(CLK) begin
			if rising_edge(CLK) and ACT = '1' then 
				case(INP_SEL) is
			
				-- [4] Arithmetic
					when "000" => -- Addition [Needs work] <----------------------------------------------------------
						RESULT <= TEMP_SUM;
						TEMP_OC <= TEMP_COUT;
						-- Overflow detection; if set, ignore OUT_RES (ALU Result).
						-- TEMP_OV <= ((INP_A(SIZE-1) NOR INP_B(SIZE-1)) AND RESULT(SIZE-1) AND TEMP_COUT) OR ((INP_A(SIZE-1) AND INP_B(SIZE-1)) AND NOT RESULT(SIZE-1) AND NOT TEMP_COUT) OR TEMP_COUT;

					when "001" => -- Subtraction [Needs work] <----------------------------------------------------------
						RESULT <= TEMP_SUM;
						TEMP_OC <= TEMP_COUT;
						if (INP_A > INP_B) OR (INP_A = INP_B) then
							TEMP_SI <= '0';
						else
							TEMP_SI <= '1';
						end if;
						-- TEMP_OV <= (NOT INP_A(SIZE-1) AND INP_B(SIZE-1) AND RESULT(SIZE-1)) OR (INP_A(SIZE-1) AND NOT INP_B(SIZE-1) AND NOT RESULT(SIZE-1));

					when "010" => -- Increment [WORKS]
						RESULT <= INP_A + 1;		
						if INP_A = MAX then -- Deal with overflow.
							TEMP_OC <= '1';
						else
							TEMP_OC <= '0';
						end if;
												
					when "011" => -- Decrement [WORKS]
						RESULT <= INP_A - 1;	
						if INP_A = MIN then -- Deals with underflow.
							TEMP_OC <= '1';
						else
							TEMP_OC <= '0';
						end if;
						
				-- [1] Relational
					when "100" => -- Eqaulity [WORKS]
						if(INP_A = INP_B) then
							RESULT <=  MAX;	
						else
							RESULT <= MIN;
						end if;
				
				-- [3] Bitwise logical
					when "101" => -- AND [WORKS]
						RESULT <= INP_A AND INP_B;
						
					when "110" => -- OR [WORKS]
						RESULT <= INP_A OR INP_B;
						
					when "111" => -- XOR [WORKS]
						RESULT <= INP_A XOR INP_B;
						
					when others =>
						
				end case;
			
			end if;
			
		end process;
		
		-- Overflow (due to using signed values) for arithmetic operations.
--		OUT_OV <= TEMP_OV;

end Behavioral;
