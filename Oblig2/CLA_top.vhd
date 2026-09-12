library IEEE;
    use IEEE.STD_LOGIC_1164.all;

entity CLA_top is
    generic(width: positive := 32);

    port(
        a, b : in std_logic_vector(width-1 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(width-1 downto 0);
        cout : out std_logic
    );
end entity CLA_top;

architecture mixed of CLA_top is

    component CLA_block
        port(a,b: in std_logic_vector(3 downto 0);
        cin: in std_logic;
        s: out std_logic_vector(3 downto 0);
        cout: out std_logic);
    end component;

    signal c: std_logic_vector(8 downto 0);

    begin
        c(0) <= cin;
        
        block1: CLA_block port map(a(width-29 downto width-32), b(width-29 downto width-32), c(0), sum(width-29 downto width-32), c(1));
        block2: CLA_block port map(a(width-25 downto width-28), b(width-25 downto width-28), c(1), sum(width-25 downto width-28), c(2));
        block3: CLA_block port map(a(width-21 downto width-24), b(width-21 downto width-24), c(2), sum(width-21 downto width-24), c(3));
        block4: CLA_block port map(a(width-17 downto width-20), b(width-17 downto width-20), c(3), sum(width-17 downto width-20), c(4));
        block5: CLA_block port map(a(width-13 downto width-16), b(width-13 downto width-16), c(4), sum(width-13 downto width-16), c(5));
        block6: CLA_block port map(a(width-9 downto width-12), b(width-9 downto width-12), c(5), sum(width-9 downto width-12), c(6));
        block7: CLA_block port map(a(width-5 downto width-8), b(width-5 downto width-8), c(6), sum(width-5 downto width-8), c(7));
        block8: CLA_block port map(a(width-1 downto width-4), b(width-1 downto width-4), c(7), sum(width-1 downto width-4), c(8));

        cout <= c(8);

    end;