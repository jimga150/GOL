----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:13:35 02/11/2019 
-- Design Name: 
-- Module Name:    GOLUpdaterSM - Behavioral 
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
use work.bus_array_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOLUpdaterSM is
	generic (screen_row_chunks : integer := 10;
				screen_height : integer := 4);
				
    Port ( clk, rst, disp_en, v_sync_fired : in  STD_LOGIC;
           rd_count : in  STD_LOGIC_VECTOR (6 downto 0);
           readout : in  STD_LOGIC_VECTOR (31 downto 0);
			  
           cmd_en, rd_en, wr_en, plane : out  STD_LOGIC;
           x_out : out  STD_LOGIC_VECTOR (5 downto 0);
           y_out : out  STD_LOGIC_VECTOR (10 downto 0);
           instruction : out  STD_LOGIC_VECTOR (2 downto 0);
           grid : out  bus_array);
end GOLUpdaterSM;

architecture Behavioral of GOLUpdaterSM is

	type state_type is (
		WAIT_FOR_FRAME_START,
		
		TL_CHUNK, TC_CHUNK, TR_CHUNK,
		MR_CHUNK, THIS_CHUNK, ML_CHUNK,
		BL_CHUNK, BC_CHUNK, BR_CHUNK,
		
		WAIT_FOR_READS,
		
		READ_TL_CHUNK, READ_TC_CHUNK, READ_TR_CHUNK,
		READ_MR_CHUNK, READ_THIS_CHUNK, READ_ML_CHUNK,
		READ_BL_CHUNK, READ_BC_CHUNK, READ_BR_CHUNK,
		
		CHUNK_TO_WRITE_BUFF,
		SEND_WRITE_CMD,
		INCREMENT_X,
		INCREMENT_Y,
		
		WAIT_FOR_FRAME_END,
		SWITCH_PLANE
	);
	
	signal state, nextstate : state_type := WAIT_FOR_FRAME_START;
	
	--memory
	signal grid_vect, grid_temp : bus_array := (others => (others => '0'));
	signal GSfilled_vect, GSfilled_temp : integer range 0 to 9 := 0;
	signal current_vect, current_temp : std_logic := '0';
	signal x_vect, x_temp : std_logic_vector(5 downto 0) := (others => '0');
	signal y_vect, y_temp : std_logic_vector(10 downto 0) := (others => '0');
	
	--neighbors
	signal x_left, x_right : std_logic_vector(5 downto 0);
	signal y_top, y_bot : std_logic_vector(10 downto 0);
	
begin

	grid <= grid_vect;

	x_left <= std_logic_vector(to_unsigned(screen_row_chunks-1, 6)) when unsigned(x_vect) = 0 
					else std_logic_vector(unsigned(x_vect) - 1);
	
	x_right <= (others => '0') when unsigned(x_vect) = to_unsigned(screen_row_chunks-1, 6)
					else std_logic_vector(unsigned(x_vect) + 1);
					
	y_top <= std_logic_vector(to_unsigned(screen_height-1, 11)) when unsigned(y_vect) = 0 
					else std_logic_vector(unsigned(y_vect) - 1);
	
	y_bot <= (others => '0') when unsigned(y_vect) = to_unsigned(screen_height-1, 11)
					else std_logic_vector(unsigned(y_vect) + 1);

	sync_proc: process(clk, rst) is begin
		if rst = '1' then
			state <= WAIT_FOR_FRAME_START;
			grid_vect <= (others => (others => '0'));
			GSfilled_vect <= 0;
			current_vect <= '0';
			x_vect <= (others => '0');
			y_vect <= (others => '0');
		elsif rising_edge(clk) then
			state <= nextstate;
			grid_vect <= grid_temp;
			GSfilled_vect <= GSfilled_temp;
			current_vect <= current_temp;
			x_vect <= x_temp;
			y_vect <= y_temp;
		end if;
	end process sync_proc;
	
	nextstate_proc: process(state, disp_en, v_sync_fired, rd_count, y_bot, x_right, GSfilled_vect) is 
	begin
		case state is
			when WAIT_FOR_FRAME_START =>
				if disp_en = '1' then
					nextstate <= TL_CHUNK;
				else 
					nextstate <= WAIT_FOR_FRAME_START;
				end if;
				
			when TL_CHUNK =>
				nextstate <= TC_CHUNK;
				
			when TC_CHUNK =>
				nextstate <= TR_CHUNK;
				
			when TR_CHUNK =>
				nextstate <= MR_CHUNK;
				
			when MR_CHUNK =>
				nextstate <= THIS_CHUNK;
				
			when THIS_CHUNK =>
				nextstate <= ML_CHUNK;
				
			when ML_CHUNK =>
				nextstate <= BL_CHUNK;
				
			when BL_CHUNK =>
				nextstate <= BC_CHUNK;
				
			when BC_CHUNK =>
				nextstate <= BR_CHUNK;
				
			when BR_CHUNK =>
				if unsigned(rd_count) = 0 then
					nextstate <= WAIT_FOR_READS;
				else 
					nextstate <= READ_TL_CHUNK;
				end if;
				
			when WAIT_FOR_READS =>
				if unsigned(rd_count) = 0 then
					nextstate <= WAIT_FOR_READS;
				else
					if GSfilled_vect = 0 then
						nextstate <= READ_TL_CHUNK;
					elsif GSfilled_vect = 1 then
						nextstate <= READ_TC_CHUNK;
					elsif GSfilled_vect = 2 then
						nextstate <= READ_TR_CHUNK;
					elsif GSfilled_vect = 3 then
						nextstate <= READ_MR_CHUNK;
					elsif GSfilled_vect = 4 then
						nextstate <= READ_THIS_CHUNK;
					elsif GSfilled_vect = 5 then
						nextstate <= READ_ML_CHUNK;
					elsif GSfilled_vect = 6 then
						nextstate <= READ_BL_CHUNK;
					elsif GSfilled_vect = 7 then
						nextstate <= READ_BC_CHUNK;
					else --if GSfilled_vect = 8 then
						nextstate <= READ_BR_CHUNK;
					end if;
				end if;
				
			when READ_TL_CHUNK =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_READS;
				else
					nextstate <= READ_TC_CHUNK;
				end if;
				
			when READ_TC_CHUNK =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_READS;
				else
					nextstate <= READ_TR_CHUNK;
				end if;
				
			when READ_TR_CHUNK =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_READS;
				else
					nextstate <= READ_MR_CHUNK;
				end if;
				
			when READ_MR_CHUNK =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_READS;
				else
					nextstate <= READ_THIS_CHUNK;
				end if;
				
			when READ_THIS_CHUNK =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_READS;
				else
					nextstate <= READ_ML_CHUNK;
				end if;
				
			when READ_ML_CHUNK =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_READS;
				else
					nextstate <= READ_BL_CHUNK;
				end if;
				
			when READ_BL_CHUNK =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_READS;
				else
					nextstate <= READ_BC_CHUNK;
				end if;
				
			when READ_BC_CHUNK =>
				if unsigned(rd_count) = 1 then
					nextstate <= WAIT_FOR_READS;
				else
					nextstate <= READ_BR_CHUNK;
				end if;
				
			when READ_BR_CHUNK =>
				nextstate <= CHUNK_TO_WRITE_BUFF;
				
			when CHUNK_TO_WRITE_BUFF =>
				nextstate <= SEND_WRITE_CMD;
				
			when SEND_WRITE_CMD =>
				nextstate <= INCREMENT_X;
				
			when INCREMENT_X =>
				if unsigned(x_right) = 0 then
					nextstate <= INCREMENT_Y;
				else
					nextstate <= TL_CHUNK;
				end if;
				
			when INCREMENT_Y =>
				if unsigned(y_bot) = 0 then
					nextstate <= WAIT_FOR_FRAME_END;
				else
					nextstate <= TL_CHUNK;
				end if;
				
			when WAIT_FOR_FRAME_END =>
				if v_sync_fired = '1' then
					nextstate <= SWITCH_PLANE;
				else
					nextstate <= WAIT_FOR_FRAME_END;
				end if;
				
			when SWITCH_PLANE => 
				nextstate <= WAIT_FOR_FRAME_START;
				
		end case;
	end process nextstate_proc;
	
	grid_GS_proc: process(state, readout, grid_vect, GSfilled_vect) is begin
		case state is
			when READ_TL_CHUNK =>
				grid_temp <= (
					grid_vect(2), 
					grid_vect(1), 
					(grid_vect(0)(33 downto 1) & readout(31))
				);
				GSfilled_temp <= 1;
				
			when READ_TC_CHUNK =>
				grid_temp <= (
					grid_vect(2), 
					grid_vect(1), 
					(grid_vect(0)(33) & readout & grid_vect(0)(0))
				);
				GSfilled_temp <= 2;
				
			when READ_TR_CHUNK =>
				grid_temp <= (
					grid_vect(2), 
					grid_vect(1), 
					(readout(0) & grid_vect(0)(32 downto 0))
				);
				GSfilled_temp <= 3;
				
			when READ_MR_CHUNK =>
				grid_temp <= (
					grid_vect(2), 
					(readout(0) & grid_vect(1)(32 downto 0)), 
					grid_vect(0)
				);
				GSfilled_temp <= 4;
				
			when READ_THIS_CHUNK =>
				grid_temp <= (
					grid_vect(2), 
					(grid_vect(1)(33) & readout & grid_vect(1)(0)), 
					grid_vect(0)
				);
				GSfilled_temp <= 5;
				
			when READ_ML_CHUNK =>
				grid_temp <= (
					grid_vect(2), 
					(grid_vect(1)(33 downto 1) & readout(31)), 
					grid_vect(0)
				);
				GSfilled_temp <= 6;
				
			when READ_BL_CHUNK =>
				grid_temp <= (
					(grid_vect(2)(33 downto 1) & readout(31)), 
					grid_vect(1), 
					grid_vect(0)
				);
				GSfilled_temp <= 7;
				
			when READ_BC_CHUNK =>
				grid_temp <= (
					(grid_vect(2)(33) & readout & grid_vect(2)(0)), 
					grid_vect(1), 
					grid_vect(0)
				);
				GSfilled_temp <= 8;
				
			when READ_BR_CHUNK => 
				grid_temp <= (
					(readout(0) & grid_vect(2)(32 downto 0)), 
					grid_vect(1), 
					grid_vect(0)
				);
				GSfilled_temp <= 0;
			
			when others =>
				grid_temp <= grid_vect;
				GSfilled_temp <= GSfilled_vect;
				
		end case;
	end process grid_GS_proc;
	
	currentplane_proc: process(state, current_vect) is begin
		case state is 
			when SWITCH_PLANE => 
				current_temp <= not current_vect;
			when others => 
				current_temp <= current_vect;
		end case;
	end process currentplane_proc;

	xy_proc: process(state, x_vect, y_vect, x_right, y_bot) is begin
		case state is
			when INCREMENT_X => 
				x_temp <= x_right;
				y_temp <= y_vect;
				
			when INCREMENT_Y =>
				x_temp <= x_vect;
				y_temp <= y_bot;
				
			when others =>
				x_temp <= x_vect;
				y_temp <= y_vect;
				
		end case;
	end process xy_proc;
	
	cmd_rd_wr_en_proc: process(state) is begin
		case state is
			when SEND_WRITE_CMD | 
					TL_CHUNK | TC_CHUNK | TR_CHUNK | 
					MR_CHUNK | THIS_CHUNK | ML_CHUNK | 
					BL_CHUNK | BC_CHUNK | BR_CHUNK =>
				cmd_en <= '1';
				rd_en <= '0';
				wr_en <= '0';
			
			when READ_TL_CHUNK | READ_TC_CHUNK | READ_TR_CHUNK | 
					READ_MR_CHUNK | READ_THIS_CHUNK | READ_ML_CHUNK | 
					READ_BL_CHUNK | READ_BC_CHUNK | READ_BR_CHUNK =>
				cmd_en <= '0';
				rd_en <= '1';
				wr_en <= '0';
				
			when CHUNK_TO_WRITE_BUFF =>
				cmd_en <= '0';
				rd_en <= '0';
				wr_en <= '1';
			
			when others =>
				cmd_en <= '0';
				rd_en <= '0';
				wr_en <= '0';
				
		end case;
	end process cmd_rd_wr_en_proc;
	
	plane_proc: process(state, current_vect) is begin
		case state is
			when SEND_WRITE_CMD =>
				plane <= not current_vect;
			
			when others =>
				plane <= current_vect;
				
		end case;
	end process plane_proc;
	
	x_out_proc: process(state, x_left, x_right, x_vect) is begin
		case state is				
			when TL_CHUNK | ML_CHUNK | BL_CHUNK =>
				x_out <= x_left;
				
			when TR_CHUNK | MR_CHUNK | BR_CHUNK =>
				x_out <= x_right;
				
			when others =>
				x_out <= x_vect;
				
		end case;
	end process x_out_proc;
	
	y_out_proc: process(state, y_top, y_bot, y_vect) is begin
		case state is
			when TL_CHUNK | TC_CHUNK | TR_CHUNK =>
				y_out <= y_top;
				
			when BL_CHUNK | BC_CHUNK | BR_CHUNK =>
				y_out <= y_bot;
				
			when others =>
				y_out <= y_vect;
				
		end case;
	end process y_out_proc;
	
   instruction_proc: process(state) is begin
		case state is
			when CHUNK_TO_WRITE_BUFF =>
				instruction <= "000";
			
			when others => 
				instruction <= "001";
				
		end case;
	end process instruction_proc;
	
end Behavioral;

