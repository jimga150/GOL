----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2023 07:07:34 PM
-- Design Name: 
-- Module Name: fifo - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo is
    generic(
        g_data_width : integer := 36;
        g_data_depth : integer := 1024
    );
    port(
        i_clk, i_rst : in std_logic;
        
        i_valid : in std_logic;
        o_ready : out std_logic;
        i_data : in std_logic_vector(g_data_width-1 downto 0);
        
        o_valid : out std_logic;
        i_ready : in std_logic;
        o_data : out std_logic_vector(g_data_width-1 downto 0)
    );
end fifo;

architecture Behavioral of fifo is

    type t_ram_type is array (g_data_depth-1 downto 0) of std_logic_vector(o_data'range);
    signal s_ram : t_ram_type;
    
    signal last_din : std_logic_vector(i_data'range);
    
    signal s_din_ptr, s_dout_ptr, s_dout_ptr_next : integer range t_ram_type'range;
    
    signal s_dout_valid, s_din_ready : std_logic;
    
    signal s_din_get, s_dout_put, s1_dout_put : std_logic;
    
    signal s_one_word_left, s_fifo_empty : std_logic;
    
    signal s_next_data : std_logic_vector(o_data'range);
    signal s_next_data_valid : std_logic;

begin
    
    --1 when data is being accepted this cycle
    s_din_get <= i_valid and s_din_ready;
    
    --1 when data is being output this cycle
    s_dout_put <= s_dout_valid and i_ready;
    
    --1 when on this cycle, the FIFO has one word in it
    s_one_word_left <= '1' when s_dout_ptr_next = s_din_ptr else '0';
    
    --1 when on this cycle, the FIFO has no words in it
    s_fifo_empty <= '1' when s_dout_ptr = s_din_ptr else '0'; 

    process(i_clk) is begin
        if rising_edge(i_clk) then
        
            s1_dout_put <= s_dout_put;
        
            if (s_din_get = '1') then
                
                --cache data in
                last_din <= i_data;
            
                --input data
                s_ram(s_din_ptr) <= i_data;
                
                --barrel increment data in pointer
                s_din_ptr <= s_din_ptr + 1;
                if (s_din_ptr = s_ram'high) then
                    s_din_ptr <= s_ram'low;
                end if;
                
                --if FIFO is inflating (gaining data on a cycle that it does not also lose some)
                if (s_dout_put = '0') then
                    --if din ptr is about to catch up to dout ptr (FIFO is about to be full)
                    if (s_din_ptr + 2 = s_dout_ptr or
                        (s_din_ptr = s_ram'high and s_dout_ptr = s_ram'low + 1) or 
                        (s_din_ptr = s_ram'high - 1 and s_dout_ptr = s_ram'low)) then
                        
                        --next cycle, we are NOT ready for data. FIFO will be full.
                        s_din_ready <= '0';
                        
                    end if;
                end if;
                
            end if;
            
            --access RAM
            s_next_data <= s_ram(s_dout_ptr_next);
            if (s_fifo_empty = '1' or s_one_word_left = '1') then
                --valid data didnt exist in RAM when this was sampled.
                s_next_data_valid <= '0';
            else
                s_next_data_valid <= '1';
            end if;
            
            --see if we have data available next cycle
            s_dout_valid <= '0';
            if (s_dout_ptr /= s_din_ptr) then
                s_dout_valid <= '1';
            end if;
            
            --dout address will increment
            if (s_dout_put = '1') then
            
                --we will always be ready for data next cycle if we're outputting on this cycle
                s_din_ready <= '1';
                
                --barrel increment data out pointers
                s_dout_ptr <= s_dout_ptr_next;
                
                s_dout_ptr_next <= s_dout_ptr_next + 1;
                if (s_dout_ptr_next = s_ram'high) then
                    s_dout_ptr_next <= s_ram'low;
                end if;
                
                --if the FIFO is deflating (losing data on a cycle that data is not also gained)
                if (s_din_get = '0') then 
                    --if the dout pointer is about to catch up to the din pointer (FIFO is about to be empty)
                    if (s_one_word_left = '1') then
                        --FIFO will be empty next cycle
                        s_dout_valid <= '0';
                    end if;
                end if;
                
            end if;
            
            --data out stuff-------------------------------------------------------------------------------------------
            --if the data wouldnt have already been in RAM, forward it to the output.
            if (s_one_word_left = '1') then
                o_data <= last_din;
            end if;
            if (s_fifo_empty = '1') then
                o_data <= i_data;
            end if;
            
            --UNLESS we're outputting data this cycle. then we need to find the NEXT word and place it on the line (if it exists).
            if (s_dout_put = '1') then
                
                if (s_next_data_valid = '1') then
                    --if the word at the next address was valid, easy.
                    o_data <= s_next_data;
                else
                    --otherwise, use the last valid input word
                    o_data <= last_din;
                end if;

                --consecutive puts means we have to forward from the next address directly to output as soon as possible.
                if (s1_dout_put = '1') then
                    o_data <= s_ram(s_dout_ptr_next);
                end if;
                
                --if one word is left and its being retrieved right now, need to forward the input word right now for the next cycle.
                --this might not be valid yet, but we dont care--the logic above will handle the o_valid flag.
                if (s_one_word_left = '1') then
                    o_data <= i_data;
                end if;
                
            end if;
            
            --data out stuff-------------------------------------------------------------------------------------------
            
            if (i_rst = '1') then
                s_din_ptr <= s_ram'low;
                s_dout_ptr <= s_ram'low;
                s_dout_ptr_next <= s_ram'low + 1;
                s_din_ready <= '1';
                s_dout_valid <= '0';
            end if;
        
        end if;
    end process;
    
    o_ready <= s_din_ready;
    o_valid <= s_dout_valid;

end Behavioral;
