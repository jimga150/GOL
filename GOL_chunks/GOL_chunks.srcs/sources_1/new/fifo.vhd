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
        g_data_width : integer := 8;
        g_data_depth : integer := 256
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
    
    signal s_din_ptr, s_dout_ptr : integer range t_ram_type'range;
    
    signal s_dout_valid, s_din_ready : std_logic;
    
    signal s_din_get, s_dout_put : std_logic;

begin

    s_din_get <= i_valid and s_din_ready;
    s_dout_put <= s_dout_valid and i_ready;

    process(i_clk) is begin
        if rising_edge(i_clk) then
        
            if (s_din_get = '1') then
            
                s_ram(s_din_ptr) <= i_data;
                
                s_din_ptr <= s_din_ptr + 1;
                if (s_din_ptr = s_ram'high) then
                    s_din_ptr <= s_ram'low;
                end if;
                
                --might be overridden below
                s_dout_valid <= '1';
                
                --if FIFO is inflating (gaining data on a cycle that it does not also lose some)
                if (s_dout_put = '0') then
                    --if din ptr is about to catch up to dout ptr (FIFO is about to be full)
                    if (s_din_ptr + 2 = s_dout_ptr or
                        (s_din_ptr = s_ram'high and s_dout_ptr = s_ram'low + 1) or 
                        (s_din_ptr = s_ram'high - 1 and s_dout_ptr = s_ram'low)) then
                        
                        s_din_ready <= '0';
                        
                    end if;
                end if;
                
            end if;
                        
            if (s_dout_put = '1') then
            
                s_din_ready <= '1';
                
                s_dout_ptr <= s_dout_ptr + 1;
                if (s_dout_ptr = s_ram'high) then
                    s_dout_ptr <= s_ram'low;
                end if;
                
                --if the FIFO is deflating (losing data on a cycle that data is not also gained)
                if (s_din_get = '0') then 
                    --if the dout pointer is about to catch up to the din pointer (FIFO is about to be empty)
                    if (s_dout_ptr + 1 = s_din_ptr or 
                        (s_dout_ptr = s_ram'high and s_din_ptr = s_ram'low)) then
                        s_dout_valid <= '0';
                    end if;
                end if;
                
            end if;
            
            
        
            if (i_rst = '1') then
                s_din_ptr <= s_ram'low;
                s_dout_ptr <= s_ram'low;
                s_din_ready <= '1';
                s_dout_valid <= '0';
            end if;
        
        end if;
    end process;
    
    --no output register but you can deal
    o_data <= s_ram(s_dout_ptr);
    
    o_ready <= s_din_ready;
    o_valid <= s_dout_valid;

end Behavioral;
