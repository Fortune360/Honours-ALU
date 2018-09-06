--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.all;

ENTITY TEST_ALU_CSA_Eight IS
END TEST_ALU_CSA_Eight;
 
ARCHITECTURE behavior OF TEST_ALU_CSA_Eight IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU_CSA_Eight
    PORT(
         INP_A 	: IN  std_logic_vector(7 downto 0);
         INP_B 	: IN  std_logic_vector(7 downto 0);
         INP_SEL 	: IN  unsigned(2 downto 0);
         C_IN 		: IN  std_logic;
         CLK 		: IN  std_logic;
         ACT 		: IN  std_logic;
         OUT_RES 	: OUT  std_logic_vector(7 downto 0);
         OUT_OC 	: OUT  std_logic;
         OUT_ZE 	: OUT  std_logic;
         OUT_SI 	: OUT  std_logic;
         OUT_PA	: OUT  std_logic
        );
    END COMPONENT;

   --Inputs
   signal INP_A 	: std_logic_vector(7 downto 0) := "00110011";
   signal INP_B 	: std_logic_vector(7 downto 0) := "01110000";
   signal INP_SEL : unsigned(2 downto 0) := "000";
	signal C_IN 	: std_logic := '0';
	signal CLK 		: std_logic := '1';
	signal ACT 		: std_logic := '0';
	signal EFF 		: std_logic := '1';

 	--Outputs
   signal OUT_RES : std_logic_vector(7 downto 0);
   signal OUT_OC 	: std_logic;
   signal OUT_ZE 	: std_logic;
   signal OUT_SI 	: std_logic;
   signal OUT_PA 	: std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
-- Concurrent
 
	--	Clock speed: 50MHz (T = 20ns)
	CLK <= not CLK after  10 ns; 
	
	-- Rotates a carry value out and in for a variety of test cases.
	-- C_IN <= not C_IN after 320 ns; 
	
	-- 4 clock cycles = 1 Effective clock cycle (When ALU is active)
	EFF <= not EFF after 40 ns; 

	process(EFF) is 
	begin
		if rising_edge(EFF) then
		
			INP_A <= INP_A + x"1";
			INP_B <= INP_B + x"10";
			if(INP_SEL = "000") then -- Because it's starts high, this alternates it with subtraction.
				C_IN <= '1';
			else 
				C_IN <= '0'; 
			end if;
			
			-- Calculations take place every 3rd base clock cycle (ACT stays high for 20ns)
			ACT <= '0', '1' after 40 ns, '0' after 60 ns; 
			
			case(INP_SEL) is 
			-- so that every operation is used equally often, just switching to the "next one"

				when "000"  => INP_SEL <= "001";
				when "001"  => INP_SEL <= "000";		-- "010"
--				when "010"  => INP_SEL <= "011";
--				when "011"  => INP_SEL <= "100";
--				when "100"  => INP_SEL <= "101";
--				when "101"  => INP_SEL <= "110";
--				when "110"  => INP_SEL <= "111";
				when others => INP_SEL <= "000";
				
			end case;
		end if;
	end process;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_CSA_Eight PORT MAP (
          INP_A 	=> INP_A,
          INP_B 	=> INP_B,
          INP_SEL => INP_SEL,
			 C_IN	 	=> C_IN,
			 CLK 		=> CLK,
			 ACT 		=> ACT,
          OUT_RES => OUT_RES,
          OUT_OC 	=> OUT_OC,
          OUT_ZE 	=> OUT_ZE,
          OUT_SI 	=> OUT_SI,
			 OUT_PA	=> OUT_PA
        );

END;
