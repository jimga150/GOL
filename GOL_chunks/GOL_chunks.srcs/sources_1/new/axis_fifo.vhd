----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2023 12:59:12 PM
-- Design Name: 
-- Module Name: axis_fifo - Behavioral
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

entity axis_fifo is
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
end axis_fifo;

architecture Behavioral of axis_fifo is
    
    signal s_fifo_full : std_logic;
    
    signal s_fifo_almost_empty : std_logic;
    
    signal s_fifo_empty : std_logic;
    
    signal s_request_fifo_data : std_logic;
    
    signal s_fifo_dout : std_logic_vector(g_data_width-1 downto 0);

begin

    o_ready <= not s_fifo_full;
    
    fifo_inst: entity work.fifo
    generic map(
        g_data_width => g_data_width,
        g_data_depth => g_data_depth
    )
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_valid => i_valid,
        o_fifo_almost_full => open,
        o_fifo_full => s_fifo_full,
        i_data => i_data,
        o_fifo_almost_empty => s_fifo_almost_empty,
        o_fifo_empty => s_fifo_empty,
        i_request_data => s_request_fifo_data,
        o_data => s_fifo_dout
    );
    
    rla_inst: entity work.read_latency_adapter
    generic map(
        g_data_width => g_data_width,
        g_producer_latency => 2
    )
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_fifo_almost_empty => s_fifo_almost_empty,
        i_fifo_empty => s_fifo_empty,
        o_read_req => s_request_fifo_data,
        i_data => s_fifo_dout,
        o_valid => o_valid,
        i_ready => i_ready,
        o_data => o_data
    );

end Behavioral;