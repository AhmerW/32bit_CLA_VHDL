library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_CLA_block is
end entity tb_CLA_block;

architecture mixed of tb_CLA_block is

    component CLA_block is
        port (
            a, b  : in  std_logic_vector(3 downto 0);
            cin   : in  std_logic;
            s     : out std_logic_vector(3 downto 0);
            cout  : out std_logic
        );
    end component;

    signal tb_a, tb_b : std_logic_vector(3 downto 0) := (others => '0');
    signal tb_cin     : std_logic := '0';
    signal tb_s       : std_logic_vector(3 downto 0) := (others => '0');
    signal tb_cout    : std_logic := '0';

begin

    DUT : CLA_block
        port map (
            a    => tb_a,
            b    => tb_b,
            cin  => tb_cin,
            s    => tb_s,
            cout => tb_cout
        );

    process
    begin
        tb_a <= "0100";  -- 4
        tb_b <= "0011";  -- 3
        wait for 20 ns;
        assert (tb_s = "0111")
            report "Feilet med: 0100 + 0011 = 0111"
            severity failure;
        wait for 10 ns;

        tb_a <= "1101";  -- 13
        tb_b <= "0010";  -- 2
        wait for 20 ns;
        assert (tb_s = "1111")
            report "Feilet med: 1101 + 0010 = 1111"
            severity failure;
        wait for 10 ns;

        tb_a <= "1001";  -- 9
        tb_b <= "0110";  -- 6
        wait for 20 ns;
        assert (tb_s = "1111")
            report "Feilet med: 1001 + 0110 = 1111"
            severity failure;
        wait for 10 ns;

        tb_a <= "0011";  -- 3
        tb_b <= "1011";  -- 11
        wait for 20 ns;
        assert (tb_s = "1110")
            report "Feilet med: 0011 + 1011 = 1110"
            severity failure;
        wait for 10 ns;

        tb_a <= "1100";  -- 12
        tb_b <= "1100";  -- 12
        wait for 20 ns;
        assert (tb_s = "1000")
            report "Feilet med: 1100 + 1100 = 1000"
            severity failure;
        wait for 10 ns;

        tb_a <= "1010";  -- 10
        tb_b <= "0101";  -- 5
        wait for 20 ns;
        assert (tb_s = "1111")
            report "Feilet med: 1010 + 0101 = 1111"
            severity failure;

        report "Testen kjørt ferdig uten feil." severity note;
        std.env.stop;
    end process;

end architecture mixed;
