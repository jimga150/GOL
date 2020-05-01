----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:49:01 01/11/2019 
-- Design Name: 
-- Module Name:    MasterSM - Behavioral 
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

entity MasterSM is
	generic(
		words_per_seg : integer := 8;
		seg_bits : integer := 8
	);
    Port ( clk : in STD_LOGIC;
			  disp_en, v_sync : in  STD_LOGIC;
			  
           done_reading : in  STD_LOGIC;
           done_updating : in  STD_LOGIC;
			  
			  row_count_plus_one : in STD_LOGIC_VECTOR(2 downto 0);
			  
			  row_count: out STD_LOGIC_VECTOR(2 downto 0);
			  			  			  
           read_seg : out  STD_LOGIC;
           segment_num : out  STD_LOGIC_VECTOR (seg_bits - 1 downto 0);
			  
           pixel_clk_en : out  STD_LOGIC;
			  
           update : out  STD_LOGIC;
           current : out  STD_LOGIC);
end MasterSM;

architecture Behavioral of MasterSM is

	type state_type is (
		FIRST_READ, 
		FIRST_WAIT, 
		START_PIXEL_CLK,
		
		INC_SEG_NUM, 
		DISPLAYING, 
		INC_COUNT, 
		WAIT_FOR_DISP,
		READ_NEXT_SEG, 
		WAIT_FOR_READ, 
		
		WAIT_FOR_SYNC, 
		
		UPDATE_CELLS, 
		WAIT_FOR_UPDATE, 
		SWITCH_PLANE, 
		READ_FIRST_SEG
	);

	signal state : state_type := FIRST_READ;
	signal nextstate : state_type := FIRST_WAIT; 
	
	signal seg_num_vect, seg_num_temp : std_logic_vector(seg_bits - 1 downto 0) := 
		std_logic_vector(to_unsigned(0, seg_bits));
	signal current_vect, current_temp : std_logic;
	signal row_count_vect, row_count_temp : std_logic_vector(2 downto 0) := "000";
	
begin

	segment_num <= seg_num_vect;
	current <= current_vect;
	row_count <= row_count_vect;

	sync_proc: process(clk) is begin
		if rising_edge(clk) then
			state <= nextstate;
			seg_num_vect <= seg_num_temp;
			current_vect <= current_temp;
			row_count_vect <= row_count_temp;
		end if;
	end process sync_proc;

	next_state: process(state, disp_en, v_sync, done_reading, done_updating, row_count_plus_one) is begin
		case state is 
			when FIRST_READ =>
				nextstate <= FIRST_WAIT;
				
			when FIRST_WAIT => 
				if done_reading = '1' then
					nextstate <= START_PIXEL_CLK;
				else 
					nextstate <= FIRST_WAIT;
				end if;
				
			when START_PIXEL_CLK =>
				if disp_en = '1' then
					nextstate <= INC_SEG_NUM;
				else 
					nextstate <= START_PIXEL_CLK;
				end if;
				
			when INC_SEG_NUM =>
				nextstate <= DISPLAYING;
				
			when DISPLAYING =>
				if disp_en = '0' then
					nextstate <= INC_COUNT;
				else 
					nextstate <= DISPLAYING;
				end if;
			
			when INC_COUNT =>
				if row_count_plus_one = "000" then
					nextstate <= READ_NEXT_SEG;
				else 
					nextstate <= WAIT_FOR_DISP;
				end if;
			
			when WAIT_FOR_DISP =>
				if disp_en = '1' then
					nextstate <= DISPLAYING;
				else 
					nextstate <= WAIT_FOR_DISP;
				end if;
				
			when READ_NEXT_SEG =>
				nextstate <= WAIT_FOR_READ;
				
			when WAIT_FOR_READ =>
				if done_reading = '1' then
					nextstate <= WAIT_FOR_SYNC;
				else 
					nextstate <= WAIT_FOR_READ;
				end if;
				
			when WAIT_FOR_SYNC =>
				if disp_en = '1' then
					nextstate <= INC_SEG_NUM;
				elsif v_sync = '1' then
					nextstate <= UPDATE_CELLS;
				else 
					nextstate <= WAIT_FOR_SYNC;
				end if;
				
			when UPDATE_CELLS =>
				nextstate <= WAIT_FOR_UPDATE;
				
			when WAIT_FOR_UPDATE =>
				if done_updating = '1' then
					nextstate <= SWITCH_PLANE;
				else 
					nextstate <= WAIT_FOR_UPDATE;
				end if;
				
			when SWITCH_PLANE =>
				nextstate <= READ_FIRST_SEG;
				
			when READ_FIRST_SEG =>
				nextstate <= WAIT_FOR_READ;
				
		end case;	
	end process next_state;
	
	output_decode: process(state) is begin
		case state is 
			when FIRST_READ =>
				read_seg <= '1';
				pixel_clk_en <= '0';
				update <= '0';
				
			when FIRST_WAIT => 
				read_seg <= '0';
				pixel_clk_en <= '0';
				update <= '0';
				
			when START_PIXEL_CLK =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
				
			when INC_SEG_NUM =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
				
			when DISPLAYING =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
				
			when INC_COUNT =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
			
			when WAIT_FOR_DISP =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
				
			when READ_NEXT_SEG =>
				read_seg <= '1';
				pixel_clk_en <= '1';
				update <= '0';
				
			when WAIT_FOR_READ =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
				
			when WAIT_FOR_SYNC =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
				
			when UPDATE_CELLS =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '1';
				
			when WAIT_FOR_UPDATE =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
				
			when SWITCH_PLANE =>
				read_seg <= '0';
				pixel_clk_en <= '1';
				update <= '0';
				
			when READ_FIRST_SEG =>
				read_seg <= '1';
				pixel_clk_en <= '1';
				update <= '0';
				
		end case;
	end process output_decode;
	
	current_proc: process(state, current_vect) is begin
		case state is
			when FIRST_READ =>
				current_temp <= '0';
			when SWITCH_PLANE =>
				current_temp <= not current_vect;
			when others =>
				current_temp <= current_vect;
		end case;
	end process current_proc;
	
	seg_num_proc: process(state, seg_num_vect) is begin
		case state is
			when INC_SEG_NUM =>
				seg_num_temp <= std_logic_vector(unsigned(seg_num_vect) + 1);
			when SWITCH_PLANE =>
				seg_num_temp <= std_logic_vector(to_unsigned(0, seg_bits));
			when others =>
				seg_num_temp <= seg_num_vect;
		end case;
	end process seg_num_proc;
	
	row_count_proc: process(state, row_count_vect, row_count_plus_one) is begin
		case state is
			when INC_COUNT =>
				row_count_temp <= row_count_plus_one;
			when READ_NEXT_SEG =>
				row_count_temp <= (others => '0');
			when others =>
				row_count_temp <= row_count_vect;
		end case;
	end process row_count_proc;

end Behavioral;

