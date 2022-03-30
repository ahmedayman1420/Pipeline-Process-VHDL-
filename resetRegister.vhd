-- <=========> //// D-Flip-Flop //// <=========> --

-- <=========> //// Library Declaration //// <=========> --
library IEEE;
use IEEE.STD_LOGIC_1164.all;
-- <----- End ----->

-- <=========> //// Entity Declaration OF D-Flip-Flop that takes custom reset value//// <=========> -- 
ENTITY resetRegister IS 

GENERIC ( n : INTEGER := 32 );

	PORT( 
			d: in std_logic_vector(n - 1 downto 0);
			clk,reset,en : IN std_logic;
			resetvalue: IN std_logic_vector(n-1 downto 0);
			q : OUT std_logic_vector(n - 1 downto 0)
		);
END resetRegister;
-- <----- End ----->

-- <=========> //// Architecture Declaration D-Flip-Flop //// <=========> -- 
ARCHITECTURE resetRegister OF resetRegister IS
BEGIN
	process(clk,reset)
	begin
	if(reset = '1') then
		q <= resetvalue;

	elsif (rising_edge(clk)) then		
		if(en = '1') then
			q <= d;
		end if;
	end if;	
	end process;
END resetRegister;
-- <----- End ----->


