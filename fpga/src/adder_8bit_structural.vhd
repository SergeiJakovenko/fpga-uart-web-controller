library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is
      port(
                a        : in  STD_LOGIC;
>>              b        : in  STD_LOGIC;
>>              cin      : in  STD_LOGIC;
>>              sum      : out STD_LOGIC;
>>              cout     : out STD_LOGIC
>>          );
>> end full_adder_1bit;

architecture GateLevel of full_adder_1bit is
begin
     sum   <= a xor b xor cin;
     cout  <= (a and b) or (cin and (a xor b));
end GateLevel;

library ieee;
use ieee.std_logic_1164.all;

entity adder_8bit_strucrutural is
    Port (
                a        : in  STD_LOGIC_VECTOR(7 downto 0);
>>              b        : in  STD_LOGIC_VECTOR(7 downto 0);
>>              cin      : in  STD_LOGIC;
>>              sum      : out STD_LOGIC_VECTOR(7 downto 0);
>>              cout     : out STD_LOGIC
>>          ); 
end adder_8bit_structural;

architecture Structural of adder_8bit_structural is

    component full_adder_1bit is
      port(
             a        : in  STD_LOGIC;
             b        : in  STD_LOGIC;
             cin      : in  STD_LOGIC;
             sum      : out STD_LOGIC;
             cout     : out STD_LOGIC
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
                   cin  => c_chqin(i),
                   sum  => sim(i),
                   cout => c_chain(i+1)
               );
    end generate gen_adder;

    cout <= c_chain(8);

end Structural;
