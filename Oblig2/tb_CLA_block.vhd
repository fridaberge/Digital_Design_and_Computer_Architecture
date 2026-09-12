library IEEE;
    use IEEE.STD_LOGIC_1164.all;

entity tb_CLA_block is
end entity tb_CLA_block;

architecture behavioral of tb_CLA_block is
    component CLA_block is
        port(
            a,b: in std_logic_vector(3 downto 0);
            cin: in std_logic;
            s: out std_logic_vector(3 downto 0);
            cout: out std_logic
        );
 end component;

signal tb_a: std_logic_vector(3 downto 0) := "0000";
signal tb_b: std_logic_vector(3 downto 0) := "0000";
signal tb_cin: std_logic := '0';
signal tb_s: std_logic_vector(3 downto 0);
signal tb_cout: std_logic;

begin
    DUT: CLA_block
    port map(tb_a,tb_b,tb_cin,tb_s,tb_cout);

    process
    begin
        wait for 10 ns;
        tb_a <= "1000";
        tb_b <= "0000";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_s = "1000") report ("sum ikke lik 1000") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= "1000";
        tb_b <= "0000";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_s = "1001") report ("sum ikke lik 1001") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= "0001";
        tb_b <= "0001";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_s = "0010") report ("sum ikke lik 0010") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= "0001";
        tb_b <= "0001";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_s = "0011") report ("sum ikke lik 0011") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= "1000";
        tb_b <= "1000";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_s = "0000") report ("sum ikke lik 0000") severity failure;
        assert(tb_cout = '1') report ("mente ikke lik 1") severity failure;

        tb_a <= "1000";
        tb_b <= "1000";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_s = "0001") report ("sum ikke lik 0001") severity failure;
        assert(tb_cout = '1') report ("mente ikke lik 1") severity failure;

	tb_a <= "1100";
        tb_b <= "0011";
        tb_cin <= '0';
        wait for 10 ns;
        assert(tb_s = "1111") report ("sum ikke lik forste 1111") severity failure;
        assert(tb_cout = '0') report ("mente ikke lik 0") severity failure;

        tb_a <= "1100";
        tb_b <= "0011";
        tb_cin <= '1';
        wait for 10 ns;
        assert(tb_s = "0000") report ("sum ikke lik andre 1111") severity failure;
        assert(tb_cout = '1') report ("mente ikke lik 1") severity failure;

        report("Ferdig med testingen! Alt gikk fint") severity note;
        std.env.stop;
    end process;
end architecture behavioral;