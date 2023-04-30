----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2023 09:10:21 PM
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--this FIFO has a two cycle latency between an assertion of i_request_data and the corresponding data being available on the line.
--i_request_data may be asserted again while output data is pending, so sequential reads are supported.
--if i_request_data is asserted while o_fifo_empty is 1, nothing happens.
--if i_valid is asserted while o_fifo_full is 1, no data is taken and the FIFO is not affected.

--this FIFO also has a capacity of g_data_depth - 1.

entity fifo is
    generic(
        g_data_width : integer := 36;
        g_data_depth : integer := 1024
    );
    port(
        i_clk, i_rst : in std_logic;
        
        i_valid : in std_logic;
        o_fifo_full : out std_logic;
        i_data : in std_logic_vector(g_data_width-1 downto 0);
        
        o_fifo_empty : out std_logic;
        i_request_data : in std_logic;
        o_data : out std_logic_vector(g_data_width-1 downto 0)
    );
end fifo;

architecture Behavioral of fifo is
    
    constant c_high_ptr : integer := g_data_depth-1;
    constant c_low_ptr : integer := 0;
    
    ------------------------------------------------------------
    --input side signals
    ------------------------------------------------------------
    signal s_din_ready : std_logic;
    
    --1 when data is being accepted this cycle
    signal s_din_get : std_logic;
    
    --plus 1 and plus 2 account for wraparound incrementing, 
    --so if s_din_ptr = c_high_ptr, then s_din_ptr_plus1 = c_low_ptr
    signal s_din_ptr, s_din_ptr_plus1, s_din_ptr_plus2, s_din_ptr_plus3 : integer range c_high_ptr downto c_low_ptr;
    
    --1 when FIFO is 1 word away from being full
    signal s_fifo_almost_full : std_logic;
    
    
    ------------------------------------------------------------
    --side-crossing side signals
    ------------------------------------------------------------
    signal s_fifo_inflating, s_fifo_deflating, fifo_cnt_staying_same : std_logic;
    
    
    ------------------------------------------------------------
    --output side signals
    ------------------------------------------------------------
    --1 when data is being output this cycle
    signal s_dout_req : std_logic;
    
    --1 when FIFO has 1 word left
    signal s_fifo_almost_empty : std_logic;
    
    signal s_dout_ptr, s_dout_ptr_plus1, s_dout_ptr_plus2, s_dout_ptr_plus3 : integer range c_high_ptr downto c_low_ptr;
    
    signal s_bram_dout : std_logic_vector(o_data'range);
    
    --1 when o_data is valid
    signal s_dout_valid : std_logic;

begin
    
    
    s_din_get <= i_valid and s_din_ready;
    
    s_dout_req <= s_dout_valid and i_request_data; 
    
    s_fifo_inflating <= s_din_get and (not s_dout_req);
    
    s_fifo_deflating <= s_dout_req and (not s_din_get);
    
    fifo_cnt_staying_same <= '1' when s_din_get = s_dout_req else '0';
    
    bram_inst: entity work.bram_simple_dp
    generic map(
        g_data_width => g_data_width,
        g_data_depth => g_data_depth
    )
    port map(
        i_clk => i_clk,
        i_ena => '1',
        i_wea => s_din_get,
        i_addra => s_din_ptr,
        i_dina => i_data,
        i_enb => '1',
        i_addrb => s_dout_ptr,
        o_doutb => s_bram_dout
    );

    process(i_clk) is begin
        if rising_edge(i_clk) then
        
            --fifo is full when s_dout_ptr = s_din_ptr
            --the data out pointer has caught up to the data in pointer.
            
            s_fifo_almost_full <= '0';
            
            if (s_fifo_deflating = '1') then
                if (s_din_ptr = s_dout_ptr) then
                    s_fifo_almost_full <= '1';
                end if;
            end if;
            
            if (fifo_cnt_staying_same = '1') then
                if (s_din_ptr_plus1 = s_dout_ptr) then
                    s_fifo_almost_full <= '1';
                end if;
            end if;
            
            if (s_fifo_inflating = '1') then
                if (s_din_ptr_plus2 = s_dout_ptr) then
                    s_fifo_almost_full <= '1';
                end if;
            end if;
            
            --if axis_fifo is inflating (gaining data on a cycle that it does not also lose some)
            --AND its 1 away from being full
            if (s_fifo_inflating = '1' and s_fifo_almost_full = '1') then
                --next cycle, we are NOT ready for data. axis_fifo will be full.
                s_din_ready <= '0';
            end if;
            
            if (s_fifo_deflating = '1') then
                s_din_ready <= '1';
            end if;
        
            if (s_din_get = '1') then
                --barrel increment data in pointer
                s_din_ptr_plus3 <= s_din_ptr_plus3 + 1;
                if (s_din_ptr_plus3 = c_high_ptr) then
                    s_din_ptr_plus3 <= c_low_ptr;
                end if;
                s_din_ptr_plus2 <= s_din_ptr_plus3;
                s_din_ptr_plus1 <= s_din_ptr_plus2;
                s_din_ptr <= s_din_ptr_plus1;
            end if;
            
            --------------------------------------------------------------------
            
            --fifo is empty when s_dout_ptr is one behind s_din_ptr
            
            s_fifo_almost_empty <= '0';
            
            if (s_fifo_deflating = '1') then
                if (s_dout_ptr_plus3 = s_din_ptr) then
                    s_fifo_almost_empty <= '1';
                end if;
            end if;
            
            if (fifo_cnt_staying_same = '1') then
                if (s_dout_ptr_plus2 = s_din_ptr) then
                    s_fifo_almost_empty <= '1';
                end if;
            end if;
            
            if (s_fifo_inflating = '1') then
                if (s_dout_ptr_plus1 = s_din_ptr) then
                    s_fifo_almost_empty <= '1';
                end if;
            end if;
                        
            if (s_fifo_deflating = '1' and s_fifo_almost_empty = '1') then
                s_dout_valid <= '0';
            end if;
            
            if (s_fifo_inflating = '1') then
                s_dout_valid <= '1';
            end if;
                        
            --dout address will increment
            if (s_dout_req = '1') then
                
                --barrel increment data out pointer
                s_dout_ptr_plus3 <= s_dout_ptr_plus3 + 1;
                if (s_dout_ptr_plus3 = c_high_ptr) then
                    s_dout_ptr_plus3 <= c_low_ptr;
                end if;
                s_dout_ptr_plus2 <= s_dout_ptr_plus3;
                s_dout_ptr_plus1 <= s_dout_ptr_plus2;
                s_dout_ptr <= s_dout_ptr_plus1;
                                
            end if;
       
            if (i_rst = '1') then
                s_din_ptr <= c_low_ptr + 1;
                s_din_ptr_plus1 <= c_low_ptr + 2;
                s_din_ptr_plus2 <= c_low_ptr + 3;
                s_din_ptr_plus3 <= c_low_ptr + 4;
                s_dout_ptr <= c_low_ptr;
                s_dout_ptr_plus1 <= c_low_ptr + 1;
                s_dout_ptr_plus2 <= c_low_ptr + 2;
                s_dout_ptr_plus3 <= c_low_ptr + 3;
                s_din_ready <= '1';
                s_dout_valid <= '0';
                s_fifo_almost_empty <= '0';
                s_fifo_almost_full <= '0';
            end if;
        
        end if;
    end process;
    
    o_data <= s_bram_dout;
    
    o_fifo_empty <= not s_dout_valid;
    o_fifo_full <= not s_din_ready;

end Behavioral;
