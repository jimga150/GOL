----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2023 10:39:43 PM
-- Design Name: 
-- Module Name: read_latency_adapter - Behavioral
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

--adapts a data producer with read latency of g_producer_latency to a zero-latency AXI stream producer.
--assumes that if o_read_req is asserted on a cycle that i_fifo_empty is high, no read request will be made.

entity read_latency_adapter is
    generic(
        g_data_width : integer := 36;
        g_producer_latency : integer := 2
    );
    port(
        i_clk, i_rst : in std_logic;
        
        i_fifo_almost_empty : in std_logic; --1 when fifo has exactly 1 word left
        i_fifo_empty : in std_logic;
        o_read_req : out std_logic;
        i_data : in std_logic_vector(g_data_width-1 downto 0);
        
        o_valid : out std_logic;
        i_ready : in std_logic;
        o_data : out std_logic_vector(g_data_width-1 downto 0)
    );
end read_latency_adapter;

architecture Behavioral of read_latency_adapter is

    constant c_queue_capacity : integer := g_producer_latency + 2;

    type t_data_arr is array(natural range<>) of std_logic_vector(o_data'range);

    signal s_output_queue : t_data_arr(c_queue_capacity - 1 downto 0);
    
    signal s_words_in_queue : integer range 0 to s_output_queue'length;
    
    signal s_read_req : std_logic;
    
    signal s_num_pending_reads : integer range 0 to g_producer_latency;
    
    signal s_read_req_pipeline : std_logic_vector(g_producer_latency downto 1);
    
    signal s_valid : std_logic;
    
    signal s_dout_put : std_logic;
        
begin

    s_dout_put <= s_valid and i_ready;
    
    process(i_clk) is
        variable v_num_pending_reads : integer range 0 to g_producer_latency;
        variable v_words_in_queue : integer range 0 to s_output_queue'length;
    begin
        if rising_edge(i_clk) then
            
            --read request pipeline tracks when a given pending read is ready
            s_read_req_pipeline <= s_read_req_pipeline(s_read_req_pipeline'high - 1 downto s_read_req_pipeline'low) & s_read_req;
            
            --using a variable here to handle cases where we might be making read requests and completing requests on the same cycle
            v_num_pending_reads := s_num_pending_reads;
            v_words_in_queue := s_words_in_queue;
            
            s_read_req <= '0';
            
            --if the FIFO has words and we have space for them
            --if the FIFO has one word left, only avoid making a new read request 
            --if we are already making a read request on this cycle
            if (i_fifo_empty = '0' and (not (i_fifo_almost_empty = '1' and s_read_req = '1')) and 
                    (s_num_pending_reads + s_words_in_queue /= c_queue_capacity or s_dout_put = '1')) then
                --make a read request
                s_read_req <= '1';
                v_num_pending_reads := v_num_pending_reads + 1;
            end if;
            
            --if we are outputting data this cycle
            if (s_dout_put = '1') then
                --shift data down
                s_output_queue(s_output_queue'high - 1 downto s_output_queue'low) <= s_output_queue(s_output_queue'high downto s_output_queue'low + 1);
                v_words_in_queue := v_words_in_queue - 1;
                
                --this uses the OLD value for s_words_in_queue, not the one we just decremented
                if (s_words_in_queue = 1) then
                    s_valid <= '0';
                end if;
                
            end if;
            
            --if a read request came back
            if (s_read_req_pipeline(s_read_req_pipeline'high) = '1') then
            
                --if we are also outputting data this cycle, we'll need to account for the shift to keep data in order
                if (s_dout_put = '1') then
                    s_output_queue(s_words_in_queue - 1) <= i_data;
                else
                    --otherwise insert it at the right index
                    s_output_queue(s_words_in_queue) <= i_data;
                end if;
                
                --update trackers
                v_words_in_queue := v_words_in_queue + 1;
                v_num_pending_reads := v_num_pending_reads - 1;
                
                --assert valid if not already asserted
                s_valid <= '1';
                
            end if;
            
            --resolve variables
            s_num_pending_reads <= v_num_pending_reads;
            s_words_in_queue <= v_words_in_queue;
            
            if (i_rst = '1') then
                s_words_in_queue <= 0;
                s_read_req <= '0';
                s_read_req_pipeline <= (others => '0');
                s_num_pending_reads <= 0;
                s_valid <= '0';
            end if;
            
        end if;
    end process;
    
    o_data <= s_output_queue(0);
    o_read_req <= s_read_req;
    o_valid <= s_valid;

end Behavioral;
