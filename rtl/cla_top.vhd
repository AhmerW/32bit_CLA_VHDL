LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY CLA_top IS
	PORT (
		a, b : IN std_logic_vector(31 DOWNTO 0);
		cin : IN std_logic;
		sum : OUT std_logic_vector(31 DOWNTO 0);
		cout : OUT std_logic
	);
END ENTITY CLA_top;
ARCHITECTURE mixed OF CLA_top IS
	COMPONENT CLA_block IS
		PORT (
			a, b : IN std_logic_vector(3 DOWNTO 0);
			cin : IN std_logic;
			s : OUT std_logic_vector(3 DOWNTO 0);
			cout : OUT std_logic
		);
	END COMPONENT;
	SIGNAL c : std_logic_vector(0 TO 8);
	-- 0 is cin
BEGIN
	c(8) <= cin;
	-- using the  carry from the last block as input to the next  blokk
	-- and c(8) as an invinsible cin
 
	clas : FOR i IN 7 DOWNTO 0 GENERATE
		ny_cla : CLA_block
		PORT MAP(
			a => a(31 - i * 4 DOWNTO 28 - i * 4), 
			b => b(31 - i * 4 DOWNTO 28 - i * 4), 
			cin => c(i + 1), 
			--
			s => sum(31 - i * 4 DOWNTO 28 - i * 4), 
			cout => c(i)
		);
	END GENERATE clas;
	cout <= c(0);
END ARCHITECTURE;