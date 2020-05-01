----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 02:04:08 PM
-- Design Name: 
-- Module Name: nine_read_sm - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nine_read_sm is
    Generic(
        address_length : integer := 6;
        row_addr_length : integer := 3;
        col_addr_length : integer := 3;
        max_row_index : integer := 6;
        max_col_index : integer := 5
        );
    Port ( 
        clk, rst, read : in STD_LOGIC;
        addr_base, addr_write : in STD_LOGIC_VECTOR(address_length - 1 downto 0);
        bram_read_en, bram_write_en : out STD_LOGIC;
        addr_out : out STD_LOGIC_VECTOR(address_length - 1 downto 0);
        grid_index_en : out STD_LOGIC_VECTOR(8 downto 0)
        );
end nine_read_sm;

architecture Behavioral of nine_read_sm is

    type state_type is (IDLE, R00, R01, R02, R10, R11, R12, R20, R21, R22, WAIT_READ_COMPLETE, WRITE);
    signal state_nrsm, next_state : state_type := IDLE;
    
    signal grid_index_next : std_logic_vector(8 downto 0);
    signal grid_index_reg : std_logic_vector(8 downto 0) := (others => '0');
    
    signal row_base_us : unsigned(row_addr_length-1 downto 0);
    signal col_base_us : unsigned(col_addr_length-1 downto 0);
    
    signal next_col, curr_col, prev_col : std_logic_vector(col_addr_length-1 downto 0);
    signal next_row, curr_row, prev_row : std_logic_vector(row_addr_length-1 downto 0);
    
    constant max_row_indx_vec : std_logic_vector(row_addr_length-1 downto 0) 
        := std_logic_vector(to_unsigned(max_row_index, row_addr_length));
        
    constant min_row_indx_vec : std_logic_vector(row_addr_length-1 downto 0) := (others => '0');
        
    constant max_col_indx_vec : std_logic_vector(col_addr_length-1 downto 0) 
        := std_logic_vector(to_unsigned(max_col_index, col_addr_length));
        
    constant min_col_indx_vec : std_logic_vector(col_addr_length-1 downto 0) := (others => '0');

begin

    sync_proc: process(clk) is begin
        if rising_edge(clk) then
            if rst = '1' then
                state_nrsm <= IDLE;
                grid_index_reg <= (others => '0');
            else
                state_nrsm <= next_state;
                grid_index_reg <= grid_index_next;
            end if;
        end if;
    end process sync_proc;
    
    grid_index_en <= grid_index_reg;
    
    nextstate_proc: process(state_nrsm, read) is begin
        case state_nrsm is 
            when IDLE => 
                if read = '1' then
                    next_state <= R00;
                else
                    next_state <= IDLE;
                end if;
            when R00 => next_state <= R01;
            when R01 => next_state <= R02;
            when R02 => next_state <= R10;
            when R10 => next_state <= R11;
            when R11 => next_state <= R12;
            when R12 => next_state <= R20;
            when R20 => next_state <= R21;
            when R21 => next_state <= R22;
            when R22 => next_state <= WAIT_READ_COMPLETE;
            when WAIT_READ_COMPLETE => next_state <= WRITE;
            when WRITE => next_state <= IDLE;
        end case;
    end process nextstate_proc;
    
    curr_col <= addr_base(col_addr_length-1 downto 0);
    curr_row <= addr_base(address_length-1 downto col_addr_length);
    
    col_base_us <= unsigned(curr_col);
    row_base_us <= unsigned(curr_row);
    
    prev_row <= max_row_indx_vec when curr_row = min_row_indx_vec else std_logic_vector(row_base_us - 1);
    next_row <= min_row_indx_vec when curr_row = max_row_indx_vec else std_logic_vector(row_base_us + 1);
    
    prev_col <= max_col_indx_vec when curr_col = min_col_indx_vec else std_logic_vector(col_base_us - 1);
    next_col <= min_col_indx_vec when curr_col = max_col_indx_vec else std_logic_vector(col_base_us + 1);
    
    with state_nrsm select addr_out <= 
        prev_row & prev_col when R00,
        prev_row & curr_col when R01,
        prev_row & next_col when R02,
        curr_row & prev_col when R10,
        curr_row & next_col when R12,
        next_row & prev_col when R20,
        next_row & curr_col when R21,
        next_row & next_col when R22,
        addr_write          when WRITE,
        curr_row & curr_col when others;
        
    with state_nrsm select bram_read_en <= '0' when IDLE | WAIT_READ_COMPLETE | WRITE, '1' when others;
    
    with state_nrsm select bram_write_en <= '1' when WRITE, '0' when others;
    
     with state_nrsm select grid_index_next <= 
        "000000001" when R00, -- ------------- Row
        "000000010" when R01, -- | 0 | 1 | 2 |  |
        "000000100" when R02, -- -------------  |
        "000001000" when R10, -- | 3 | 4 | 5 |  |
        "000010000" when R11, -- -------------  v
        "000100000" when R12, -- | 6 | 7 | 8 |
        "001000000" when R20, -- ------------- 
        "010000000" when R21, -- Col -->
        "100000000" when R22,
        (others => '0') when others;

end Behavioral;
