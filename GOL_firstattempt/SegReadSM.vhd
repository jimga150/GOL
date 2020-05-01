----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:19:54 01/23/2019 
-- Design Name: 
-- Module Name:    SegReadSM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SegReadSM is
	generic (chunk_index_bits : integer := 6;
				row_index_bits : integer := 11);
    Port ( clk, rst, rd_empty, disp_en, v_sync, current : in  STD_LOGIC;
			  rd_count : in STD_LOGIC_VECTOR (6 downto 0);
			  chunk_index_plus_one : in  STD_LOGIC_VECTOR (chunk_index_bits - 1 downto 0);
			  row_in : in STD_LOGIC_VECTOR (row_index_bits - 1 downto 0);
           chunk_addr : out  STD_LOGIC_VECTOR (chunk_index_bits + row_index_bits downto 0);
           rd_en, cmd_en : out  STD_LOGIC);
end SegReadSM;

architecture Behavioral of SegReadSM is

	type state_type is (
		WAIT_FOR_SYNC,
		ACCEPT_ROW,
		RESET_ROW,
		
		SEND_READ_CMD,
		INC_CHUNK_INDEX_CMD,
		WAIT_FOR_FIRST_READ_AND_ROW_END,
		CLOCK_CHUNK_INTO_SRC,
		WAIT_FOR_NEXT_READ,
		INC_CHUNK_INDEX_READOUT
	);
	
	signal state, nextstate : state_type := RESET_ROW;
	
	signal chunk_index_vect, chunk_index_temp : 
		std_logic_vector(chunk_index_bits - 1 downto 0) := (others => '0');
	
	signal next_row_vect, next_row_temp : 
		std_logic_vector(row_index_bits - 1 downto 0) := (others => '0');

begin

	chunk_addr(chunk_index_bits - 1 downto 0) <= chunk_index_vect;
	chunk_addr(chunk_index_bits + row_index_bits - 1 downto chunk_index_bits)
		<= next_row_vect;
	chunk_addr(chunk_index_bits + row_index_bits) <= current;
	
	sync_proc: process (clk, rst) is begin
		if rst = '1' then
			state <= RESET_ROW;
			chunk_index_vect <= (others => '0');
			next_row_vect <= (others => '0');
		elsif rising_edge(clk) then
			state <= nextstate;
			chunk_index_vect <= chunk_index_temp;
			next_row_vect <= next_row_temp;
		end if;
	end process sync_proc;
	
	next_state_proc: process (state, disp_en, v_sync, rd_empty, rd_count, chunk_index_plus_one) is begin
		case state is
			when WAIT_FOR_SYNC =>
				if disp_en = '1' then
					nextstate <= ACCEPT_ROW;
				elsif v_sync = '1' then
					nextstate <= RESET_ROW;
				else 
					nextstate <= WAIT_FOR_SYNC;
				end if;
				
			when ACCEPT_ROW =>
				nextstate <= SEND_READ_CMD;
				
			when RESET_ROW =>
				nextstate <= SEND_READ_CMD;
				
			when SEND_READ_CMD =>
				nextstate <= INC_CHUNK_INDEX_CMD;				
				
			when INC_CHUNK_INDEX_CMD =>
				if unsigned(chunk_index_plus_one) = 0 then
					nextstate <= WAIT_FOR_FIRST_READ_AND_ROW_END;
				else 
					nextstate <= SEND_READ_CMD;
				end if;
				
			when WAIT_FOR_FIRST_READ_AND_ROW_END =>
				if (disp_en = '0' and rd_empty = '0') then
					nextstate <= CLOCK_CHUNK_INTO_SRC;
				else
					nextstate <= WAIT_FOR_FIRST_READ_AND_ROW_END;
				end if;
				
			when CLOCK_CHUNK_INTO_SRC =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_NEXT_READ;
				else
					nextstate <= INC_CHUNK_INDEX_READOUT;
				end if;
				
			when WAIT_FOR_NEXT_READ =>
				if rd_empty = '0' then
					nextstate <= INC_CHUNK_INDEX_READOUT;
				else
					nextstate <= WAIT_FOR_NEXT_READ;
				end if;
				
			when INC_CHUNK_INDEX_READOUT =>
				if unsigned(chunk_index_plus_one) = 0 then
					nextstate <= WAIT_FOR_SYNC;
				else 
					nextstate <= CLOCK_CHUNK_INTO_SRC;
				end if;
			
		end case;
	end process next_state_proc;
	
	cmd_en_proc: process (state) is begin
		case state is
			when SEND_READ_CMD =>
				cmd_en <= '1';
			when others =>
				cmd_en <= '0';
		end case;
	end process cmd_en_proc;
	
	rd_en_proc: process (state) is begin
		case state is
			when CLOCK_CHUNK_INTO_SRC =>
				rd_en <= '1';
			when others =>
				rd_en <= '0';
		end case;
	end process rd_en_proc;
	
	chunk_index_proc: process(state, chunk_index_vect, chunk_index_plus_one) is begin
		case state is
			when INC_CHUNK_INDEX_CMD | INC_CHUNK_INDEX_READOUT =>
				chunk_index_temp <= chunk_index_plus_one;
			when others =>
				chunk_index_temp <= chunk_index_vect;
		end case;
	end process chunk_index_proc;
	
	next_row_proc: process(state, next_row_vect, row_in) is begin
		case state is
			when ACCEPT_ROW =>
				next_row_temp <= std_logic_vector(unsigned(row_in) + 1);
			when RESET_ROW => 
				next_row_temp <= (others => '0');
			when others =>
				next_row_temp <= next_row_vect;
		end case;
	end process next_row_proc;

end Behavioral;

