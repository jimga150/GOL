----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2020 03:21:33 PM
-- Design Name: 
-- Module Name: read_module_SM - Behavioral
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

library work;
use work.GOL_package.all;

entity read_module_SM is
    generic(vsync_active_val : std_logic := '0');
    port(
        clk, rst, vsync, disp_en : in std_logic;
        ar_ready, rd_valid : in std_logic;
        count_in : in std_logic_vector(GOL_row_word_addr_length-1 downto 0);
        row_vga_in : in std_logic_vector(GOL_frame_row_addr_length-1 downto 0);
        row_out : out std_logic_vector(GOL_frame_row_addr_length-1 downto 0);
        ar_valid, rd_ready, count_rst : out std_logic
    );
end read_module_SM;

architecture Behavioral of read_module_SM is

    type state_type is (IDLE, ISSUE_READS, WAIT_BLANKING, WAIT_READS, INC_ADDR);
    signal rm_state, next_state : state_type := IDLE;
    
    signal row : std_logic_vector(GOL_frame_row_addr_length-1 downto 0) := (others => '0');
    signal rowm1_wa : std_logic_vector(GOL_frame_row_addr_length-1 downto 0);

begin

    row_out <= row;
    
    rowm1_wa <= GOL_max_row_vect when unsigned(row) = 0 else std_logic_vector(unsigned(row) - 1);

    sync_proc: process(clk) is begin
        if rising_edge(clk) then
            if rst = '1' then
                rm_state <= IDLE;
            else
                rm_state <= next_state;
            end if;
        end if;
    end process sync_proc;
    
    ns_proc: process(rm_state, vsync, disp_en, count_in, row_vga_in, rowm1_wa, row, ar_ready, rd_valid) is begin
        case rm_state is
            when IDLE => 
                if vsync = vsync_active_val then
                    next_state <= ISSUE_READS;
                else
                    next_state <= IDLE;
                end if;
            when ISSUE_READS => 
                if count_in = GOL_max_word_vect and ar_ready = '1' then
                    next_state <= WAIT_BLANKING;
                else
                    next_state <= ISSUE_READS;
                end if;
            when WAIT_BLANKING => 
                --true in the front porch before the H_sync just BEFORE the row that we need to load into dist. RAM
                if disp_en = '0' and row_vga_in = rowm1_wa then
                    next_state <= WAIT_READS;
                else
                    next_state <= WAIT_BLANKING;
                end if;
            when WAIT_READS => 
                if count_in = GOL_max_word_vect and rd_valid = '1' then
                    next_state <= INC_ADDR;
                else
                    next_state <= WAIT_READS;
                end if;
            when INC_ADDR =>
                if row = GOL_num_rows_vect then
                    next_state <= IDLE;
                else
                    next_state <= ISSUE_READS;
                end if;
        end case;
    end process ns_proc;
    
    row_proc: process(clk) is begin
        if rising_edge(clk) then
            if rst = '1' or rm_state = IDLE then
                row <= (others => '0');
            elsif next_state = INC_ADDR then
                row <= std_logic_vector(unsigned(row) + 1);
            end if;
        end if;
    end process;
    
    ar_valid <= '1' when rm_state = ISSUE_READS else '0';
    rd_ready <= '1' when rm_state = WAIT_READS else '0';
    count_rst <= '1' when (rm_state = ISSUE_READS and next_state = WAIT_BLANKING) or rm_state = INC_ADDR else rst;

end Behavioral;
