library ieee;
use IEEE.STD_LOGIC_1164.All;

entity seq_detector is
	generic (
		ACTIVE_LEVEL : std_logic := '1'
	);
	port (
		clc		 : in  std_logic;
		reset	 : in  std_logic;
		data_in  : in  std_logic;
		seq_101  : out std_logic;
		seq_1010 : out std_logic;
		seq_1011 : out std_logic
	);
end entity seq_detector;

architecture Behavioral of seq_detector is

	type t_state is (S_IDLE, S_1, S_10, S_1010, S_1011);
	
	signal state_reg, state_next : t_state := S_IDLE;
	
begin
	
	process(clc, reset)
	begin
		if reset = '1' then
			state_reg <= S_IDLE;
		elsif rising_edge(clc) then
			state_reg <= state_next;
		end if;
	end process;

	process(state_reg, data_in)
	begin
		state_next <= state_reg;
		
		case state_reg is
			when S_IDLE => 
				if data_in = '1' then
					state_next <= S_1;
				else
					state_next <= S_IDLE;
				end if;
				
			when S_1 =>
				if data_in = '0' then
					state_next <= S_10;
				else
					state_next <= S_1;
				end if;
					
			when S_10 =>
				if data_in = '1' then
					state_next <= S_101;
				else
					state_next <= S_IDLE;
				end if;
				
			when S_101 =>
				if 		data_in = '0' then
					state_next <= S_1010;
				elsif 	data_in = '1' then
					state_next <= S_1011;
				end if;

			when S_1010 =>
				if 	data_in = '1' then
					state_next <= S_101;
				else
					state_next <= S_IDLE;
				end if;
			
			when S_1011 =>
				if data_in = '1' then
					state_next <= S_1;
				else
					state_next <= S_10;
				end if;
			
			when others =>
				state_next <= S_IDLE;
		end case;
	end process;
	
	seq_101  <= '1' when (state_reg = S_101)  else '0';
	seq_1010 <= '1' when (state_reg = S_1010) else '0';
	seq_1011 <= '1' when (state_reg = S_1011) else '0';

end architecture Behavioral;	