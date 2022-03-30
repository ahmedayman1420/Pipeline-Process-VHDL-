library ieee;
use ieee.std_logic_1164.all;

-- Forward unit entity
-- responsible for forwarding the data already evaluated in ALU or Memory stages
-- back to the previous instructions, in order not to fetch the wrong one
-- rSrc1 : The first source register address
-- rSrc2 : The second source register address
-- rDstAlu : The destination register address already evaluated in Alu stage
-- rDstMem : The destination register address already evaluated in memory stage
-- ctrl : The control signal told the forward unit that this's an alu instruction
-- select1: The select signal forwards to the mux1 at the alu source1
-- select2: The select signal forwards to the mux2 at the alu source2
entity forward_unit is
port(	clk: std_logic;
 rSrc1, rSrc2, rDstAlu, rDstMem: in std_logic_vector(2 downto 0);
	alu_wb_ctrl, mem_wb_ctrl:	in std_logic;
	select1, select2: 		out std_logic_vector(1 downto 0));
end entity;

architecture arch1 of forward_unit is
begin
--process(clk)
--begin 
--if (clk='0') then
select1 <= "01" when rSrc1 = rDstAlu and alu_wb_ctrl ='1'  -- if the source matchs both stages, select the recent one at alu
	else "10" when rSrc1 = rDstMem and mem_wb_ctrl = '1'
	else "00";					   -- if there is no dependency, select that comes from the decoder
	--if ( rSrc1 = rDstAlu and alu_wb_ctrl ='1') then
		--select1 <= "01";
	--elsif (rSrc1 = rDstMem and mem_wb_ctrl = '1') then 
		--select1 <= "10";
	--else 
		--select1 <= "00";
	--end if;
select2 <= "01"when rSrc2 = rDstAlu and alu_wb_ctrl ='1'
	else "10" when rSrc2 = rDstMem and mem_wb_ctrl = '1'
	else "00";
	--if ( rSrc2 = rDstAlu and alu_wb_ctrl ='1') then
		--select2 <= "01";
	--elsif (rSrc2 = rDstMem and mem_wb_ctrl = '1') then 
		--select2 <= "10";
	--else 
		--select2 <= "00";
	--end if;
--end if ;
--e--nd process;
end architecture;