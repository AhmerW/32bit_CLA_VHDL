LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY CLA_block IS
	PORT (
		a, b : IN std_logic_vector(3 DOWNTO 0);
		cin : IN std_logic;
		s : OUT std_logic_vector(3 DOWNTO 0);
		cout : OUT std_logic
	);
END ENTITY CLA_block;
ARCHITECTURE mixed OF CLA_block IS
	COMPONENT fulladder IS
		PORT (
			a, b : IN std_logic;
			cin : IN std_logic;
			s : OUT std_logic;
			cout : OUT std_logic
		);
	END COMPONENT;
	SIGNAL p, g : std_logic_vector(3 DOWNTO 0);
	SIGNAL c : std_logic_vector(4 DOWNTO 0);
	SIGNAL p30, g30 : std_logic;
BEGIN
	-- connecting together 4 fulladders
	addder : 
	FOR i IN 0 TO 3 GENERATE
		ny_adder : fulladder
		PORT MAP(
			a => a(i), 
			b => b(i), 
			cin => c(i), 
			--
			s => s(i), -- sum
			cout => OPEN -- we only care about cout
		);
	END GENERATE addder;
	c(0) <= cin;
	-- propagate and generate per sum-adder
	cla : FOR i IN 0 TO 3 GENERATE
		p(i) <= a(i) OR b(i);
		g(i) <= a(i) AND b(i);
		c(i + 1) <= g(i) OR (p(i) AND c(i));
	END GENERATE cla;
	-- this is the carry-out logic
	p30 <= AND p;
	g30 <= ((((((((g(0) AND p(1)) OR g(1)) AND p(2)) OR g(2)) AND p(3)) OR
		g(3)) AND p(3)) OR g(3));
		cout <= (p30 AND cin) OR g30;
END ARCHITECTURE;