----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2023 01:21:13 PM
-- Design Name: 
-- Module Name: axis_cc_fifo - Behavioral
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

entity axis_cc_fifo is
    generic(
        g_data_width : integer := 36;
        g_data_depth : integer := 1024;
        g_sync_stages : integer := 3
    );
    port(
        i_m_clk, i_m_rst : in std_logic;
        
        i_m_valid : in std_logic;
        o_m_ready : out std_logic;
        i_m_data : in std_logic_vector(g_data_width-1 downto 0);
        
        i_s_clk, i_s_rst : in std_logic;
        
        o_s_valid : out std_logic;
        i_s_ready : in std_logic;
        o_s_data : out std_logic_vector(g_data_width-1 downto 0)
    );
end axis_cc_fifo;

architecture Behavioral of axis_cc_fifo is

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

    attribute ASYNC_REG : boolean;

    constant c_addr_width : integer := integer(ceil(log2(real(g_data_depth))));

    type t_greycode_meta_pline_type is array(g_sync_stages downto 1) 
        of std_logic_vector(c_addr_width-1 downto 0);

    signal s_m_ready : std_logic;
    signal s_m_get : std_logic;
    signal s_m_din_addr : integer range 0 to g_data_depth-1;
    signal s_m_din_addr_next, s_m_din_addr_p2 : integer range 0 to g_data_depth-1;
    
    signal s_m_din_addr_grey : std_logic_vector(c_addr_width-1 downto 0);
    
    signal s_m_dout_addr_grey_pline : t_greycode_meta_pline_type;
    attribute ASYNC_REG of s_m_dout_addr_grey_pline : signal is TRUE;
    
    signal s_m_dout_addr_grey : std_logic_vector(c_addr_width-1 downto 0);
    
    signal s_m_dout_addr : integer range 0 to g_data_depth-1;
    
    
    
    signal s_s_dout_addr_next : integer range 0 to g_data_depth-1;
    signal s_s_dout_addr : integer range 0 to g_data_depth-1;
    signal s_s_dout_addr_grey : std_logic_vector(c_addr_width-1 downto 0);
    
    signal s_s_valid : std_logic;
    signal s_s_dout_put : std_logic;
    signal s1_s_dout_put : std_logic;
    
    signal s_s_next_data_valid : std_logic;
    signal s_s_next_data : std_logic_vector(g_data_width-1 downto 0);
    signal s_s_curr_data : std_logic_vector(g_data_width-1 downto 0);
    
    signal s_s_din_addr_grey_pline : t_greycode_meta_pline_type;
    attribute ASYNC_REG of s_s_din_addr_grey_pline : signal is TRUE;
    
    signal s_s_din_addr_grey : std_logic_vector(c_addr_width-1 downto 0);
    
    signal s_s_din_addr : integer range 0 to g_data_depth-1;
    
    signal s_s_fifo_empty : std_logic;
    signal s_s_one_word_left : std_logic;
    
    signal s_s_dout_addrs_setup : std_logic;
    signal s_s_dout_datas_setup : std_logic;
    
    signal s_s_forward_data : std_logic;
        
begin

    o_m_ready <= s_m_ready;
    
    --1 when data is being received this cycle
    s_m_get <= s_m_ready and i_m_valid;
    
    s_m_dout_addr_grey <= s_m_dout_addr_grey_pline(s_m_dout_addr_grey_pline'high);
    
    process(i_m_clk) is begin
        if rising_edge(i_m_clk) then
        
            --shift over grey coded address for dout
            s_m_dout_addr_grey_pline <= 
                s_m_dout_addr_grey_pline(s_m_dout_addr_grey_pline'high - 1 downto s_m_dout_addr_grey_pline'low) 
                & s_s_dout_addr_grey;
            
            --convert to binary
            s_m_dout_addr <= to_integer(unsigned(
                grey_to_binary(s_m_dout_addr_grey)
            ));
            
            if (s_m_get) then
                
                --barrel increment data in pointer
                s_m_din_addr_p2 <= s_m_din_addr_p2 + 1;
                if (s_m_din_addr_p2 = g_data_depth-1) then
                    s_m_din_addr_p2 <= 0;
                end if;
                s_m_din_addr_next <= s_m_din_addr_p2;
                s_m_din_addr <= s_m_din_addr_next;
                
            end if;
            
            s_m_din_addr_grey <= binary_to_grey(
                std_logic_vector(to_unsigned(s_m_din_addr, s_m_din_addr_grey'length))
            );
            
            s_m_ready <= '1';
            --if din ptr is about to catch up to dout ptr (axis_fifo is about to be full)
            if (
                (s_m_get = '1' and s_m_din_addr_p2 = s_m_dout_addr) or 
                (s_m_get = '0' and s_m_din_addr_next = s_m_dout_addr)
            ) then
                --next cycle, we are NOT ready for data. axis_fifo will be full.
                s_m_ready <= '0';
                --in this logic, we are not interested in whether or not the other 
                --clock domain is outputting data. That can be cycle-to-cycle 
                --intermittent, and there's no guaruntee that the grey code for a 
                --given dout address will arrive in this clock domain on the same 
                --cycle that the corresponding value of the put signal does, so its 
                --safer to assume the worst and say its generating back pressure 
                --(dout address is not changing).
            end if;
            
            if (i_m_rst) then
                s_m_ready <= '0';
                s_m_din_addr <= 0;
                s_m_din_addr_next <= 1;
                s_m_din_addr_p2 <= 2;
                s_m_din_addr_grey <= (others => '0'); --0 <=> 0 in bin to grey
                s_m_dout_addr_grey_pline <= (others => (others => '0'));
                s_m_dout_addr <= 0;
            end if;
            
        end if;
    end process;

    bram_inst: entity work.bram_dp
    generic map(
        g_data_width => g_data_width,
        g_data_depth => g_data_depth
    )
    port map(
        i_clka => i_m_clk,
        i_ena => '1',
        i_wea => s_m_get,
        i_addra => s_m_din_addr,
        i_dina => i_m_data,
        o_douta => open,
        i_clkb => i_s_clk,
        i_enb => '1',
        i_web => '0',
        i_addrb => s_s_dout_addr_next,
        i_dinb => (others => '0'),
        o_doutb => s_s_next_data
    );
    
    o_s_valid <= s_s_valid;
    
    s_s_dout_put <= s_s_valid and i_s_ready;
    
    s_s_din_addr_grey <= s_s_din_addr_grey_pline(s_s_din_addr_grey_pline'high);
    
    s_s_fifo_empty <= '1' when s_s_din_addr = s_s_dout_addr else '0';
    
    s_s_one_word_left <= '1' when s_s_din_addr = s_s_dout_addr_next else '0';
    
    process(i_s_clk) is begin
        if rising_edge(i_s_clk) then
        
            s_s_din_addr_grey_pline <= 
                s_s_din_addr_grey_pline(s_s_din_addr_grey_pline'high - 1 downto s_s_din_addr_grey_pline'low)
                & s_m_din_addr_grey;
                
            s_s_din_addr <= to_integer(unsigned(
                grey_to_binary(s_s_din_addr_grey)
            ));
            
            s1_s_dout_put <= s_s_dout_put;
            
--            s_s_valid <= '0';
--            if (s_s_fifo_empty = '0') then
--                s_s_valid <= '1';
--            end if;
            
            if (s_s_dout_addrs_setup = '0') then
                
                if (s_s_din_addr /= s_s_dout_addr_next) then
                    s_s_dout_addr_next <= s_s_din_addr;
                    --indicates that s_s_dout_addr_next is properly 
                    --set up to be one address ahead of s_s_dout_addr 
                    s_s_dout_addrs_setup <= '1';
                    s_s_dout_datas_setup <= s_s_dout_addrs_setup;
                    s_s_curr_data <= s_s_next_data;
                end if;
                
            elsif (s_s_dout_put) then
                
                --more than one word left
                if (not s_s_one_word_left) then
                    s_s_dout_addr_next <= s_s_dout_addr_next + 1;
                    if (s_s_dout_addr_next = g_data_depth-1) then
                        s_s_dout_addr_next <= 0;
                    end if;
                else
                    --uh-oh, we emptied the FIFO.
                    --now we enter a mode where, confusingly, the address used for reading 
                    --the block RAM (s_s_dout_addr_next) has caught up with the address used 
                    --for tracking the FIFO state (s_s_dout_addr). We have to do this since 
                    --we can't forward data directly from the input, its on another clock 
                    --domain. So here we will wait for the input data address to advance, 
                    --at which point we will know that the data at the read address is 
                    --valid--and then we know we have data again, and the read data pointer 
                    --will sit one value ahead as it is supposed to.
                    s_s_dout_addrs_setup <= '0';
                end if;
                
                s_s_dout_addr <= s_s_dout_addr_next;
                s_s_dout_datas_setup <= s_s_dout_addrs_setup;
                s_s_curr_data <= s_s_next_data;
                
            end if;
            
            s_s_dout_addr_grey <= binary_to_grey(
                std_logic_vector(to_unsigned(s_s_dout_addr, s_s_dout_addr_grey'length))
            );
            
            s_s_next_data_valid <= '1';
            if (s_s_fifo_empty or s_s_one_word_left) then
                s_s_next_data_valid <= '0';
            end if;
            
            s_s_forward_data <= '0';
            --consecutive puts need a data forward
            if (s_s_dout_put and s1_s_dout_put) then
                s_s_forward_data <= '1';
            end if;
            
            --also, if the data didnt exist in s_s_next_data to shift to s_s_curr_data, 
            --we'll nned to forward data on the next cycle.
            if (s_s_dout_put and (not s_s_dout_datas_setup)) then
                s_s_forward_data <= '1';
            end if;
            
            --if last cycle we were forwarding data, we'll need to keep that up.
            if (s_s_forward_data) then
                s_s_dout_datas_setup <= s_s_dout_addrs_setup;
                s_s_curr_data <= s_s_next_data;
            end if;
            
            if (i_s_rst) then
                s_s_dout_addr <= 0;
                s_s_dout_addr_next <= 0;
                s_s_dout_addr_grey <= (others => '0');
                s_s_din_addr <= 0;
                s_s_din_addr_grey_pline <= (others => (others => '0'));
                s1_s_dout_put <= '0';
                s_s_dout_addrs_setup <= '0';
                s_s_dout_datas_setup <= '0';
                s_s_forward_data <= '0';
            end if;
        
        end if;
    end process;
    
    o_s_data <= s_s_next_data when s_s_forward_data = '1' else s_s_curr_data;
    s_s_valid <= (not s_s_fifo_empty) and s_s_dout_addrs_setup;

end Behavioral;
