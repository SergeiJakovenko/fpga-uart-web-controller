library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_8bit_behavioral is
    Port (
        a        : in  STD_LOGIC_VECTOR(7 downto 0);
        b        : in  STD_LOGIC_VECTOR(7 downto 0);
        cin      : in  STD_LOGIC;
        sum      : out STD_LOGIC_VECTOR(7 downto 0);
        cout     : out STD_LOGIC
    );
end adder_8bit_behavioral;

architecture Behavioral of adder_8bit_behavioral is
begin
    process(a, b, cin)
        variable carry : STD_LOGIC;
        variable s     : STD_LOGIC;
    begin
        carry := cin;
        for i in 0 to 7 loop
            s := a(i) xor b(i) xor carry;
            if (a(i) = '1' and b(i) = '1') or (carry = '1' and (a(i) xor b(i)) = '1') then
                carry := '1';
            else
                carry := '0';
            end if;
            sum(i) <= s;
        end loop;
        cout <= carry;
    end process;
end Behavioral;
