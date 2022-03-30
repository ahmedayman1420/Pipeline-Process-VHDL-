Library ieee;
use ieee.std_logic_1164.all;

entity fetch is 

port(
ip : inout std_logic_vector(19 downto 0);
clk: in std_logic;
instruction : out std_logic_vector(31 downto 0));

end entity;

Architecture struct of fetch is

COMPONENT ram IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(19 DOWNTO 0);
		datain  : IN  std_logic_vector(31 DOWNTO 0);
		dataout : OUT std_logic_vector(31 DOWNTO 0));
END COMPONENT;

COMPONENT n_bit_adder is 
generic(N: integer :=32);
port(
a,b : in std_logic_vector(N-1 downto 0);
cin: in std_logic;
cout: out std_logic;
s : out std_logic_vector(N-1 downto 0));
end COMPONENT;

COMPONENT fetchaddedvalue is 

port(
opcode : in std_logic_vector(4 downto 0);
addedvalue : out std_logic_vector(19 downto 0));

end COMPONENT;

signal previnstruction : std_logic_vector(31 downto 0);
signal temp : std_logic_vector(31 downto 0);
signal tempadder : std_logic_vector(19 downto 0);
signal couttemp : std_logic;
signal addedvalue: std_logic_vector(19 downto 0);
signal instructionread: std_logic_vector(31 downto 0);
begin
	

	r: ram PORT MAP(clk, '0', ip, temp, instructionread);
	instruction <= instructionread;
	v: fetchaddedvalue PORT MAP(instructionread(31 downto 27), addedvalue);
	a: n_bit_adder GENERIC MAP(20) PORT MAP(ip,addedvalue, '0', couttemp, tempadder);
	
	
	PROCESS(clk) IS
		BEGIN
			IF rising_edge(clk) THEN  
				ip<=tempadder;
			END IF;
	END PROCESS;


end Architecture;