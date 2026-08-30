library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_seq_detector is
end entity tb_seq_detector;

architecture Behavioral of tb_seq_detector is

    component seq_detector is
        generic (
            ACTIVE_LEVEL : std_logic := '1'
        );
        port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            data_in    : in  std_logic;
            seq_101    : out std_logic;
            seq_1010   : out std_logic;
            seq_1011   : out std_logic
        );
    end component;

    signal clk     : std_logic := '0';
    signal reset   : std_logic := '1';
    signal data_in : std_logic := '0';

    signal seq_101  : std_logic;
    signal seq_1010 : std_logic;
    signal seq_1011 : std_logic;

    constant CLK_PERIOD : time := 20 ns;

begin

    uut: seq_detector
        generic map ( ACTIVE_LEVEL => '1' )
        port map (
            clk => clk, reset => reset, data_in => data_in,
            seq_101 => seq_101, seq_1010 => seq_1010, seq_1011 => seq_1011
        );

    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    stim_proc: process
        type t_bit_array is array (0 to 9) of std_logic;
        constant TEST_STREAM : t_bit_array := ('1', '0', '1', '0', '1', '1', '0', '1', '0', '1');
    begin
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        wait for CLK_PERIOD;

        for i in TEST_STREAM'range loop
            data_in <= TEST_STREAM(i);
            wait for CLK_PERIOD;
        end loop;

        data_in <= '0';
        wait for 100 ns;
        wait;
    end process;

end architecture Behavioral;