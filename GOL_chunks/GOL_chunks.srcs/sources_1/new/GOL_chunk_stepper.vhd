----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/01/2022 04:11:09 PM
-- Design Name: 
-- Module Name: GOL_chunk_stepper - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

use work.GOL_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_chunk_stepper is
    Port (
        i_clk, i_rst, i_step_ena : in STD_LOGIC;
        
        i_top_edge, i_bottom_edge : in STD_LOGIC_VECTOR(c_num_cell_cols-1 downto 0) := (others => '0');
        i_right_edge, i_left_edge : in STD_LOGIC_VECTOR(c_num_cell_rows-1 downto 0) := (others => '0');
        i_top_left_bit, i_top_right_bit, i_bottom_left_bit, i_bottom_right_bit : in std_logic := '0';
                
        o_bram_clk : out std_logic;
        o_bram_ena, o_bram_we : out std_logic;
        o_bram_addr : out std_logic_vector(9 downto 0);
        o_bram_wr_data : out std_logic_vector(35 downto 0);
        i_bram_rd_data : in std_logic_vector(35 downto 0);
        
        o_top_edge, o_bottom_edge : out STD_LOGIC_VECTOR(c_num_cell_cols-1 downto 0);
        o_right_edge, o_left_edge : out STD_LOGIC_VECTOR(c_num_cell_rows-1 downto 0);
        o_top_left_bit, o_top_right_bit, o_bottom_left_bit, o_bottom_right_bit : out std_logic
        
    );
end GOL_chunk_stepper;

architecture Behavioral of GOL_chunk_stepper is

    constant c_bram_read_delay : integer := 2;
    
    signal s_current_state_msb, s_next_state_msb : std_logic;
    
    signal s_cache_top_left_bit : std_logic;
    signal s_cache_top_edge : std_logic_vector(c_chunk_width-1 downto 0);
    signal s_cache_top_right_bit : std_logic;
    
    signal s_cache_left_edge : std_logic_vector(c_chunk_height-1 downto 0);
    signal s_cache_center_chunk : t_chunk_type;
    signal s_cache_right_edge : std_logic_vector(c_chunk_height-1 downto 0);
    
    signal s_cache_bottom_left_bit : std_logic;
    signal s_cache_bottom_edge : std_logic_vector(c_chunk_width-1 downto 0);
    signal s_cache_bottom_right_bit : std_logic;
    
    signal s_we_top_left_bit_pline : std_logic_vector(c_bram_read_delay downto 0);
    signal s_we_top_edge_pline : std_logic_vector(c_bram_read_delay downto 0);
    signal s_we_top_right_bit_pline : std_logic_vector(c_bram_read_delay downto 0);
    
    signal s_we_left_edge_pline : std_logic_vector(c_bram_read_delay downto 0);
    signal s_we_center_chunk_pline : std_logic_vector(c_bram_read_delay downto 0);
    signal s_we_right_edge_pline : std_logic_vector(c_bram_read_delay downto 0);
    
    signal s_we_bottom_left_bit_pline : std_logic_vector(c_bram_read_delay downto 0);
    signal s_we_bottom_edge_pline : std_logic_vector(c_bram_read_delay downto 0);
    signal s_we_bottom_right_bit_pline : std_logic_vector(c_bram_read_delay downto 0);
    
    signal s_block_top_edge, s_block_bottom_edge : std_logic_vector(c_num_cell_cols-1 downto 0);
    signal s_block_right_edge, s_block_left_edge : std_logic_vector(c_num_cell_rows-1 downto 0);
    signal s_block_top_left_bit, s_block_top_right_bit, s_block_bottom_left_bit, s_block_bottom_right_bit : std_logic;
    
    signal s_current_chunk_x : unsigned(c_num_chunk_col_bits-1 downto 0);
    signal s_current_chunk_y : unsigned(c_num_chunk_row_bits-1 downto 0);
    signal s_current_chunk_x_int : integer;
    signal s_current_chunk_y_int : integer;
    
    type t_state_type is (
        READOUT_IDLE,
        READ_TOP_LEFT,
        READ_TOP_MIDDLE,
        READ_TOP_RIGHT,
        READ_CENTER_LEFT,
        READ_CENTER,
        READ_CENTER_RIGHT,
        READ_BOTTOM_LEFT,
        READ_BOTTOM_MIDDLE,
        READ_BOTTOM_RIGHT,
        READ_WAIT,
        WRITE_CHUNK
    );
    constant c_readout_sm_reset_state : t_state_type := READOUT_IDLE;
    signal s_readout_state : t_state_type;
    
    signal s_read_wait_cnt : integer range 0 to (c_bram_read_delay + 1);
    
    signal s_chunk_in : t_chunk_type;
    signal s_chunk_towrite : t_chunk_type;
    
    signal s_last_write : std_logic;
    
begin

    o_bram_clk <= i_clk;
    
    s_next_state_msb <= not s_current_state_msb;
    
    s_chunk_in <= vector_to_chunk(i_bram_rd_data);
    
    s_current_chunk_x_int <= to_integer(s_current_chunk_x);
    s_current_chunk_y_int <= to_integer(s_current_chunk_y);
    
    chunk_logic_inst: entity work.GOL_chunk_logic
    port map(
        i_chunk => s_cache_center_chunk,
        i_top_row => s_cache_top_edge, 
        i_bottom_row => s_cache_bottom_edge,
        i_left_col => s_cache_left_edge, 
        i_right_col => s_cache_right_edge,
        i_top_left_bit => s_cache_top_left_bit, 
        i_top_right_bit => s_cache_top_right_bit, 
        i_bottom_left_bit => s_cache_bottom_left_bit, 
        i_bottom_right_bit => s_cache_bottom_right_bit,
        o_chunk => s_chunk_towrite
    );
    
    process(i_clk) is begin
        if rising_edge(i_clk) then
        
            o_bram_ena <= '1';
            o_bram_we <= '0';
            
            s_we_top_left_bit_pline <= s_we_top_left_bit_pline(s_we_top_left_bit_pline'high - 1 downto 0) & '0';
            s_we_top_edge_pline <= s_we_top_edge_pline(s_we_top_edge_pline'high - 1 downto 0) & '0';
            s_we_top_right_bit_pline <= s_we_top_right_bit_pline(s_we_top_right_bit_pline'high - 1 downto 0) & '0';
            s_we_left_edge_pline <= s_we_left_edge_pline(s_we_left_edge_pline'high - 1 downto 0) & '0';
            s_we_center_chunk_pline <= s_we_center_chunk_pline(s_we_center_chunk_pline'high - 1 downto 0) & '0';
            s_we_right_edge_pline <= s_we_right_edge_pline(s_we_right_edge_pline'high - 1 downto 0) & '0';
            s_we_bottom_left_bit_pline <= s_we_bottom_left_bit_pline(s_we_bottom_left_bit_pline'high - 1 downto 0) & '0';
            s_we_bottom_edge_pline <= s_we_bottom_edge_pline(s_we_bottom_edge_pline'high - 1 downto 0) & '0';
            s_we_bottom_right_bit_pline <= s_we_bottom_right_bit_pline(s_we_bottom_right_bit_pline'high - 1 downto 0) & '0';
            
            case (s_readout_state) is
            when READOUT_IDLE => 
            
                o_bram_ena <= '0';
                
                --update edge outputs for neighboring blocks
                o_top_edge <= s_block_top_edge;
                o_bottom_edge <= s_block_bottom_edge;
                o_left_edge <= s_block_left_edge;
                o_right_edge <= s_block_right_edge;
                o_top_left_bit <= s_block_top_left_bit;
                o_top_right_bit <= s_block_top_right_bit;
                o_bottom_left_bit <= s_block_bottom_left_bit;
                o_bottom_right_bit <= s_block_bottom_right_bit;
            
                if (i_step_ena = '1') then
                    s_readout_state <= READ_TOP_LEFT;
                end if;
                
            when READ_TOP_LEFT => 
            
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int-1, s_current_chunk_y_int-1, s_current_state_msb, o_bram_addr'length);
                
                s_we_top_left_bit_pline(0) <= '1';

                s_readout_state <= READ_TOP_MIDDLE;
                
            when READ_TOP_MIDDLE => 
            
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int, s_current_chunk_y_int-1, s_current_state_msb, o_bram_addr'length);

                s_we_top_edge_pline(0) <= '1';
                
                s_readout_state <= READ_TOP_RIGHT;
                
            when READ_TOP_RIGHT => 
                
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int+1, s_current_chunk_y_int-1, s_current_state_msb, o_bram_addr'length);

                s_we_top_right_bit_pline(0) <= '1';
                
                s_readout_state <= READ_CENTER_LEFT;
                
            when READ_CENTER_LEFT => 
                
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int-1, s_current_chunk_y_int, s_current_state_msb, o_bram_addr'length);
                s_we_left_edge_pline(0) <= '1';
                
                s_readout_state <= READ_CENTER;
                
            when READ_CENTER =>
            
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int, s_current_chunk_y_int, s_current_state_msb, o_bram_addr'length);
                                
                s_we_center_chunk_pline(0) <= '1';
                
                s_readout_state <= READ_CENTER_RIGHT;
                
            when READ_CENTER_RIGHT => 
                
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int+1, s_current_chunk_y_int, s_current_state_msb, o_bram_addr'length);
                
                s_we_right_edge_pline(0) <= '1';
                
                s_readout_state <= READ_BOTTOM_LEFT;
                
            when READ_BOTTOM_LEFT =>
                 
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int-1, s_current_chunk_y_int+1, s_current_state_msb, o_bram_addr'length);
                
                s_we_bottom_left_bit_pline(0) <= '1';
                
                s_readout_state <= READ_BOTTOM_MIDDLE;
                
            when READ_BOTTOM_MIDDLE =>
                 
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int, s_current_chunk_y_int+1, s_current_state_msb, o_bram_addr'length);
                
                s_we_bottom_edge_pline(0) <= '1';
                
                s_readout_state <= READ_BOTTOM_RIGHT;
                
            when READ_BOTTOM_RIGHT => 
                
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int+1, s_current_chunk_y_int+1, s_current_state_msb, o_bram_addr'length);
                
                s_we_bottom_right_bit_pline(0) <= '1';
                
                s_readout_state <= READ_WAIT;
                s_read_wait_cnt <= 0;
                
            when READ_WAIT =>
            
                s_read_wait_cnt <= s_read_wait_cnt + 1;
                
                if (s_read_wait_cnt = c_bram_read_delay) then
                    s_readout_state <= WRITE_CHUNK;
                end if;
                
            when WRITE_CHUNK =>
            
                o_bram_addr <= get_chunk_addr(s_current_chunk_x_int, s_current_chunk_y_int, s_next_state_msb, o_bram_addr'length);
                
                o_bram_we <= '1'; 
                
                o_bram_wr_data <= chunk_to_vector(s_chunk_towrite);
                
                s_readout_state <= READ_TOP_LEFT;
                if (s_last_write = '1') then
                    s_readout_state <= READOUT_IDLE;
                end if;
                                
            end case;
            
            if (s_readout_state = WRITE_CHUNK) then
            
                s_current_chunk_x <= s_current_chunk_x + 1;
            
                if (s_current_chunk_x_int = c_num_chunk_cols - 1) then
                    s_current_chunk_x <= (others => '0');
                    s_current_chunk_y <= s_current_chunk_y + 1;
                    if (s_current_chunk_y_int = c_num_chunk_rows - 1) then
                        s_current_chunk_y <= (others => '0');
                        s_current_state_msb <= not s_current_state_msb;
                    end if;                
                end if;
                
                if (s_current_chunk_y_int = 0) then
                    
                    if (s_current_chunk_x_int = 0) then
                        s_block_top_left_bit <= s_chunk_towrite(0)(0);
                    end if;
                
                    s_block_top_edge(c_chunk_width*(s_current_chunk_x_int+1)-1 downto c_chunk_width*s_current_chunk_x_int) <= s_chunk_towrite(0);
                    
                    if (s_current_chunk_x_int = c_num_chunk_cols - 1) then
                        s_block_top_right_bit <= s_chunk_towrite(0)(c_chunk_width-1);
                    end if;
                    
                end if;

                if (s_current_chunk_x_int = 0) then
                    for r in 0 to c_chunk_height-1 loop
                        s_block_left_edge(c_chunk_height*s_current_chunk_y_int + r) <= s_chunk_towrite(r)(0);
                    end loop;
                end if;
                
                if (s_current_chunk_x_int = c_num_chunk_cols - 1) then
                    for r in 0 to c_chunk_height-1 loop
                        s_block_right_edge(c_chunk_height*s_current_chunk_y_int + r) <= s_chunk_towrite(r)(c_chunk_width-1);
                    end loop;
                end if;
                
                if (s_current_chunk_y_int = c_num_chunk_rows - 1) then
                    
                    if (s_current_chunk_x_int = 0) then
                        s_block_bottom_left_bit <= s_chunk_towrite(c_chunk_height-1)(0);
                    end if;
                
                    s_block_bottom_edge(c_chunk_width*(s_current_chunk_x_int+1)-1 downto c_chunk_width*s_current_chunk_x_int) <= s_chunk_towrite(c_chunk_height-1);
                    
                    if (s_current_chunk_x_int = c_num_chunk_cols - 1) then
                        s_block_bottom_right_bit <= s_chunk_towrite(c_chunk_height-1)(c_chunk_width-1);
                    end if;
                    
                end if;
                
            end if;
            
            if (s_current_chunk_x_int = c_num_chunk_cols - 1 and s_current_chunk_y_int = c_num_chunk_rows - 1) then
                s_last_write <= '1';
            end if;
            
            if (s_readout_state = READOUT_IDLE) then
                s_last_write <= '0';
            end if;
            
            if (s_we_top_left_bit_pline(s_we_top_left_bit_pline'high) = '1') then
                s_cache_top_left_bit <= s_chunk_in(s_chunk_in'high)(s_chunk_in(0)'high);
                if (s_current_chunk_y_int = 0) then
                    if (s_current_chunk_x_int = 0) then
                        s_cache_top_left_bit <= i_top_left_bit;
                    else
                        s_cache_top_left_bit <= i_top_edge(c_chunk_width*s_current_chunk_x_int - 1);
                    end if;
                elsif (s_current_chunk_x_int = 0) then
                    s_cache_top_left_bit <= i_left_edge(c_chunk_height*s_current_chunk_y_int - 1);
                end if;
            end if;
            
            if (s_we_top_edge_pline(s_we_top_edge_pline'high) = '1') then
                s_cache_top_edge <= s_chunk_in(s_chunk_in'high);
                if (s_current_chunk_y_int = 0) then
                    s_cache_top_edge <= i_top_edge(c_chunk_width*(s_current_chunk_x_int+1)-1 downto c_chunk_width*s_current_chunk_x_int);
                end if;
            end if;
            
            if (s_we_top_right_bit_pline(s_we_top_right_bit_pline'high) = '1') then
                s_cache_top_right_bit <= s_chunk_in(s_chunk_in'high)(0);
                if (s_current_chunk_y_int = 0) then
                    if (s_current_chunk_x_int = c_num_chunk_cols-1) then
                        s_cache_top_right_bit <= i_top_right_bit;
                    else
                        s_cache_top_right_bit <= i_top_edge(c_chunk_width*(s_current_chunk_x_int+1));
                    end if;
                elsif (s_current_chunk_x_int = c_num_chunk_cols-1) then
                    s_cache_top_right_bit <= i_right_edge(c_chunk_height*s_current_chunk_y_int - 1);
                end if;
            end if;
            
            if (s_we_left_edge_pline(s_we_left_edge_pline'high) = '1') then
                for r in 0 to c_chunk_height-1 loop
                    s_cache_left_edge(r) <= s_chunk_in(r)(s_chunk_in(0)'high);
                end loop;
                if (s_current_chunk_x_int = 0) then
                    s_cache_left_edge <= i_left_edge(c_chunk_height*(s_current_chunk_y_int+1)-1 downto c_chunk_height*s_current_chunk_y_int);
                end if;
            end if;
            
            if (s_we_center_chunk_pline(s_we_center_chunk_pline'high) = '1') then
                s_cache_center_chunk <= s_chunk_in;
            end if;
            
            if (s_we_right_edge_pline(s_we_right_edge_pline'high) = '1') then
                for r in 0 to c_chunk_height-1 loop
                    s_cache_right_edge(r) <= s_chunk_in(r)(0);
                end loop;
                if (s_current_chunk_x_int = c_num_chunk_cols-1) then
                    s_cache_right_edge <= i_right_edge(c_chunk_height*(s_current_chunk_y_int+1)-1 downto c_chunk_height*s_current_chunk_y_int);
                end if;
            end if;
            
            if (s_we_bottom_left_bit_pline(s_we_bottom_left_bit_pline'high) = '1') then
                s_cache_bottom_left_bit <= s_chunk_in(0)(s_chunk_in(0)'high);
                if (s_current_chunk_y_int = c_num_chunk_rows-1) then
                    if (s_current_chunk_x_int = 0) then
                        s_cache_bottom_left_bit <= i_bottom_left_bit;
                    else
                        s_cache_bottom_left_bit <= i_bottom_edge(c_chunk_width*s_current_chunk_x_int - 1);
                    end if;
                elsif (s_current_chunk_x_int = 0) then
                    s_cache_bottom_left_bit <= i_left_edge(c_chunk_height*(s_current_chunk_y_int+1));
                end if;
            end if;
            
            if (s_we_bottom_edge_pline(s_we_bottom_edge_pline'high) = '1') then
                s_cache_bottom_edge <= s_chunk_in(0);
                if (s_current_chunk_y_int = c_num_chunk_rows-1) then
                    s_cache_bottom_edge <= 
                        i_bottom_edge(c_chunk_width*(s_current_chunk_x_int+1)-1 downto c_chunk_width*s_current_chunk_x_int);
                end if;
            end if;
            
            if (s_we_bottom_right_bit_pline(s_we_bottom_right_bit_pline'high) = '1') then
                s_cache_bottom_right_bit <= s_chunk_in(0)(0);
                if (s_current_chunk_y_int = c_num_chunk_rows-1) then
                    if (s_current_chunk_x_int = c_num_chunk_cols-1) then
                        s_cache_bottom_right_bit <= i_bottom_right_bit;
                    else
                        s_cache_bottom_right_bit <= i_bottom_edge(c_chunk_width*(s_current_chunk_x_int+1));
                    end if;
                elsif (s_current_chunk_x_int = c_num_chunk_cols-1) then
                    s_cache_bottom_right_bit <= i_right_edge(c_chunk_height*(s_current_chunk_y_int+1));
                end if;
            end if;
            
            if (i_rst = '1') then
                o_top_edge <= (others => '0');
                o_bottom_edge <= (others => '0');
                o_left_edge <= (others => '0');
                o_right_edge <= (others => '0');
                o_top_left_bit <= '0';
                o_top_right_bit <= '0';
                o_bottom_left_bit <= '0';
                o_bottom_right_bit <= '0';
                s_block_top_edge <= (others => '0');
                s_block_bottom_edge <= (others => '0');
                s_block_right_edge <= (others => '0');
                s_block_left_edge <= (others => '0');
                s_block_top_left_bit <= '0';
                s_block_top_right_bit <= '0';
                s_block_bottom_left_bit <= '0';
                s_block_bottom_right_bit <= '0';
                s_we_top_left_bit_pline <= (others => '0');
                s_we_top_edge_pline <= (others => '0');
                s_we_top_right_bit_pline <= (others => '0');
                s_we_left_edge_pline <= (others => '0');
                s_we_center_chunk_pline <= (others => '0');
                s_we_right_edge_pline <= (others => '0');
                s_we_bottom_left_bit_pline <= (others => '0');
                s_we_bottom_edge_pline <= (others => '0');
                s_we_bottom_right_bit_pline <= (others => '0');
                s_current_chunk_x <= (others => '0');
                s_current_chunk_y <= (others => '0');
                s_current_state_msb <= '0';
                s_readout_state <= c_readout_sm_reset_state;
            end if;
            
        end if;
    end process;        
    
end Behavioral;
