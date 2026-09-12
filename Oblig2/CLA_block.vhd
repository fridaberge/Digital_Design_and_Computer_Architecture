library IEEE;
    use IEEE.STD_LOGIC_1164.all;

entity CLA_block is
    port(
        a, b : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end entity CLA_block;

architecture mixed of CLA_block is

    component fulladder
        port(a,b,cin: in std_logic;
        s,cout: out std_logic);
    end component;

    signal p, g: std_logic_vector(3 downto 0);
    signal c: std_logic_vector(4 downto 0);
    signal p30,g30: std_logic;

    begin
        p <= a(3 downto 0) or b(3 downto 0);
        g <= a(3 downto 0) and b(3 downto 0);

        p30 <= and p;
        g30 <= g(3) or (p(3) and (g(2) or (p(2) and (g(1) or (p(1) and g(0))))));

        c(0) <= cin;

        f1: fulladder port map(a(0), b(0), c(0), s(0), c(1));
        f2: fulladder port map(a(1), b(1), c(1), s(1), c(2));
        f3: fulladder port map(a(2), b(2), c(2), s(2), c(3));
        f4: fulladder port map(a(3), b(3), c(3), s(3), c(4));

        cout <= g30 or (p30 and cin);

    end;