library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_8bit_dataflow is
    Port (
             a        : in  STD_LOGIC_VECTOR(7 downto 0);
             b        : in  STD_LOGIC_VECTOR(7 downto 0);
             cin      : in  STD_LOGIC;
             sum      : out STD_LOGIC_VECTOR(7 downto 0);
             cout     : out STD_LOGIC
         );
end adder_8bit_dataflow;

architecture Dataflow of adder_8bit_dataflow is
    signal temp_sum : unsigned(8 downto 0);
begin
    temp_sum <= resize(unsigned(a), 9) + resize(unsigned(b), 9) + (0 => cin);
    sum <= std_logic_vector(temp_sum(7 downto 0));
    cout <= temp_sum(8);
end Dataflow;
