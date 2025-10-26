LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fulladder IS
	PORT (
		a : IN std_logic;
		b : IN std_logic;
		cin : IN std_logic;
		s : OUT std_logic;
		cout : OUT std_logic
	);
END fulladder;
ARCHITECTURE rtl OF fulladder IS
BEGIN
	s <= a XOR b XOR cin;
	cout <= ((a XOR b) AND cin) OR (a AND b);

END rtl;