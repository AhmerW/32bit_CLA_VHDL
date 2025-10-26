LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY tb_CLA_top IS
END ENTITY tb_CLA_top;
ARCHITECTURE mixed OF tb_CLA_top IS
	COMPONENT CLA_top IS
		PORT (
			a, b : IN std_logic_vector(31 DOWNTO 0);
			cin : IN std_logic;
			--
			sum : OUT std_logic_vector(31 DOWNTO 0);
			cout : OUT std_logic
		);
	END COMPONENT;
	SIGNAL tb_a, tb_b : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL tb_cin : std_logic := '0';
	SIGNAL tb_sum : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL tb_cout : std_logic := '0';
BEGIN
	DUT : CLA_top
	PORT MAP(
		a => tb_a, 
		b => tb_b, 
		cin => tb_cin, 
		--
		sum => tb_sum, 
		cout => tb_cout
	);
	PROCESS BEGIN
	-- Test 1: simple addition without carry
	tb_a <= std_logic_vector(to_unsigned(15, 32));
	tb_b <= std_logic_vector(to_unsigned(16, 32));
	tb_cin <= '0';
	WAIT FOR 20 ns;
	ASSERT (tb_sum = std_logic_vector(to_unsigned(31, 32)) AND tb_cout = 
	'0')
	REPORT ("FAILED: 15+16 = 31") SEVERITY failure;
		-- Test 2: small numbers no carry
		tb_a <= std_logic_vector(to_unsigned(7, 32));
		tb_b <= std_logic_vector(to_unsigned(5, 32));
		tb_cin <= '0';WAIT FOR 20 ns;
		ASSERT (tb_sum = std_logic_vector(to_unsigned(12, 32)) AND tb_cout = 
		'0')
		REPORT ("FAILED: 7+5 = 12") SEVERITY failure;
			-- Test 3: output with carry
			tb_a <= std_logic_vector(to_unsigned(15, 32));
			tb_b <= std_logic_vector(to_unsigned(1, 32));
			tb_cin <= '0';WAIT FOR 20 ns;
			ASSERT (tb_sum = std_logic_vector(to_unsigned(16, 32)) AND tb_cout = 
			'0')
			REPORT ("FAILED: 15+1 = 16") SEVERITY failure;
				-- Test 4: carryin
				tb_a <= std_logic_vector(to_unsigned(8, 32));
				tb_b <= std_logic_vector(to_unsigned(8, 32));
				tb_cin <= '1';WAIT FOR 20 ns;
				ASSERT (tb_sum = std_logic_vector(to_unsigned(17, 32)) AND tb_cout = 
				'0')
				REPORT ("FAILED: 8+8+1 = 17") SEVERITY failure;
					-- Test 5:big numbers without carry out
					tb_a <= std_logic_vector(to_unsigned(4096, 32));
					tb_b <= std_logic_vector(to_unsigned(4096, 32));
					tb_cin <= '0';WAIT FOR 20 ns;
					ASSERT (tb_sum = std_logic_vector(to_unsigned(8192, 32)) AND tb_cout = 
					'0')
					REPORT ("FAILED: 4096+4096 = 8192") SEVERITY failure;
						-- Test 6: absolult maximum
						tb_a <= x"FFFFFFFF";
						tb_b <= x"00000001";
						tb_cin <= '0';WAIT FOR 20 ns;
						ASSERT (tb_sum = x"00000000" AND tb_cout = '1')
						REPORT ("FAILED: FFFFFFFF+1 = 0 WITH carry OUT") SEVERITY
							failure;
							-- Test 7: Carry-in propagating
							tb_a <= std_logic_vector(to_unsigned(255, 32));
							tb_b <= std_logic_vector(to_unsigned(1, 32));
							tb_cin <= '1';WAIT FOR 20 ns;
							ASSERT (tb_sum = std_logic_vector(to_unsigned(257, 32)) AND tb_cout = 
							'0')
							REPORT ("FAILED: 255+1+carry_in = 257") SEVERITY failure;
								-- Test 8: complex big numbers tall
								tb_a <= std_logic_vector(to_unsigned(100000, 32));
								tb_b <= std_logic_vector(to_unsigned(250000, 32));
								tb_cin <= '0';WAIT FOR 20 ns;
								ASSERT (tb_sum = std_logic_vector(to_unsigned(350000, 32)) AND tb_cout
								'0')
								REPORT ("FAILED: 100000+250000 = 350000") SEVERITY failure;
									-- Test 9: alternating bits
									tb_a <= x"AAAAAAAA";
									tb_b <= x"55555555";
									tb_cin <= '0';WAIT FOR 20 ns;
									ASSERT (tb_sum = x"FFFFFFFF" AND tb_cout = '0')
									REPORT ("FAILED: AAAAAAAA + 55555555 = FFFFFFFF") SEVERITY
										failure;
										-- Test 10: high carry out
										tb_a <= x"12345678";
                                        tb_b <= x"87654321";
                                        tb_cin <= '0';
                                        wait for 20 ns;
                                        assert ( tb_sum = x"99999999" and tb_cout = '0') 
                                            report ("FAILED: 12345678 + 87654321 = 99999999") severity 
                                            failure;
-- Done
        report("Ferdig!") severity note;
        std.env.stop;
    end process;
end architecture mixed;