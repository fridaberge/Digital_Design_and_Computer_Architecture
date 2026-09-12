library IEEE;
    use IEEE.STD_LOGIC_1164.all;

entity tb_CLA_top is
	generic(width: positive := 32);
end entity tb_CLA_top;

architecture behavioral of tb_CLA_top is
    component CLA_top is
        port(
            a, b : in std_logic_vector(width-1 downto 0);
            cin : in std_logic;
            sum : out std_logic_vector(width-1 downto 0);
            cout : out std_logic
        );
 end component;

signal tb_a: std_logic_vector(width-1 downto 0) := x"00000000";
signal tb_b: std_logic_vector(width-1 downto 0) := x"00000000";
signal tb_cin: std_logic := '0';
signal tb_sum: std_logic_vector(width-1 downto 0);
signal tb_cout: std_logic;

begin
    DUT: CLA_top
    port map(tb_a,tb_b,tb_cin,tb_sum,tb_cout);

    process
    begin
        wait for 10 ns;
        tb_a <= x"00001000";
        tb_b <= x"00000000";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_sum = x"00001000") report ("sum ikke lik 0x00001000") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= x"0000F000";
        tb_b <= x"00000000";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_sum = x"0000F001") report ("sum ikke lik 0x00001001") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= x"0000000C";
        tb_b <= x"0000000C";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_sum = x"00000018") report ("sum ikke lik 0x00000018") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= x"0000000C";
        tb_b <= x"0000000C";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_sum = x"00000019") report ("sum ikke lik 0x00000019") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= x"00ABC000";
        tb_b <= x"12300000";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_sum = x"12DBC000") report ("sum ikke lik 0x12DBC000") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= x"12300000";
        tb_b <= x"00ABC000";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_sum = x"12DBC001") report ("sum ikke lik 0x12DBC001") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

	tb_a <= x"FCA34522";
        tb_b <= x"87654321";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_sum = x"84088843") report ("sum ikke lik forste 0x84088843") severity failure;
        assert(tb_cout = '1') report ("mente ikke lik 1") severity failure;

        tb_a <= x"FCA34522";
        tb_b <= x"87654321";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_sum = x"84088844") report ("sum ikke lik andre 0x84088844") severity failure;
        assert(tb_cout = '1') report ("mente ikke lik 1") severity failure;

        tb_a <= x"FFFFFFFF";
        tb_b <= x"FFFFFFFF";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_sum = x"FFFFFFFE") report ("sum ikke lik 0xFFFFFFFE") severity failure;
        assert(tb_cout = '1') report ("mente ikke lik 1") severity failure;

        tb_a <= x"FFFFFFFF";
        tb_b <= x"FFFFFFFF";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_sum = x"FFFFFFFF") report ("sum ikke lik 0xFFFFFFFF") severity failure;
        assert(tb_cout = '1') report ("mente ikke lik 1") severity failure;

	tb_a <= x"ABCDEF01";
        tb_b <= x"10FEDCBA";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_sum = x"BCCCCBBB") report ("sum ikke lik 0xBCCCCBBB") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= x"ABCDEF01";
        tb_b <= x"10FEDCBA";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_sum = x"BCCCCBBC") report ("sum ikke lik 0xBCCCCBBC") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        report("Ferdig med testingen! Alt gikk fint") severity note;
        std.env.stop;
    end process;
end architecture behavioral;