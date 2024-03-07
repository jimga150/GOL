----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2023 09:24:09 PM
-- Design Name: 
-- Module Name: cc_fifo - Behavioral
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

--this FIFO has a two cycle latency between an assertion of i_m_request_data and the corresponding data being available on the line.
--i_m_request_data may be asserted again while output data is pending, so sequential reads are supported.
--if i_m_request_data is asserted while o_m_fifo_empty is 1, nothing happens.
--if i_s_valid is asserted while o_s_fifo_full is 1, no data is taken and the FIFO is not affected.

--this FIFO also has a capacity of g_data_depth - 1.

entity cc_fifo is
    generic(
        g_data_width : integer := 36;
        g_data_depth : integer := 1024;
        g_sync_stages : integer := 3
    );
    port(
        i_clk_s, i_rst_s : in std_logic;
        
        i_s_valid : in std_logic;
        o_s_fifo_almost_full : out std_logic;
        o_s_fifo_full : out std_logic;
        i_s_data : in std_logic_vector(g_data_width-1 downto 0);
        
        
        i_clk_m, i_rst_m : in std_logic;
        
        o_m_fifo_almost_empty : out std_logic;
        o_m_fifo_empty : out std_logic;
        i_m_request_data : in std_logic;
        o_m_data : out std_logic_vector(g_data_width-1 downto 0)
    );
end cc_fifo;

architecture Behavioral of cc_fifo is

    pure function binary_to_grey(
        i_binary : std_logic_vector
    ) return std_logic_vector is
        variable v_ans : std_logic_vector(i_binary'range);
    begin
        v_ans(i_binary'high) := i_binary(i_binary'high);
        for lv_i in i_binary'high-1 downto 0 loop
            v_ans(lv_i) := i_binary(lv_i) xor i_binary(lv_i+1);
        end loop;
        return v_ans;
    end function;
    
    pure function grey_to_binary(
        i_grey : std_logic_vector
    ) return std_logic_vector is
        variable v_ans : std_logic_vector(i_grey'range);
        variable v_xor_result : std_logic := '0';
    begin
        for lv_i in i_grey'range loop
            v_xor_result := v_xor_result xor i_grey(lv_i);
            v_ans(lv_i) := v_xor_result;
        end loop;
        return v_ans;
    end function;
    
    
    constant c_high_ptr : integer := g_data_depth-1;
    constant c_low_ptr : integer := 0;
    
    attribute ASYNC_REG : boolean;

    constant c_addr_width : integer := integer(ceil(log2(real(g_data_depth))));

    type t_greycode_meta_pline_type is array(g_sync_stages downto 1) 
        of std_logic_vector(c_addr_width-1 downto 0);
        
    
    ------------------------------------------------------------
    --input side signals
    ------------------------------------------------------------
    signal s_s_din_ready : std_logic;
    
    --1 when data is being accepted this cycle
    signal s_s_din_get : std_logic;
    
    --plus 1 and plus 2 account for wraparound incrementing, 
    --so if s_s_din_ptr = c_high_ptr, then s_s_din_ptr_plus1 = c_low_ptr
    signal s_s_din_ptr, s_s_din_ptr_plus1, s_s_din_ptr_plus2, s_s_din_ptr_plus3 : integer range c_high_ptr downto c_low_ptr;
    
    signal s_s_din_ptr_grey : std_logic_vector(c_addr_width-1 downto 0);
    
    --1 when FIFO is 1 word away from being full
    signal s_s_fifo_almost_full : std_logic;
    
    signal s_s_dout_ptr_grey_pline : t_greycode_meta_pline_type;
    attribute ASYNC_REG of s_s_dout_ptr_grey_pline : signal is TRUE;
    
    signal s_s_dout_ptr_grey : std_logic_vector(c_addr_width-1 downto 0);
    
    signal s_s_dout_ptr : integer range 0 to g_data_depth-1;
    
    ------------------------------------------------------------
    --output side signals
    ------------------------------------------------------------
    --1 when data is being output this cycle
    signal s_m_dout_req : std_logic;
    
    --1 when FIFO has 1 word left
    signal s_m_fifo_almost_empty : std_logic;
    
    signal s_m_dout_ptr, s_m_dout_ptr_plus1, s_m_dout_ptr_plus2, s_m_dout_ptr_plus3 : integer range c_high_ptr downto c_low_ptr;
    
    signal s_m_dout_ptr_grey : std_logic_vector(c_addr_width-1 downto 0);
    
    signal s_m_bram_dout : std_logic_vector(o_m_data'range);
    
    --1 when o_m_data is valid
    signal s_m_dout_valid : std_logic;
    
    signal s_m_din_ptr_grey_pline : t_greycode_meta_pline_type;
    attribute ASYNC_REG of s_m_din_ptr_grey_pline : signal is TRUE;
    
    signal s_m_din_ptr_grey : std_logic_vector(c_addr_width-1 downto 0);
    
    signal s_m_din_ptr : integer range 0 to g_data_depth-1;

begin
    
    bram_inst: entity work.bram_dp
    generic map(
        g_data_width => g_data_width,
        g_data_depth => g_data_depth
    )    
    port map(
        i_clka => i_clk_s,
        i_ena => '1',
        i_wea => s_s_din_get,
        i_addra => s_s_din_ptr,
        i_dina => i_s_data,
        o_douta => open,
        i_clkb => i_clk_m,
        i_enb => '1',
        i_web => '0',
        i_addrb => s_m_dout_ptr,
        i_dinb => (others => '0'),
        o_doutb => s_m_bram_dout
    );

    process(i_clk_s) is begin
        if rising_edge(i_clk_s) then
        
            --fifo is full when s_m_dout_ptr = s_s_din_ptr
            --the data out pointer has caught up to the data in pointer.
            
            s_s_fifo_almost_full <= '0';
            
            if (s_s_din_get = '1' and s_s_din_ptr_plus2 = s_s_dout_ptr) then
                s_s_fifo_almost_full <= '1';
            elsif (s_s_din_get = '0' and s_s_din_ptr_plus1 = s_s_dout_ptr) then
                s_s_fifo_almost_full <= '1';
            end if;
            
            s_s_din_ready <= '1';
            --if axis_fifo is inflating
            --AND its 1 away from being full
            if ((s_s_din_get = '1' and s_s_fifo_almost_full = '1') or s_s_din_ptr = s_s_dout_ptr) then
                --next cycle, we are NOT ready for data. axis_fifo will be full.
                s_s_din_ready <= '0';
            end if;
        
            if (s_s_din_get = '1') then
                --barrel increment data in pointer
                s_s_din_ptr_plus3 <= s_s_din_ptr_plus3 + 1;
                if (s_s_din_ptr_plus3 = c_high_ptr) then
                    s_s_din_ptr_plus3 <= c_low_ptr;
                end if;
                s_s_din_ptr_plus2 <= s_s_din_ptr_plus3;
                s_s_din_ptr_plus1 <= s_s_din_ptr_plus2;
                s_s_din_ptr <= s_s_din_ptr_plus1;
            end if;
            
            s_s_din_ptr_grey <= binary_to_grey(
                std_logic_vector(to_unsigned(s_s_din_ptr, s_s_din_ptr_grey'length))
            );
            
            s_s_dout_ptr_grey_pline <= 
                s_s_dout_ptr_grey_pline(s_s_dout_ptr_grey_pline'high - 1 downto s_s_dout_ptr_grey_pline'low) & 
                s_m_dout_ptr_grey;
                
            s_s_dout_ptr <= to_integer(unsigned(
                grey_to_binary(s_s_dout_ptr_grey)
            ));
            
            if (i_rst_s = '1') then
                s_s_din_ptr <= c_low_ptr + 1;
                s_s_din_ptr_plus1 <= c_low_ptr + 2;
                s_s_din_ptr_plus2 <= c_low_ptr + 3;
                s_s_din_ptr_plus3 <= c_low_ptr + 4;
                s_s_din_ready <= '1';
                s_s_fifo_almost_full <= '0';
            end if;
            
        end if;
    end process;
    
    s_s_dout_ptr_grey <= s_s_dout_ptr_grey_pline(s_s_dout_ptr_grey_pline'high);
    
    o_s_fifo_full <= not s_s_din_ready;

    o_s_fifo_almost_full <= s_s_fifo_almost_full;
    
    s_s_din_get <= i_s_valid and s_s_din_ready;
    
    process(i_clk_m) is begin
        if rising_edge(i_clk_m) then
            
            --fifo is empty when s_m_dout_ptr is one behind s_s_din_ptr
            
            s_m_fifo_almost_empty <= '0';
            
            if (s_m_dout_req = '1' and s_m_dout_ptr_plus2 = s_m_din_ptr) then
                s_m_fifo_almost_empty <= '1';
            elsif(s_m_dout_req = '0' and s_m_dout_ptr_plus1 = s_m_din_ptr) then
                s_m_fifo_almost_empty <= '1';
            end if;
            
            s_m_dout_valid <= '1';
            if ((s_m_dout_req = '1' and s_m_fifo_almost_empty = '1') or s_m_dout_ptr_plus1 = s_m_din_ptr) then
                s_m_dout_valid <= '0';
            end if;
                        
            --dout address will increment
            if (s_m_dout_req = '1') then
                
                --barrel increment data out pointer
                s_m_dout_ptr_plus3 <= s_m_dout_ptr_plus3 + 1;
                if (s_m_dout_ptr_plus3 = c_high_ptr) then
                    s_m_dout_ptr_plus3 <= c_low_ptr;
                end if;
                s_m_dout_ptr_plus2 <= s_m_dout_ptr_plus3;
                s_m_dout_ptr_plus1 <= s_m_dout_ptr_plus2;
                s_m_dout_ptr <= s_m_dout_ptr_plus1;
                                
            end if;
            
            s_m_dout_ptr_grey <= binary_to_grey(
                std_logic_vector(to_unsigned(s_m_dout_ptr, s_m_dout_ptr_grey'length))
            );
            
            s_m_din_ptr_grey_pline <= 
                s_m_din_ptr_grey_pline(s_m_din_ptr_grey_pline'high - 1 downto s_m_din_ptr_grey_pline'low) & 
                s_s_din_ptr_grey;
                
            s_m_din_ptr <= to_integer(unsigned(
                grey_to_binary(s_m_din_ptr_grey)
            ));
       
            if (i_rst_m = '1') then
                s_m_dout_ptr <= c_low_ptr;
                s_m_dout_ptr_plus1 <= c_low_ptr + 1;
                s_m_dout_ptr_plus2 <= c_low_ptr + 2;
                s_m_dout_ptr_plus3 <= c_low_ptr + 3;
                s_m_dout_valid <= '0';
                s_m_fifo_almost_empty <= '0';
            end if;
        
        end if;
    end process;
    
    s_m_din_ptr_grey <= s_m_din_ptr_grey_pline(s_m_din_ptr_grey_pline'high);
    
    o_m_fifo_almost_empty <= s_m_fifo_almost_empty;

    s_m_dout_req <= s_m_dout_valid and i_m_request_data;
    
    o_m_data <= s_m_bram_dout;
    
    o_m_fifo_empty <= not s_m_dout_valid;

end Behavioral;
