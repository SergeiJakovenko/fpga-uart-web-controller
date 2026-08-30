library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is
    port (
        a    : in  std_logic;
        b    : in  std_logic;
        cin  : in  std_logic;
        sum  : out std_logic;
        cout : out std_logic
    );
end full_adder_1bit;

architecture GateLevel of full_adder_1bit is
begin
    sum  <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end GateLevel;