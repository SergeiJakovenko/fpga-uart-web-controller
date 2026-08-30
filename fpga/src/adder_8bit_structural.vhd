library ieee;
use ieee.std_logic_1164.all;

entity adder_8bit_structural is
    port (
        a    : in  std_logic_vector(7 downto 0);
        b    : in  std_logic_vector(7 downto 0);
        cin  : in  std_logic;
        sum  : out std_logic_vector(7 downto 0);
        cout : out std_logic
    );
end adder_8bit_structural;

architecture Structural of adder_8bit_structural is

    component full_adder_1bit is
        port (
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            sum  : out std_logic;
            cout : out std_logic
        );
    end component;

    signal c_chain : std_logic_vector(8 downto 0);

begin
    c_chain(0) <= cin;

    gen_adder: for i in 0 to 7 generate
        FA_inst : full_adder_1bit
            port map (
                a    => a(i),
                b    => b(i),
                cin  => c_chain(i),
                sum  => sum(i),
                cout => c_chain(i+1)
            );
    end generate gen_adder;

    cout <= c_chain(8);

end Structural;